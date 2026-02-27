#!/bin/bash
set -e
source ./scripts/00-config.sh

echo "Creating Web NSG"
az network nsg create \
  --resource-group "$RG" \
  --name "$WEB_NSG" \
  --location "$LOCATION"

echo "Allow SSH to Web subnet (port 22) from your public IP only"
MY_IP="$(curl -s ifconfig.me)/32"

az network nsg rule create \
  --resource-group "$RG" \
  --nsg-name "$WEB_NSG" \
  --name Allow-SSH-MyIP \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "$MY_IP" \
  --destination-port-range 22

echo "Creating App NSG"
az network nsg create \
  --resource-group "$RG" \
  --name "$APP_NSG" \
  --location "$LOCATION"

echo "Allow Web subnet to App subnet (port 8080)"
az network nsg rule create \
  --resource-group "$RG" \
  --nsg-name "$APP_NSG" \
  --name Allow-Web-To-App \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "$WEB_CIDR" \
  --destination-port-range 8080

echo "Deny SSH from Internet to App"
az network nsg rule create \
  --resource-group "$RG" \
  --nsg-name "$APP_NSG" \
  --name Deny-SSH-Internet \
  --priority 200 \
  --direction Inbound \
  --access Deny \
  --protocol Tcp \
  --source-address-prefix Internet \
  --destination-port-range 22

echo "Creating DB NSG"
az network nsg create \
  --resource-group "$RG" \
  --name "$DB_NSG" \
  --location "$LOCATION"

echo "Allow App subnet to DB subnet (port 5432)"
az network nsg rule create \
  --resource-group "$RG" \
  --nsg-name "$DB_NSG" \
  --name Allow-App-To-DB \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "$APP_CIDR" \
  --destination-port-range 5432

echo "Deny non-App access to DB (5432)"
az network nsg rule create \
  --resource-group "$RG" \
  --nsg-name "$DB_NSG" \
  --name Deny-DB-From-NonApp \
  --priority 150 \
  --direction Inbound \
  --access Deny \
  --protocol Tcp \
  --source-address-prefix "*" \
  --destination-port-range 5432

echo "Associating NSGs to subnets"

az network vnet subnet update \
  --resource-group "$RG" \
  --vnet-name "$VNET" \
  --name "$WEB_SUBNET" \
  --network-security-group "$WEB_NSG"

az network vnet subnet update \
  --resource-group "$RG" \
  --vnet-name "$VNET" \
  --name "$APP_SUBNET" \
  --network-security-group "$APP_NSG"

az network vnet subnet update \
  --resource-group "$RG" \
  --vnet-name "$VNET" \
  --name "$DB_SUBNET" \
  --network-security-group "$DB_NSG"

echo "NSG configuration completed."