-- =====================================================================
-- MART LAYER: dim_route  (shared dimension)
-- Purpose: matches post_dim_route.csv target shape exactly (no new
--          columns).
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: joins to mart_medications on route_id (route category used
--        in Medication Safety / Route Category slicers)
-- =====================================================================

SELECT
  route_id,
  route_raw,
  route_label,
  route_category,
  is_injectable,
  is_oral,
  is_inhaled,
  administration_setting,
  description

FROM {{ ref('stg_dim_route') }}
