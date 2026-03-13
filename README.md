# Rapid7 InsightVM SQL Query Export Documentation

> **Comprehensive documentation suite for Rapid7 InsightVM SQL Query Export interface**

[![Tables](https://img.shields.io/badge/Tables-89-blue)](./COMPLETE_TABLE_REFERENCE.md)
[![Queries](https://img.shields.io/badge/Queries-151-green)](./QUERIES/)
[![Schema](https://img.shields.io/badge/Schema-Complete-orange)](./RAPID7_INSIGHTVM_ERD.md)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

This repository contains the most comprehensive documentation available for the **Rapid7 InsightVM SQL Query Export** interface, providing detailed schema information, table references, and practical guidance for vulnerability management teams.

> **Note:** This documentation represents the most complete schema reference we have been able to identify and document. It is not officially verified by Rapid7 and should be used as a reference guide rather than a guaranteed specification. Always verify field names and data types in your specific environment.

---

## Quick Start

### For Vulnerability Management Teams

1. **Start with** [Quick Table Lookup](./QUICK_TABLE_LOOKUP.md) for immediate answers
2. **Browse** [SQL Queries](./QUERIES/) for ready-to-run report templates
3. **Reference** [Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md) for detailed field information
4. **Use** [Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md) to understand table relationships

### For Developers and Integrators

1. **Start with** [Machine-Readable Schema Files](./SCHEMA_FILES_README.md) for automation and code generation
2. **Review** the [Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md) for field-level detail
3. **Study** the [Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md) for data modeling
4. **Use** the JSON schemas for MCP integration, ORM generation, or query builders

---

## Documentation Files

| File | Description |
|------|-------------|
| [Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md) | All 89 tables with field descriptions, data types, constraints, and key relationships (64 dimension + 24 fact + 1 function) |
| [Quick Table Lookup](./QUICK_TABLE_LOOKUP.md) | Top 10 tables, use-case organization, ready-to-use SQL examples, join patterns, and performance tips |
| [Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md) | Mermaid diagrams showing table relationships, fact vs. dimension organization, and bridge tables |
| [Schema Files Guide](./SCHEMA_FILES_README.md) | JSON schema files for automation, query building, MCP development, and code generation |

---

## SQL Queries

151 ready-to-run SQL queries in [`./QUERIES/`](./QUERIES/), organized by use case:

| Category | Example Queries | Description |
|----------|----------------|-------------|
| **Asset Inventory** | `COMPREHENSIVE_ASSET_INVENTORY`, `LIVE_ASSETS`, `ASSET_COUNT` | Asset discovery, host details, IP/MAC/OS data |
| **Vulnerabilities** | `ALL_ASSETS_ALL_VULNS`, `MOST_CRITICAL_VULNERABILITIES`, `VULN_AGING` | Vulnerability findings, severity, aging, exploit status |
| **Risk & Prioritization** | `ASSETS_ORDERED_BY_RISK`, `TOP_10_RISKIEST_ASSETS`, `ASSET_CONTEXT_DRIVEN_RISK` | Risk scores, prioritized remediation targets |
| **Remediation** | `TOP_25_REMEDIATION_REPORT`, `REMEDIATION_SUMMARY`, `TRACK_REMEDIATION` | Solution tracking, remediation progress, rollup reports |
| **Compliance** | `POLICY_COMPLIANCE`, `POLICY_RESULTS_AND_EXCEPTIONS`, `POLICY_REPORT_WITH_DETAILS` | Policy rule results, compliance percentages, exceptions |
| **Authentication** | `LIST_ASSETS_WITH_CREDENTIAL_STATUS`, `AUTHENTICATION_SERVICE_STATUS` | Credential verification, scan authentication results |
| **Software** | `SOFTWARE_INVENTORY`, `OBSOLETE_SOFTWARE`, `DETECT_FIREFOX_PER_VERSION` | Installed software, obsolete OS/software detection |
| **Scanning** | `SCAN_DURATION_REPORT`, `RECENTLY_SCANNED_ASSETS`, `SCAN_HISTORY_RISK` | Scan performance, coverage, history |
| **Trending** | `ASSET_GROUP_COMPARE_4_WEEK_TREND`, `HISTORICAL_VULNERABILITY_FINDINGS` | Week-over-week comparisons, historical snapshots |
| **SSL/TLS** | `TLS_1_VULNERABILITIES`, `SSL_ALL_CERTS`, `ASSETS_WITH_EXPIRING_CERTIFICATES` | Certificate inventory, TLS/SSL protocol findings |
| **Hot Topics** | `LOG4J_QUERY_BY_INSTANCE`, `SMBV1_ENABLED`, `ASSET_WITH_SHELL_SHOCK` | Queries for high-profile vulnerabilities |

### How to Use

1. Open a query from `./QUERIES/` in the InsightVM SQL Query Export console or your PostgreSQL client
2. Review the `FROM`/`JOIN` tables and any `WHERE` filters -- adjust for your environment (sites, tags, dates)
3. Start with `LIMIT` during testing, then remove or tune for reports and dashboards
4. Many queries include header comments with purpose, data sources, and estimated row counts

### Performance Tips

- Prefer **fact tables** for counts and aggregations
- **Filter early** with `WHERE` clauses before large joins
- **Limit results** during development and testing
- Queries marked with `WARNING` comments may return large result sets -- add filters before running in production

---

## Schema Overview

### Table Distribution

- **Dimension Tables:** 64 (master data, lookups, configurations)
- **Fact Tables:** 24 (metrics, measurements, aggregations)
- **Functions:** 1 (remediation analysis)

### Key Entity Categories

| Category | Description | Core Tables |
|----------|-------------|-------------|
| **Assets** | Hosts, servers, network devices | `dim_asset`, `fact_asset` |
| **Vulnerabilities** | Security findings and CVSS scores | `dim_vulnerability`, `fact_asset_vulnerability_instance` |
| **Scans** | Discovery and assessment activities | `dim_scan`, `fact_scan`, `fact_asset_scan` |
| **Policies** | Compliance and configuration checks | `dim_policy`, `dim_policy_rule`, `fact_asset_policy` |
| **Solutions** | Remediation recommendations | `dim_solution`, `fact_remediation()` |
| **Exceptions** | Risk acceptance and exclusions | `dim_vulnerability_exception` |

### Data Model Types

- **Accumulating Snapshots** -- Current state (`fact_asset`, `fact_vulnerability`)
- **Transaction Facts** -- Historical events (`fact_asset_scan`, `fact_scan`)
- **Bridge Tables** -- Many-to-many relationships
- **Lookup Tables** -- Reference data and enumerations

---

## Common Use Cases

### Asset Inventory with Vulnerability Counts

```sql
SELECT
    da.ip_address,
    da.host_name,
    fa.vulnerabilities,
    fa.critical_vulnerabilities,
    fa.riskscore
FROM dim_asset da
JOIN fact_asset fa ON da.asset_id = fa.asset_id
WHERE fa.vulnerabilities > 0
ORDER BY fa.riskscore DESC;
```

### Critical Vulnerabilities with Solutions

```sql
SELECT
    dv.title,
    dv.severity,
    dv.cvss_score,
    ds.summary,
    ds.solution_type
FROM dim_vulnerability dv
JOIN dim_vulnerability_solution dvs ON dv.vulnerability_id = dvs.vulnerability_id
JOIN dim_solution ds ON dvs.solution_id = ds.solution_id
WHERE dv.severity = 'Critical'
ORDER BY dv.cvss_score DESC;
```

### Policy Compliance by Asset

```sql
SELECT
    da.ip_address,
    dp.title AS policy_name,
    fap.rule_compliance,
    fap.compliant_rules,
    fap.noncompliant_rules
FROM fact_asset_policy fap
JOIN dim_asset da ON fap.asset_id = da.asset_id
JOIN dim_policy dp ON fap.policy_id = dp.policy_id
WHERE fap.rule_compliance < 100
ORDER BY fap.rule_compliance ASC;
```

---

## Technical Details

### Prerequisites

- **Rapid7 InsightVM** with SQL Query Export enabled
- **Database access** (local console or hosted)
- **SQL knowledge** for query construction
- **PostgreSQL** (for local console access)

### Supported Versions

- **InsightVM 6.x** and later
- **PostgreSQL 9.x** and later
- **SQL Query Export** interface

---

## Disclaimers

- This documentation is based on extensive analysis of the InsightVM SQL Query Export interface
- **Not officially verified** by Rapid7 -- use as reference, not specification
- **Schema may vary** between InsightVM versions and configurations
- **Custom configurations** may affect table structure
- **Always verify** field names and data types in your specific environment before production use

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- **Rapid7** for the InsightVM platform and SQL Query Export interface
- **Vulnerability management community** for feedback and contributions
- **Security teams** who provided real-world use cases and examples
