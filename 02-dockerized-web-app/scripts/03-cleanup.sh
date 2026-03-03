#!/bin/bash
set -e

RG="frances-docker-rg"

echo "Deleting Resource Group:"
az group delete -n "$RG" --yes --no-wait
echo "Cleanup started."