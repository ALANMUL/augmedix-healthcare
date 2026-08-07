-- =====================================================================
-- RAW LAYER: dim_drug
-- Source: pre_dim_drug.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_drug` (
  drug_id                STRING,
  drug_name               STRING,
  drug_class               STRING,
  therapeutic_area          STRING,
  controlled_substance       STRING,
  high_alert_med             STRING,
  requires_monitoring         STRING,
  standard_dose               STRING,
  route_category               STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_drug \
--   ./data/pre_dim_drug.csv \
--   ./schema/raw_dim_drug_schema.json
