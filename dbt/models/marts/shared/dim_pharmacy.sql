-- =====================================================================
-- MART LAYER: dim_pharmacy  (shared dimension)
-- Purpose: matches post_dim_pharmacy.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: not currently joined in mart_medications (pharmacy_name is
--        stored as free text there) -- available for a future join
--        on pharmacy_name/pharmacy_id if the model is extended.
-- =====================================================================

SELECT
  pharmacy_id,
  pharmacy_name,
  pharmacy_type,
  is_mail_order,
  is_retail,
  is_pbm,
  parent_company,
  description

FROM {{ ref('stg_dim_pharmacy') }}
