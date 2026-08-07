-- =====================================================================
-- VERIFY ROW COUNTS — run after loading, compare against expected
-- =====================================================================

SELECT 'raw_claims' AS table_name, COUNT(*) AS row_count, 15104 AS expected FROM `augmedix-healthcare.augmedix.raw_claims`
UNION ALL
SELECT 'raw_diagnoses', COUNT(*), 18636 FROM `augmedix-healthcare.augmedix.raw_diagnoses`
UNION ALL
SELECT 'raw_dim_cpt', COUNT(*), 1870 FROM `augmedix-healthcare.augmedix.raw_dim_cpt`
UNION ALL
SELECT 'raw_dim_drug', COUNT(*), 20 FROM `augmedix-healthcare.augmedix.raw_dim_drug`
UNION ALL
SELECT 'raw_dim_formulary_tier', COUNT(*), 4 FROM `augmedix-healthcare.augmedix.raw_dim_formulary_tier`
UNION ALL
SELECT 'raw_dim_frequency', COUNT(*), 44 FROM `augmedix-healthcare.augmedix.raw_dim_frequency`
UNION ALL
SELECT 'raw_dim_icd10', COUNT(*), 25 FROM `augmedix-healthcare.augmedix.raw_dim_icd10`
UNION ALL
SELECT 'raw_dim_indication', COUNT(*), 16 FROM `augmedix-healthcare.augmedix.raw_dim_indication`
UNION ALL
SELECT 'raw_dim_insurance', COUNT(*), 13 FROM `augmedix-healthcare.augmedix.raw_dim_insurance`
UNION ALL
SELECT 'raw_dim_lab_test', COUNT(*), 18 FROM `augmedix-healthcare.augmedix.raw_dim_lab_test`
UNION ALL
SELECT 'raw_dim_pharmacy', COUNT(*), 6 FROM `augmedix-healthcare.augmedix.raw_dim_pharmacy`
UNION ALL
SELECT 'raw_dim_route', COUNT(*), 4 FROM `augmedix-healthcare.augmedix.raw_dim_route`
UNION ALL
SELECT 'raw_encounters', COUNT(*), 7552 FROM `augmedix-healthcare.augmedix.raw_encounters`
UNION ALL
SELECT 'raw_lab_results', COUNT(*), 15839 FROM `augmedix-healthcare.augmedix.raw_lab_results`
UNION ALL
SELECT 'raw_medications', COUNT(*), 13501 FROM `augmedix-healthcare.augmedix.raw_medications`
UNION ALL
SELECT 'raw_patients', COUNT(*), 3000 FROM `augmedix-healthcare.augmedix.raw_patients`
UNION ALL
SELECT 'raw_providers', COUNT(*), 200 FROM `augmedix-healthcare.augmedix.raw_providers`
UNION ALL
SELECT 'raw_vital_signs', COUNT(*), 5000 FROM `augmedix-healthcare.augmedix.raw_vital_signs`
ORDER BY table_name;

-- Flag any row where row_count != expected before proceeding to dbt build.
