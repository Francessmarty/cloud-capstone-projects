#!/bin/bash
set -e
source ./scripts/00-config.sh

echo "Deleting Resource Group: $RG"

az group delete \
  --name "$RG" \
  --yes \
  --no-wait

echo "Cleanup initiated. Azure is deleting all resources in background."