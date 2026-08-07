-- =====================================================================
-- MART LAYER: diagnoses  (Clinical Quality pillar)
-- Purpose: adds diagnostic complexity calc, matching post_diagnoses.csv
--          target shape.
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Clinical Quality page (Readmission Rate by Diagnostic
--        Complexity bar)
-- =====================================================================

WITH dx_counts AS (
  SELECT
    encounter_id,
    COUNT(diagnosis_id) AS dx_count_per_encounter
  FROM {{ ref('stg_diagnoses') }}
  GROUP BY encounter_id
)

SELECT
  d.diagnosis_id,
  d.encounter_id,
  d.patient_id,
  d.diagnosis_type,
  d.rank,
  d.diagnosis_date,
  d.dx_status,
  d.confirmed_by_provider,
  d.icd10_id,
  c.dx_count_per_encounter AS dx_count_per_encounter,
  CASE
    WHEN c.dx_count_per_encounter = 1 THEN '1 Diagnosis'
    WHEN c.dx_count_per_encounter = 2 THEN '2 Diagnoses'
    WHEN c.dx_count_per_encounter = 3 THEN '3 Diagnoses'
    ELSE '4+ Diagnoses'
  END AS dx_complexity_bucket
FROM {{ ref('stg_diagnoses') }} d
JOIN dx_counts c
  ON d.encounter_id = c.encounter_id
