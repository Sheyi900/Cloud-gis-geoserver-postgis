#!/bin/bash
# setup-ec2.sh
# EC2 bootstrap script for GeoServer deployment

set -e

echo "=== Updating system packages ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing Docker ==="
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Creating 1GB Swap ==="
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "=== Verifying Swap ==="
free -h

echo "Setup complete. You can now run the GeoServer container."
