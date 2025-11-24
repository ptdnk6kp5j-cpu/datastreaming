#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./setup.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Handles the initial setup of the database environment.
# -----------------------------------------------------------------------------

echo "=== Setting up database ${ORACLE_SID} with PDB ${ORACLE_PDB} ==="

# load generic env variables and functions
source "${ORACLE_BASE}/scripts/ops/env.sh"

# Initialize the database
. "${SHELL_DIR}/bootstrap.sh"

echo "=== Database ${ORACLE_SID} with PDB ${ORACLE_PDB} setup completed ==="
