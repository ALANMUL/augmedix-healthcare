-- =====================================================================
-- MART LAYER: encounters  (Operations pillar)
-- Purpose: adds dacumentation_method, a relabel of amb_documentation,
--          matching post_encounters.csv target shape.
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Encounter page (documentation method breakdown)
-- Note: column name "dacumentation_method" preserves the typo present
--       in the current live model's DAX Studio export, to avoid
--       breaking existing measures/visuals that reference it literally.
-- =====================================================================

SELECT
  encounter_id,
  patient_id,
  provider_id,
  encounter_date,
  encounter_type,
  chief_complaint,
  facility_name,
  facility_state,
  department,
  duration_minutes,
  note_type,
  visit_disposition,
  total_charge,
  insurance_paid,
  patient_copay,
  admit_source,
  discharge_date,
  readmission_30day,
  telehealth_flag,
  amb_documentation,
  created_timestamp,
  icd10_id,
  CASE
    WHEN amb_documentation = 'Complete'   THEN 'AI-Assisted'
    WHEN amb_documentation = 'Incomplete' THEN 'Manual'
    WHEN amb_documentation = 'Pending'    THEN 'Hybrid'
    ELSE NULL
  END AS dacumentation_method

FROM {{ ref('stg_encounters') }}
