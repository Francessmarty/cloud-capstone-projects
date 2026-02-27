#!/bin/bash
set -e

# Load config
source ./scripts/00-config.sh

echo "Deploying VMs into subnets"
echo "RG: $RG | VNET: $VNET | Location: $LOCATION"

# Basic checks
if [[ ! -f "$SSH_KEY" ]]; then
  echo "SSH public key not found at: $SSH_KEY"
  echo "Create it with:"
  echo "ssh-keygen -t ed25519 -f ~/.ssh/frances-azure -C \"frances-azure\""
  exit 1
fi

# Function to create VM
create_vm () {
  local VM_NAME="$1"
  local SUBNET_NAME="$2"
  local PUBLIC="$3"

  
  echo "Creating VM: $VM_NAME in subnet: $SUBNET_NAME"

  if [[ "$PUBLIC" == "yes" ]]; then
    az vm create \
      --resource-group "$RG" \
      --name "$VM_NAME" \
      --location "$LOCATION" \
      --image "Ubuntu2204" \
      --size "$VM_SIZE" \
      --admin-username "$ADMIN_USER" \
      --ssh-key-values "$SSH_KEY" \
      --vnet-name "$VNET" \
      --subnet "$SUBNET_NAME" \
      --public-ip-sku "Standard" \
      --output none
  else
    az vm create \
      --resource-group "$RG" \
      --name "$VM_NAME" \
      --location "$LOCATION" \
      --image "Ubuntu2204" \
      --size "$VM_SIZE" \
      --admin-username "$ADMIN_USER" \
      --ssh-key-values "$SSH_KEY" \
      --vnet-name "$VNET" \
      --subnet "$SUBNET_NAME" \
      --public-ip-address "" \
      --output none
  fi

  echo "VM created: $VM_NAME"
}

# Create VMs
create_vm "$WEB_VM" "$WEB_SUBNET" "yes"
create_vm "$APP_VM" "$APP_SUBNET" "no"
create_vm "$DB_VM" "$DB_SUBNET" "no"


echo "VM IP Addresses:"
az vm list-ip-addresses -g "$RG" -o table


echo "All VMs deployed successfully."