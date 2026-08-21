#!/bin/bash
# =====================================================================
# LOAD ALL RAW TABLES — run from repo root, requires bq CLI authenticated
# Usage: bash ops/load_all_raw.sh
# Assumes: sql/raw/*.sql already run (tables exist), CSVs in data/pre_process/
# =====================================================================

set -e  # stop on first error

PROJECT="augmedix-healthcare"
DATASET="augmedix"
DATA_DIR="data/pre_process"

declare -A TABLE_FILES=(
  ["raw_claims"]="pre_claims.csv"
  ["raw_diagnoses"]="pre_diagnoses.csv"
  ["raw_dim_cpt"]="pre_dim_cpt.csv"
  ["raw_dim_drug"]="pre_dim_drug.csv"
  ["raw_dim_formulary_tier"]="pre_dim_formulary_tier.csv"
  ["raw_dim_frequency"]="pre_dim_frequency.csv"
  ["raw_dim_icd10"]="pre_dim_icd10.csv"
  ["raw_dim_indication"]="pre_dim_indication.csv"
  ["raw_dim_insurance"]="pre_dim_insurence.csv"
  ["raw_dim_lab_test"]="pre_dim_lab_test.csv"
  ["raw_dim_pharmacy"]="pre_dim_pharmacy.csv"
  ["raw_dim_route"]="pre_dim_route.csv"
  ["raw_encounters"]="pre_encounters.csv"
  ["raw_lab_results"]="pre_lab_results.csv"
  ["raw_medications"]="pre_medications.csv"
  ["raw_patients"]="pre_patients.csv"
  ["raw_providers"]="pre_providers.csv"
  ["raw_vital_signs"]="pre_vital_signs.csv"
)

for TABLE in "${!TABLE_FILES[@]}"; do
  CSV="${TABLE_FILES[$TABLE]}"
  echo "Loading $CSV -> $TABLE ..."
  bq load \
    --source_format=CSV \
    --skip_leading_rows=1 \
    --replace=true \
    "${PROJECT}:${DATASET}.${TABLE}" \
    "${DATA_DIR}/${CSV}"
done

echo "All 18 raw tables loaded."
