-- Run as SYSDBA

-- =======================================
-- Switch to root container
-- =======================================
ALTER SESSION SET CONTAINER = CDB$ROOT;

PROMPT === Configuring Database for GoldenGate ===

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

-- Enable supplemental logging and force logging
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
ALTER DATABASE FORCE LOGGING;

-- Switch logfile AFTER enforcing FORCE LOGGING
ALTER SYSTEM SWITCH LOGFILE;

-- Optional tuning
ALTER SYSTEM SET STREAMS_POOL_SIZE = 512M SCOPE=BOTH;
ALTER SYSTEM SET ENABLE_GOLDENGATE_REPLICATION = TRUE SCOPE=BOTH;

PROMPT === Creating Common GoldenGate Admin User ===

CREATE USER C##OGGADMIN IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON USERS
  ACCOUNT UNLOCK;

GRANT CREATE SESSION TO C##OGGADMIN CONTAINER = ALL;
GRANT CONNECT        TO C##OGGADMIN CONTAINER = ALL;

BEGIN
  DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE(
    grantee                 => 'C##OGGADMIN',
    privilege_type          => 'CAPTURE',
    grant_select_privileges => TRUE,
    do_grants               => TRUE,
    container               => 'ALL'
  );
END;
/

-- =======================================
-- Switch to local pluggable database
-- =======================================
ALTER SESSION SET CONTAINER = SORPDB1;

PROMPT === Creating GoldenGate Admin User in PDB ===

CREATE USER SOR_OGG_ADMIN IDENTIFIED BY tfsdwh_POC1
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON USERS
  ACCOUNT UNLOCK;

-- Required dictionary access
GRANT SELECT ANY DICTIONARY TO SOR_OGG_ADMIN;

-- Schema-level privileges
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE SEQUENCE,
      CREATE PROCEDURE
      TO SOR_OGG_ADMIN;

PROMPT === GoldenGate Admin User Setup Complete ===
