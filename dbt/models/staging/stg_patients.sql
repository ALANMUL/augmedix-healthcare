-- =====================================================================
-- STAGING MODEL: stg_patients
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  patient_id,
  mrn,
  first_name,
  last_name,
  SAFE.PARSE_DATE('%Y-%m-%d', date_of_birth)  AS date_of_birth,
  age,
  gender,
  race,
  ethnicity,
  preferred_language,
  address_line1,
  city,
  state,
  zip_code,
  primary_insurance_member_id,
  pcp_id,
  deceased,
  SAFE.PARSE_DATE('%Y-%m-%d', created_date)   AS created_date,
  smoking_status,
  alcohol_use,
  primary_insurance_name_id,
  CAST(secondary_insurance_name_id AS INT64)  AS secondary_insurance_name_id

FROM {{ source('augmedix_raw', 'raw_patients') }}
