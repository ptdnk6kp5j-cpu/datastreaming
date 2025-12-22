-- =========================================================
-- Run as SYSDBA
-- =========================================================

ALTER SESSION SET CONTAINER = dwhpdb1;

-- =========================================================
-- tiplus landing schemas
-- =========================================================

CREATE USER dwh_tiplus_as_landing
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

CREATE USER dwh_tiplus_eu_landing
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- =========================================================
-- tiplus source schema
-- =========================================================

CREATE USER dwh_tiplus_source
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- =========================================================
-- datavault schema
-- =========================================================

CREATE USER dwh_datavault
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- =========================================================
-- dbt technical user
-- =========================================================

CREATE USER dwh_tiplus_dbt
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- =========================================================
-- grants for schema owners
-- =========================================================

GRANT
  CREATE SESSION,
  CREATE TABLE,
  CREATE VIEW,
  CREATE SEQUENCE
TO
  dwh_tiplus_as_landing,
  dwh_tiplus_eu_landing,
  dwh_tiplus_source,
  dwh_datavault;

-- =========================================================
-- grants for dbt technical user
-- =========================================================

GRANT
  CREATE SESSION,
  CREATE TABLE,
  CREATE VIEW,
  CREATE SEQUENCE,
  SELECT ANY TABLE,
  CREATE ANY TABLE,
  CREATE ANY VIEW,
  INSERT ANY TABLE,
  UPDATE ANY TABLE,
  DELETE ANY TABLE
TO
  dwh_tiplus_dbt;