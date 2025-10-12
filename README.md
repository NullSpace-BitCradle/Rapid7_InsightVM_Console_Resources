# Rapid7 InsightVM SQL Query Export Documentation

> **Comprehensive documentation suite for Rapid7 InsightVM SQL Query Export interface**

[![Documentation](https://img.shields.io/badge/Documentation-Complete-brightgreen)](https://github.com/yourusername/rapid7-insightvm-docs)
[![Tables](https://img.shields.io/badge/Tables-89-blue)](./COMPLETE_TABLE_REFERENCE.md)
[![Schema](https://img.shields.io/badge/Schema-Complete-orange)](./RAPID7_INSIGHTVM_ERD.md)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📋 Overview

This repository contains the most comprehensive documentation available for the **Rapid7 InsightVM SQL Query Export** interface, providing detailed schema information, table references, and practical guidance for vulnerability management teams.

> **⚠️ Important Note:** This documentation represents the most complete schema reference we have been able to identify and document. While we have made every effort to ensure accuracy, this documentation is not officially verified by Rapid7 and should be used as a reference guide rather than a guaranteed specification.

## 🎯 What This Documentation Provides

- **Complete table and field reference** for all 89 tables in the InsightVM SQL Export
- **Visual entity relationship diagrams** showing database structure and relationships
- **Quick lookup guide** with common use cases and query examples
- **Practical examples** and best practices for vulnerability management

---

## 📚 Documentation Files

### [📊 Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md)

The most comprehensive reference available for all InsightVM SQL Export tables

- **89 tables** documented to the best of our ability with field descriptions
- **Data types and constraints** as identified from schema analysis
- **Primary and foreign key relationships** as discovered
- **Table descriptions** compiled from available sources
- **64 dimension tables** + **24 fact tables** + **1 function**

### [⚡ Quick Table Lookup](./QUICK_TABLE_LOOKUP.md)

Fast reference guide for common use cases

- **Top 10 most used tables** based on query frequency
- **Use case organization** (Asset Inventory, Vulnerability Management, etc.)
- **Ready-to-use SQL examples** for common scenarios
- **Performance tips** and best practices
- **Common join patterns** and filtering techniques

### [🗺️ Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md)

Visual database schema representation

- **Mermaid diagrams** showing identified table relationships
- **Core entities** and their discovered connections
- **Fact vs. dimension table** organization as understood
- **Many-to-many relationships** and bridge tables as identified
- **Comprehensive schema map** for all 89 tables

### [📄 Machine-Readable Schema Files](./SCHEMA_FILES_README.md)

JSON schema files for automation, query building, and MCP development

- **Complete schema** (`rapid7_insightvm_complete_schema.json`) - 89 tables with full field definitions
- **Compact schema** (`rapid7_insightvm_schema_compact.json`) - Key tables optimized for query building
- **MCP integration** templates and function definitions
- **Query building helpers** and common join patterns
- **Code generation** support for ORMs and APIs

---

## ⚠️ Important Disclaimers

### Documentation Accuracy

- This documentation is based on **extensive analysis** of the InsightVM SQL Query Export interface
- **Field names, data types, and relationships** have been documented to the best of our ability
- **Schema may vary** between InsightVM versions and configurations
- **Always verify** field names and data types in your specific environment before using in production queries

### Limitations

- **Not officially verified** by Rapid7
- **Schema changes** may occur with InsightVM updates
- **Custom configurations** may affect table structure
- **Use as reference only** - not a guaranteed specification

---

## 🚀 Quick Start

### For Vulnerability Management Teams

1. **Start with** [Quick Table Lookup](./QUICK_TABLE_LOOKUP.md) for immediate answers
2. **Reference** [Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md) for detailed field information
3. **Use** [Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md) to understand table relationships

### For Developers and Integrators

1. **Start with** [Machine-Readable Schema Files](./SCHEMA_FILES_README.md) for automation and code generation
2. **Review** the [Complete Table Reference](./COMPLETE_TABLE_REFERENCE.md) for API understanding
3. **Study** the [Entity Relationship Diagram](./RAPID7_INSIGHTVM_ERD.md) for data modeling
4. **Use** the [Quick Table Lookup](./QUICK_TABLE_LOOKUP.md) for common query patterns

---

## 📊 Schema Overview

### Table Distribution

- **Dimension Tables:** 64 (master data, lookups, configurations)
- **Fact Tables:** 24 (metrics, measurements, aggregations)
- **Functions:** 1 (remediation analysis)

### Key Entity Categories

- **Assets** - Hosts, servers, network devices
- **Vulnerabilities** - Security findings and CVSS scores
- **Scans** - Discovery and assessment activities
- **Policies** - Compliance and configuration checks
- **Solutions** - Remediation recommendations
- **Exceptions** - Risk acceptance and exclusions

### Data Model Types

- **Accumulating Snapshots** - Current state (fact_asset, fact_vulnerability)
- **Transaction Facts** - Historical events (fact_asset_scan, fact_scan)
- **Bridge Tables** - Many-to-many relationships
- **Lookup Tables** - Reference data and enumerations

---

## 💡 Common Use Cases

### Asset Inventory Management

```sql
-- Get all assets with vulnerability counts
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

### Vulnerability Analysis

```sql
-- Find critical vulnerabilities with solutions
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

### Compliance Reporting

```sql
-- Policy compliance by asset
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

## 🔧 Technical Details

### Prerequisites

- **Rapid7 InsightVM** with SQL Query Export enabled
- **Database access** (local console or hosted)
- **SQL knowledge** for query construction
- **PostgreSQL** (for local console access)

### Supported Versions

- **InsightVM 6.x** and later
- **PostgreSQL 9.x** and later
- **SQL Query Export** interface

### Schema Files

- **Complete Schema** (`rapid7_insightvm_complete_schema.json`) - Full 89-table reference
- **Compact Schema** (`rapid7_insightvm_schema_compact.json`) - Optimized for query building
- **Machine-readable format** for automation and integration
- **MCP development** templates and function definitions

### Performance Considerations

- **Use fact tables** for counts and aggregations
- **Filter early** with WHERE clauses before JOINs
- **Limit results** during development and testing
- **Index on primary keys** (automatic in most cases)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Rapid7** for the InsightVM platform and SQL Query Export interface
- **Vulnerability management community** for feedback and contributions
- **Security teams** who provided real-world use cases and examples
