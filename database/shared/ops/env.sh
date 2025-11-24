#!bin=bash

# -----------------------------------------------------------------------------
# Usage:
#   ./env.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Sets up the environment variables for the deployment.
#   Enables multiple deployments by setting deployment-specific variables.
# Tips
#   Use DEPLOYMENT_ID to distinguish between different deployments.
#   DEPLOYMENT_ID must match with the directory name under scripts/.
#  Example:
#    export DEPLOYMENT_ID="sor" for deployment under scripts/sor/
# -----------------------------------------------------------------------------

echo " === Loading environment ==="

export ORACLE_HOST=localhost
export ORACLE_PORT=1521

export DEPLOYMENT_ID="${DEPLOYMENT_ID:-deployment}"
export DEPLOYMENT_DIR="${ORACLE_BASE}/scripts/${DEPLOYMENT_ID}"
export SHELL_DIR=${DEPLOYMENT_DIR}/shell
export SQL_DIR=${DEPLOYMENT_DIR}/sql

# Load deployment-specific environment variables if set
env_file="${DEPLOYMENT_DIR}/env.sh"
if [ -f "${env_file}" ]; then
    source "${env_file}"
fi

echo "Oracle Host: ${ORACLE_HOST}"
echo "Oracle Port: ${ORACLE_PORT}"
echo "Oracle SID: ${ORACLE_SID}"
echo "Oracle PDB: ${ORACLE_PDB}"
echo "Deployment directory: ${DEPLOYMENT_DIR}"
echo "Shell directory: ${SHELL_DIR}"
echo "SQL directory: ${SQL_DIR}"

echo " === Environment loaded ==="
