-- =====================================================================
-- RAW LAYER: dim_icd10
-- Source: pre_dim_icd10.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_icd10` (
  icd10_id       INT64,
  icd10_code      STRING,
  description        STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_icd10 \
--   ./data/pre_dim_icd10.csv \
--   ./schema/raw_dim_icd10_schema.json
