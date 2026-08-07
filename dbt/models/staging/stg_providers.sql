-- =====================================================================
-- STAGING MODEL: stg_providers
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  provider_id,
  npi,
  first_name,
  last_name,
  suffix,
  full_name,
  specialty,
  NULLIF(TRIM(sub_specialty), '')  AS sub_specialty,
  hospital_affiliation,
  group_practice,
  state_license,
  accepting_patients,
  telehealth_enabled,
  years_experience,
  medical_school,
  dea_number

FROM {{ source('augmedix_raw', 'raw_providers') }}
