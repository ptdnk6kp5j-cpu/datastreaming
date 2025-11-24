{{ config(
    materialized='incremental',
    unique_key='baseevent_id'
) }}

with src as (
    select
        key97                      as baseevent_id,
        master_key,
        amount,
        status,
        src_operation_type,
        src_scn,
        src_commit_timestamp,
        dw_source_system,
        dw_insert_ts
    from DWH_LANDING_TIPLUS_AS.BASEEVENT
    {% if is_incremental() %}
        where src_scn > (select max(src_scn) from {{ this }})
    {% endif %}
)

select * from src
