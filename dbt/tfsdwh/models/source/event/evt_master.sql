{{ config(**source_incremental_config()) }}

{{ source_model(
    payload_sql = master_payload(),
    table_name  = 'master_cdc'
) }}