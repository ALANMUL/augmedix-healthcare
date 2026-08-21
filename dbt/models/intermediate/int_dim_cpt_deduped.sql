{{
  config(
    materialized='table'
  )
}}

with ranked as (

    select
        *,
        row_number() over (
            partition by cpt_code
            order by cpt_id
        ) as rn

    from {{ ref('stg_dim_cpt') }}

)

select
    cpt_id,
    cpt_code,
    cpt_description,
    pos_code,
    drg_code

from ranked
where rn = 1
