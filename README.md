# Data Streaming Platform – Oracle 19c, GoldenGate 23, dbt & Full Automation

This repository provides a **complete, containerized data‑streaming architecture** built on:

- **Oracle 19c** (Source + Data Warehouse)
- **Oracle GoldenGate 23 Microservices**
- **dbt-core** using the `dbt-oracle` adapter
- Fully automated **bootstrap**, **initialization**, **schema deployment**, **reset**, and **interactive menu tooling**
- A unified shell + SQL deployment framework

It is designed for **local development**, **proof-of-concepts**, **training**, and **data engineering experimentation**.

---

# 1. Directory Structure

```
datastreaming/
├── database/
│   ├── shared/
│   │   ├── ops/
│   │   │   ├── env.sh
│   │   │   ├── menu.sh
│   │   │   ├── common functions...
│   │   └── (shared logic used by SOR & DWH)
│   │
│   ├── sor/
│   │   ├── deployment/
│   │   │   ├── shell/
│   │   │   │   ├── bootstrap.sh
│   │   │   │   ├── initialize.sh
│   │   │   │   ├── reset.sh
│   │   │   ├── sql/
│   │   │   │   ├── setup_ogg.sql
│   │   │   │   ├── create_tizone_users.sql
│   │   │   │   ├── create_tizone_tables.sql
│   │   │   │   ├── drop_tizone_users.sql
│   │   │   │   ├── drop_tizone_tables.sql
│   │
│   ├── dwh/
│   │   ├── deployment/
│   │   │   ├── shell/
│   │   │   │   ├── bootstrap.sh
│   │   │   │   ├── initialize.sh
│   │   │   │   ├── reset.sh
│   │   │   ├── sql/
│   │   │   │   ├── create_dwh_users.sql
│   │   │   │   ├── create_dwh_tables.sql
│   │   │   │   ├── drop_dwh_users.sql
│   │   │   │   ├── drop_dwh_tables.sql
│
├── ogg/
│   └── config, service deployment files...
│
├── dbt/
│   ├── profiles/
│   ├── models/
│   └── Dockerfile
│
├── docker-compose.yml
├── .env example
```

---

# 2. Services & Architecture

### **2.1. SOR – Source Oracle 19c**
- **Container name:** `sor`
- **Image:** `oracle/database:19.3.0-ee`
- **CDB/PDB:** `SORCDB / SORPDB1`

**Schemas created**
- `TIZONE1_OWNER`
- `TIZONE2_OWNER`
- `SOR_OGG_ADMIN`

**GoldenGate setup performed**
- Archive logging
- Supplemental log data
- Force logging
- Common capture admin: `C##OGGADMIN`

---

### **2.2. DWH – Data Warehouse Oracle 19c**
- **Container name:** `dwh`
- **Image:** `oracle/database:19.3.0-ee`
- **CDB/PDB:** `DWHCDB / DWHPDB1`

**Schemas created (create_dwh_users.sql)**
- Landing: `DWH_LANDING_TIPLUS_AS`, `DWH_LANDING_TIPLUS_EU`
- Stage: `DWH_STAGE_TIPLUS_AS`, `DWH_STAGE_TIPLUS_EU`
- Vault: `DWH_RAW_VAULT`, `DWH_BUSINESS_VAULT`
- Analytics: `DWH_ANALYTICS`
- dbt: `DWH_DBT_USER`

**Tables created (create_dwh_tables.sql)**  
- `BASEEVENT`, `MASTER` in each landing schema

---

### **2.3. GoldenGate 23 Microservices**
- **Service name:** `ogg23`
- **Image:** `oracle/goldengate:23.4`
- **Ports:**
  - http://localhost:18080
  - https://localhost:18443
- **Admin user:** `oggadmin / ${OGG_ADMIN_PASSWORD}`

---

### **2.4. dbt (tfsdwh)**
- Connects to DWH `DWHPDB1`
- Uses `DWH_DBT_USER`
- Layers:
  - `stage/`
  - `raw_vault/`
  - `business_vault/`
  - `analytics/`

---

# 3. Prerequisites

### **3.1. Required software**
- Docker Desktop
- Git
- Bash shell
- Oracle account (for downloading binaries)

### **3.2. Recommended Docker Desktop resources**
- CPUs: **6–12**
- Memory: **8–16 GB**
- Swap: **1–4 GB**
- Disk: **50+ GB free**

### **3.3. CPU architecture check**

#### Windows
```
echo %PROCESSOR_ARCHITECTURE%
```

#### Linux / macOS
```
uname -m
```

Output meaning:
- `x86` – 32-bit  
- `AMD64` – Intel/AMD 64-bit  
- `ARM64` – Apple ARM  

---

# 4. Building Required Images

## 4.1. Clone Oracle Docker Repository

```
git clone https://github.com/oracle/docker-images.git
```

## 4.2. Download GoldenGate Binaries

Place ZIP (do not unzip) in:

```
docker-images/OracleGoldenGate/23/
```

## 4.3 ARM only – Download Oracle 19c ARM Build
Place ZIP into:

```
docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/
```

---

## 4.4. Build GoldenGate Image

### AMD64:
```
docker build --tag=oracle/goldengate:23.4 --build-arg INSTALLER=V1042871-01.zip .
```

### ARM64:
```
docker build --platform=linux/amd64 --tag=oracle/goldengate:23.4 --build-arg INSTALLER=V1042871-01.zip .
```

Expected: `oracle/goldengate:23.4`

---

## 4.5. Build Oracle 19c Database Image

```
buildContainerImage.sh -v 19.3.0 -e
```

Expected: `oracle/database:19.3.0-ee`

---

# 5. Deploying the Full Stack

## 5.1 Clone this Repo

Click the **“Code”** button at the top of this page to copy the correct clone URL.


## 5.2 Build the dbt Image

Build the dbt image, navigate to the directory containing your `docker-compose.yml` file and run:

```bash
docker compose build dbt


## 5.3 Start the stack

```
docker compose up -d
```

Monitor database initialization:

```
docker logs -f sor
docker logs -f dwh
```

Wait for:

```
DATABASE IS READY TO USE!
```

---

# 6. Runtime Operations

## 6.1. Using the interactive menu

Inside container:

```
docker exec -it dwh bash
/opt/oracle/scripts/ops/menu.sh
```

Menu:

1. **Reset**  
2. **Initialize**  
3. **Reinitialize**  

The same exists inside the SOR container.

---

## 6.2. Connecting to Oracle

### Host:
- SOR → localhost:1521 / SORPDB1  
- DWH → localhost:1522 / DWHPDB1  

### Inside containers:
```
docker exec -it sor sqlplus / as sysdba
docker exec -it dwh sqlplus / as sysdba
```

---

## 6.3. Running dbt

```
docker exec -it dbt bash
dbt debug
dbt run
dbt test
```

---

# 7. Conventions

### SQL Naming
- `create_*_users.sql`
- `drop_*_users.sql`
- `create_*_tables.sql`
- `drop_*_tables.sql`
- `setup_ogg.sql`

### Shell Orchestration
- `bootstrap.sh`
- `initialize.sh`
- `reset.sh`
- `menu.sh`

### Shared Logic
Inside:

```
database/shared/ops/
```

---

# 8. License

This project is licensed under the **MIT License**.
