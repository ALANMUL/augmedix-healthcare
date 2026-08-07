-- =====================================================================
-- STAGING MODEL: stg_dim_lab_test
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  lab_test_id,
  NULLIF(TRIM(lab_test_name), '')  AS lab_test_name,
  lab_abbreviation,
  lab_category,
  body_system,
  is_fasting_required,
  critical_high,
  critical_low,
  unit,
  loinc_code,
  NULLIF(TRIM(description), '')    AS description

FROM {{ source('augmedix_raw', 'raw_dim_lab_test') }}
