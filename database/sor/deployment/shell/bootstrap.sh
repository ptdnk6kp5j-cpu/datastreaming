#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./bootstrap.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Handles the bootstrap of the DWH database.
#   This script:
#     1. Sets up OGG prerequisites (setup_ogg.sh)
#.    2. Runs the full initialization (initialize.sh)
#   Used only when the environment starts for the very first time.
# -----------------------------------------------------------------------------

echo "=== Bootstrapping database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

sqlplus -s / as sysdba <<EOF
PROMPT === Setting up OGG ===

DEFINE SOR_ROOT_OGGADMIN_PASSWORD='${SOR_ROOT_OGGADMIN_PASSWORD}'
DEFINE SOR_OGG_ADMIN_PASSWORD='${SOR_OGG_ADMIN_PASSWORD}'

@"${SQL_DIR}/setup_ogg.sql"

PROMPT === OGG Setup Complete ===
EXIT;
EOF

. "${SHELL_DIR}/initialize.sh"

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} bootstrapping done ==="
