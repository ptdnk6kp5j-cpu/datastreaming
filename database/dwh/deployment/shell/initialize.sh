#!/bin/bash
# -----------------------------------------------------------------------------
# Usage:
#   ./initialize.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Runs all creation scripts for the DWH database.
# -----------------------------------------------------------------------------

echo "=== Initializing database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

sqlplus -s / as sysdba <<EOF
PROMPT === Initializing database ===

DEFINE DWH_OGG_ADMIN_PASSWORD='${DWH_OGG_ADMIN_PASSWORD}'
DEFINE DWH_LANDING_TIPLUS_AS_PASSWORD='${DWH_LANDING_TIPLUS_AS_PASSWORD}'
DEFINE DWH_LANDING_TIPLUS_EU_PASSWORD='${DWH_LANDING_TIPLUS_EU_PASSWORD}'
DEFINE DWH_STAGE_TIPLUS_AS_PASSWORD='${DWH_STAGE_TIPLUS_AS_PASSWORD}'
DEFINE DWH_STAGE_TIPLUS_EU_PASSWORD='${DWH_STAGE_TIPLUS_EU_PASSWORD}'
DEFINE DWH_RAW_VAULT_PASSWORD='${DWH_RAW_VAULT_PASSWORD}'
DEFINE DWH_BUSINESS_VAULT_PASSWORD='${DWH_BUSINESS_VAULT_PASSWORD}'
DEFINE DWH_ANALYTICS_PASSWORD='${DWH_ANALYTICS_PASSWORD}'
DEFINE DWH_DBT_USER_PASSWORD='${DWH_DBT_USER_PASSWORD}'

@"${SQL_DIR}/create_dwh_users.sql"
@"${SQL_DIR}/create_dwh_tables.sql"

PROMPT === Database initialized ===
EXIT;
EOF

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} initialized ==="
