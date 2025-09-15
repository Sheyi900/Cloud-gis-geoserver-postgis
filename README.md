# Cloud-gis-geoserver-postgis
Set up a GIS Enterprise system on the cloud.


# 🌍 Cloud GIS Deployment with PostGIS + GeoServer + Docker

This repo demonstrates how to build and publish a simple **cloud GIS stack** using:

- **PostgreSQL + PostGIS** → spatial database (local or AWS RDS)
- **GeoServer (Dockerized)** → serves layers as WMS/WFS
- **QGIS** → visualization and validation client

The workflow replicates a typical **Enterprise GIS setup** but with **open-source tools** and **Docker** so anyone can reproduce it.

---

## 🚀 Architecture

![Architecture Diagram](docs/architecture_diagram.png)

**Components:**
1. **PostGIS Database** (local Postgres or AWS RDS)
2. **GeoServer in Docker** (local or AWS EC2)
3. **QGIS Client** (consumes WMS/WFS services)

---

## ⚙️ Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [PostgreSQL](https://www.postgresql.org/download/) + [PostGIS](https://postgis.net/install/)
- [QGIS](https://qgis.org/downloads/)
- (Optional) AWS account (for RDS/EC2 deployment)

---

## 📂 Repository Structure

cloud-gis-geoserver-postgis/
├─ README.md # This file
├─ sql/
│ ├─ create_extensions.sql # Enable PostGIS
│ └─ sample_queries.sql # Example spatial queries
├─ docker/
│ └─ geoserver_run.md # Docker commands
├─ geoserver/
│ └─ publish_layer.md # Steps to publish PostGIS data
├─ qgis/
│ └─ screenshots/ # Screenshots of maps & connections
├─ aws/
│ ├─ rds_setup.md # AWS RDS setup notes
│ ├─ ec2_setup.md # EC2 + Docker notes
│ └─ security_groups.md # Security group configs
└─ docs/
├─ architecture_diagram.png
└─ workflow.png

yaml
Copy code

---

## 🛠 Step-by-Step Workflow

### 1. Setup PostGIS
- Install Postgres locally (or create AWS RDS instance).
- Enable PostGIS:
  ```sql
  CREATE EXTENSION postgis;
Import dataset (Natural Earth, shapefile, etc.):
shp2pgsql -I -s 4326 data/ne_states.shp public.us_states | psql -U postgres -d gis

### 2. Run GeoServer with Docker
docker run -d --name geoserver \
  -p 8080:8080 \
  docker.osgeo.org/geoserver:2.24.2
Access at: http://localhost:8080/geoserver

Username: admin

Password: geoserver

### 3. Connect GeoServer to PostGIS
Login → Data → Stores → Add new Store → PostGIS.

Enter DB credentials (local or AWS RDS).

Publish layer → Layer Preview → OpenLayers to verify.

📸 Example screenshot:

### 4. View Layer in QGIS
Add new WMS connection:

http://<host-ip>:8080/geoserver/wms
Load us_states layer into QGIS.

📸 Example screenshot:

### 5. Example Spatial Queries
Inside PostGIS (gis DB):

```sql
    -- Largest polygons by area
SELECT name, admin, ST_Area(geom::geography) AS area_m2
FROM public.us_states
ORDER BY area_m2 DESC
LIMIT 5;

-- Intersects with bounding box
SELECT name
FROM public.us_states
WHERE geom && ST_MakeEnvelope(-130, 24, -66, 50, 4326);

🌐 Optional Cloud Setup (AWS)
RDS: Managed PostgreSQL + PostGIS

EC2: Host Dockerized GeoServer

Update security groups:

Port 5432 → open to your IP (for DB)

Port 8080 → open to your IP (for GeoServer)

📸 Architecture example:

🎯 Deliverables
WMS/WFS endpoint published from GeoServer

QGIS visualization of layers

Example SQL + Docker + AWS setup scripts

📖 Credits
Natural Earth Data

PostGIS

GeoServer

QGIS

