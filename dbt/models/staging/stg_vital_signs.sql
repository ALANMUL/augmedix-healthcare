-- =====================================================================
-- STAGING MODEL: stg_vital_signs
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  vital_id,
  encounter_id,
  SAFE.PARSE_DATE('%Y-%m-%d', recorded_date)  AS recorded_date,
  SAFE.PARSE_TIME('%H:%M:%S', recorded_time)  AS recorded_time,
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

FROM {{ source('augmedix_raw', 'raw_vital_signs') }}
