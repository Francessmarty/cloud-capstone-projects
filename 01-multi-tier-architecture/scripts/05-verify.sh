#!/bin/bash
set -e
source ./scripts/00-config.sh


echo "Getting private IPs."

APP_IP=$(az vm list-ip-addresses -g "$RG" -n "$APP_VM" \
  --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)

DB_IP=$(az vm list-ip-addresses -g "$RG" -n "$DB_VM" \
  --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)

echo "APP_IP=$APP_IP"
echo "DB_IP=$DB_IP"

echo "Installing netcat on all VMs"

for VM in "$WEB_VM" "$APP_VM" "$DB_VM"
do
  az vm run-command invoke -g "$RG" -n "$VM" \
    --command-id RunShellScript \
    --scripts "sudo apt-get update -y && sudo apt-get install -y netcat-openbsd" \
    --output none
done

echo "Starting listener on APP (8080)"
az vm run-command invoke -g "$RG" -n "$APP_VM" \
  --command-id RunShellScript \
  --scripts "nohup nc -lkp 8080 >/dev/null 2>&1 &" \
  --output none

echo "Starting listener on DB (5432)"
az vm run-command invoke -g "$RG" -n "$DB_VM" \
  --command-id RunShellScript \
  --scripts "nohup nc -lkp 5432 >/dev/null 2>&1 &" \
  --output none

echo "TEST 1: WEB -> APP:8080 (should PASS)"
az vm run-command invoke -g "$RG" -n "$WEB_VM" \
  --command-id RunShellScript \
  --scripts "nc -zv -w 3 $APP_IP 8080"


echo "TEST 2: WEB -> DB:5432 (should FAIL)"
set +e
az vm run-command invoke -g "$RG" -n "$WEB_VM" \
  --command-id RunShellScript \
  --scripts "nc -zv -w 3 $DB_IP 5432"
TEST2_EXIT=$?
set -e

if [ $TEST2_EXIT -eq 0 ]; then
  echo "UNEXPECTED: WEB -> DB succeeded (should FAIL). Check NSG rules."
else
  echo "Expected result: WEB -> DB blocked."
fi


echo "TEST 3: APP -> DB:5432 (should PASS)"
az vm run-command invoke -g "$RG" -n "$APP_VM" \
  --command-id RunShellScript \
  --scripts "nc -zv -w 3 $DB_IP 5432"


echo "Verification completed."
echo "Expected:"
echo "- WEB -> APP: PASS"
echo "- WEB -> DB: FAIL"
echo "- APP -> DB: PASS"