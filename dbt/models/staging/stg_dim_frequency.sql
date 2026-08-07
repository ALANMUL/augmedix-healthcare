-- =====================================================================
-- STAGING MODEL: stg_dim_frequency
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  frequency_id,
  frequency_raw,
  NULLIF(TRIM(frequency_label), '')  AS frequency_label,
  frequency_category,
  times_per_day,
  interval_minutes,
  doses_per_week,
  is_prn,
  is_controlled_schedule,
  tier,
  source_system,
  NULLIF(TRIM(description), '')      AS description

FROM {{ source('augmedix_raw', 'raw_dim_frequency') }}
