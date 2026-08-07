-- =====================================================================
-- RAW LAYER: encounters
-- Source: pre_encounters.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- Note: telehealth_flag kept as STRING ("True"/"False" literal values
--       in source) -- matches existing DAX pattern filtering on
--       telehealth_flag = "True", not a BOOL type.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_encounters` (
  encounter_id           STRING,
  patient_id              STRING,
  provider_id               STRING,
  encounter_date              STRING,   -- cast in staging
  encounter_type                 STRING,
  chief_complaint                   STRING,
  facility_name                        STRING,
  facility_state                          STRING,
  department                                 STRING,
  duration_minutes                              INT64,
  note_type                                        STRING,
  visit_disposition                                   STRING,
  total_charge                                           FLOAT64,
  insurance_paid                                            FLOAT64,
  patient_copay                                                FLOAT64,
  admit_source                                                    STRING,
  discharge_date                                                     STRING,   -- cast in staging
  readmission_30day                                                     STRING,
  telehealth_flag                                                          STRING,
  amb_documentation                                                           STRING,
  created_timestamp                                                              STRING,   -- cast in staging
  icd10_id                                                                          INT64
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_encounters \
--   ./data/pre_encounters.csv \
--   ./schema/raw_encounters_schema.json
