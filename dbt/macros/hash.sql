{% macro hash(cols) %}
    upper(
        standard_hash(
            {%- set expr = [] -%}
            {%- for c in cols -%}
                {%- do expr.append("cast(" ~ c ~ " as varchar2(4000))") -%}
            {%- endfor -%}
            {{ expr | join(" || '|' || ") }},
            'SHA256'
        )
    )
{% endmacro %}
