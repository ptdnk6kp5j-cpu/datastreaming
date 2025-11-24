{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_master'
) }}

select
    {{ hash(['master_ref']) }}  as hk_master,
    master_ref                  as natural_key,
    dw_source_system            as record_source,
    src_scn                     as src_scn,
    systimestamp                as load_ts
from {{ ref('stg_master_as') }}

union all

select
    {{ hash(['master_ref']) }},
    master_ref,
    dw_source_system,
    src_scn,
    systimestamp
from {{ ref('stg_master_eu') }}
