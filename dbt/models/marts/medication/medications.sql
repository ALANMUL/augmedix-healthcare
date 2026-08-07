-- =====================================================================
-- MART LAYER: medications  (Medication / Pharmacy pillar)
-- Purpose: matches post_medications.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI Medication page (Generic Rate, Adherence, Controlled
--        Substance, Prior Auth measures via joins to dim_drug,
--        dim_route, dim_frequency, dim_indication, dim_formulary_tier)
-- =====================================================================

SELECT
  medication_id,
  patient_id,
  prescribing_provider_id,
  start_date,
  end_date,
  status,
  refills_authorized,
  pharmacy_name,
  ndc_code,
  generic_flag,
  adherence_rate,
  dose,
  dose_units,
  frequency_id,
  drug_id,
  route_id,
  indication_id,
  tier_id

FROM {{ ref('stg_medications') }}
