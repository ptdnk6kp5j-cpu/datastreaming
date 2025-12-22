-- =========================================================
-- Run as SYSDBA
-- =========================================================

ALTER SESSION SET CONTAINER = dwhpdb1;

-- =========================================================
-- master_cdc
-- =========================================================

CREATE TABLE dwh_tiplus_as_landing.master_cdc (
  -- source system info
  source_system        VARCHAR2(20),   -- 'TIPLUS'
  source_zone_name     VARCHAR2(10),   -- AS / EU
  source_zone_code     NUMBER(2),
  source_region        VARCHAR2(20),
  source_schema        VARCHAR2(50),
  source_table         VARCHAR2(50),
  source_logical_db    VARCHAR2(50),
  source_technical_db  VARCHAR2(100),
  -- cdc info
  source_event_id      NUMBER,
  source_txn_id        VARCHAR2(100),
  op_type              CHAR(1),
  is_before_image      CHAR(1),
  is_after_image       CHAR(1),
  -- time info
  source_commit_ts     TIMESTAMP,
  source_scn           NUMBER,
  ingest_ts            TIMESTAMP,
  ingest_seq           NUMBER,
  ingest_batch_id      VARCHAR2(50),
  -- payload
  key97                NUMBER,
  refno_mbe            CHAR(8 CHAR),
  refno_pfix           CHAR(3 CHAR),
  refno_brn            CHAR(8 CHAR),
  master_ref           CHAR(20 CHAR),
  status               CHAR(4 CHAR),
  amount               NUMBER(15,0)
);

CREATE TABLE dwh_tiplus_eu_landing.master_cdc AS
SELECT
  *
FROM
  dwh_tiplus_as_landing.master_cdc
WHERE
  1 = 0;

-- =========================================================
-- baseevent_cdc
-- =========================================================

CREATE TABLE dwh_tiplus_as_landing.baseevent_cdc (
  source_system        VARCHAR2(20),
  source_zone_name     VARCHAR2(10),
  source_zone_code     NUMBER(2),
  source_region        VARCHAR2(20),
  source_schema        VARCHAR2(50),
  source_table         VARCHAR2(50),
  source_logical_db    VARCHAR2(50),
  source_technical_db  VARCHAR2(100),
  source_event_id      NUMBER,
  source_txn_id        VARCHAR2(100),
  op_type              CHAR(1),
  is_before_image      CHAR(1),
  is_after_image       CHAR(1),
  source_commit_ts     TIMESTAMP,
  source_scn           NUMBER,
  ingest_ts            TIMESTAMP,
  ingest_seq           NUMBER,
  ingest_batch_id      VARCHAR2(50),
  key97                NUMBER,
  refno_pfix           CHAR(3 CHAR),
  refno_serl           NUMBER,
  master_key           NUMBER,
  status               CHAR(1),
  amount               NUMBER(15,0)
);

CREATE TABLE dwh_tiplus_eu_landing.baseevent_cdc AS
SELECT
  *
FROM
  dwh_tiplus_as_landing.baseevent_cdc
WHERE
  1 = 0;

CREATE SEQUENCE dwh_tiplus_as_landing.seq_baseevent_cdc
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
CACHE 1000;

CREATE SEQUENCE dwh_tiplus_as_landing.seq_master_cdc
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
CACHE 1000;

CREATE SEQUENCE dwh_tiplus_eu_landing.seq_baseevent_cdc
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
CACHE 1000;

CREATE SEQUENCE dwh_tiplus_eu_landing.seq_master_cdc
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
CACHE 1000;