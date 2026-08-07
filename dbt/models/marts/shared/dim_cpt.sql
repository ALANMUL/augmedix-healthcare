-- =====================================================================
-- MART LAYER: dim_cpt  (shared dimension)
-- Purpose: matches post_dim_cpt.csv target shape exactly (no new columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_claims on cpt_id across all pillars.
-- =====================================================================

SELECT
  cpt_id,
  cpt_code,
  cpt_description,
  pos_code,
  drg_code

FROM {{ ref('stg_dim_cpt') }}
