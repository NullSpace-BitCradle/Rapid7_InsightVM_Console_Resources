# Machine-Readable Schema Files

This directory contains machine-readable JSON schema files for the Rapid7 InsightVM SQL Query Export interface, designed for automation, query building, and MCP development.

## 📁 Files Overview

### `rapid7_insightvm_complete_schema.json` (173KB)

Complete schema with all 89 tables and full field definitions

- **89 tables** with complete field information
- **All data types, constraints, and descriptions**
- **Primary and foreign key relationships**
- **Field-level metadata** for each table
- **Best for:** Complete reference, code generation, validation

### `rapid7_insightvm_schema_compact.json` (7KB)

Compact schema optimized for query building and MCP integration

- **Key tables only** with essential information
- **Common query patterns** and join templates
- **MCP function templates** for automation
- **Query building helpers** and examples
- **Best for:** Quick reference, query automation, MCP development

## 🎯 Use Cases

### Query Builder Automation

```json
{
  "common_joins": {
    "asset_vulnerability": "dim_asset da JOIN fact_asset_vulnerability_instance favi ON da.asset_id = favi.asset_id JOIN dim_vulnerability dv ON favi.vulnerability_id = dv.vulnerability_id"
  },
  "common_filters": {
    "critical_vulnerabilities": "dv.severity = 'Critical'"
  }
}
```

### MCP Development

```json
{
  "mcp_integration": {
    "function_templates": {
      "get_asset_vulnerabilities": {
        "description": "Get vulnerabilities for a specific asset",
        "parameters": ["asset_id"],
        "query_template": "SELECT dv.*, favi.* FROM dim_vulnerability dv JOIN fact_asset_vulnerability_instance favi ON dv.vulnerability_id = favi.vulnerability_id WHERE favi.asset_id = {asset_id}"
      }
    }
  }
}
```

### Code Generation

- **ORM models** from table definitions
- **API endpoints** from field metadata
- **Validation schemas** from constraints
- **Type definitions** from data types

## 🔧 Technical Details

### Schema Structure

```json
{
  "schema": {
    "name": "rapid7_insightvm_sql_export",
    "version": "1.0.0",
    "statistics": {
      "total_tables": 89,
      "dimension_tables": 64,
      "fact_tables": 24,
      "functions": 1
    },
    "tables": {
      "table_name": {
        "type": "dimension|fact|function",
        "description": "Table description",
        "primary_key": "field_name",
        "fields": {
          "field_name": {
            "type": "data_type",
            "primary_key": true|false,
            "nullable": true|false,
            "description": "Field description",
            "foreign_key": "referenced_table.field"
          }
        },
        "relationships": {
          "one_to_many": ["table1", "table2"],
          "many_to_one": ["table1"],
          "many_to_many": ["table1"]
        }
      }
    }
  }
}
```

### Data Types Supported

- **bigint** - Large integers (asset_id, scan_id)
- **integer** - Standard integers (vulnerability_id, site_id)
- **text** - Variable-length strings
- **timestamp** - Date and time values
- **inet** - IP addresses
- **macaddr** - MAC addresses
- **bool** - Boolean values
- **real** - Floating-point numbers

## 🚀 Integration Examples

### Python Query Builder

```python
import json

# Load schema
with open('rapid7_insightvm_schema_compact.json', 'r') as f:
    schema = json.load(f)

# Generate JOIN clause
def build_join(table1, table2):
    join_info = schema['schema']['query_building_helpers']['common_joins']
    return join_info.get(f"{table1}_{table2}", "")

# Example usage
join_clause = build_join("asset", "vulnerability")
```

### JavaScript MCP Server

```javascript
const schema = require('./rapid7_insightvm_schema_compact.json');

// Generate function from template
function createQueryFunction(templateName, params) {
    const template = schema.schema.mcp_integration.function_templates[templateName];
    return template.query_template.replace(/{(\w+)}/g, (match, key) => params[key]);
}
```

## ⚠️ Important Notes

- **Not officially verified** by Rapid7
- **Schema may vary** between InsightVM versions
- **Always validate** field names in your environment
- **Use as reference** for automation, not as specification

## 📊 File Statistics

| File | Size | Tables | Use Case |
|------|------|--------|----------|
| `rapid7_insightvm_complete_schema.json` | 173KB | 89 | Complete reference, code generation |
| `rapid7_insightvm_schema_compact.json` | 7KB | 4 key tables | Query building, MCP development |

---

**Generated from:** COMPLETE_TABLE_REFERENCE.md and RAPID7_INSIGHTVM_ERD.md  
**Last updated:** January 2025
