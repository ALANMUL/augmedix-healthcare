-- =====================================================================
-- RAW LAYER: dim_route
-- Source: pre_dim_route.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_route` (
  route_id                STRING,
  route_raw                  STRING,
  route_label                   STRING,
  route_category                   STRING,
  is_injectable                       STRING,
  is_oral                                STRING,
  is_inhaled                                STRING,
  administration_setting                       STRING,
  description                                     STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_route \
--   ./data/pre_dim_route.csv \
--   ./schema/raw_dim_route_schema.json
