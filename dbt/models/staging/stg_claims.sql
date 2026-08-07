-- =====================================================================
-- STAGING MODEL: stg_claims
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  claim_id,
  encounter_id,
  patient_id,
  provider_id,
  SAFE.PARSE_DATE('%Y-%m-%d', claim_date)              AS claim_date,
  units,
  charge_amount,
  allowed_amount,
  insurance_paid,
  patient_responsibility,
  claim_status,
  NULLIF(TRIM(denial_reason), '')                      AS denial_reason,
  SAFE.PARSE_DATE('%Y-%m-%d', claim_submitted_date)     AS claim_submitted_date,
  SAFE.PARSE_DATE('%Y-%m-%d', claim_paid_date)          AS claim_paid_date,
  cpt_id,
  insurance_name_id,
  icd10_id

FROM {{ source('augmedix_raw', 'raw_claims') }}
