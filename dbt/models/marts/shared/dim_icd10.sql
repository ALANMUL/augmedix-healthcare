-- =====================================================================
-- MART LAYER: dim_icd10  (shared dimension)
-- Purpose: matches post_dim_icd10.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_claims and mart_diagnoses on icd10_id
--        (Top 10 Diagnoses, Chronic Disease Burden visuals)
-- =====================================================================

SELECT
  icd10_id,
  icd10_code,
  description

FROM {{ ref('stg_dim_icd10') }}
