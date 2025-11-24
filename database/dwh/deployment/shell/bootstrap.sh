#!/bin/bash
# -----------------------------------------------------------------------------
# Usage:
#   ./bootstrap.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Handles the bootstrap of the DWH database.
#   This script:
#     1. Sets up Oracle GoldenGate prerequisites
#     2. Runs the full database initialization
#   Used only on FIRST startup of a fresh environment.
# -----------------------------------------------------------------------------

echo "=== Bootstrapping database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

sqlplus -s / as sysdba <<EOF
PROMPT === Setting up OGG ===

DEFINE DWH_OGG_ADMIN_PASSWORD='${DWH_OGG_ADMIN_PASSWORD}'

@"${SQL_DIR}/setup_ogg.sql"

PROMPT === OGG Setup Complete ===
EXIT;
EOF

. "${SHELL_DIR}/initialize.sh"

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} bootstrapping done ==="
