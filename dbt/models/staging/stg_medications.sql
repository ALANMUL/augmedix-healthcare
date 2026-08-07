-- =====================================================================
-- STAGING MODEL: stg_medications
-- Materialized as: table (see dbt_project.yml)
-- 
-- =====================================================================

SELECT
  medication_id,
  patient_id,
  prescribing_provider_id,
  SAFE.PARSE_DATE('%Y-%m-%d', start_date)  AS start_date,
  SAFE.PARSE_DATE('%Y-%m-%d', end_date)    AS end_date,
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

FROM {{ source('augmedix_raw', 'raw_medications') }}
