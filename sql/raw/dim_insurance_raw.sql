-- =====================================================================
-- RAW LAYER: dim_insurance
-- Source: pre_dim_insurence.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- Note: source column is "insurence_name_id" (typo in source export) --
--       kept exactly as-is here per raw-layer rule (no fixes at raw).
--       Corrected to "insurance_name_id" starting at staging.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_insurance` (
  insurance_name         STRING,
  insurence_name_id       INT64   -- [sic] typo preserved from source
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_insurance \
--   ./data/pre_dim_insurence.csv \
--   ./schema/raw_dim_insurance_schema.json
