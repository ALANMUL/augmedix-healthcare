-- =====================================================================
-- MART LAYER: dim_indication  (shared dimension)
-- Purpose: matches post_dim_indication.csv target shape exactly
--          (no new columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_medications on indication_id (is_chronic flag
--        used in Chronic Disease Burden / Medication pillar)
-- =====================================================================

SELECT
  indication_id,
  indication_raw,
  indication_label,
  clinical_category,
  is_chronic,
  is_acute,
  body_system,
  icd10_category

FROM {{ ref('stg_dim_indication') }}
