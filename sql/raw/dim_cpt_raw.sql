-- =====================================================================
-- RAW LAYER: dim_cpt
-- Source: pre_dim_cpt.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- Note: this is a CPT x POS bridge table (1,870 rows = 20 unique CPT
--       codes x their POS/DRG combos), NOT deduped to 20 rows. It exists
--       to give claims[cpt_id] a stable 1:1 surrogate key to a specific
--       (cpt_code, pos_code, drg_code) combination.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_cpt` (
  cpt_id             INT64,
  cpt_code           INT64,
  cpt_description    STRING,
  pos_code           INT64,
  drg_code           FLOAT64
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_cpt \
--   ./data/pre_dim_cpt.csv \
--   ./schema/raw_dim_cpt_schema.json
