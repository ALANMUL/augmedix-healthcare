-- =====================================================================
-- RAW LAYER: lab_results
-- Source: pre_lab_results.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_lab_results` (
  lab_result_id            STRING,
  encounter_id               STRING,
  result_value                  FLOAT64,
  reference_range                  STRING,
  abnormal_flag                       STRING,
  collection_date                        STRING,   -- cast in staging
  result_date                               STRING,   -- cast in staging
  ordering_provider_id                         STRING,
  lab_status                                      STRING,
  specimen_type                                      STRING,
  lab_test_id                                           STRING,
  patient_id                                               STRING,
  unit                                                        STRING,
  loinc_code                                                     STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_lab_results \
--   ./data/pre_lab_results.csv \
--   ./schema/raw_lab_results_schema.json
