#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./initialize.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Handles the initialization of the SOR database.
#   This script:
#     1. Sets up the SOR environment (env.sh)
#     2. Runs all setup scripts located in the sql directory
# ----------------------------------------------------------------------------- 

echo "=== Initializing database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

sqlplus -s / as sysdba <<EOF
PROMPT === Initializing database ===

DEFINE SOR_TIZONE1_OWNER_PASSWORD='${SOR_TIZONE1_OWNER_PASSWORD}'
DEFINE SOR_TIZONE2_OWNER_PASSWORD='${SOR_TIZONE2_OWNER_PASSWORD}'

@"${SQL_DIR}/create_tizone_users.sql"
@"${SQL_DIR}/create_tizone_tables.sql"

PROMPT === Database initialized ===
EXIT;
EOF

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} initialized ==="
