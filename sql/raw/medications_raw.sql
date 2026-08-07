-- =====================================================================
-- RAW LAYER: medications
-- Source: pre_medications.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_medications` (
  medication_id               STRING,
  patient_id                    STRING,
  prescribing_provider_id          STRING,
  start_date                          STRING,   -- cast in staging
  end_date                               STRING,   -- cast in staging
  status                                     STRING,
  refills_authorized                            INT64,
  pharmacy_name                                    STRING,
  ndc_code                                            STRING,
  generic_flag                                           STRING,
  adherence_rate                                            FLOAT64,
  dose                                                         STRING,
  dose_units                                                      STRING,
  frequency_id                                                       STRING,
  drug_id                                                               STRING,
  route_id                                                                 STRING,
  indication_id                                                               STRING,
  tier_id                                                                        STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_medications \
--   ./data/pre_medications.csv \
--   ./schema/raw_medications_schema.json
