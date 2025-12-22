{% macro source_incremental_config() %}
  {{
    return({
      "materialized": "incremental",
      "unique_key": "source_event_id",
      "indexes": [
        {
          "name": "idx_" ~ this.identifier ~ "_hwm",
          "columns": ["ingest_ts", "ingest_seq"]
        }
      ]
    })
  }}
{% endmacro %}