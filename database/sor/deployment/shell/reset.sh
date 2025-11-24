#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./reset.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Runs all drop scripts for the DWH database.
# -----------------------------------------------------------------------------

echo "=== Reset database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="


sqlplus -s / as sysdba <<EOF
PROMPT === Reset database ===

@"${SQL_DIR}/drop_tizone_tables.sql"
@"${SQL_DIR}/drop_tizone_users.sql"

PROMPT === Database reset ===
EXIT;
EOF

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} reset ==="
