# Augmedix Healthcare Analytics — BigQuery + dbt Pipeline

Synthetic healthcare analytics dataset (~79K rows across 8 fact/entity
tables + 10 dimension tables) modeled through a layered BigQuery pipeline,
feeding a Power BI portfolio dashboard across four pillars: **Finance
(RCM)**, **Operations (Encounters)**, **Clinical Quality**, and
**Population Health**.

Project: `augmedix-healthcare`  ·  Dataset: `augmedix`
GitHub: https://github.com/ALANMUL/augmedix-healthcare

---

## Architecture

```
raw  →  staging  →  marts  →  Power BI
```

| Layer | Object type | Purpose |
|---|---|---|
| **raw** | `TABLE` | Exact mirror of source CSVs (DAX Studio exports). Loaded outside dbt via `bq load`. Never transformed. |
| **staging** | `TABLE` (dbt model) | Type casts, null standardization. No business logic. 1:1 column shape with raw. |
| **marts** | `TABLE` (dbt model) | Final, business-grain tables. **This is the only layer Power BI connects to.** |

No `intermediate` layer — none of the 18 tables need cross-fact joins
before reaching mart shape, so adding one would be speculative structure
with nothing in it. No materialized views for marts, since BigQuery
materialized views can't handle the joins/aggregations some marts need
(e.g. `claims` mart's AR-aging CTE) — marts are `CREATE OR REPLACE TABLE`
via dbt/scheduled query instead.

---

## Folder structure

```
augmedix-healthcare/
├── data/
│   ├── pre_process/        18 source CSVs (not committed — see .gitignore)
│   └── sample/               small sample files safe to commit for demo
├── sql/
│   └── raw/                  18 CREATE TABLE DDL files — raw layer, outside dbt
├── dbt/
│   ├── dbt_project.yml
│   ├── packages.yml
│   └── models/
│       ├── staging/           18 stg_*.sql models + sources.yml + schema.yml
│       └── marts/              18 mart models, one folder per pillar
│           ├── finance/           claims
│           ├── operations/         encounters
│           ├── clinical/            diagnoses, lab_results, vital_signs
│           ├── medication/           medications
│           ├── population/            patients
│           └── shared/                 10 dimension tables + providers
├── ops/
│   ├── drop_raw_tables.sql    step 1 — drop before reload
│   ├── load_all_raw.sh        step 3 — bq load all 18 CSVs
│   └── verify_row_counts.sql  step 4 — confirm load matches expected counts
└── docs/
```

---

## Load order

1. `ops/drop_raw_tables.sql` — drop old raw tables (BigQuery Console)
2. Run each `sql/raw/*.sql` file — creates 18 raw tables fresh
3. `bash ops/load_all_raw.sh` — loads the 18 source CSVs via `bq load`
4. `ops/verify_row_counts.sql` — confirm row counts match expected
5. `cd dbt && dbt deps && dbt build` — builds staging → marts in dependency
   order (resolved automatically via the `ref()` graph), runs schema tests
6. Point Power BI's BigQuery connector at `mart_*` tables only

---

## Design principles

- **Grain discipline** — every mart matches the grain of its source
  table (one row per claim, one row per encounter, etc.); no
  pre-aggregation to a coarser grain happens in SQL, since Power BI's DAX
  layer owns aggregation
- **No fact-to-fact joins in Power BI** — cross-fact metrics (e.g. Charge
  Capture Gap between `encounters.total_charge` and `claims.charge_amount`)
  are computed via relationships in the Power BI model, not pre-joined in
  BigQuery, since the two facts stay at their natural grain
- **Snapshot dates over wall-clock dates** — time-sensitive calculated
  columns (e.g. `claims.days_open` for AR aging) are computed against
  `MAX(date)` within the dataset itself, not `CURRENT_DATE()`, so results
  stay stable against this frozen synthetic dataset instead of drifting
  as real-world time moves past it
- **Raw never silently fixes source data** — known source issues (e.g.
  the `insurence_name_id` column typo) are preserved exactly in raw and
  corrected starting at staging, so raw stays a true audit trail of what
  was actually loaded
- **Fix once, not per-measure** — data quality issues resolved in SQL
  (dropping mismatched `first_name`/`last_name` from `providers`,
  relabeling `amb_documentation`) happen once at the mart layer, not
  repeated across multiple DAX measures downstream

---

## Models with real transform logic

| Model | Logic |
|---|---|
| `dbt/models/marts/finance/claims.sql` | AR aging (`days_open`, `aging_bucket`, `aging_bucket_rank`), snapshot-dated against `MAX(claim_date)` |
| `dbt/models/marts/clinical/diagnoses.sql` | `dx_count_per_encounter` (window count), `dx_complexity_bucket` |
| `dbt/models/marts/operations/encounters.sql` | `dacumentation_method` — relabel of `amb_documentation` |
| `dbt/models/marts/shared/providers.sql` | Drops mismatched `first_name`/`last_name` (data quality note in file) |
| `dbt/models/staging/stg_dim_insurance.sql` | Corrects source typo `insurence_name_id` → `insurance_name_id` |

Every other model (13 of 18) is a clean passthrough — type casts and null
cleanup only, no business logic.

---

## Status

| Layer | Status |
|---|---|
| Raw DDL (18 tables) | ✅ SQL written, ready to run |
| Old raw tables dropped | ✅ Done |
| Raw tables created | 🔄 In progress |
| Raw data load | ⏳ Not started |
| Row count verification | ⏳ Not started |
| dbt staging models (18) | ✅ Written, not yet run against BigQuery |
| dbt marts (18) | ✅ Written, not yet run against BigQuery |
| dbt tests (unique/not_null/relationships) | ✅ Written, not yet run |
| Power BI connection to marts | ⏳ Not started |