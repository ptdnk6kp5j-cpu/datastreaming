{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_link || load_ts'
) }}

select
    {{ hash(['baseevent_id','master_key']) }} as hk_link,
    {{ hashdiff(['master_key']) }}            as hdiff,
    src_commit_timestamp                      as valid_from,
    systimestamp                              as load_ts,
    dw_source_system                          as record_source
from {{ ref('stg_baseevent_as') }}

union all

select
    {{ hash(['baseevent_id','master_key']) }},
    {{ hashdiff(['master_key']) }},
    src_commit_timestamp,
    systimestamp,
    dw_source_system
from {{ ref('stg_baseevent_eu') }}
