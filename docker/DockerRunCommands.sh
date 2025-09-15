#!/bin/bash
# DockerRunCommands.sh
# Run GeoServer container with persistent storage

set -e

echo "=== Pulling GeoServer image ==="
sudo docker pull kartoza/geoserver

echo "=== Creating persistent data directory ==="
sudo mkdir -p /opt/geoserver_data

echo "=== Running GeoServer container ==="
sudo docker run -d --name geoserver \
  -p 8080:8080 \
  -v /opt/geoserver_data:/var/local/geoserver \
  -e GEOSERVER_ADMIN_USER=admin \
  -e GEOSERVER_ADMIN_PASSWORD=geoserver \
  -e JAVA_OPTS="-Xms256m -Xmx512m" \
  kartoza/geoserver

echo "=== Checking container status ==="
sudo docker ps
