{% macro source_model(payload_sql, table_name) %}

{%- set schemas = [
    'landing_tiplus_as',
    'landing_tiplus_eu'
] -%}

{%- for schema in schemas %}

    select

        {{ metadata_payload() }},
        {{ payload_sql }}

    from {{ source(schema, table_name) }}
    where is_after_image = 'Y'
    and {{ incremental_filter() }}

{%- if not loop.last %}

    union all

{%- endif %}

{%- endfor %}

{% endmacro %}