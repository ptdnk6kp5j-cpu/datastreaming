-- =========================================================
-- Run as SYSDBA
-- =========================================================

ALTER SESSION SET CONTAINER = dwhpdb1;

-- =========================================================
-- GoldenGate apply users (target side) in TFSDWH
-- =========================================================

CREATE USER dwh_tiplus_as_ogg
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  ACCOUNT UNLOCK;

CREATE USER dwh_tiplus_eu_ogg
  IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  ACCOUNT UNLOCK;

-- =========================================================
-- Base privileges for apply users
-- =========================================================

GRANT
  CREATE SESSION,
  CREATE TABLE,
  CREATE SEQUENCE,
  CREATE PROCEDURE,
  CREATE VIEW,
  CREATE JOB
TO
  dwh_tiplus_as_ogg,
  dwh_tiplus_eu_ogg;

-- =========================================================
-- GoldenGate apply privileges
-- =========================================================

BEGIN
  dbms_goldengate_auth.grant_admin_privilege(
    grantee                 => 'DWH_TIPLUS_AS_OGG',
    privilege_type          => 'APPLY',
    grant_select_privileges => TRUE,
    do_grants               => TRUE
  );
END;
/

BEGIN
  dbms_goldengate_auth.grant_admin_privilege(
    grantee                 => 'DWH_TIPLUS_EU_OGG',
    privilege_type          => 'APPLY',
    grant_select_privileges => TRUE,
    do_grants               => TRUE
  );
END;
/