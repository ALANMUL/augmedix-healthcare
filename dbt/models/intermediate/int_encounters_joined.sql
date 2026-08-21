{{
  config(
    materialized='table'
  )
}}

select
    e.encounter_id,
    e.patient_id,
    e.provider_id,
    e.encounter_date,
    e.encounter_type,
    e.chief_complaint,
    e.facility_name,
    e.facility_state,
    e.department,
    e.duration_minutes,
    e.note_type,
    e.visit_disposition,
    e.total_charge,
    e.insurance_paid,
    e.patient_copay,
    e.admit_source,
    e.discharge_date,
    e.readmission_30day,
    e.telehealth_flag,
    e.amb_documentation,
    e.created_timestamp,

    e.icd10_id,
    icd.icd10_code,
    icd.description as icd10_description

from {{ ref('stg_encounters') }} as e
left join {{ ref('stg_dim_icd10') }} as icd
    on e.icd10_id = icd.icd10_id
