-- =====================================================================
-- RAW LAYER: dim_frequency
-- Source: pre_dim_frequency.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_frequency` (
  frequency_id              STRING,
  frequency_raw               STRING,
  frequency_label                STRING,
  frequency_category                STRING,
  times_per_day                        FLOAT64,
  interval_minutes                        INT64,
  doses_per_week                             FLOAT64,
  is_prn                                        STRING,
  is_controlled_schedule                          STRING,
  tier                                                INT64,
  source_system                                          STRING,
  description                                               STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_frequency \
--   ./data/pre_dim_frequency.csv \
--   ./schema/raw_dim_frequency_schema.json
