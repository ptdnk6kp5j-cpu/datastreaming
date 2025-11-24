{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_link'
) }}

select
    {{ hash(['baseevent_id','master_key']) }} as hk_link,
    {{ hash(['baseevent_id']) }}              as hk_baseevent,
    {{ hash(['master_key']) }}                as hk_master,
    src_scn                                   as src_scn,
    dw_source_system                           as record_source,
    systimestamp                               as load_ts
from {{ ref('stg_baseevent_as') }}

union all

select
    {{ hash(['baseevent_id','master_key']) }},
    {{ hash(['baseevent_id']) }},
    {{ hash(['master_key']) }},
    src_scn,
    dw_source_system,
    systimestamp
from {{ ref('stg_baseevent_eu') }}
