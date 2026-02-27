#!/bin/bash
set -e

echo "Starting full deployment."

./scripts/01-deploy-network.sh
./scripts/02-deploy.nsg.sh
./scripts/03-deploy.vm.sh
./scripts/05-verify.sh

echo "Full deployment completed successfully."
echo "Run ./scripts/cleanup.sh when finished."