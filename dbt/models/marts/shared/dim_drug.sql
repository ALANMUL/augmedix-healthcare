-- =====================================================================
-- MART LAYER: dim_drug  (shared dimension)
-- Purpose: matches post_dim_drug.csv target shape exactly (no new columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_medications on drug_id (controlled_substance,
--        high_alert_med flags used in Medication Safety measures)
-- =====================================================================

SELECT
  drug_id,
  drug_name,
  drug_class,
  therapeutic_area,
  controlled_substance,
  high_alert_med,
  requires_monitoring,
  standard_dose,
  route_category

FROM {{ ref('stg_dim_drug') }}
