{{ config(**source_incremental_config()) }}

{{ source_model(
    payload_sql = baseevent_payload(),
    table_name  = 'baseevent_cdc'
) }}