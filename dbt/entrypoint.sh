#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Running dbt deps for project tfsdwh..."
# Install project dependencies
cd /usr/app/dbt/tfsdwh
dbt deps

echo "Starting container main process..."
# Execute the original command passed to the container (if any), 
# or just keep it alive as intended
exec tail -f /dev/null
