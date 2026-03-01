#!/bin/bash
set -e
source ./scripts/00-config.sh

echo "Getting private IPs..."

APP_IP=$(az vm show -d -g "$RG" -n "$APP_VM" --query privateIps -o tsv)
DB_IP=$(az vm show -d -g "$RG" -n "$DB_VM" --query privateIps -o tsv)

echo "APP_IP=$APP_IP"
echo "DB_IP=$DB_IP"
echo "----------------------------------"

run_test () {
  FROM_VM=$1
  TO_IP=$2
  PORT=$3
  EXPECTED=$4
  LABEL=$5

  echo "TEST: $LABEL (should $EXPECTED)"

  OUTPUT=$(az vm run-command invoke \
    -g "$RG" -n "$FROM_VM" \
    --command-id RunShellScript \
    --scripts "timeout 4 nc -zvw3 $TO_IP $PORT; echo RC:\$?" \
    --query "value[0].message" -o tsv)

  echo "$OUTPUT"

  if echo "$OUTPUT" | grep -q "RC:0"; then
    ACTUAL="PASS"
  else
    ACTUAL="FAIL"
  fi

  if [[ "$ACTUAL" == "$EXPECTED" ]]; then
    echo "RESULT: $ACTUAL Pass"
  else
    echo "RESULT: $ACTUAL Fail"
  fi

  echo "----------------------------------"
}

run_test "$WEB_VM" "$APP_IP" 8080 "PASS" "WEB -> APP:8080"
run_test "$WEB_VM" "$DB_IP" 5432 "FAIL" "WEB -> DB:5432"
run_test "$APP_VM" "$DB_IP" 5432 "PASS" "APP -> DB:5432"

echo "Verification completed."