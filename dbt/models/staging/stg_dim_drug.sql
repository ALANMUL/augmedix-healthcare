-- =====================================================================
-- STAGING MODEL: stg_dim_drug
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  drug_id,
  NULLIF(TRIM(drug_name), '')            AS drug_name,
  NULLIF(TRIM(drug_class), '')           AS drug_class,
  NULLIF(TRIM(therapeutic_area), '')     AS therapeutic_area,
  controlled_substance,
  high_alert_med,
  requires_monitoring,
  standard_dose,
  route_category

FROM {{ source('augmedix_raw', 'raw_dim_drug') }}
