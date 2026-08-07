# Augmedix Healthcare Analytics

BigQuery + dbt data pipeline feeding a Power BI portfolio dashboard.
BigQuery project: `augmedix-healthcare` | Dataset: `augmedix`

## Architecture

```
Ingestion (outside dbt)          dbt-managed
------------------------         --------------------------------------------
bq load CSVs           -->   raw_* tables --> sources.yml --> staging models --> mart models --> Power BI
(data/pre_process/*.csv)
```

## Repo structure

```
augmedix-healthcare/
├── data/
│   ├── pre_process/     18 source CSVs (DAX Studio exports) -- not committed, see .gitignore
│   └── sample/           small sample files safe to commit for demo purposes
├── sql/
│   └── raw/              18 CREATE TABLE DDL files -- raw layer, outside dbt
├── dbt/
│   ├── dbt_project.yml
│   ├── packages.yml
│   └── models/
│       ├── staging/       18 stg_*.sql models + sources.yml + schema.yml (tests)
│       └── marts/          18 mart models, organized by pillar
│           ├── finance/       claims
│           ├── operations/     encounters
│           ├── clinical/        diagnoses, lab_results, vital_signs
│           ├── medication/       medications
│           ├── population/        patients
│           └── shared/             10 dimension tables + providers
├── ops/
│   ├── drop_raw_tables.sql    step 1 -- drop before reload
│   ├── load_all_raw.sh        step 3 -- bq load all 18 CSVs
│   └── verify_row_counts.sql  step 4 -- confirm load matches expected counts
└── docs/
```

## Run order

1. `ops/drop_raw_tables.sql` -- run in BigQuery Console (drops old raw tables)
2. Run each `sql/raw/*.sql` file -- creates the 18 raw tables fresh
3. `bash ops/load_all_raw.sh` -- loads the 18 CSVs into those raw tables
4. `ops/verify_row_counts.sql` -- confirm row counts match expected
5. `cd dbt && dbt deps && dbt build` -- builds staging + mart layers in dependency order, runs tests

See `dbt/README.md` for dbt-specific setup (profiles.yml, adapter install).

## Models with real transform logic

| Model | Logic |
|---|---|
| `dbt/models/marts/finance/claims.sql` | AR aging (`days_open`, `aging_bucket`, `aging_bucket_rank`), snapshot-dated against `MAX(claim_date)` in the dataset rather than `CURRENT_DATE()` |
| `dbt/models/marts/clinical/diagnoses.sql` | `dx_count_per_encounter`, `dx_complexity_bucket` |
| `dbt/models/marts/operations/encounters.sql` | `dacumentation_method` relabel of `amb_documentation` |
| `dbt/models/marts/shared/providers.sql` | Drops mismatched `first_name`/`last_name` (see data quality note in model file) |
| `dbt/models/staging/stg_dim_insurance.sql` | Corrects source typo `insurence_name_id` -> `insurance_name_id` |

Every other model is a clean passthrough (type casts + null cleanup only).
