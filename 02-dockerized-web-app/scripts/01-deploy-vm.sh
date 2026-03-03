#!/bin/bash
set -e

# Config 
RG="frances-docker-rg"
LOC="eastus"
VM="frances-docker-vm"
USER="frances"
APP_PORT="8080"

# Docker Hub images
FRONTEND_IMAGE="francesehinor/dockerized-web-app-frontend:v2"
BACKEND_IMAGE="francesehinor/dockerized-web-app-backend:v2"
DB_IMAGE="francesehinor/dockerized-web-app-db:v2"

echo "Creating Resource Group"
az group create -n "$RG" -l "$LOC" -o table

echo "Creating Ubuntu VM"
az vm create \
  -g "$RG" -n "$VM" \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username "$USER" \
  --generate-ssh-keys \
  -o json > /tmp/frances-vm.json

PUBLIC_IP="$(jq -r '.publicIpAddress' /tmp/frances-vm.json)"
echo "PUBLIC IP: $PUBLIC_IP"

echo "Opening ports 22 + ${APP_PORT}"
az vm open-port -g "$RG" -n "$VM" --port 22 -o none
az vm open-port -g "$RG" -n "$VM" --port "$APP_PORT" -o none

echo "Installing Docker + Compose plugin"
az vm run-command invoke \
  -g "$RG" -n "$VM" \
  --command-id RunShellScript \
  --scripts "
set -e
sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER || true
sudo systemctl enable docker
sudo systemctl start docker
" -o none

echo " Writing docker-compose.yml on VM with images from Docker Hub"
az vm run-command invoke \
  -g "$RG" -n "$VM" \
  --command-id RunShellScript \
  --scripts "
set -e
cat > /home/$USER/docker-compose.yml <<EOF
services:
  frontend:
    image: $FRONTEND_IMAGE
    container_name: frances-frontend
    ports:
      - \"8080:80\"
    depends_on:
      - backend
    networks:
      - app-network

  backend:
    image: $BACKEND_IMAGE
    container_name: frances-backend
    ports:
      - \"5000:5000\"
    environment:
      DB_HOST: db
      DB_USER: appuser
      DB_PASSWORD: apppass
      DB_NAME: appdb
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: $DB_IMAGE
    container_name: frances-db
    environment:
      MYSQL_DATABASE: appdb
      MYSQL_USER: appuser
      MYSQL_PASSWORD: apppass
      MYSQL_ROOT_PASSWORD: rootpass
    # No need to expose 3306 publicly for the assignment
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
EOF

sudo chown $USER:$USER /home/$USER/docker-compose.yml
" -o none

echo "Starting containers on VM"
az vm run-command invoke \
  -g "$RG" -n "$VM" \
  --command-id RunShellScript \
  --scripts "
set -e
cd /home/$USER
sudo docker compose pull
sudo docker compose up -d
sudo docker compose ps
" -o table


echo "READY"
echo "Public URL: http://$PUBLIC_IP:$APP_PORT"
echo "SSH:        ssh $USER@$PUBLIC_IP"
echo "Next: run ./02-ssh.sh for SSH”