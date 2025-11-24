#!/bin/bash

# -----------------------------------------------------------------------------
# Usage:
#   ./menu.sh
# -----------------------------------------------------------------------------
# Purpose:
#   Provides an interactive menu to:
#     1. Reset the database environment
#     2. Initialize the database environment
#     3. Reset + initialize in sequence
# -----------------------------------------------------------------------------

# load generic env variables and functions
. "${ORACLE_BASE}/scripts/ops/env.sh"

while true; do
    clear
    echo "========== ${SERVICE_NAME} MENU =========="
    echo "1) Reset"
    echo "2) Initialize"
    echo "3) Reinitialize (Reset + Initialize)"
    echo "q) Quit"
    read -p "Choice: " choice

    case "${choice}" in
        1)
            bash "${SHELL_DIR}/reset.sh"
            ;;
        2)
            bash "${SHELL_DIR}/initialize.sh"
            ;;
        3)
            bash "${SHELL_DIR}/reset.sh"
            bash "${SHELL_DIR}/initialize.sh"
            ;;
        q)
            exit 0
            ;;
        *)
            echo "Invalid choice"
            sleep 1
            ;;
    esac

    echo
    echo
    echo
    read -p "Press [Enter] to continue..."

done
