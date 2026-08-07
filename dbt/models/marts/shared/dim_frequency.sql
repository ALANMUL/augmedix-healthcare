-- =====================================================================
-- MART LAYER: dim_frequency  (shared dimension)
-- Purpose: matches post_dim_frequency.csv target shape exactly
--          (no new columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_medications on frequency_id (PRN Medications
--        measure in Medication pillar)
-- =====================================================================

SELECT
  frequency_id,
  frequency_raw,
  frequency_label,
  frequency_category,
  times_per_day,
  interval_minutes,
  doses_per_week,
  is_prn,
  is_controlled_schedule,
  tier,
  source_system,
  description

FROM {{ ref('stg_dim_frequency') }}
