{{
  config(
    materialized='table'
  )
}}

select
    m.medication_id,
    m.patient_id,
    m.prescribing_provider_id,
    m.start_date,
    m.end_date,
    m.status,
    m.refills_authorized,
    m.pharmacy_name,
    m.ndc_code,
    m.generic_flag,
    m.adherence_rate,
    m.dose,
    m.dose_units,

    m.drug_id,
    drug.drug_name,
    drug.drug_class,
    drug.therapeutic_area,
    drug.controlled_substance,
    drug.high_alert_med,
    drug.requires_monitoring,

    m.route_id,
    route.route_label,
    route.route_category,
    route.is_injectable,
    route.is_oral,
    route.is_inhaled,

    m.frequency_id,
    freq.frequency_label,
    freq.frequency_category,
    freq.is_prn,
    freq.is_controlled_schedule,

    m.indication_id,
    ind.indication_label,
    ind.clinical_category,
    ind.is_chronic,
    ind.is_acute,

    m.tier_id,
    tier.formulary_tier,
    tier.tier_label,
    tier.cost_level,
    tier.requires_prior_auth

from {{ ref('stg_medications') }} as m
left join {{ ref('stg_dim_drug') }} as drug
    on m.drug_id = drug.drug_id
left join {{ ref('stg_dim_route') }} as route
    on m.route_id = route.route_id
left join {{ ref('stg_dim_frequency') }} as freq
    on m.frequency_id = freq.frequency_id
left join {{ ref('stg_dim_indication') }} as ind
    on m.indication_id = ind.indication_id
left join {{ ref('stg_dim_formulary_tier') }} as tier
    on m.tier_id = tier.tier_id
