-- =====================================================================
-- RAW LAYER: dim_indication
-- Source: pre_dim_indication.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_indication` (
  indication_id         STRING,
  indication_raw          STRING,
  indication_label           STRING,
  clinical_category              STRING,
  is_chronic                        STRING,
  is_acute                            STRING,
  body_system                            STRING,
  icd10_category                             STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_indication \
--   ./data/pre_dim_indication.csv \
--   ./schema/raw_dim_indication_schema.json
