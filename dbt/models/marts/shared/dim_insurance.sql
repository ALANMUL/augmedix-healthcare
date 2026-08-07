-- =====================================================================
-- MART LAYER: dim_insurance  (shared dimension)
-- Purpose: matches post_dim_insurence.csv target shape, with the
--          insurance_name_id column name corrected (see staging note).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_claims on insurance_name_id (Payer Performance
--        table, Denial Rate by Payer measure), and mart_patients on
--        primary/secondary_insurance_name_id (Dual Insurance Rate)
-- =====================================================================

SELECT
  insurance_name,
  insurance_name_id

FROM {{ ref('stg_dim_insurance') }}
