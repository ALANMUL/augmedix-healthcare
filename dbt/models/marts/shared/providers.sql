-- =====================================================================
-- MART LAYER: providers  (capstone / cross-pillar dimension)
-- Purpose: matches post_providers.csv target shape -- drops
--          first_name/last_name (redundant with full_name, and
--          mismatched with it -- see staging notes).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Provider Scorecard page (Revenue/Provider,
--        Encounters/Provider, Denial Rate, Telehealth Rate)
-- Note: full_name does not reliably map back to first_name/last_name
--       on the same row in the source data (independently randomized
--       synthetic fields). Dropping first_name/last_name here removes
--       that mismatch from anything downstream.
-- =====================================================================

SELECT
  provider_id,
  npi,
  suffix,
  full_name,
  specialty,
  sub_specialty,
  hospital_affiliation,
  group_practice,
  state_license,
  accepting_patients,
  telehealth_enabled,
  years_experience,
  medical_school,
  dea_number

FROM {{ ref('stg_providers') }}
