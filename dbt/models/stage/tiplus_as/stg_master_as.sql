{{ config(
    materialized='incremental',
    unique_key='master_ref'
) }}

with src as (
    select
        master_ref,
        amount,
        status,
        src_operation_type,
        src_scn,
        src_commit_timestamp,
        dw_source_system,
        dw_insert_ts
    from DWH_LANDING_TIPLUS_AS.MASTER
    {% if is_incremental() %}
        where src_scn > (select max(src_scn) from {{ this }})
    {% endif %}
)

select * from src
