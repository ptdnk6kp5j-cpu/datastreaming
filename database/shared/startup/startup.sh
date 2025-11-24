#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./startup.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Handles the startup of the database environment.
# -----------------------------------------------------------------------------

echo "=== Starting database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

# load generic env variables and functions
source "${ORACLE_BASE}/scripts/ops/env.sh"

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} started ==="
