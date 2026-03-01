#!/bin/bash
set -e

# Unique prefix
PREFIX="frances"

# Location
LOCATION="northeurope"

# Resource group + network names
RG="${PREFIX}-rg"
VNET="${PREFIX}-vnet"

# Subnet names
WEB_SUBNET="${PREFIX}-web-subnet"
APP_SUBNET="${PREFIX}-app-subnet"
DB_SUBNET="${PREFIX}-db-subnet"

# Address ranges
VNET_CIDR="10.10.0.0/16"
WEB_CIDR="10.10.1.0/24"
APP_CIDR="10.10.2.0/24"
DB_CIDR="10.10.3.0/24"

# NSG names
WEB_NSG="${PREFIX}-web-nsg"
APP_NSG="${PREFIX}-app-nsg"
DB_NSG="${PREFIX}-db-nsg"

# VM names
WEB_VM="${PREFIX}-web-vm"
APP_VM="${PREFIX}-app-vm"
DB_VM="${PREFIX}-db-vm"

# Admin username
ADMIN_USER="azureuser"

# Cheap VM size
VM_SIZE="Standard_D2s_v3"

# SSH public key
SSH_KEY="$HOME/.ssh/frances-azure.pub"