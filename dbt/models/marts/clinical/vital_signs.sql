-- =====================================================================
-- MART LAYER: vital_signs  (Clinical Quality pillar)
-- Purpose: matches post_vital_signs.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_encounters on encounter_id (BP/BMI category
--        breakdowns, vitals-based quality flags)
-- =====================================================================

SELECT
  vital_id,
  encounter_id,
  recorded_date,
  recorded_time,
  systolic_bp,
  diastolic_bp,
  bp_flag,
  heart_rate_bpm,
  respiratory_rate,
  temperature_f,
  o2_saturation_pct,
  height_cm,
  weight_kg,
  bmi,
  bmi_category,
  pain_scale_0_10,
  recorded_by

FROM {{ ref('stg_vital_signs') }}
