-- =====================================================================
-- STAGING MODEL: stg_dim_cpt
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  cpt_id,
  cpt_code,
  NULLIF(TRIM(cpt_description), '')  AS cpt_description,
  pos_code,
  drg_code

FROM {{ source('augmedix_raw', 'raw_dim_cpt') }}
