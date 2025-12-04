#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Running dbt deps..."
# The working directory is already set to /usr/app/dbt
dbt deps

echo "Starting container main process..."
# Execute the original command passed to the container (if any), 
# or just keep it alive as intended
exec tail -f /dev/null
