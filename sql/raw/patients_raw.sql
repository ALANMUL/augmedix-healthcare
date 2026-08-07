-- =====================================================================
-- RAW LAYER: patients
-- Source: pre_patients.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_patients` (
  patient_id                     STRING,
  mrn                              STRING,
  first_name                        STRING,
  last_name                            STRING,
  date_of_birth                          STRING,   -- cast in staging
  age                                       INT64,
  gender                                       STRING,
  race                                            STRING,
  ethnicity                                          STRING,
  preferred_language                                    STRING,
  address_line1                                            STRING,
  city                                                        STRING,
  state                                                          STRING,
  zip_code                                                          INT64,
  primary_insurance_member_id                                          STRING,
  pcp_id                                                                   STRING,
  deceased                                                                    STRING,
  created_date                                                                   STRING,   -- cast in staging
  smoking_status                                                                    STRING,
  alcohol_use                                                                           STRING,
  primary_insurance_name_id                                                                INT64,
  secondary_insurance_name_id                                                                  FLOAT64  -- has nulls
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_patients \
--   ./data/pre_patients.csv \
--   ./schema/raw_patients_schema.json
