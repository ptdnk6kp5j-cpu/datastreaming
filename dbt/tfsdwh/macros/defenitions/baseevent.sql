{# ============================================================
  Baseevent - canonical data definition
  Used in: Source, Stage, DV (Hub / Sat)
============================================================ #}

{% macro baseevent_payload() %}
    key97,
    refno_pfix,
    refno_serl,
    master_key,
    status,
    amount
{% endmacro %}


{% macro baseevent_business_key() %}
    key97
{% endmacro %}


{% macro baseevent_sat_payload() %}
    refno_pfix,
    refno_serl,
    master_key,
    status,
    amount
{% endmacro %}