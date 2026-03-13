# Rapid7 InsightVM Database ERD

## Entity Relationship Diagram for Rapid7 InsightVM SQL Query Export Schema

This document provides a visual representation of the database schema relationships using Mermaid diagrams.

---

## Core Schema Overview

### Primary Entities

```mermaid
erDiagram
    dim_asset {
        bigint asset_id PK
        macaddr mac_address
        inet ip_address
        text host_name
        integer operating_system_id FK
        integer host_type_id FK
        text sites
        timestamp last_assessed_for_vulnerabilities
    }
    
    dim_vulnerability {
        integer vulnerability_id PK
        text title
        text severity
        real cvss_score
        integer exploits
        text description
        text solution
    }
    
    dim_site {
        integer site_id PK
        text name
        text description
        bigint last_scan_id FK
        bigint previous_scan_id FK
    }
    
    dim_scan {
        bigint scan_id PK
        text scan_name
        timestamp started
        timestamp finished
        text status_id FK
        text type_id FK
    }
    
    dim_solution {
        integer solution_id PK
        text summary
        text fix
        text solution_type
        text cpe
    }
```

### Core Relationships

```mermaid
erDiagram
    dim_asset ||--o{ fact_asset : "has"
    dim_asset ||--o{ fact_asset_vulnerability_instance : "has"
    dim_asset ||--o{ dim_site_asset : "belongs to"
    dim_asset ||--o{ dim_tag_asset : "tagged with"
    
    dim_vulnerability ||--o{ fact_asset_vulnerability_instance : "found in"
    dim_vulnerability ||--o{ dim_vulnerability_solution : "has solution"
    
    dim_site ||--o{ dim_site_asset : "contains"
    dim_site ||--o{ fact_site : "has metrics"
    
    dim_scan ||--o{ fact_scan : "generates"
    dim_scan ||--o{ fact_asset_scan : "scans"
    
    dim_solution ||--o{ dim_vulnerability_solution : "fixes"
    dim_solution ||--o{ fact_remediation : "remediates"
```

---

## Detailed Entity Relationships

### Asset Management

```mermaid
erDiagram
    dim_asset {
        bigint asset_id PK
        text host_name
        inet ip_address
        macaddr mac_address
    }
    
    dim_asset_host_name {
        bigint asset_id FK
        text host_name
        integer source_type_id
    }
    
    dim_asset_ip_address {
        bigint asset_id FK
        inet ip_address
        text type
    }
    
    dim_asset_mac_address {
        bigint asset_id FK
        macaddr mac_address
    }
    
    dim_asset_operating_system {
        bigint asset_id FK
        integer operating_system_id FK
        integer fingerprint_source_id FK
        real certainty
    }
    
    dim_asset_software {
        bigint asset_id FK
        integer software_id FK
        integer fingerprint_source_id FK
        real certainty
    }
    
    dim_asset_service {
        bigint asset_id FK
        integer service_id FK
        integer protocol_id FK
        integer port
        integer service_fingerprint_id FK
    }
    
    dim_asset ||--o{ dim_asset_host_name : "has"
    dim_asset ||--o{ dim_asset_ip_address : "has"
    dim_asset ||--o{ dim_asset_mac_address : "has"
    dim_asset ||--o{ dim_asset_operating_system : "runs"
    dim_asset ||--o{ dim_asset_software : "has"
    dim_asset ||--o{ dim_asset_service : "provides"
```

### Vulnerability Management

```mermaid
erDiagram
    fact_asset_vulnerability_instance {
        bigint asset_id FK
        integer vulnerability_id FK
        timestamp date
        text status_id
        text proof
        integer port
        integer protocol_id FK
        text key
    }
    
    fact_asset_vulnerability_age {
        bigint asset_id FK
        integer vulnerability_id FK
        integer age_in_days
        timestamp first_discovered
        timestamp most_recently_discovered
        timestamp reintroduced_date
    }
    
    dim_vulnerability_solution {
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    dim_asset_vulnerability_solution {
        bigint asset_id FK
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    fact_asset_vulnerability_instance ||--|| fact_asset_vulnerability_age : "tracks age"
    dim_vulnerability ||--o{ dim_vulnerability_solution : "has"
    dim_asset ||--o{ dim_asset_vulnerability_solution : "has"
```

### Policy & Compliance

```mermaid
erDiagram
    dim_policy {
        integer policy_id PK
        text title
        text description
        integer policy_group_id FK
    }
    
    dim_policy_rule {
        integer rule_id PK
        integer policy_id FK
        text title
        text description
        text operation
        text entity_value
    }
    
    fact_asset_policy {
        bigint asset_id FK
        integer policy_id FK
        integer compliant_rules
        integer noncompliant_rules
        real rule_compliance
    }
    
    fact_asset_policy_rule {
        bigint asset_id FK
        integer policy_id FK
        integer rule_id FK
        text status_id FK
        text result
    }
    
    dim_policy ||--o{ dim_policy_rule : "contains"
    dim_policy ||--o{ fact_asset_policy : "evaluates"
    dim_policy_rule ||--o{ fact_asset_policy_rule : "tests"
```

### Exception Management

```mermaid
erDiagram
    dim_vulnerability_exception {
        integer vulnerability_exception_id PK
        integer vulnerability_id FK
        text scope_id FK
        text reason_id FK
        text status_id FK
        integer site_id FK
        bigint asset_id FK
        text submitted_by
        timestamp submitted_date
        timestamp expiration_date
    }
    
    dim_exception_scope {
        text scope_id PK
        text short_description
        text description
    }
    
    dim_exception_reason {
        integer reason_id PK
        text description
    }
    
    dim_exception_status {
        text status_id PK
        text description
    }
    
    fact_asset_vulnerability_instance_excluded {
        bigint asset_id FK
        integer vulnerability_id FK
        integer vulnerability_exception_id FK
        integer port
        text key
    }
    
    dim_vulnerability_exception ||--o{ fact_asset_vulnerability_instance_excluded : "excludes"
    dim_exception_scope ||--o{ dim_vulnerability_exception : "defines scope"
    dim_exception_reason ||--o{ dim_vulnerability_exception : "justifies"
    dim_exception_status ||--o{ dim_vulnerability_exception : "tracks status"
```

---

## Fact Tables Overview

### Transaction Facts (Scan-based)

```mermaid
erDiagram
    fact_asset_scan {
        bigint asset_id FK
        bigint scan_id FK
        timestamp scan_started
        timestamp scan_finished
        integer vulnerabilities
        integer critical_vulnerabilities
        real riskscore
        text pci_status
    }
    
    fact_asset_scan_operating_system {
        bigint asset_id FK
        bigint scan_id FK
        integer operating_system_id FK
        integer fingerprint_source_id FK
        real certainty
    }
    
    fact_asset_scan_service {
        bigint asset_id FK
        bigint scan_id FK
        integer service_id FK
        integer protocol_id FK
        integer port
        integer service_fingerprint_id FK
        integer credential_status_id FK
    }
    
    fact_asset_scan_vulnerability_finding {
        bigint asset_id FK
        bigint scan_id FK
        integer vulnerability_id FK
        timestamp date
        integer vulnerability_instances
    }
    
    fact_scan {
        bigint scan_id FK
        timestamp started
        timestamp finished
        integer assets
        integer vulnerabilities
        integer critical_vulnerabilities
        real riskscore
        text pci_status
    }
```

### Accumulating Snapshots (Current State)

```mermaid
erDiagram
    fact_asset {
        bigint asset_id FK
        integer vulnerabilities
        integer critical_vulnerabilities
        integer severe_vulnerabilities
        integer moderate_vulnerabilities
        integer low_vulnerabilities
        real riskscore
        text pci_status
        integer aggregated_credential_status_id FK
    }
    
    fact_asset_vulnerability_finding {
        bigint asset_id FK
        integer vulnerability_id FK
        timestamp date
        integer vulnerability_instances
        text status_id
    }
    
    fact_vulnerability {
        integer vulnerability_id FK
        integer assets
        integer critical_assets
        integer severe_assets
        integer moderate_assets
        integer low_assets
        real riskscore
    }
    
    fact_site {
        integer site_id FK
        integer assets
        integer vulnerabilities
        integer critical_vulnerabilities
        real riskscore
        text pci_status
    }
```

---

## Key Relationship Patterns

### Many-to-Many Relationships

```mermaid
erDiagram
    dim_asset ||--o{ dim_asset_group_asset : "belongs to"
    dim_asset_group ||--o{ dim_asset_group_asset : "contains"
    
    dim_asset ||--o{ dim_tag_asset : "tagged with"
    dim_tag ||--o{ dim_tag_asset : "applied to"
    
    dim_vulnerability ||--o{ dim_vulnerability_solution : "has"
    dim_solution ||--o{ dim_vulnerability_solution : "fixes"
    
    dim_site ||--o{ dim_site_scan : "scanned by"
    dim_scan ||--o{ dim_site_scan : "executes on"
```

### Lookup Tables

```mermaid
erDiagram
    dim_operating_system {
        integer operating_system_id PK
        text vendor
        text family
        text name
        text version
        text architecture
        text cpe
    }
    
    dim_software {
        integer software_id PK
        text vendor
        text family
        text name
        text version
        text class
        text cpe
    }
    
    dim_service {
        integer service_id PK
        text name
    }
    
    dim_protocol {
        integer protocol_id PK
        text name
    }
    
    dim_host_type {
        integer host_type_id PK
        text description
    }
    
    dim_scan_status {
        text status_id PK
        text description
    }

    dim_scan_type {
        text type_id PK
        text description
    }
```

---

## Usage Patterns

### Common Query Patterns

1. **Asset Inventory**: `dim_asset` → `dim_asset_*` (host names, IPs, OS, software)
2. **Vulnerability Analysis**: `fact_asset_vulnerability_instance` → `dim_vulnerability`
3. **Compliance Reporting**: `fact_asset_policy` → `dim_policy` → `dim_policy_rule`
4. **Scan Results**: `fact_asset_scan` → `dim_scan` → `dim_site`
5. **Remediation Planning**: `fact_remediation()` function → `dim_solution`

### Performance Considerations

- **Primary Keys**: All tables have proper primary keys
- **Foreign Keys**: Relationships are properly indexed
- **Fact Tables**: Use for aggregations and counts
- **Dimension Tables**: Use for filtering and grouping
- **Bridge Tables**: Handle many-to-many relationships

---

## Related Documentation

- **[COMPLETE_TABLE_REFERENCE.md](COMPLETE_TABLE_REFERENCE.md)** - Complete field documentation
- **[QUICK_TABLE_LOOKUP.md](QUICK_TABLE_LOOKUP.md)** - Quick reference guide

---

## Complete Schema Map

**Warning: This is a comprehensive view of all 89 tables and their relationships. It's complex but useful for understanding the complete data model.**

### Core Entities & Primary Relationships

```mermaid
erDiagram
    %% Core Entities
    dim_asset {
        bigint asset_id PK
        inet ip_address
        text host_name
        integer operating_system_id FK
        integer host_type_id FK
    }
    
    dim_vulnerability {
        integer vulnerability_id PK
        text title
        text severity
        real cvss_score
    }
    
    dim_site {
        integer site_id PK
        text name
        bigint last_scan_id FK
    }
    
    dim_scan {
        bigint scan_id PK
        text scan_name
        timestamp started
        text status_id FK
    }
    
    dim_solution {
        integer solution_id PK
        text summary
        text solution_type
    }
    
    %% Primary Fact Tables
    fact_asset {
        bigint asset_id FK
        integer vulnerabilities
        real riskscore
    }
    
    fact_asset_vulnerability_instance {
        bigint asset_id FK
        integer vulnerability_id FK
        text status_id
        integer port
    }
    
    fact_scan {
        bigint scan_id FK
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    fact_site {
        integer site_id FK
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    fact_vulnerability {
        integer vulnerability_id FK
        integer assets
        real riskscore
    }
    
    %% Core Relationships
    dim_asset ||--o{ fact_asset : "has"
    dim_asset ||--o{ fact_asset_vulnerability_instance : "has"
    dim_asset ||--o{ dim_site_asset : "belongs to"
    
    dim_vulnerability ||--o{ fact_asset_vulnerability_instance : "found in"
    dim_vulnerability ||--o{ fact_vulnerability : "affects"
    
    dim_site ||--o{ fact_site : "has"
    dim_site ||--o{ dim_site_asset : "contains"
    
    dim_scan ||--o{ fact_scan : "generates"
    dim_scan ||--o{ fact_asset_scan : "scans"
    
    dim_solution ||--o{ fact_remediation : "remediates"
```

### Asset Detail Tables

```mermaid
erDiagram
    dim_asset {
        bigint asset_id PK
        inet ip_address
        text host_name
    }
    
    dim_asset_host_name {
        bigint asset_id FK
        text host_name
    }
    
    dim_asset_ip_address {
        bigint asset_id FK
        inet ip_address
        text type
    }
    
    dim_asset_mac_address {
        bigint asset_id FK
        macaddr mac_address
    }
    
    dim_asset_operating_system {
        bigint asset_id FK
        integer operating_system_id FK
        real certainty
    }
    
    dim_asset_software {
        bigint asset_id FK
        integer software_id FK
        real certainty
    }
    
    dim_asset_service {
        bigint asset_id FK
        integer service_id FK
        integer port
    }
    
    dim_asset_container {
        bigint asset_id FK
        text container_id
        text name
    }
    
    dim_asset_file {
        bigint asset_id FK
        text name
        bigint size
    }
    
    dim_asset_user_account {
        bigint asset_id FK
        text name
    }
    
    %% Asset Detail Relationships
    dim_asset ||--o{ dim_asset_host_name : "has"
    dim_asset ||--o{ dim_asset_ip_address : "has"
    dim_asset ||--o{ dim_asset_mac_address : "has"
    dim_asset ||--o{ dim_asset_operating_system : "runs"
    dim_asset ||--o{ dim_asset_software : "has"
    dim_asset ||--o{ dim_asset_service : "provides"
    dim_asset ||--o{ dim_asset_container : "contains"
    dim_asset ||--o{ dim_asset_file : "has"
    dim_asset ||--o{ dim_asset_user_account : "has"
```

### Vulnerability Management Tables

```mermaid
erDiagram
    dim_vulnerability {
        integer vulnerability_id PK
        text title
        text severity
    }
    
    fact_asset_vulnerability_instance {
        bigint asset_id FK
        integer vulnerability_id FK
        text status_id
        integer port
    }
    
    fact_asset_vulnerability_age {
        bigint asset_id FK
        integer vulnerability_id FK
        integer age_in_days
    }
    
    fact_asset_vulnerability_finding {
        bigint asset_id FK
        integer vulnerability_id FK
        integer vulnerability_instances
    }
    
    dim_vulnerability_solution {
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    dim_asset_vulnerability_solution {
        bigint asset_id FK
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    dim_vulnerability_exception {
        integer vulnerability_exception_id PK
        integer vulnerability_id FK
        text status_id FK
    }
    
    fact_asset_vulnerability_instance_excluded {
        bigint asset_id FK
        integer vulnerability_id FK
        integer vulnerability_exception_id FK
    }
    
    %% Vulnerability Relationships
    dim_vulnerability ||--o{ fact_asset_vulnerability_instance : "found in"
    dim_vulnerability ||--o{ fact_asset_vulnerability_age : "aged in"
    dim_vulnerability ||--o{ fact_asset_vulnerability_finding : "found in"
    dim_vulnerability ||--o{ dim_vulnerability_solution : "has"
    dim_vulnerability ||--o{ dim_asset_vulnerability_solution : "has solutions"
    dim_vulnerability ||--o{ dim_vulnerability_exception : "excepted"
    
    dim_vulnerability_exception ||--o{ fact_asset_vulnerability_instance_excluded : "excludes"
```

### Policy & Compliance Tables

```mermaid
erDiagram
    dim_policy {
        integer policy_id PK
        text title
        integer policy_group_id FK
    }
    
    dim_policy_group {
        integer policy_group_id PK
        text name
    }
    
    dim_policy_rule {
        integer rule_id PK
        integer policy_id FK
        text title
    }
    
    fact_asset_policy {
        bigint asset_id FK
        integer policy_id FK
        real rule_compliance
    }
    
    fact_asset_policy_rule {
        bigint asset_id FK
        integer policy_id FK
        integer rule_id FK
        text result
    }
    
    fact_policy {
        integer policy_id FK
        integer assets
        real asset_compliance
    }
    
    fact_policy_rule {
        integer policy_id FK
        integer rule_id FK
        integer assets
        real asset_compliance
    }
    
    %% Policy Relationships
    dim_policy_group ||--o{ dim_policy : "contains"
    dim_policy ||--o{ dim_policy_rule : "contains"
    dim_policy ||--o{ fact_asset_policy : "evaluates"
    dim_policy ||--o{ fact_policy : "has"
    
    dim_policy_rule ||--o{ fact_asset_policy_rule : "tests"
    dim_policy_rule ||--o{ fact_policy_rule : "has"
```

### Scan & Discovery Tables

```mermaid
erDiagram
    dim_scan {
        bigint scan_id PK
        text scan_name
        timestamp started
        text status_id FK
        text type_id FK
    }
    
    dim_scan_engine {
        integer scan_engine_id PK
        text name
        text version
    }
    
    dim_scan_template {
        integer scan_template_id PK
        text name
    }
    
    fact_asset_scan {
        bigint asset_id FK
        bigint scan_id FK
        integer vulnerabilities
        real riskscore
    }
    
    fact_asset_scan_operating_system {
        bigint asset_id FK
        bigint scan_id FK
        integer operating_system_id FK
    }
    
    fact_asset_scan_service {
        bigint asset_id FK
        bigint scan_id FK
        integer service_id FK
        integer port
    }
    
    fact_asset_scan_software {
        bigint asset_id FK
        bigint scan_id FK
        integer software_id FK
    }
    
    fact_asset_scan_vulnerability_finding {
        bigint asset_id FK
        bigint scan_id FK
        integer vulnerability_id FK
        integer vulnerability_instances
    }
    
    fact_asset_scan_vulnerability_instance {
        bigint asset_id FK
        bigint scan_id FK
        integer vulnerability_id FK
        text status_id
        integer port
    }
    
    %% Scan Relationships
    dim_scan ||--o{ fact_asset_scan : "scans"
    dim_scan ||--o{ fact_asset_scan_operating_system : "detects"
    dim_scan ||--o{ fact_asset_scan_service : "discovers"
    dim_scan ||--o{ fact_asset_scan_software : "finds"
    dim_scan ||--o{ fact_asset_scan_vulnerability_finding : "finds"
    dim_scan ||--o{ fact_asset_scan_vulnerability_instance : "instances"
```

### Lookup & Reference Tables

```mermaid
erDiagram
    dim_operating_system {
        integer operating_system_id PK
        text vendor
        text family
        text name
        text version
    }
    
    dim_software {
        integer software_id PK
        text vendor
        text family
        text name
        text version
    }
    
    dim_service {
        integer service_id PK
        text name
    }
    
    dim_protocol {
        integer protocol_id PK
        text name
    }
    
    dim_host_type {
        integer host_type_id PK
        text description
    }
    
    dim_scan_status {
        text status_id PK
        text description
    }

    dim_scan_type {
        text type_id PK
        text description
    }
    
    dim_fingerprint_source {
        integer fingerprint_source_id PK
        text source
    }
    
    dim_credential_status {
        integer credential_status_id PK
        text credential_status_description
    }
    
    dim_vulnerability_status {
        text status_id PK
        text description
    }
    
    dim_exception_scope {
        text scope_id PK
        text description
    }
    
    dim_exception_reason {
        integer reason_id PK
        text description
    }
    
    dim_exception_status {
        text status_id PK
        text description
    }
    
    dim_tag {
        integer tag_id PK
        text name
        text type
    }
    
    dim_asset_group {
        integer asset_group_id PK
        text name
        bool dynamic_membership
    }
    
    %% Lookup Relationships
    dim_operating_system ||--o{ dim_asset : "primary"
    dim_software ||--o{ dim_asset_software : "installed"
    dim_service ||--o{ dim_asset_service : "provided"
    dim_protocol ||--o{ dim_asset_service : "uses"
    dim_host_type ||--o{ dim_asset : "classified as"
    dim_scan_status ||--o{ dim_scan : "status"
    dim_scan_type ||--o{ dim_scan : "type"
    dim_fingerprint_source ||--o{ dim_asset_operating_system : "sources"
    dim_credential_status ||--o{ dim_asset_service_credential : "status"
    dim_vulnerability_status ||--o{ fact_asset_vulnerability_instance : "status"
    dim_exception_scope ||--o{ dim_vulnerability_exception : "scopes"
    dim_exception_reason ||--o{ dim_vulnerability_exception : "justifies"
    dim_exception_status ||--o{ dim_vulnerability_exception : "status"
    dim_tag ||--o{ dim_tag_asset : "applied to"
    dim_asset_group ||--o{ dim_asset_group_asset : "contains"
```

### Bridge & Junction Tables

```mermaid
erDiagram
    dim_site_asset {
        integer site_id FK
        bigint asset_id FK
    }
    
    dim_tag_asset {
        integer tag_id FK
        bigint asset_id FK
        text source
    }
    
    dim_asset_group_asset {
        integer asset_group_id FK
        bigint asset_id FK
    }
    
    dim_site_scan {
        integer site_id FK
        bigint scan_id FK
    }
    
    dim_site_scan_config {
        integer site_id FK
        integer scan_template_id FK
        integer scan_engine_id FK
    }
    
    dim_vulnerability_solution {
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    dim_asset_vulnerability_solution {
        bigint asset_id FK
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    dim_asset_vulnerability_best_solution {
        bigint asset_id FK
        integer vulnerability_id FK
        integer solution_id FK
    }
    
    %% Bridge Relationships
    dim_site_asset }o--|| dim_site : "belongs to"
    dim_site_asset }o--|| dim_asset : "contains"
    
    dim_tag_asset }o--|| dim_tag : "applied to"
    dim_tag_asset }o--|| dim_asset : "tagged with"
    
    dim_asset_group_asset }o--|| dim_asset_group : "contains"
    dim_asset_group_asset }o--|| dim_asset : "grouped in"
    
    dim_site_scan }o--|| dim_site : "scanned by"
    dim_site_scan }o--|| dim_scan : "executes on"
    
    dim_vulnerability_solution }o--|| dim_vulnerability : "has"
    dim_vulnerability_solution }o--|| dim_solution : "fixes"
    
    dim_asset_vulnerability_solution }o--|| dim_asset : "has"
    dim_asset_vulnerability_solution }o--|| dim_vulnerability : "has"
    dim_asset_vulnerability_solution }o--|| dim_solution : "solves"
```

### Additional Fact Tables

```mermaid
erDiagram
    fact_asset_discovery {
        bigint asset_id FK
        timestamp first_discovered
        timestamp last_discovered
    }
    
    fact_asset_group {
        integer asset_group_id FK
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    fact_asset_policy_rule_check {
        bigint asset_id FK
        integer policy_id FK
        integer rule_id FK
        text result
    }
    
    fact_asset_scan_policy {
        bigint asset_id FK
        bigint scan_id FK
        integer policy_id FK
        real rule_compliance
    }
    
    fact_policy_rule {
        integer policy_id FK
        integer rule_id FK
        integer assets
        real asset_compliance
    }
    
    fact_remediation {
        integer solution_id FK
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    fact_tag {
        integer tag_id FK
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    fact_all {
        integer assets
        integer vulnerabilities
        real riskscore
    }
    
    %% Additional Fact Relationships
    fact_asset_discovery }o--|| dim_asset : "tracks"
    fact_asset_group }o--|| dim_asset_group : "summarizes"
    fact_asset_policy_rule_check }o--|| dim_asset : "checks"
    fact_asset_scan_policy }o--|| dim_asset : "evaluates"
    fact_asset_scan_policy }o--|| dim_scan : "during"
    fact_policy_rule }o--|| dim_policy : "summarizes"
    fact_policy_rule }o--|| dim_policy_rule : "summarizes"
    fact_remediation }o--|| dim_solution : "tracks"
    fact_tag }o--|| dim_tag : "summarizes"
```

---
