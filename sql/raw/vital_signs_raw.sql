-- =====================================================================
-- RAW LAYER: vital_signs
-- Source: pre_vital_signs.csv
-- Purpose: 1:1 passthrough of source file. No transforms, no casts.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `augmedix-healthcare.augmedix.raw_vital_signs` (
  vital_id                STRING,
  encounter_id               STRING,
  recorded_date                  STRING,   -- cast in staging
  recorded_time                     STRING,   -- cast in staging
  systolic_bp                          INT64,
  diastolic_bp                            INT64,
  bp_flag                                    STRING,
  heart_rate_bpm                                INT64,
  respiratory_rate                                 INT64,
  temperature_f                                       FLOAT64,
  o2_saturation_pct                                      FLOAT64,
  height_cm                                                 FLOAT64,
  weight_kg                                                    FLOAT64,
  bmi                                                             FLOAT64,
  bmi_category                                                       STRING,
  pain_scale_0_10                                                       INT64,
  recorded_by                                                              STRING
);

-- Load pattern (bq CLI):
-- bq load --source_format=CSV --skip_leading_rows=1 --replace=false \
--   augmedix-healthcare:augmedix.raw_vital_signs \
--   ./data/pre_vital_signs.csv \
--   ./schema/raw_vital_signs_schema.json
