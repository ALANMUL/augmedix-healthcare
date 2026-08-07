-- =====================================================================
-- STAGING MODEL: stg_dim_icd10
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  icd10_id,
  icd10_code,
  NULLIF(TRIM(description), '')  AS description

FROM {{ source('augmedix_raw', 'raw_dim_icd10') }}
