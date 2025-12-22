{{ config(materialized='view') }}

{%- set yaml_metadata -%}

source_model: 'evt_master'

ldts: 'ingest_ts'
rsrc: {{ metadata_record_source() }}

include_source_columns: true

hashed_columns:
  hk_master:
    - source_system
    - source_zone_name
    - key97

  hd_master_s:
    is_hashdiff: true
    columns:
      - refno_mbe
      - refno_pfix
      - refno_brn
      - master_ref
      - status
      - amount

{%- endset -%}

{{ datavault4dbt.stage(yaml_metadata=yaml_metadata) }}