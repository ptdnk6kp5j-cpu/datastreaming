{{ config(materialized='view') }}

{%- set yaml_metadata -%}

source_model: 'evt_baseevent'

ldts: 'ingest_ts'
rsrc: {{ metadata_record_source() }}

include_source_columns: true

hashed_columns:
  hk_baseevent:
    - source_system
    - source_zone_name
    - key97

  hk_baseevent_master_l:
    - source_system
    - source_zone_name
    - key97
    - master_key

  hd_baseevent_s:
    is_hashdiff: true
    columns:
      - refno_pfix
      - refno_serl
      - master_key
      - status
      - amount

{%- endset -%}

{{ datavault4dbt.stage(yaml_metadata=yaml_metadata) }}