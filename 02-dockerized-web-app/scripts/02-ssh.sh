#!/bin/bash
set -e

RG="frances-docker-rg"
VM="frances-docker-vm"
USER="frances"

PUBLIC_IP="$(az vm show -d -g "$RG" -n "$VM" --query publicIps -o tsv)"

echo "ssh ${USER}@${PUBLIC_IP}"
echo ""

ssh "${USER}@${PUBLIC_IP}"