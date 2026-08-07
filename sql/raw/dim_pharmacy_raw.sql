-- =====================================================================
-- RAW LAYER: dim_pharmacy
-- Source: pre_dim_pharmacy.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- Note: current medications table stores pharmacy_name as free text
--       (no pharmacy_id FK yet) -- this dim is available for a future
--       join if the model is extended.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_pharmacy` (
  pharmacy_id          STRING,
  pharmacy_name           STRING,
  pharmacy_type              STRING,
  is_mail_order                  STRING,
  is_retail                         STRING,
  is_pbm                               STRING,
  parent_company                          STRING,
  description                                STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_pharmacy \
--   ./data/pre_dim_pharmacy.csv \
--   ./schema/raw_dim_pharmacy_schema.json
