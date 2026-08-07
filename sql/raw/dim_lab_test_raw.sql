-- =====================================================================
-- RAW LAYER: dim_lab_test
-- Source: pre_dim_lab_test.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- Note: critical_high/critical_low are STRING by design (values like
--       ">200", "<40" carry comparison operators, not pure numerics).
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_lab_test` (
  lab_test_id            STRING,
  lab_test_name             STRING,
  lab_abbreviation             STRING,
  lab_category                    STRING,
  body_system                        STRING,
  is_fasting_required                   STRING,
  critical_high                            STRING,
  critical_low                                STRING,
  unit                                           STRING,
  loinc_code                                        STRING,
  description                                          STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_lab_test \
--   ./data/pre_dim_lab_test.csv \
--   ./schema/raw_dim_lab_test_schema.json
