{{
  config(
    materialized='table'
  )
}}

select
    l.lab_result_id,
    l.encounter_id,
    l.patient_id,
    l.result_value,
    l.reference_range,
    l.abnormal_flag,
    l.collection_date,
    l.result_date,
    l.ordering_provider_id,
    l.lab_status,
    l.specimen_type,
    l.unit,
    l.loinc_code,

    l.lab_test_id,
    lt.lab_test_name,
    lt.lab_abbreviation,
    lt.lab_category,
    lt.body_system,
    lt.is_fasting_required,
    lt.critical_high,
    lt.critical_low

from {{ ref('stg_lab_results') }} as l
left join {{ ref('stg_dim_lab_test') }} as lt
    on l.lab_test_id = lt.lab_test_id
