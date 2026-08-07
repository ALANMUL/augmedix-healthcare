-- =====================================================================
-- STAGING MODEL: stg_encounters
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  encounter_id,
  patient_id,
  provider_id,
  SAFE.PARSE_DATE('%Y-%m-%d', encounter_date)             AS encounter_date,
  encounter_type,
  NULLIF(TRIM(chief_complaint), '')                        AS chief_complaint,
  facility_name,
  facility_state,
  department,
  duration_minutes,
  note_type,
  visit_disposition,
  total_charge,
  insurance_paid,
  patient_copay,
  admit_source,
  SAFE.PARSE_DATE('%Y-%m-%d', discharge_date)              AS discharge_date,
  readmission_30day,
  telehealth_flag,
  amb_documentation,
  SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%S', created_timestamp) AS created_timestamp,
  icd10_id

FROM {{ source('augmedix_raw', 'raw_encounters') }}
