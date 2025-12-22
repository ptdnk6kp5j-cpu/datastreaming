{% macro metadata_payload(prefix='') %}
    {{ prefix }}source_system,
    {{ prefix }}source_zone_name,
    {{ prefix }}source_zone_code,
    {{ prefix }}source_region,
    {{ prefix }}source_schema,
    {{ prefix }}source_table,
    {{ prefix }}source_logical_db,
    {{ prefix }}source_technical_db,

    {{ prefix }}source_event_id,
    {{ prefix }}source_txn_id,
    {{ prefix }}op_type,
    {{ prefix }}is_before_image,
    {{ prefix }}is_after_image,

    {{ prefix }}source_commit_ts,
    {{ prefix }}source_scn,

    {{ prefix }}ingest_ts,
    {{ prefix }}ingest_seq,
    {{ prefix }}ingest_batch_id
{% endmacro %}

{% macro metadata_start_timestamp() %}
    TO_TIMESTAMP_TZ('{{ run_started_at.strftime('%Y-%m-%d %H:%M:%S.%f %z') }}', 'YYYY-MM-DD HH24:MI:SS.FF6 TZH:TZM')
{% endmacro %}

{% macro metadata_record_source() %}
    (source_system || '||' || source_zone_name)
{% endmacro %}
