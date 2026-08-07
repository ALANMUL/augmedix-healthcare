-- =====================================================================
-- STAGING MODEL: stg_diagnoses
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  diagnosis_id,
  encounter_id,
  patient_id,
  diagnosis_type,
  rank,
  SAFE.PARSE_DATE('%Y-%m-%d', diagnosis_date)   AS diagnosis_date,
  dx_status,
  confirmed_by_provider,
  icd10_id

FROM {{ source('augmedix_raw', 'raw_diagnoses') }}
