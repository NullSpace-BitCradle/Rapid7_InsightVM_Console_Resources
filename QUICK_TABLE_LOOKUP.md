# Quick Table Lookup Guide

**Quick reference for the most commonly used tables in SQL Query Export.**

---

## Top 10 Most Used Tables

Based on frequency in 143 example queries:

| Rank | Table | Usage Count | Purpose | Key Fields |
|------|-------|-------------|---------|------------|
| 1 | `fact_asset` | 67 | Asset vulnerability summary | `asset_id`, `vulnerabilities`, `critical_vulnerabilities`, `riskscore` |
| 2 | `dim_asset` | 48 | Asset master data | `asset_id`, `ip_address`, `host_name`, `operating_system_id` |
| 3 | `fact_asset_vulnerability_instance` | 31 | Vulnerability instances per asset | `asset_id`, `vulnerability_id`, `date`, `status_id`, `proof`, `port` |
| 4 | `dim_vulnerability` | 28 | Vulnerability definitions | `vulnerability_id`, `title`, `severity`, `cvss_score`, `exploits` |
| 5 | `dim_site` | 20 | Site configuration | `site_id`, `name`, `description`, `last_scan_id` |
| 6 | `fact_asset_scan` | 18 | Per-scan asset metrics | `asset_id`, `scan_id`, `scan_started`, `vulnerabilities` |
| 7 | `dim_scan` | 16 | Scan details | `scan_id`, `started`, `finished`, `status_id`, `scan_name` |
| 8 | `dim_asset_vulnerability_solution` | 14 | Solutions per vuln per asset | `asset_id`, `vulnerability_id`, `solution_id` |
| 9 | `dim_solution` | 13 | Remediation solutions | `solution_id`, `summary`, `fix`, `solution_type` |
| 10 | `dim_site_asset` | 12 | Asset-to-site mapping | `site_id`, `asset_id` |

---

## By Use Case

### Asset Inventory

**Primary Tables:**

- `dim_asset` - Asset master data
- `dim_asset_host_name` - All host names/aliases
- `dim_asset_ip_address` - All IP addresses
- `dim_asset_operating_system` - OS fingerprints
- `dim_asset_software` - Installed software

**Quick Query:**

```sql
SELECT 
    da.asset_id,
    da.ip_address,
    da.host_name,
    da.mac_address,
    da.operating_system_id,
    da.sites,
    da.last_assessed_for_vulnerabilities
FROM dim_asset da
WHERE da.ip_address IS NOT NULL
ORDER BY da.ip_address;
```

### Vulnerability Management

**Primary Tables:**

- `fact_asset_vulnerability_instance` - Active vulnerability instances
- `dim_vulnerability` - Vulnerability definitions
- `fact_asset` - Asset vulnerability summary
- `dim_asset_vulnerability_solution` - Solutions per vuln
- `fact_asset_vulnerability_age` - Vulnerability age tracking
- `fact_vulnerability` - Vulnerability statistics

**Quick Query:**

```sql
SELECT 
    favi.asset_id,
    da.ip_address,
    favi.vulnerability_id,
    dv.title,
    dv.severity,
    dv.cvss_score,
    favi.date,
    favi.port,
    favi.proof
FROM fact_asset_vulnerability_instance favi
JOIN dim_asset da ON favi.asset_id = da.asset_id
JOIN dim_vulnerability dv ON favi.vulnerability_id = dv.vulnerability_id
WHERE favi.status_id = 'vulnerable-version'
ORDER BY dv.severity DESC, da.ip_address;
```

### Remediation Planning

**Primary Tables:**

- `fact_remediation()` - Top solutions by risk score (FUNCTION)
- `dim_solution` - Solution details
- `dim_asset_vulnerability_solution` - Asset-vuln-solution mapping
- `dim_asset_vulnerability_best_solution` - Best solution per asset-vuln

**Quick Query:**

```sql
SELECT 
    solution_id,
    assets,
    vulnerabilities,
    critical_vulnerabilities,
    severe_vulnerabilities,
    riskscore
FROM fact_remediation(10, 'riskscore')
ORDER BY riskscore DESC;
```

### Compliance & Policy

**Primary Tables:**

- `fact_asset_policy` - Asset policy compliance
- `fact_asset_policy_rule` - Asset policy rule results
- `dim_policy` - Policy definitions
- `dim_policy_rule` - Policy rule definitions
- `dim_policy_override` - Policy overrides

**Quick Query:**

```sql
SELECT 
    fap.asset_id,
    da.ip_address,
    fap.policy_id,
    dp.title AS policy_title,
    fap.compliant_rules,
    fap.noncompliant_rules,
    fap.rule_compliance
FROM fact_asset_policy fap
JOIN dim_asset da ON fap.asset_id = da.asset_id
JOIN dim_policy dp ON fap.policy_id = dp.policy_id
WHERE fap.rule_compliance < 100
ORDER BY fap.rule_compliance ASC;
```

### Scanning & Discovery

**Primary Tables:**

- `dim_scan` - Scan metadata
- `fact_scan` - Scan statistics
- `fact_asset_scan` - Per-asset scan results
- `dim_scan_engine` - Scan engines
- `dim_site_scan` - Site-to-scan mapping

**Quick Query:**

```sql
SELECT 
    ds.scan_id,
    ds.scan_name,
    ds.started,
    ds.finished,
    ds.status_id,
    fs.assets,
    fs.vulnerabilities,
    fs.critical_vulnerabilities
FROM dim_scan ds
LEFT JOIN fact_scan fs ON ds.scan_id = fs.scan_id
WHERE ds.started >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY ds.started DESC;
```

### Exception Management

**Primary Tables:**

- `dim_vulnerability_exception` - Exception records
- `dim_exception_scope` - Scope types
- `dim_exception_reason` - Reason types
- `dim_exception_status` - Status types
- `fact_asset_vulnerability_instance_excluded` - Excluded instances

**Quick Query:**

```sql
SELECT 
    dve.vulnerability_exception_id,
    dve.vulnerability_id,
    dv.title,
    dve.submitted_by,
    dve.submitted_date,
    dve.expiration_date,
    dve.status_id,
    des.description AS status
FROM dim_vulnerability_exception dve
JOIN dim_vulnerability dv ON dve.vulnerability_id = dv.vulnerability_id
JOIN dim_exception_status des ON dve.status_id = des.status_id
WHERE dve.status_id = 'approve'
  AND (dve.expiration_date IS NULL OR dve.expiration_date > CURRENT_DATE)
ORDER BY dve.submitted_date DESC;
```

### Vulnerability Age Management

**Primary Tables:**

- `fact_asset_vulnerability_age` - Vulnerability age tracking
- `dim_vulnerability` - Vulnerability definitions
- `dim_asset` - Asset information
- `fact_asset_vulnerability_instance` - Current instances

**Quick Query:**

```sql
SELECT 
    favage.asset_id,
    da.ip_address,
    da.host_name,
    favage.vulnerability_id,
    dv.title,
    dv.severity,
    favage.age_in_days,
    favage.first_discovered,
    favage.most_recently_discovered
FROM fact_asset_vulnerability_age favage
JOIN dim_asset da ON favage.asset_id = da.asset_id
JOIN dim_vulnerability dv ON favage.vulnerability_id = dv.vulnerability_id
WHERE favage.age_in_days > 90  -- Vulnerabilities older than 90 days
  AND dv.severity IN ('Critical', 'Severe')
ORDER BY favage.age_in_days DESC, dv.severity DESC;
```

---

## Common Joins

### Asset → Site

```sql
FROM dim_asset da
JOIN dim_site_asset dsa ON da.asset_id = dsa.asset_id
JOIN dim_site ds ON dsa.site_id = ds.site_id
```

### Asset → Vulnerabilities

```sql
FROM dim_asset da
JOIN fact_asset_vulnerability_instance favi ON da.asset_id = favi.asset_id
JOIN dim_vulnerability dv ON favi.vulnerability_id = dv.vulnerability_id
```

### Vulnerability → Solutions

```sql
FROM dim_vulnerability dv
JOIN dim_vulnerability_solution dvs ON dv.vulnerability_id = dvs.vulnerability_id
JOIN dim_solution ds ON dvs.solution_id = ds.solution_id
```

### Asset → Tags

```sql
FROM dim_asset da
JOIN dim_tag_asset dta ON da.asset_id = dta.asset_id
JOIN dim_tag dt ON dta.tag_id = dt.tag_id
```

### Asset → Vulnerability Age

```sql
FROM dim_asset da
JOIN fact_asset_vulnerability_age favage ON da.asset_id = favage.asset_id
JOIN dim_vulnerability dv ON favage.vulnerability_id = dv.vulnerability_id
```

### Scan → Assets

```sql
FROM dim_scan ds
JOIN fact_asset_scan fas ON ds.scan_id = fas.scan_id
JOIN dim_asset da ON fas.asset_id = da.asset_id
```

---

## Pro Tips

### Filtering Tips

```sql
-- Only current/active vulnerabilities (most common)
WHERE favi.status_id = 'vulnerable-version'

-- Exclude exceptions
WHERE favi.vulnerability_exception_ids IS NULL

-- High/Critical only
WHERE dv.severity IN ('Critical', 'Severe')
  OR dv.severity_score >= 7

-- Recent scans only (last 30 days)
WHERE ds.started >= CURRENT_DATE - INTERVAL '30 days'

-- Active/running scans
WHERE ds.status_id IN ('running', 'complete')

-- Assets with vulnerabilities
WHERE fa.vulnerabilities > 0

-- Vulnerability age (older than 30 days)
WHERE favage.age_in_days > 30

-- Excluded vulnerability instances
WHERE favie.vulnerability_exception_id IS NOT NULL
```

### Performance Tips

1. **Use fact tables for counts:**

   - Don't: `COUNT(*)` across large joins
   - Do: Use `fact_asset.vulnerabilities`

2. **Filter early:**

   - Put WHERE clauses before JOINs when possible
   - Use CTEs to pre-filter large tables

3. **Limit results during development:**

   - Always use `LIMIT 10` while testing
   - Remove only when query is finalized

4. **Use indexes:**

   - Primary keys: `asset_id`, `vulnerability_id`, `scan_id`
   - Foreign keys are indexed automatically

---

## Full Documentation

For complete field lists and descriptions, see:

- **[COMPLETE_TABLE_REFERENCE.md](COMPLETE_TABLE_REFERENCE.md)** - All 89 tables

---
