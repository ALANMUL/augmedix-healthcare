-- =====================================================================
-- STAGING MODEL: stg_dim_formulary_tier
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  tier_id,
  formulary_tier,
  NULLIF(TRIM(tier_label), '')   AS tier_label,
  cost_level,
  requires_prior_auth,
  mail_order_eligible,
  patient_cost_share,
  NULLIF(TRIM(description), '')  AS description

FROM {{ source('augmedix_raw', 'raw_dim_formulary_tier') }}
