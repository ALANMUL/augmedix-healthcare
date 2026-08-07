-- =====================================================================
-- STAGING MODEL: stg_dim_pharmacy
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  pharmacy_id,
  NULLIF(TRIM(pharmacy_name), '')  AS pharmacy_name,
  pharmacy_type,
  is_mail_order,
  is_retail,
  is_pbm,
  NULLIF(TRIM(parent_company), '') AS parent_company,
  NULLIF(TRIM(description), '')    AS description

FROM {{ source('augmedix_raw', 'raw_dim_pharmacy') }}
