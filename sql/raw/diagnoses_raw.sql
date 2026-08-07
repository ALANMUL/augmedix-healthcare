-- =====================================================================
-- RAW LAYER: diagnoses
-- Source: pre_diagnoses.csv (DAX Studio export, resolved surrogate keys)
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_diagnoses` (
  diagnosis_id            STRING,
  encounter_id             STRING,
  patient_id               STRING,
  diagnosis_type            STRING,
  rank                     INT64,
  diagnosis_date             STRING,   -- kept as STRING in raw; cast in staging
  dx_status                 STRING,
  confirmed_by_provider      STRING,
  icd10_id                  INT64
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_diagnoses \
--   ./data/pre_diagnoses.csv \
--   ./schema/raw_diagnoses_schema.json
