-- =====================================================================
-- MART LAYER: lab_results  (Clinical Quality pillar)
-- Purpose: matches post_lab_results.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Lab Results page (Abnormal Rate, Critical Rate,
--        Avg Turnaround Days)
-- =====================================================================

SELECT
  lab_result_id,
  encounter_id,
  result_value,
  reference_range,
  abnormal_flag,
  collection_date,
  result_date,
  ordering_provider_id,
  lab_status,
  specimen_type,
  lab_test_id,
  patient_id,
  unit,
  loinc_code

FROM {{ ref('stg_lab_results') }}
