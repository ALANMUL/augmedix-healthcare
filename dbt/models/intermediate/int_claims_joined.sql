{{
  config(
    materialized='table'
  )
}}

select
    c.claim_id,
    c.encounter_id,
    c.patient_id,
    c.provider_id,
    c.claim_date,
    c.units,
    c.charge_amount,
    c.allowed_amount,
    c.insurance_paid,
    c.patient_responsibility,
    c.claim_status,
    c.denial_reason,
    c.claim_submitted_date,
    c.claim_paid_date,

    c.cpt_id,
    cpt.cpt_code,
    cpt.cpt_description,
    cpt.pos_code,
    cpt.drg_code,

    c.icd10_id,
    icd.icd10_code,
    icd.description as icd10_description,

    c.insurance_name_id,
    ins.insurance_name

from {{ ref('stg_claims') }} as c
left join {{ ref('int_dim_cpt_deduped') }} as cpt
    on c.cpt_id = cpt.cpt_id
left join {{ ref('stg_dim_icd10') }} as icd
    on c.icd10_id = icd.icd10_id
left join {{ ref('stg_dim_insurance') }} as ins
    on c.insurance_name_id = ins.insurance_name_id
