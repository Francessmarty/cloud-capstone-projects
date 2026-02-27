#!/bin/bash
set -e

echo "Starting full deployment."

./scripts/deploy-network.sh
./scripts/deploy.nsg.sh
./scripts/deploy.vm.sh
./scripts/verify.sh

echo "Full deployment completed successfully."
echo "Run ./scripts/cleanup.sh when finished."