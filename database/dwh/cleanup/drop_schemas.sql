-- =========================================================
-- Run as SYSDBA
-- =========================================================

ALTER SESSION SET CONTAINER = dwhpdb1;

-- =========================================================
-- drop tiplus landing schemas
-- =========================================================

DROP USER dwh_tiplus_as_landing CASCADE;
DROP USER dwh_tiplus_eu_landing CASCADE;

-- =========================================================
-- drop tiplus source schema
-- =========================================================

DROP USER dwh_tiplus_source CASCADE;

-- =========================================================
-- drop datavault schema
-- =========================================================

DROP USER dwh_datavault CASCADE;

-- =========================================================
-- drop dbt technical user
-- =========================================================

DROP USER dwh_tiplus_dbt CASCADE;