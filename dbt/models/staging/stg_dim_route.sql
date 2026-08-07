-- =====================================================================
-- STAGING MODEL: stg_dim_route
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  route_id,
  route_raw,
  NULLIF(TRIM(route_label), '')  AS route_label,
  route_category,
  is_injectable,
  is_oral,
  is_inhaled,
  administration_setting,
  NULLIF(TRIM(description), '')  AS description

FROM {{ source('augmedix_raw', 'raw_dim_route') }}
