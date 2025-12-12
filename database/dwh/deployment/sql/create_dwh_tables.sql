-- Run as SYSDBA

ALTER SESSION SET CONTAINER = DWHPDB1;

PROMPT === Creating Landing Tables: TIPLUS AS ===

CREATE TABLE DWH_LANDING_TIPLUS_AS.BASEEVENT (
    KEY97                   NUMBER,
    REFNO_PFIX              CHAR(3 CHAR),
    REFNO_SERL              NUMBER,
    MASTER_KEY              NUMBER,
    STATUS                  CHAR(1 CHAR),
    AMOUNT                  NUMBER(15,0),
    SRC_OPERATION_TYPE      CHAR(1 CHAR),
    SRC_TRANSACTION_ID      VARCHAR2(50 CHAR),
    SRC_SCN                 NUMBER,
    SRC_SEQ_NO              NUMBER,
    SRC_COMMIT_TIMESTAMP    TIMESTAMP(6),
    OGG_CAPTURE_TS          TIMESTAMP(6),
    OGG_APPLY_TS            TIMESTAMP(6),
    DW_INSERT_TS            TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
    DW_SOURCE_SYSTEM        VARCHAR2(50 CHAR)
);

CREATE TABLE DWH_LANDING_TIPLUS_AS.MASTER (
    KEY97                   NUMBER,
    REFNO_MBE               CHAR(8 CHAR),
    REFNO_PFIX              CHAR(3 CHAR),
    REFNO_BRN               CHAR(8 CHAR),
    MASTER_REF              CHAR(20 CHAR),
    STATUS                  CHAR(4 CHAR),
    AMOUNT                  NUMBER(15,0),
    SRC_OPERATION_TYPE      CHAR(1 CHAR),
    SRC_TRANSACTION_ID      VARCHAR2(50 CHAR),
    SRC_SCN                 NUMBER,
    SRC_SEQ_NO              NUMBER,
    SRC_COMMIT_TIMESTAMP    TIMESTAMP(6),
    OGG_CAPTURE_TS          TIMESTAMP(6),
    OGG_APPLY_TS            TIMESTAMP(6),
    DW_INSERT_TS            TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
    DW_SOURCE_SYSTEM        VARCHAR2(50 CHAR)
);

PROMPT === Creating Landing Tables: TIPLUS EU ===

CREATE TABLE DWH_LANDING_TIPLUS_EU.BASEEVENT (
    KEY97                   NUMBER,
    REFNO_PFIX              CHAR(3 CHAR),
    REFNO_SERL              NUMBER,
    MASTER_KEY              NUMBER,
    STATUS                  CHAR(1 CHAR),
    AMOUNT                  NUMBER(15,0),
    SRC_OPERATION_TYPE      CHAR(1 CHAR),
    SRC_TRANSACTION_ID      VARCHAR2(50 CHAR),
    SRC_SCN                 NUMBER,
    SRC_SEQ_NO              NUMBER,
    SRC_COMMIT_TIMESTAMP    TIMESTAMP(6),
    OGG_CAPTURE_TS          TIMESTAMP(6),
    OGG_APPLY_TS            TIMESTAMP(6),
    DW_INSERT_TS            TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
    DW_SOURCE_SYSTEM        VARCHAR2(50 CHAR)
);

CREATE TABLE DWH_LANDING_TIPLUS_EU.MASTER (
    KEY97                   NUMBER,
    REFNO_MBE               CHAR(8 CHAR),
    REFNO_PFIX              CHAR(3 CHAR),
    REFNO_BRN               CHAR(8 CHAR),
    MASTER_REF              CHAR(20 CHAR),
    STATUS                  CHAR(4 CHAR),
    AMOUNT                  NUMBER(15,0),
    SRC_OPERATION_TYPE      CHAR(1 CHAR),
    SRC_TRANSACTION_ID      VARCHAR2(50 CHAR),
    SRC_SCN                 NUMBER,
    SRC_SEQ_NO              NUMBER,
    SRC_COMMIT_TIMESTAMP    TIMESTAMP(6),
    OGG_CAPTURE_TS          TIMESTAMP(6),
    OGG_APPLY_TS            TIMESTAMP(6),
    DW_INSERT_TS            TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
    DW_SOURCE_SYSTEM        VARCHAR2(50 CHAR)
);

PROMPT === Landing TIPLUS table creation complete ===

CREATE TABLE DWH_CONTROL.ELT_HWM(
    DW_SOURCE_SYSTEM VARCHAR2(50 CHAR),
    SRC_SCN      NUMBER,
    LAST_LOAD_DATE TIMESTAMP(6),
    PRIMARY KEY (SOURCE_SYSTEM, ZONE)
);


DWH_STAGING_MASTER
HK(KEY | ZONE) PK HUB
HK(   REFNO_MBE               CHAR(8 CHAR),
    REFNO_PFIX              CHAR(3 CHAR),
    REFNO_BRN               CHAR(8 CHAR),
    MASTER_REF              CHAR(20 CHAR),
    STATUS                  CHAR(4 CHAR),
    AMOUNT                  NUMBER(15,0),)
Clean ' ' to NULL
Revmove duplicates
Clean up error