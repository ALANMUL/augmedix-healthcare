{{
  config(
    materialized='table'
  )
}}

select
    p.patient_id,
    p.mrn,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    p.age,
    p.gender,
    p.race,
    p.ethnicity,
    p.preferred_language,
    p.address_line1,
    p.city,
    p.state,
    p.zip_code,
    p.primary_insurance_member_id,
    p.pcp_id,
    p.deceased,
    p.created_date,
    p.smoking_status,
    p.alcohol_use,

    p.primary_insurance_name_id,
    primary_ins.insurance_name as primary_insurance_name,

    p.secondary_insurance_name_id,
    secondary_ins.insurance_name as secondary_insurance_name

from {{ ref('stg_patients') }} as p
left join {{ ref('stg_dim_insurance') }} as primary_ins
    on p.primary_insurance_name_id = primary_ins.insurance_name_id
left join {{ ref('stg_dim_insurance') }} as secondary_ins
    on p.secondary_insurance_name_id = secondary_ins.insurance_name_id
