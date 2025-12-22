{% macro incremental_filter() %}
(
    1 = 1
    {% if is_incremental() %}
    AND (
        -- 1) source is empty for this flow → load all records
        NOT EXISTS (
            SELECT 1
            FROM {{ this }} t
            WHERE
                t.source_system   = source_system
            AND t.source_zone_name = source_zone_name
        )
        OR
        -- 2) source contains data for this flow → load only newer records
        EXISTS (
            SELECT 1
            FROM {{ this }} t
            WHERE
                t.source_system   = source_system
            AND t.source_zone_name = source_zone_name
            AND (
                ingest_ts > t.ingest_ts
                OR (
                    ingest_ts = t.ingest_ts
                AND ingest_seq > t.ingest_seq
                )
            )
        )
    )
    {% endif %}
)
{% endmacro %}