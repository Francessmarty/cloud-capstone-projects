#!/bin/bash
set -e

# Load config variables
source ./scripts/00-config.sh

echo "Creating Resource Group"
az group create \
  --name $RG \
  --location $LOCATION

echo "Creating Virtual Network"
az network vnet create \
  --resource-group $RG \
  --name $VNET \
  --address-prefix $VNET_CIDR \
  --subnet-name $WEB_SUBNET \
  --subnet-prefix $WEB_CIDR

echo "Creating App Subnet"
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET \
  --name $APP_SUBNET \
  --address-prefix $APP_CIDR

echo "Creating DB Subnet"
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET \
  --name $DB_SUBNET \
  --address-prefix $DB_CIDR

echo "Network deployment completed."