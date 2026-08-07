-- =====================================================================
-- RAW LAYER: providers
-- Source: pre_providers.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_providers` (
  provider_id             STRING,
  npi                        INT64,
  first_name                    STRING,
  last_name                        STRING,
  suffix                              STRING,
  full_name                             STRING,
  specialty                                STRING,
  sub_specialty                               STRING,
  hospital_affiliation                           STRING,
  group_practice                                    STRING,
  state_license                                        STRING,
  accepting_patients                                      STRING,
  telehealth_enabled                                         STRING,
  years_experience                                              INT64,
  medical_school                                                   STRING,
  dea_number                                                          STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_providers \
--   ./data/pre_providers.csv \
--   ./schema/raw_providers_schema.json
