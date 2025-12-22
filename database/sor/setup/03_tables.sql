-- Run as SYSDBA

ALTER SESSION SET CONTAINER = SORPDB1;

PROMPT === Creating TIZONE1 Tables ===

CREATE TABLE TIZONE1_OWNER.BASEEVENT (
    KEY97              NUMBER,
    REFNO_PFIX         CHAR(3 CHAR),
    REFNO_SERL         NUMBER,
    MASTER_KEY         NUMBER,
    STATUS             CHAR(1 CHAR),
    AMOUNT             NUMBER(15,0)
);

CREATE TABLE TIZONE1_OWNER.MASTER (
    KEY97              NUMBER,
    REFNO_MBE          CHAR(8 CHAR),
    REFNO_PFIX         CHAR(3 CHAR),
    REFNO_BRN          CHAR(8 CHAR),
    MASTER_REF         CHAR(20 CHAR),
    STATUS             CHAR(4 CHAR),
    AMOUNT             NUMBER(15,0)
);

PROMPT === Creating TIZONE2 Tables ===

CREATE TABLE TIZONE2_OWNER.BASEEVENT (
    KEY97              NUMBER,
    REFNO_PFIX         CHAR(3 CHAR),
    REFNO_SERL         NUMBER,
    MASTER_KEY         NUMBER,
    STATUS             CHAR(1 CHAR),
    AMOUNT             NUMBER(15,0)
);

CREATE TABLE TIZONE2_OWNER.MASTER (
    KEY97              NUMBER,
    REFNO_MBE          CHAR(8 CHAR),
    REFNO_PFIX         CHAR(3 CHAR),
    REFNO_BRN          CHAR(8 CHAR),
    MASTER_REF         CHAR(20 CHAR),
    STATUS             CHAR(4 CHAR),
    AMOUNT             NUMBER(15,0)
);

PROMPT === TIZONE table creation complete ===
