{{ config(
    materialized='incremental',
    unique_key='hk_link || valid_from'
) }}

with ordered as (
    select 
        hk_link,
        valid_from,
        lead(valid_from) over (partition by hk_link order by valid_from) as next_valid_from
    from {{ ref('sat_link_baseevent_master') }}
)

select
    hk_link,
    valid_from,
    coalesce(next_valid_from, to_timestamp('9999-12-31','YYYY-MM-DD')) as valid_to,
    systimestamp as load_ts
from ordered
