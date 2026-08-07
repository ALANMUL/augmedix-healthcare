-- =====================================================================
-- MART LAYER: dim_lab_test  (shared dimension)
-- Purpose: matches post_dim_lab_test.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_lab_results on lab_test_id (critical_high/low
--        thresholds used in Critical Rate measure, Lab Results pillar)
-- =====================================================================

SELECT
  lab_test_id,
  lab_test_name,
  lab_abbreviation,
  lab_category,
  body_system,
  is_fasting_required,
  critical_high,
  critical_low,
  unit,
  loinc_code,
  description

FROM {{ ref('stg_dim_lab_test') }}
