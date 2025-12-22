{# ============================================================
  Master - canonical data definition
  Used in: Source, Stage, DV (Hub / Sat)
============================================================ #}

{% macro master_payload() %}
    key97,
    refno_mbe,
    refno_pfix,
    refno_brn,
    master_ref,
    status,
    amount
{% endmacro %}


{% macro master_business_key() %}
    key97
{% endmacro %}


{% macro master_sat_payload() %}
    refno_mbe,
    refno_pfix,
    refno_brn,
    master_ref,
    status,
    amount
{% endmacro %}