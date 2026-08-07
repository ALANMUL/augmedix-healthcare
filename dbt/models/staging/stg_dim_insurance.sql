-- =====================================================================
-- STAGING MODEL: stg_dim_insurance
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  NULLIF(TRIM(insurance_name), '')  AS insurance_name,
  insurence_name_id                 AS insurance_name_id   -- typo fixed

FROM {{ source('augmedix_raw', 'raw_dim_insurance') }}
