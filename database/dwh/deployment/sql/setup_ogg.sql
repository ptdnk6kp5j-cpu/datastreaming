-- Run as SYSDBA

ALTER SESSION SET CONTAINER = DWHPDB1;

PROMPT === Creating GoldenGate Admin User ===

CREATE USER DWH_OGG_ADMIN IDENTIFIED BY &DWH_OGG_ADMIN_PASSWORD
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON USERS
  ACCOUNT UNLOCK;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE SEQUENCE,
      CREATE PROCEDURE,
      CREATE VIEW,
      CREATE JOB
      TO DWH_OGG_ADMIN;

PROMPT === Granting GoldenGate APPLY Privilege ===

BEGIN
  DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE(
    grantee                 => 'DWH_OGG_ADMIN',
    privilege_type          => 'APPLY',
    grant_select_privileges => TRUE,
    do_grants               => TRUE
  );
END;
/

PROMPT === GoldenGate Admin User Setup Complete ===
