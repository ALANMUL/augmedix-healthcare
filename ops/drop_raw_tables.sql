-- =====================================================================
-- DROP RAW TABLES — run before re-creating with corrected DDL
-- Run in BigQuery Console query editor (or bq CLI / Cloud Shell)
-- =====================================================================

DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_claims`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_diagnoses`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_cpt`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_drug`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_formulary_tier`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_frequency`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_icd10`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_indication`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_insurance`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_lab_test`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_pharmacy`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_dim_route`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_encounters`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_lab_results`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_medications`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_patients`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_providers`;
DROP TABLE IF EXISTS `augmedix-healthcare.augmedix.raw_vital_signs`;
