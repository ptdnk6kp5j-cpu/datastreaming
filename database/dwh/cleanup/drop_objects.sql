-- =========================================================
-- Run as SYSDBA
-- =========================================================

ALTER SESSION SET CONTAINER = dwhpdb1;


DROP SEQUENCE dwh_tiplus_as_landing.seq_master_cdc PURGE;
DROP SEQUENCE dwh_tiplus_eu_landing.seq_master_cdc PURGE;
DROP SEQUENCE dwh_tiplus_as_landing.seq_baseevent_cdc PURGE;
DROP SEQUENCE dwh_tiplus_eu_landing.seq_baseevent_cdc PURGE;


DROP TABLE dwh_tiplus_as_landing.master_cdc
  CASCADE CONSTRAINTS
  PURGE;

DROP TABLE dwh_tiplus_eu_landing.master_cdc
  CASCADE CONSTRAINTS
  PURGE;

DROP TABLE dwh_tiplus_as_landing.baseevent_cdc
  CASCADE CONSTRAINTS
  PURGE;

DROP TABLE dwh_tiplus_eu_landing.baseevent_cdc
  CASCADE CONSTRAINTS
  PURGE;