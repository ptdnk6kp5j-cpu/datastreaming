{{ config(
    materialized='incremental',
    incremental_strategy='append',
    unique_key='hk_master || load_ts'
) }}

select
    {{ hash(['master_ref']) }} as hk_master,
    {{ hashdiff(['status','amount','src_operation_type']) }} as hdiff,
    status,
    amount,
    src_operation_type,
    src_commit_timestamp       as valid_from,
    systimestamp               as load_ts,
    dw_source_system           as record_source
from {{ ref('stg_master_as') }}

union all

select
    {{ hash(['master_ref']) }},
    {{ hashdiff(['status','amount','src_operation_type']) }},
    status,
    amount,
    src_operation_type,
    src_commit_timestamp,
    systimestamp,
    dw_source_system
from {{ ref('stg_master_eu') }}
