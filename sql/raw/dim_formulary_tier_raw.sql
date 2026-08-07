-- =====================================================================
-- RAW LAYER: dim_formulary_tier
-- Source: pre_dim_formulary_tier.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_dim_formulary_tier` (
  tier_id                STRING,
  formulary_tier           STRING,
  tier_label                STRING,
  cost_level                  STRING,
  requires_prior_auth           STRING,
  mail_order_eligible              STRING,
  patient_cost_share                  STRING,
  description                            STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_dim_formulary_tier \
--   ./data/pre_dim_formulary_tier.csv \
--   ./schema/raw_dim_formulary_tier_schema.json
