-- =====================================================================
-- RAW LAYER: claims
-- Source: pre_claims.csv (DAX Studio export, resolved surrogate keys)
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_claims` (
  claim_id                STRING,
  encounter_id             STRING,
  patient_id               STRING,
  provider_id              STRING,
  claim_date                STRING,   -- kept as STRING in raw; cast happens in staging
  units                    INT64,
  charge_amount            FLOAT64,
  allowed_amount           FLOAT64,
  insurance_paid           FLOAT64,
  patient_responsibility   FLOAT64,
  claim_status              STRING,
  denial_reason             STRING,
  claim_submitted_date       STRING,
  claim_paid_date            STRING,
  cpt_id                    INT64,
  insurance_name_id         INT64,
  icd10_id                  INT64
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_claims \
--   ./data/pre_claims.csv \
--   ./schema/raw_claims_schema.json
