#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./reset.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Runs all drop scripts for the DWH database.
# -----------------------------------------------------------------------------

echo "=== Resetting database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

sqlplus -s / as sysdba <<EOF
PROMPT === Reset database ===

@"${SQL_DIR}/drop_dwh_tables.sql"
@"${SQL_DIR}/drop_dwh_users.sql"

PROMPT === Database reset completed ===
EXIT;
EOF

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} reset ==="
