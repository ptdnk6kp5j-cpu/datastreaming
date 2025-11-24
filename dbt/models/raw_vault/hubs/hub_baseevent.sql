{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_baseevent'
) }}

select
    {{ hash(['baseevent_id']) }} as hk_baseevent,
    baseevent_id                 as natural_key,
    dw_source_system             as record_source,
    src_scn                      as src_scn,
    systimestamp                 as load_ts
from {{ ref('stg_baseevent_as') }}

union all

select
    {{ hash(['baseevent_id']) }},
    baseevent_id,
    dw_source_system,
    src_scn,
    systimestamp
from {{ ref('stg_baseevent_eu') }}
