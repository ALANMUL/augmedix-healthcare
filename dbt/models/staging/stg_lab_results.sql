-- =====================================================================
-- STAGING MODEL: stg_lab_results
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  lab_result_id,
  encounter_id,
  result_value,
  reference_range,
  abnormal_flag,
  SAFE.PARSE_DATE('%Y-%m-%d', collection_date)  AS collection_date,
  SAFE.PARSE_DATE('%Y-%m-%d', result_date)       AS result_date,
  ordering_provider_id,
  lab_status,
  specimen_type,
  lab_test_id,
  patient_id,
  unit,
  loinc_code

FROM {{ source('augmedix_raw', 'raw_lab_results') }}
