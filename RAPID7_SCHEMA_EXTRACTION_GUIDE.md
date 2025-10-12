# 📓 InsightVM Schema Extraction (Local Console)

## 🌟 Objective

Extract the **full database schema** (no data) from the InsightVM local console PostgreSQL instance, for the purpose of offline analysis, ETL modeling, or platform integration (e.g. custom MCP server).

---

## ✅ Assumptions

* InsightVM is installed locally on an Ubuntu/RHEL VM (not the hosted SaaS version).
* You have **root** access to the box.
* Postgres is a **bundled binary**, not exposed externally.
* You're connecting via **SSH** from your workstation.

---

## ⚒️ Step-by-Step Process

### 1. **Find the Postgres Process and Binary Path**

```bash
ps aux | grep postgres
```

Expected output:

```text
nxpgsql  /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/postgres -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata
```

Identify:

* Binary path: `/opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/`
* Data directory: `/opt/rapid7/nexpose/nsc/nxpgsql/nxpdata`

---

### 2. **Edit `pg_hba.conf` to Allow Local Access**

```bash
sudo nano /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata/pg_hba.conf
```

Change this line:

```conf
local   all             all                                     md5
```

To:

```conf
local   all             all                                     trust
```

---

### 3. **Reload Postgres Config**

```bash
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_ctl reload -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata
```

---

### 4. **Verify DB Access Without Password**

```bash
cd /tmp
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/psql -d nexpose
```

You should land in the `nexpose=#` prompt. Exit with:

```bash
\q
```

---

### 5. **Dump the Schema**

```bash
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_dump -s -d nexpose -f /tmp/insightvm_schema.sql
```

* `-s`: schema only (no data)
* `-f`: write output to file

---

### 6. **Transfer the Schema File to Your Workstation**

From your **workstation terminal** (not inside SSH):

```bash
scp dbinfosec@<console_ip>:/tmp/insightvm_schema.sql .
```

If using hostname:

```bash
scp dbinfosec@<console_hostname>:/tmp/insightvm_schema.sql .
```

---

### 7. **Revert `pg_hba.conf` for Security**

Restore the original line:

```conf
local   all             all                                     md5
```

Then reload:

```bash
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_ctl reload -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata
```

---

## ✅ Output

* File: `/tmp/insightvm_schema.sql`
* Contents: All table definitions, fields, types, constraints, indexes.
* Loadable with:

```bash
createdb insightvm_schema
psql -d insightvm_schema -f insightvm_schema.sql
```

---

## ✅ Validation Steps

### Verify Schema Extraction Success

```bash
# Check file was created and has reasonable size
ls -lh /tmp/insightvm_schema.sql

# Expected: File should be several MB in size
# Example: -rw-r--r-- 1 nxpgsql nxpgsql 2.1M Jan 15 10:30 insightvm_schema.sql
```

### Validate Schema Content

```bash
# Count tables in the schema
grep -c "CREATE TABLE" /tmp/insightvm_schema.sql

# Expected: Should find 80+ tables
# Example: 89

# Check for key tables
grep -E "CREATE TABLE.*dim_asset|CREATE TABLE.*fact_asset" /tmp/insightvm_schema.sql

# Expected: Should find core tables
```

### Test Schema Loading

```bash
# Create test database
createdb insightvm_test

# Load schema
psql -d insightvm_test -f /tmp/insightvm_schema.sql

# Verify tables exist
psql -d insightvm_test -c "\dt" | wc -l

# Expected: Should show 80+ tables
```

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### Permission Denied Errors

**Problem:** `psql: FATAL: password authentication failed`

**Solution:**

```bash
# Verify pg_hba.conf was updated correctly
sudo cat /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata/pg_hba.conf | grep "local.*all.*all"

# Should show: local   all             all                                     trust
# If not, repeat step 2 of the extraction process
```

#### Connection Refused

**Problem:** `psql: could not connect to server`

**Solution:**

```bash
# Check if PostgreSQL is running
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_ctl status -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata

# If not running, start it
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_ctl start -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata
```

#### Empty or Invalid Schema File

**Problem:** Schema file is empty or contains errors

**Solution:**

```bash
# Check file size
ls -lh /tmp/insightvm_schema.sql

# If empty, verify database access
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/psql -d nexpose -c "\dt" | head -10

# Re-run extraction with verbose output
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_dump -s -v -d nexpose -f /tmp/insightvm_schema.sql
```

#### SCP Transfer Fails

**Problem:** Cannot transfer file from console to workstation

**Solution:**

```bash
# Check SSH connectivity
ssh dbinfosec@<console_hostname> "echo 'SSH working'"

# Verify file exists on console
ssh dbinfosec@<console_hostname> "ls -lh /tmp/insightvm_schema.sql"

# Try alternative transfer methods
# Option 1: Use rsync
rsync -avz dbinfosec@<console_hostname>:/tmp/insightvm_schema.sql .

# Option 2: Copy to web-accessible location
sudo cp /tmp/insightvm_schema.sql /var/www/html/
# Then download via browser: http://<console_ip>/insightvm_schema.sql
```

### Rollback Instructions

If you need to revert changes:

```bash
# Restore original pg_hba.conf
sudo sed -i 's/local   all             all                                     trust/local   all             all                                     md5/' /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata/pg_hba.conf

# Reload PostgreSQL configuration
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/pg_ctl reload -D /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata

# Verify security is restored
sudo -u nxpgsql /opt/rapid7/nexpose/nsc/nxpgsql/pgsql/bin/psql -d nexpose
# Should now prompt for password (press Ctrl+C to exit)
```

---

## 📋 Notes

* Read-only operation, does not interfere with live scans or data.
* Ideal for versioning schema over time as Rapid7 updates.
* Compatible with:

  * **DBeaver** / **pgAdmin** (for ERD)
  * `psql` CLI
  * Python/SQLAlchemy for parsing and modeling

---
