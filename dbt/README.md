# Augmedix Healthcare Analytics — dbt Project

Transforms raw BigQuery tables (`augmedix-healthcare.augmedix.raw_*`) into
staging and mart layers consumed by the Power BI report.

## Architecture

```
Ingestion (outside dbt)     dbt-managed
─────────────────────       ─────────────────────────────
bq load CSVs      ──►   raw_* tables ──► sources.yml ──► staging models ──► mart models ──► Power BI
(pre_process files)                      (this dbt project)
```

Raw ingestion stays outside dbt on purpose — dbt owns transformation, not
loading. `sources.yml` declares the 18 `raw_*` tables as sources so dbt can
build a proper dependency graph (`dbt docs generate` will show lineage from
source → staging → mart).

## Structure

```
dbt/
├── dbt_project.yml
├── packages.yml              dbt_utils
├── models/
│   ├── staging/
│   │   ├── sources.yml       declares the 18 raw_* tables
│   │   ├── schema.yml        unique/not_null/relationships tests
│   │   └── stg_*.sql         18 models — type casts, null cleanup only
│   └── marts/
│       ├── finance/          claims (AR aging calc)
│       ├── operations/       encounters (documentation method relabel)
│       ├── clinical/         diagnoses (complexity bucket), lab_results, vital_signs
│       ├── medication/       medications
│       ├── population/       patients
│       └── shared/           10 dimension tables + providers
├── macros/                   (empty — no custom macros needed yet)
├── seeds/                    (empty — no static CSV seeds needed)
└── snapshots/                (empty — no SCD tracking needed yet)
```

No `intermediate/` layer — none of the 18 tables need cross-fact joins before
reaching mart shape. No `marts/reporting/` — Power BI's DAX layer owns
aggregation; adding pre-aggregated reporting tables here would just duplicate
that logic in two places.

## Setup

1. Install dbt with the BigQuery adapter:
   ```
   pip install dbt-bigquery
   ```

2. Create `~/.dbt/profiles.yml` (not committed — contains credentials):
   ```yaml
   augmedix_healthcare:
     target: dev
     outputs:
       dev:
         type: bigquery
         method: oauth        # or service-account with keyfile
         project: augmedix-healthcare
         dataset: augmedix
         threads: 4
         location: US
   ```

3. Install packages and run:
   ```
   dbt deps
   dbt build          # runs models + tests
   dbt docs generate   # builds lineage graph
   dbt docs serve      # view it locally
   ```

## Models with real transform logic (not pure passthrough)

| Model | Logic |
|---|---|
| `marts/finance/claims.sql` | AR aging: `days_open`, `aging_bucket`, `aging_bucket_rank`. Snapshot date = `MAX(claim_date)` in the dataset, not `CURRENT_DATE()` — keeps aging stable against this frozen synthetic dataset instead of drifting with wall-clock time. |
| `marts/clinical/diagnoses.sql` | `dx_count_per_encounter` (window count via CTE), `dx_complexity_bucket` (bucketed off that count). |
| `marts/operations/encounters.sql` | `dacumentation_method` — direct relabel of `amb_documentation` (typo preserved to match the live Power BI model's column name). |
| `marts/shared/providers.sql` | Drops `first_name`/`last_name` — these don't reliably map to `full_name` on the same row in source data (independently randomized synthetic fields). |
| `stg_dim_insurance.sql` | Corrects source typo `insurence_name_id` → `insurance_name_id`. |

Every other model is a clean passthrough — type casts and null cleanup only.
