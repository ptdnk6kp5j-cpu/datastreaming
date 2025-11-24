{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_baseevent || load_ts'
) }}

select
    {{ hash(['baseevent_id']) }} as hk_baseevent,
    {{ hashdiff(['status','amount','src_operation_type']) }} as hdiff,
    status,
    amount,
    src_operation_type,
    src_commit_timestamp         as valid_from,
    systimestamp                 as load_ts,
    dw_source_system             as record_source
from {{ ref('stg_baseevent_as') }}

union all

select
    {{ hash(['baseevent_id']) }},
    {{ hashdiff(['status','amount','src_operation_type']) }},
    status,
    amount,
    src_operation_type,
    src_commit_timestamp,
    systimestamp,
    dw_source_system
from {{ ref('stg_baseevent_eu') }}
