-- =====================================================================
-- MART LAYER: patients  (Population Health pillar)
-- Purpose: matches post_patients.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Population page (chronic prevalence, risk
--        stratification, dual insurance rate, geriatric rate)
-- Note: age-band column and high-risk patient flag are planned as
--       Power Query calculated columns per your build notes, not here
--       -- keeping this mart a clean passthrough so Power Query owns
--       that presentation-layer logic.
-- =====================================================================

SELECT
  patient_id,
  mrn,
  first_name,
  last_name,
  date_of_birth,
  age,
  gender,
  race,
  ethnicity,
  preferred_language,
  address_line1,
  city,
  state,
  zip_code,
  primary_insurance_member_id,
  pcp_id,
  deceased,
  created_date,
  smoking_status,
  alcohol_use,
  primary_insurance_name_id,
  secondary_insurance_name_id

FROM {{ ref('stg_patients') }}
