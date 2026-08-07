-- =====================================================================
-- STAGING MODEL: stg_dim_indication
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  indication_id,
  indication_raw,
  NULLIF(TRIM(indication_label), '')  AS indication_label,
  clinical_category,
  is_chronic,
  is_acute,
  body_system,
  icd10_category

FROM {{ source('augmedix_raw', 'raw_dim_indication') }}
