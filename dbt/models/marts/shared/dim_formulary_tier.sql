-- =====================================================================
-- MART LAYER: dim_formulary_tier  (shared dimension)
-- Purpose: matches post_dim_formulary_tier.csv target shape exactly
--          (no new columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_medications on tier_id (Prior Auth Required
--        measure in Medication pillar)
-- =====================================================================

SELECT
  tier_id,
  formulary_tier,
  tier_label,
  cost_level,
  requires_prior_auth,
  mail_order_eligible,
  patient_cost_share,
  description

FROM {{ ref('stg_dim_formulary_tier') }}
