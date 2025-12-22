/* ============================================================
   MASTER_CDC – CDC ingest voorbeelddata
   ============================================================ */

-- INSERT (AFTER image)
INSERT INTO dwh_tiplus_as_landing.master_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','MASTER','PTIA01','PTIA01_11305_ac_dbaas',
  1000001,'TXN-ABC-001','I','N','Y',
  TIMESTAMP '2025-01-10 09:15:03',81234567,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_master_cdc.NEXTVAL,
  'BATCH_20250110_01',
  1001,'MBE00001','PF1','BRN00001','MASTER-1001','ACTV',5000
);

-- UPDATE (BEFORE image)
INSERT INTO dwh_tiplus_as_landing.master_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','MASTER','PTIA01','PTIA01_11305_ac_dbaas',
  1000002,'TXN-ABC-002','U','Y','N',
  TIMESTAMP '2025-01-10 10:02:11',81234901,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_master_cdc.NEXTVAL,
  'BATCH_20250110_02',
  1001,'MBE00001','PF1','BRN00001','MASTER-1001','ACTV',5000
);

-- UPDATE (AFTER image)
INSERT INTO dwh_tiplus_as_landing.master_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','MASTER','PTIA01','PTIA01_11305_ac_dbaas',
  1000003,'TXN-ABC-002','U','N','Y',
  TIMESTAMP '2025-01-10 10:02:11',81234901,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_master_cdc.NEXTVAL,
  'BATCH_20250110_02',
  1001,'MBE00001','PF1','BRN00001','MASTER-1001','SUSP',4500
);


/* ============================================================
   BASEEVENT_CDC – CDC ingest voorbeelddata
   ============================================================ */

-- INSERT (AFTER image)
INSERT INTO dwh_tiplus_as_landing.baseevent_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','BASEEVENT','PTIA01','PTIA01_11305_ac_dbaas',
  2000001,'TXN-DEF-001','I','N','Y',
  TIMESTAMP '2025-01-10 11:30:45',81235555,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_baseevent_cdc.NEXTVAL,
  'BATCH_20250110_03',
  20001,'PF1',9001,1001,'A',1500
);

-- UPDATE (BEFORE image)
INSERT INTO dwh_tiplus_as_landing.baseevent_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','BASEEVENT','PTIA01','PTIA01_11305_ac_dbaas',
  2000002,'TXN-DEF-002','U','Y','N',
  TIMESTAMP '2025-01-10 12:05:10',81236001,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_baseevent_cdc.NEXTVAL,
  'BATCH_20250110_04',
  20001,'PF1',9001,1001,'A',1500
);

-- UPDATE (AFTER image)
INSERT INTO dwh_tiplus_as_landing.baseevent_cdc VALUES (
  'TIPLUS','AS',1,'Asia',
  'TIZONE1_OWNER','BASEEVENT','PTIA01','PTIA01_11305_ac_dbaas',
  2000003,'TXN-DEF-002','U','N','Y',
  TIMESTAMP '2025-01-10 12:05:10',81236001,
  SYSTIMESTAMP,dwh_tiplus_as_landing.seq_baseevent_cdc.NEXTVAL,
  'BATCH_20250110_04',
  20001,'PF1',9001,1001,'C',1300
);

COMMIT;