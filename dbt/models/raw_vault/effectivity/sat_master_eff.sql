{{ config(
    materialized='incremental',
    unique_key='hk_master || valid_from'
) }}

with ordered as (
    select 
        hk_master,
        valid_from,
        lead(valid_from) over (partition by hk_master order by valid_from) as next_valid_from
    from {{ ref('sat_master') }}
)

select
    hk_master,
    valid_from,
    coalesce(next_valid_from, to_timestamp('9999-12-31','YYYY-MM-DD')) as valid_to,
    systimestamp as load_ts
from ordered
