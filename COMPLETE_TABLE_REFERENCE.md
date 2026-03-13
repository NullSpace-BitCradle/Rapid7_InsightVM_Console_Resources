# Rapid7 InsightVM SQL Query Export - Complete Table & Field Reference

> **Generated:** 2025-10-12 11:29:50
> **Source:** Official Rapid7 Documentation + Manual Field Enumeration

This document provides near complete documentation for all tables and functions available through the Rapid7 InsightVM SQL Query Export interface, including:

- **Table descriptions** from official Rapid7 documentation
- **Field names** from manual enumeration
- **Data types and descriptions** from official documentation
- **Primary keys and foreign keys** where applicable

---

## Summary

- **Dimension Tables:** 64
- **Fact Tables:** 24
- **Functions:** 1
- **Total:** 89

---

## Table of Contents

- [dim_aggregated_credential_status](#dim_aggregated_credential_status)
- [dim_asset](#dim_asset)
- [dim_asset_container](#dim_asset_container)
- [dim_asset_file](#dim_asset_file)
- [dim_asset_group](#dim_asset_group)
- [dim_asset_group_account](#dim_asset_group_account)
- [dim_asset_group_asset](#dim_asset_group_asset)
- [dim_asset_host_name](#dim_asset_host_name)
- [dim_asset_ip_address](#dim_asset_ip_address)
- [dim_asset_mac_address](#dim_asset_mac_address)
- [dim_asset_operating_system](#dim_asset_operating_system)
- [dim_asset_scan](#dim_asset_scan)
- [dim_asset_service](#dim_asset_service)
- [dim_asset_service_configuration](#dim_asset_service_configuration)
- [dim_asset_service_credential](#dim_asset_service_credential)
- [dim_asset_software](#dim_asset_software)
- [dim_asset_unique_id](#dim_asset_unique_id)
- [dim_asset_user_account](#dim_asset_user_account)
- [dim_asset_vulnerability_best_solution](#dim_asset_vulnerability_best_solution)
- [dim_asset_vulnerability_solution](#dim_asset_vulnerability_solution)
- [dim_credential_status](#dim_credential_status)
- [dim_exception_reason](#dim_exception_reason)
- [dim_exception_scope](#dim_exception_scope)
- [dim_exception_status](#dim_exception_status)
- [dim_fingerprint_source](#dim_fingerprint_source)
- [dim_host_type](#dim_host_type)
- [dim_operating_system](#dim_operating_system)
- [dim_policy](#dim_policy)
- [dim_policy_group](#dim_policy_group)
- [dim_policy_override](#dim_policy_override)
- [dim_policy_result_status](#dim_policy_result_status)
- [dim_policy_rule](#dim_policy_rule)
- [dim_policy_rule_cce_platform_nist_control_mapping](#dim_policy_rule_cce_platform_nist_control_mapping)
- [dim_policy_rule_test](#dim_policy_rule_test)
- [dim_protocol](#dim_protocol)
- [dim_scan](#dim_scan)
- [dim_scan_engine](#dim_scan_engine)
- [dim_scan_status](#dim_scan_status)
- [dim_scan_template](#dim_scan_template)
- [dim_scan_type](#dim_scan_type)
- [dim_scope_asset_group](#dim_scope_asset_group)
- [dim_scope_site](#dim_scope_site)
- [dim_service](#dim_service)
- [dim_service_fingerprint](#dim_service_fingerprint)
- [dim_site](#dim_site)
- [dim_site_asset](#dim_site_asset)
- [dim_site_scan](#dim_site_scan)
- [dim_site_scan_config](#dim_site_scan_config)
- [dim_site_target](#dim_site_target)
- [dim_software](#dim_software)
- [dim_solution](#dim_solution)
- [dim_solution_highest_supercedence](#dim_solution_highest_supercedence)
- [dim_solution_prerequisite](#dim_solution_prerequisite)
- [dim_solution_supercedence](#dim_solution_supercedence)
- [dim_tag](#dim_tag)
- [dim_tag_asset](#dim_tag_asset)
- [dim_vulnerability](#dim_vulnerability)
- [dim_vulnerability_category](#dim_vulnerability_category)
- [dim_vulnerability_exception](#dim_vulnerability_exception)
- [dim_vulnerability_exploit](#dim_vulnerability_exploit)
- [dim_vulnerability_malware_kit](#dim_vulnerability_malware_kit)
- [dim_vulnerability_reference](#dim_vulnerability_reference)
- [dim_vulnerability_solution](#dim_vulnerability_solution)
- [dim_vulnerability_status](#dim_vulnerability_status)
- [fact_all](#fact_all)
- [fact_asset](#fact_asset)
- [fact_asset_discovery](#fact_asset_discovery)
- [fact_asset_group](#fact_asset_group)
- [fact_asset_policy](#fact_asset_policy)
- [fact_asset_policy_rule](#fact_asset_policy_rule)
- [fact_asset_policy_rule_check](#fact_asset_policy_rule_check)
- [fact_asset_scan](#fact_asset_scan)
- [fact_asset_scan_operating_system](#fact_asset_scan_operating_system)
- [fact_asset_scan_policy](#fact_asset_scan_policy)
- [fact_asset_scan_service](#fact_asset_scan_service)
- [fact_asset_scan_software](#fact_asset_scan_software)
- [fact_asset_scan_vulnerability_finding](#fact_asset_scan_vulnerability_finding)
- [fact_asset_scan_vulnerability_instance](#fact_asset_scan_vulnerability_instance)
- [fact_asset_vulnerability_age](#fact_asset_vulnerability_age)
- [fact_asset_vulnerability_finding](#fact_asset_vulnerability_finding)
- [fact_asset_vulnerability_instance](#fact_asset_vulnerability_instance)
- [fact_asset_vulnerability_instance_excluded](#fact_asset_vulnerability_instance_excluded)
- [fact_policy](#fact_policy)
- [fact_policy_rule](#fact_policy_rule)
- [fact_remediation](#fact_remediation)
- [fact_scan](#fact_scan)
- [fact_site](#fact_site)
- [fact_tag](#fact_tag)
- [fact_vulnerability](#fact_vulnerability)

---

## dim_aggregated_credential_status

**Description:** Dimension table containing the aggregated credential status information for assets. This table stores the overall credential testing status that summarizes the results of credential-based scanning attempts across all services on an asset.

**Keys & Relationships:**

- **Primary Key:** `aggregated_credential_status_id`
- **Referenced By:** [`fact_asset`](#fact_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `aggregated_credential_status_id` | integer | The unique identifier of the aggregated credential status. |
| 2 | `aggregated_credential_status_description` | text | The description of the aggregated credential status. |

---

## dim_asset

**Description:** Dimension for the most recent information of all assets. This is a slowly changing dimension that will change as new scans are performed on the asset.

**Keys & Relationships:**

- **Primary Key:** `asset_id`
- **Foreign Keys:**
  - `operating_system_id` → [`dim_operating_system`](#dim_operating_system)
  - `host_type_id` → [`dim_host_type`](#dim_host_type)
- **Referenced By:** [`dim_asset_container`](#dim_asset_container), [`dim_asset_file`](#dim_asset_file), [`dim_asset_group_asset`](#dim_asset_group_asset), [`dim_asset_host_name`](#dim_asset_host_name), [`dim_asset_ip_address`](#dim_asset_ip_address), [`dim_asset_mac_address`](#dim_asset_mac_address), [`dim_asset_operating_system`](#dim_asset_operating_system), [`dim_asset_scan`](#dim_asset_scan), [`dim_asset_service`](#dim_asset_service), [`dim_asset_service_configuration`](#dim_asset_service_configuration), [`dim_asset_service_credential`](#dim_asset_service_credential), [`dim_asset_software`](#dim_asset_software), [`dim_asset_unique_id`](#dim_asset_unique_id), [`dim_asset_user_account`](#dim_asset_user_account), [`dim_asset_vulnerability_best_solution`](#dim_asset_vulnerability_best_solution), [`dim_asset_vulnerability_solution`](#dim_asset_vulnerability_solution), [`dim_site_asset`](#dim_site_asset), [`dim_tag_asset`](#dim_tag_asset), [`fact_asset`](#fact_asset), [`fact_asset_discovery`](#fact_asset_discovery), and all asset-related fact tables

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `mac_address` | macaddr | The primary or best MAC address associated to the asset in the scan. |
| 3 | `ip_address` | inet | The primary IP address of the asset. |
| 4 | `host_name` | text | The primary host name of the asset. If a host name was used to detect the asset, this name will be preferred. |
| 5 | `operating_system_id` | integer | The unique identifier of the primary operating system detected on the asset. |
| 6 | `host_type_id` | integer | The unique identifier of the host type (e.g., Guest, Hypervisor, Physical, Virtual). |
| 7 | `match_value` | text | The value used to match and uniquely identify the asset across scans. |
| 8 | `sites` | text | A comma-delimited list of sites the asset is currently a part of (sorted by name ascending). This column can be used a simple and conventient alternative to querying against dim_site_asset to retrieve the individual relationships. |
| 9 | `last_assessed_for_vulnerabilities` | timestamp | The date and time the asset was last assessed for vulnerabilities. |

---

## dim_asset_container

**Description:** Dimension for the containers detected on a container host. Each record represents one container. If an asset has no containers or is not a container host, there will be no records for the asset in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `container_id` | text | The identifier of the container. |
| 3 | `name` | text | The name of the container. |
| 4 | `status` | text | The status of the container (one of 'CREATED', 'RUNNING', 'PAUSED', 'RESTARTING', 'EXITED', 'DEAD', or 'UNKNOWN;') |
| 5 | `created` | timestamp | The date that the container was created. |
| 6 | `started` | timestamp | The date the container last started. |
| 7 | `finished` | timestamp | The date the container last finished running. |
| 8 | `image_id` | text | The identifier of the image the container was based from. |
| 9 | `digest` | text | The digest of the image the container was based on. |
| 10 | `repository` | text | The repository of the image the container was based on. |

---

## dim_asset_file

**Description:** Dimension for files and directories that have been enumerated on an asset. Each record represents one file or directory discovered on an asset. If an asset has no files or groups enumerated, there will be no records in this dimension for the asset.

**Keys & Relationships:**

- **Primary Key:** `file_id`
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `file_id` | bigint | The unique identifier of the file or directory. |
| 3 | `type` | text | The type of the file. Either 'Directory', 'File' or 'Unknown'. |
| 4 | `name` | text | The name of the file or directory. |
| 5 | `size` | bigint | The size of the file or directory in bytes. If the size is unknown, or the file is a directory, the value will be -1. |

---

## dim_asset_group

**Description:** Dimension for all asset groups that any assets within the scope of the report belong to. Each asset group has metadata that define it and can be based off dynamic membership criteria.

**Keys & Relationships:**

- **Primary Key:** `asset_group_id`
- **Referenced By:** [`dim_asset_group_asset`](#dim_asset_group_asset), [`dim_scope_asset_group`](#dim_scope_asset_group), [`fact_asset_group`](#fact_asset_group)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_group_id` | integer | The unique identifier of the asset group. |
| 2 | `name` | text | The name of the asset groups which provides a human-readable identifier of the group. Asset groups names are guaranteed to be unique across multiple groups. |
| 3 | `description` | text | A description of the asset group that indicates the content, purpose, or composition of a group. |
| 4 | `dynamic_membership` | bool | Indicates whether the assets belonging to the group are defined statically by an user, or can change automatically based on asset metadata. If true, the membership of the group is dynamically changed whenever scans are performed on assets and the metadata and vulnerabilities related to the asset change. If false, the membership is static and defined manually by a group administrator. |

---

## dim_asset_group_account

**Description:** Dimension for user group accounts that have been enumerated on an asset. Each record represents one user group account on an asset. If an asset has no user group accounts enumerated, there will be no records in this dimension for the asset.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `name` | text | The name of the group account. |

---

## dim_asset_group_asset

**Description:** Dimension for the association between an asset and an asset group. For each asset there will be one record with an association to one asset group. This dimension only provides current associations and does not indicate whether an asset once belonged to a group, but it is no longer.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_group_id`, `asset_id`)
- **Foreign Keys:**
  - `asset_group_id` → [`dim_asset_group`](#dim_asset_group)
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_group_id` | integer | The unique identifier of the asset group. |
| 2 | `asset_id` | bigint | The unique identifier of the asset. |

---

## dim_asset_host_name

**Description:** Dimension for the aliases or host names of an asset. Each record represents one of the host names that were discovered during the most recent scan of the asset, including the primary name available within the other asset fact tables. This dimension is built so it includes all aliases found in any node on the asset within the latest scan. If an asset did not have a host name detected in the latest scan, an empty value will be associated with the asset.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `host_name` | text | A host name that was detected on the asset. |
| 3 | `source_type_id` | integer | The identifier of the source type from which the host name was detected. |

---

## dim_asset_ip_address

**Description:** Bridge table that stores all IP addresses associated with an asset. This table captures the many-to-many relationship between assets and their various IP addresses, including both primary and secondary IPs discovered during scanning.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `ip_address` | inet | An IP address associated with the asset. |
| 3 | `type` | text | The type of IP address (e.g., 'IPv4' or 'IPv6'). |

---

## dim_asset_mac_address

**Description:** Bridge table that stores all MAC addresses associated with an asset. This table captures the many-to-many relationship between assets and their various MAC addresses discovered during network scanning.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `mac_address` | macaddr | A MAC address associated with the asset. |

---

## dim_asset_operating_system

**Description:** Dimension for the potential operating systems on an asset. Unlike dim_asset, this dimension provides access to all operating system fingerprints that have been detected. If an asset has no operating system fingerprints detected on it, there will be no records for the asset in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `operating_system_id` → [`dim_operating_system`](#dim_operating_system)
  - `fingerprint_source_id` → [`dim_fingerprint_source`](#dim_fingerprint_source)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `operating_system_id` | integer | The unique identifier of the operating system detected. |
| 3 | `fingerprint_source_id` | integer | The unique identifier of the fingerprint source used to detect the operating system. |
| 4 | `certainty` | real | The certainty of the fingerprint, expressed as a decimal confidence between 0 (low) and 1.0 (high). |

---

## dim_asset_scan

**Description:** Bridge table that tracks the relationship between assets and scans, storing scan-specific metadata for each asset during a particular scan execution. This table captures when assets were scanned and their scan-specific attributes.

**Keys & Relationships:**

- **Primary Key:** Composite (`scan_id`, `asset_id`)
- **Foreign Keys:**
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scan_id` | bigint | The unique identifier of the scan. |
| 2 | `asset_id` | bigint | The unique identifier of the asset. |
| 3 | `scan_started` | timestamp | The time at which the scan started. |
| 4 | `scan_finished` | timestamp | The time at which the scan ended. |
| 5 | `match_value` | text | The match value used to identify the asset in the scan. |

---

## dim_asset_service

**Description:** Dimension for the set of services that have been detected on an asset. Each record represents an open port that is running a service on a protocol. If an asset has no services detected on it, there will be no records for the asset in this dimension.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `service_id`, `protocol_id`, `port`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `service_id` | integer | The unique identifier of the service. |
| 3 | `protocol_id` | integer | The unique identifier of the protocol. |
| 4 | `port` | integer | The port the service is running on. |
| 5 | `service_fingerprint_id` | integer | The unique identifier of the service fingerprint. |
| 6 | `certainty` | real | The certainty of the service fingerprint that detected the service, expressed as a decimal confidence between 0 (low) and 1.0 (high). |

---

## dim_asset_service_configuration

**Description:** Dimension for the configurations that have been detected on the services of an asset. Each record represents a configuration value that has been detected on a service. If an asset has no services detected on it, or no configurations were detected, there will be no records for the asset in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `service_id` → [`dim_service`](#dim_service)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `service_id` | integer | The unique identifier of the service. |
| 3 | `name` | text | The name of the configuration value (e.g. 'http.banner', 'ssl.cert.sig.alg.name', etc). |
| 4 | `value` | text | The value of the configuration (e.g. 'Microsoft-IIS/7.5', 'SHA1withRSA', etc). |
| 5 | `port` | integer | The port the service is running on. |

---

## dim_asset_service_credential

**Description:** Bridge table that stores credential testing information for services discovered on assets. This table tracks which services were tested with credentials, the results of those tests, and the associated protocol and port information.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)
  - `credential_status_id` → [`dim_credential_status`](#dim_credential_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `service_id` | integer | The unique identifier of the service. |
| 3 | `port` | integer | The port on which the service was running. |
| 4 | `protocol_id` | integer | The unique identifier of the protocol. |
| 5 | `credential_status_id` | integer | The unique identifier of the credential status. |

---

## dim_asset_software

**Description:** Dimension for the software that have been detected on an asset. Each record represents a fingerprint result and multiple software instances can be associated with each asset. If an asset had no installed software detected, there will be no records in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `software_id` → [`dim_software`](#dim_software)
  - `fingerprint_source_id` → [`dim_fingerprint_source`](#dim_fingerprint_source)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `software_id` | integer | The unique identifier of the software detected on the asset. |
| 3 | `fingerprint_source_id` | integer | The unique identifier of the fingerprint source used to detect the software. |

---

## dim_asset_unique_id

**Description:** Dimension for the unique identifiers on an asset. Each record represents a unique identifier enumerated on an asset. Not all assets are guaranteed to have a unique identifier.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `source` | text | The source used to discover the unique identifier (e.g. 'WML' or 'system_profiler', etc) |
| 3 | `unique_id` | text | The unique identifier enumerated on the asset. |

---

## dim_asset_user_account

**Description:** Dimension for user accounts that have been enumerated on an asset. Each record represents one user account on an asset. If an asset has no user accounts enumerated, there will be no records in this dimension for the asset.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `name` | text | The short, login name associated with the user account. This value may be null, but is typically non-null. |
| 3 | `full_name` | text | The longer name, or description, of the user account. |

---

## dim_asset_vulnerability_best_solution

**Description:** Bridge table that identifies the best remediation solution for each vulnerability found on a specific asset. This table helps prioritize remediation efforts by linking assets and vulnerabilities to their most effective solution.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 3 | `solution_id` | integer | The unique identifier of the best remediation solution for this vulnerability on this asset. |

---

## dim_asset_vulnerability_solution

**Description:** Bridge table that stores all possible remediation solutions for vulnerabilities found on assets. This table captures the many-to-many relationship between asset-vulnerability combinations and their available remediation solutions.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`, `solution_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 3 | `solution_id` | integer | The unique identifier of a remediation solution for this vulnerability on this asset. |

---

## dim_credential_status

**Description:** Lookup table containing the different states of credential testing results. This table stores the various outcomes when attempting to authenticate with discovered services using provided credentials.

**Keys & Relationships:**

- **Primary Key:** `credential_status_id`
- **Referenced By:** [`dim_asset_service_credential`](#dim_asset_service_credential)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `credential_status_id` | integer | The unique identifier of the credential status. |
| 2 | `credential_status_description` | text | The description of the credential status (e.g., 'All Credentials Failed', 'Partial Success', 'Success'). |

---

## dim_exception_reason

**Description:** Lookup table containing the valid reasons for submitting vulnerability exceptions. This table stores the business justifications that can be used when requesting to exclude vulnerabilities from compliance reporting.

**Keys & Relationships:**

- **Primary Key:** `reason_id`
- **Referenced By:** [`dim_vulnerability_exception`](#dim_vulnerability_exception)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `reason_id` | integer | The unique identifier of the exception reason. |
| 2 | `description` | text | The description of why the vulnerability exception was submitted (e.g., 'Acceptable Use', 'Compensating Control', 'False Positive'). |

---

## dim_exception_scope

**Description:** Lookup table defining the different levels at which vulnerability exceptions can be applied. This table stores the scope options for exceptions, such as global, site-level, asset-level, or instance-level exclusions.

**Keys & Relationships:**

- **Primary Key:** `scope_id`
- **Referenced By:** [`dim_vulnerability_exception`](#dim_vulnerability_exception)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scope_id` | text | The unique identifier of the exception scope (e.g., 'G' for Global, 'D' for Asset, 'I' for Instance, 'S' for Site). |
| 2 | `short_description` | text | A short description of the exception scope. |
| 3 | `description` | text | A detailed description of the exception scope level. |

---

## dim_exception_status

**Description:** Lookup table containing the different states of vulnerability exception requests. This table stores the workflow statuses for exception approval processes, such as pending, approved, rejected, or expired.

**Keys & Relationships:**

- **Primary Key:** `status_id`
- **Referenced By:** [`dim_vulnerability_exception`](#dim_vulnerability_exception)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `status_id` | text | The unique identifier of the exception status. |
| 2 | `description` | text | The description of the exception status (e.g., 'Approved', 'Rejected', 'Under Review', 'Expired'). |

---

## dim_fingerprint_source

**Description:** Lookup table containing the different sources used for fingerprinting operating systems and software. This table stores the various methods used to identify system components, such as WMI, Registry, File System, or Network Banner.

**Keys & Relationships:**

- **Primary Key:** `fingerprint_source_id`
- **Referenced By:** [`dim_asset_operating_system`](#dim_asset_operating_system), [`dim_asset_software`](#dim_asset_software)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `fingerprint_source_id` | integer | The unique identifier of the fingerprint source. |
| 2 | `source` | text | The source of the fingerprint (e.g., 'WMI', 'Registry', 'File System'). |

---

## dim_host_type

**Description:** Lookup table containing the different types of hosts that can be discovered during scanning. This table stores the various host classifications, such as Physical, Virtual, Guest, or Hypervisor systems.

**Keys & Relationships:**

- **Primary Key:** `host_type_id`
- **Referenced By:** [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `host_type_id` | integer | The unique identifier of the host type. |
| 2 | `description` | text | The description of the host type (e.g., 'Guest', 'Hypervisor', 'Physical', 'Virtual'). |

---

## dim_operating_system

**Description:** Dimension table containing detailed information about operating systems discovered during scanning. This table stores comprehensive OS details including vendor, family, name, version, architecture, and CPE identifiers for all detected operating systems.

**Keys & Relationships:**

- **Primary Key:** `operating_system_id`
- **Referenced By:** [`dim_asset`](#dim_asset), [`dim_asset_operating_system`](#dim_asset_operating_system), [`fact_asset_scan_operating_system`](#fact_asset_scan_operating_system)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `operating_system_id` | integer | The unique identifier of the operating system. |
| 2 | `asset_type` | text | The type of asset (e.g., 'Guest', 'Hypervisor', 'Physical', 'Virtual'). |
| 3 | `description` | text | A full description of the operating system including vendor, family, name, version, and architecture. |
| 4 | `vendor` | text | The vendor of the operating system (e.g., 'Microsoft', 'Red Hat', 'Apple'). |
| 5 | `family` | text | The family of the operating system (e.g., 'Windows', 'Linux', 'Mac OS X'). |
| 6 | `name` | text | The name of the operating system (e.g., 'Windows Server 2019', 'Ubuntu'). |
| 7 | `version` | text | The version of the operating system. |
| 8 | `architecture` | text | The system architecture (e.g., 'x86', 'x64', 'ARM'). |
| 9 | `system` | text | The system description combining vendor and family. |
| 10 | `cpe` | text | The Common Platform Enumeration (CPE) identifier for the operating system. |

---

## dim_policy

**Description:** Dimension for all metadata related to a policy. It contains one record for every policy that currently exists.

**Keys & Relationships:**

- **Primary Key:** `policy_id`
- **Referenced By:** [`dim_policy_group`](#dim_policy_group), [`dim_policy_rule`](#dim_policy_rule), [`fact_asset_policy`](#fact_asset_policy), [`fact_asset_scan_policy`](#fact_asset_scan_policy), [`fact_policy`](#fact_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `policy_id` | bigint | The unique identifier of a policy. |
| 2 | `scope` | text | The scope of the policy (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 3 | `title` | text | The title of the policy as visible to the user. |
| 4 | `description` | text | A description of the policy. |
| 5 | `total_rules` | integer | The total number of rules defined in the policy. |
| 6 | `benchmark_name` | text | The name of the benchmark standard the policy is based on (e.g., 'CIS', 'DISA STIG', 'PCI DSS'). |
| 7 | `benchmark_version` | text | The version of the benchmark standard. |
| 8 | `category` | text | The category of the policy. |

---

## dim_policy_group

**Description:** Dimension for all the metadata for each group of rules within a policy. It contains one record for every unhidden group within each policy.

**Keys & Relationships:**

- **Primary Key:** Composite (`policy_id`, `group_id`)
- **Foreign Keys:**
  - `policy_id` → [`dim_policy`](#dim_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `policy_id` | bigint | The identifier of the policy. |
| 2 | `scope` | text | The scope of the policy (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 3 | `group_id` | bigint | The identifier of the group. |
| 4 | `group_name` | text | The name of policy group. |
| 5 | `title` | text | The title of the group, for each policy, that is visible to the user. |
| 6 | `description` | text | A description of the group. |
| 7 | `parent_group_id` | bigint | The identifier of a group in the policy that a group directly belongs to. |
| 8 | `sub_groups` | integer | The number of groups descending from a group |
| 9 | `rules` | integer | The number of all rules including rule of a group's sub-groups. |

---

## dim_policy_override

**Description:** Dimension table containing policy override information that allows administrators to override policy rule results. This table stores override requests, approvals, effective dates, and the new status to be applied to specific policy rules.

**Keys & Relationships:**

- **Primary Key:** `override_id`
- **Referenced By:** [`fact_asset_policy_rule`](#fact_asset_policy_rule), [`fact_asset_scan_policy`](#fact_asset_scan_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `override_id` | bigint | The unique identifier of the policy override. |
| 2 | `submitted_by` | text | The login name of the user who submitted the override. |
| 3 | `submit_time` | timestamp | The time at which the override was submitted. |
| 4 | `comments` | text | Comments provided when the override was submitted. |
| 5 | `reviewed_by` | text | The login name of the user who reviewed the override. |
| 6 | `review_comments` | text | Comments provided when the override was reviewed. |
| 7 | `review_state_id` | integer | The identifier of the review state. |
| 8 | `effective_time` | timestamp | The time at which the override becomes effective. |
| 9 | `expiration_time` | timestamp | The time at which the override expires. |
| 10 | `new_status_id` | integer | The identifier of the new status applied by the override. |
| 11 | `scope_id` | text | The identifier of the scope to which the override applies. |

---

## dim_policy_result_status

**Description:** Lookup table containing the different possible results for policy rule evaluations. This table stores the various outcome states for policy compliance testing, such as Pass, Fail, Not Applicable, or Error.

**Keys & Relationships:**

- **Primary Key:** `status_id`
- **Referenced By:** [`fact_asset_policy`](#fact_asset_policy), [`fact_asset_policy_rule`](#fact_asset_policy_rule), [`fact_asset_policy_rule_check`](#fact_asset_policy_rule_check), [`fact_asset_scan_policy`](#fact_asset_scan_policy), [`fact_policy`](#fact_policy), [`fact_policy_rule`](#fact_policy_rule)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `status_id` | text | The unique identifier of the policy result status. |
| 2 | `description` | text | The description of the policy result status (e.g., 'Pass', 'Fail', 'Not Applicable', 'Error'). |

---

## dim_policy_rule

**Description:** Dimension for all the metadata for each rule within a policy. It contains one record for every rule within each policy.

**Keys & Relationships:**

- **Primary Key:** `rule_id`
- **Foreign Keys:**
  - `policy_id` → [`dim_policy`](#dim_policy)
- **Referenced By:** [`dim_policy_rule_cce_platform_nist_control_mapping`](#dim_policy_rule_cce_platform_nist_control_mapping), [`dim_policy_rule_test`](#dim_policy_rule_test), [`fact_asset_policy_rule`](#fact_asset_policy_rule), [`fact_asset_policy_rule_check`](#fact_asset_policy_rule_check), [`fact_policy_rule`](#fact_policy_rule)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `policy_id` | bigint | The identifier of the policy. |
| 2 | `scope` | text | The scope of the policy rule (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 3 | `rule_id` | bigint | The identifier of the policy rule. |
| 4 | `title` | text | The title of the rule, for each policy, that is visible to the user. It describes a state or condition with which a tested asset should comply. |
| 5 | `description` | text | A description of the rule. |
| 6 | `parent_group_id` | bigint | The identifier of a group in the policy that a rule directly belongs to. |
| 7 | `severity` | text | The severity of the rule. A textual value that can be one of the following: "low", "medium", "high", or "unknown". |
| 8 | `rationale` | text | Descriptive text explaining why compliance is important to the security of the target platform. |
| 9 | `remediation` | text | Instructions for remediating the non-compliant rule. |
| 10 | `role` | text | The rule's role in scoring and reporting: "full", "unchecked" and "unscored". |
| 11 | `enabled` | bool | The boolean to determine whether this rule is enabled. |

---

## dim_policy_rule_cce_platform_nist_control_mapping

**Description:** Dimension that provides all NIST SP 800-53 controls mappings for each CCE within a rule.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `rule_id` → [`dim_policy_rule`](#dim_policy_rule)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `rule_id` | bigint | The identifier of the policy rule. |
| 2 | `rule_scope` | text | The scope of the policy rule (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 3 | `cce_item_id` | text | The identifier of the CCE item. |
| 4 | `platform` | text | The platform of the CCE. |
| 5 | `control_name` | text | The name of the control mapping. |
| 6 | `date_published` | date | The date published of the control mapping. |

---

## dim_policy_rule_test

**Description:** Dimension that provides all tests associated with a policy rule.

**Keys & Relationships:**

- **Primary Key:** `test_id`
- **Foreign Keys:**
  - `rule_id` → [`dim_policy_rule`](#dim_policy_rule)
- **Referenced By:** [`fact_asset_policy_rule_check`](#fact_asset_policy_rule_check)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `test_id` | text | The unique identifier of the policy rule test. |
| 2 | `test_type` | text | The type of the policy rule test. |
| 3 | `test_name` | text | The name of the policy rule test. |
| 4 | `test_version` | text | The version of the policy rule test. |
| 5 | `rule_id` | bigint | The identifier of the policy rule. |
| 6 | `entity_name` | text | The name of the entity being tested (e.g., registry key, file path, service name). |
| 7 | `operation` | text | The comparison operation used in the test (e.g., 'equals', 'less than', 'pattern match'). |
| 8 | `entity_value` | text | The expected value for the entity in the test. |

---

## dim_protocol

**Description:** Lookup table containing the network protocols used by services and vulnerabilities. This table stores the various communication protocols discovered during scanning, such as TCP, UDP, ICMP, and others.

**Keys & Relationships:**

- **Primary Key:** `protocol_id`
- **Referenced By:** [`dim_asset_service`](#dim_asset_service), [`dim_asset_service_credential`](#dim_asset_service_credential), [`fact_asset_vulnerability_instance`](#fact_asset_vulnerability_instance), [`fact_asset_scan_vulnerability_instance`](#fact_asset_scan_vulnerability_instance)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `protocol_id` | integer | The unique identifier of the protocol. |
| 2 | `name` | text | The name of the protocol (e.g., 'TCP', 'UDP', 'ICMP'). |
| 3 | `description` | text | A description of the protocol. |

---

## dim_scan

**Description:** Dimension for all scans that have been run on any sites within access of the report, not only those within the scope. All scans will be made available, regardless of their scan status, including currently running scans.

**Keys & Relationships:**

- **Primary Key:** `scan_id`
- **Foreign Keys:**
  - `status_id` → [`dim_scan_status`](#dim_scan_status)
  - `type_id` → [`dim_scan_type`](#dim_scan_type)
- **Referenced By:** [`dim_asset_scan`](#dim_asset_scan), [`dim_site_scan`](#dim_site_scan), [`dim_vulnerability_exception`](#dim_vulnerability_exception), [`fact_asset_policy_rule`](#fact_asset_policy_rule), [`fact_asset_scan`](#fact_asset_scan), [`fact_asset_scan_policy`](#fact_asset_scan_policy), [`fact_asset_scan_operating_system`](#fact_asset_scan_operating_system), [`fact_asset_scan_service`](#fact_asset_scan_service), [`fact_asset_scan_software`](#fact_asset_scan_software), [`fact_asset_scan_vulnerability_finding`](#fact_asset_scan_vulnerability_finding), [`fact_asset_scan_vulnerability_instance`](#fact_asset_scan_vulnerability_instance), [`fact_scan`](#fact_scan)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scan_id` | bigint | The unique identifier of the scan. |
| 2 | `started` | timestamp | The time at which the scan started. |
| 3 | `finished` | timestamp | The time at which the scan ended, which may be NULL if a scan is still in progress. |
| 4 | `status_id` | text | The unique identifier of the scan status. |
| 5 | `type_id` | text | The unique identifier of the scan type. |
| 6 | `scan_name` | text | The user-driven scan name for the scan. |

---

## dim_scan_engine

**Description:** Dimensions for the scan engines that may be selected to run scans, including standalone engines or pools. One record is present in this dimension for each scan engine that is defined.

**Keys & Relationships:**

- **Primary Key:** `scan_engine_id`
- **Referenced By:** [`dim_site_scan_config`](#dim_site_scan_config)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scan_engine_id` | integer | The unique identifier of the scan engine. |
| 2 | `name` | text | The name of the scan engine. |
| 3 | `address` | text | The address (either IP or host name) of the scan engine. |
| 4 | `port` | integer | The port the scan engine is running on. |
| 5 | `priority` | integer | The priority of the scan engine. |
| 6 | `last_refreshed` | timestamp | The date and time the scan engine was last refreshed. |

---

## dim_scan_status

**Description:** Lookup table containing the different states of scan execution. This table stores the various statuses that scans can have during their lifecycle, such as Running, Finished, Stopped, Error, Paused, or Aborted.

**Keys & Relationships:**

- **Primary Key:** `status_id`
- **Referenced By:** [`dim_scan`](#dim_scan)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `status_id` | text | The unique identifier of the scan status. |
| 2 | `description` | text | The description of the scan status (e.g., 'Running', 'Finished', 'Stopped', 'Error', 'Paused', 'Aborted', 'Unknown'). |

---

## dim_scan_template

**Description:** Dimension for all scan templates that are defined. A record is present for each scan template in the system.

**Keys & Relationships:**

- **Primary Key:** `scan_template_id`
- **Referenced By:** [`dim_site_scan_config`](#dim_site_scan_config)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scan_template_id` | text | The unique identifier of the scan template. |
| 2 | `name` | text | The short, human-readable name of the scan template. |
| 3 | `description` | text | The verbose description of the scan template. |

---

## dim_scan_type

**Description:** Lookup table containing the different types of scans that can be executed. This table stores the various scan execution methods, such as Manual, Scheduled, or Agent-based scans.

**Keys & Relationships:**

- **Primary Key:** `type_id`
- **Referenced By:** [`dim_scan`](#dim_scan)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `type_id` | text | The unique identifier of the scan type. |
| 2 | `description` | text | The description of the scan type (e.g., 'Manual', 'Scheduled', 'Agent'). |

---

## dim_scope_asset_group

**Description:** Scope table that defines which asset groups are included in the current reporting scope. This table acts as a filter to determine which asset groups should be considered when generating reports and analytics.

**Keys & Relationships:**

- **Primary Key:** None (scope table)
- **Foreign Keys:**
  - `asset_group_id` → [`dim_asset_group`](#dim_asset_group)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_group_id` | integer | The unique identifier of the asset group that is within the report scope. |

---

## dim_scope_site

**Description:** Scope table that defines which sites are included in the current reporting scope. This table acts as a filter to determine which sites should be considered when generating reports and analytics.

**Keys & Relationships:**

- **Primary Key:** None (scope table)
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site that is within the report scope. |

---

## dim_service

**Description:** Lookup table containing the different types of network services that can be discovered during scanning. This table stores the various service types detected on assets, such as HTTP, HTTPS, SSH, FTP, SMTP, and others.

**Keys & Relationships:**

- **Primary Key:** `service_id`
- **Referenced By:** [`dim_asset_service`](#dim_asset_service), [`dim_asset_service_configuration`](#dim_asset_service_configuration), [`dim_asset_service_credential`](#dim_asset_service_credential), [`fact_asset_vulnerability_instance`](#fact_asset_vulnerability_instance), [`fact_asset_scan_service`](#fact_asset_scan_service), [`fact_asset_scan_vulnerability_instance`](#fact_asset_scan_vulnerability_instance)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `service_id` | integer | The unique identifier of the service. |
| 2 | `name` | text | The name of the service (e.g., 'HTTP', 'HTTPS', 'SSH', 'FTP', 'SMTP'). |

---

## dim_service_fingerprint

**Description:** Dimension table containing detailed information about service fingerprints discovered during scanning. This table stores comprehensive service details including vendor, family, name, and version information for all detected services.

**Keys & Relationships:**

- **Primary Key:** `service_fingerprint_id`
- **Referenced By:** [`dim_asset_service`](#dim_asset_service), [`fact_asset_scan_service`](#fact_asset_scan_service)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `service_fingerprint_id` | integer | The unique identifier of the service fingerprint. |
| 2 | `vendor` | text | The vendor of the service (e.g., 'Apache', 'Microsoft', 'Cisco'). |
| 3 | `family` | text | The family of the service (e.g., 'HTTP Server', 'Database'). |
| 4 | `name` | text | The name of the service (e.g., 'Apache HTTP Server', 'IIS'). |
| 5 | `version` | text | The version of the service. |

---

## dim_site

**Description:** Dimension for all sites. Each site has metadata that define it, including organization information.

**Keys & Relationships:**

- **Primary Key:** `site_id`
- **Foreign Keys:**
  - `last_scan_id` → [`dim_scan`](#dim_scan)
  - `previous_scan_id` → [`dim_scan`](#dim_scan)
- **Referenced By:** [`dim_scope_site`](#dim_scope_site), [`dim_site_asset`](#dim_site_asset), [`dim_site_scan`](#dim_site_scan), [`dim_site_scan_config`](#dim_site_scan_config), [`dim_site_target`](#dim_site_target), [`fact_site`](#fact_site)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `name` | text | The name of the site which provides a human-readable identifier of the site. Site names are guaranteed to be unique across multiple sites. |
| 3 | `description` | text | An optional description of the site that indicates the content, purpose, or composition of a site. |
| 4 | `importance` | text | A human-readable description of the importance of site, one of the values: 'Very Low', 'Low', 'Normal', 'High' or 'Very High' |
| 5 | `dynamic_targets` | bool | Indicates whether the targets defined within the site are dynamically configured based on a discovery connection. If true, a discovery connection is the means by which the targets of a site are defined and dynamically updated. If false, the target definition is static and manually configured by a site administrator. |
| 6 | `risk_factor` | real | An adjustment factor for the risk of a site. The weighting factor defaults to 1.0 and can be adjusted up or down as the importance of a site is changed. The higher the importance, the larger the risk factor, and the lower the importance, the lower the risk factor. |
| 7 | `last_scan_id` | bigint | The identifier of the scan that last ran for the site. If the site has not had a scan run, the value will be NULL. |
| 8 | `previous_scan_id` | bigint | The identifier of the scan that ran prior to the last scan for the site. If the site has not had a scan run, the value will be NULL. |
| 9 | `organization_name` | text | The optional name of the organization the site is associated to. |
| 10 | `organization_url` | text | The URL/website of the organization the site is associated to. |
| 11 | `organization_contact` | text | The contact name for the contact of the organization the site is associated to. |
| 12 | `organization_job_title` | text | The job title of the contact of the organization the site isassociated to. |
| 13 | `organization_email` | text | The email address of the contact of the organization the site is associated to. |
| 14 | `organization_phone` | text | The phone number of the organization the site is associated to. |
| 15 | `organization_address` | text | The address of the organization the site is associated to. |
| 16 | `organization_city` | text | The city/region of the organization the site is associated to. |
| 17 | `organization_state` | text | The state/county/province/territory of the organization of the site. |
| 18 | `organization_country` | text | The country of organization the site is associated to. |
| 19 | `organization_zip` | text | The zip-code (if applicable) of the organization the site is associated to. |

---

## dim_site_asset

**Description:** Dimension for the association between an asset and a site. For each asset there will be one record with an association to only one site.

**Keys & Relationships:**

- **Primary Key:** Composite (`site_id`, `asset_id`)
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `asset_id` | bigint | The unique identifier of the asset. |

---

## dim_site_scan

**Description:** Bridge table that tracks the relationship between sites and scans, storing which scans have been executed against which sites. This table captures the many-to-many relationship between sites and their associated scan executions.

**Keys & Relationships:**

- **Primary Key:** Composite (`site_id`, `scan_id`)
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)
  - `scan_id` → [`dim_scan`](#dim_scan)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |

---

## dim_site_scan_config

**Description:** Configuration table that stores the scan settings and parameters for each site. This table contains the scan template and scan engine assignments for each site, defining how scans should be executed against specific sites.

**Keys & Relationships:**

- **Primary Key:** `site_id`
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)
  - `scan_template_id` → [`dim_scan_template`](#dim_scan_template)
  - `scan_engine_id` → [`dim_scan_engine`](#dim_scan_engine)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `scan_template_id` | text | The unique identifier of the scan template configured for the site. |
| 3 | `scan_engine_id` | integer | The unique identifier of the scan engine configured for the site. |

---

## dim_site_target

**Description:** Dimension for all the included and excluded targets of a site. For all assets in the scope of the report, a record will be present for each unique IP range and/or host name defined as an included or excluded address in the site configuration. If any global exclusions are applied, these will also be provided at the site level.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `type` | text | Either 'host' or 'ip' to indicate the type of address. |
| 3 | `included` | bool | True if the target is included in the configuration, or false if it is excluded. |
| 4 | `target` | text | If type is 'host', this is the host name. |
| 5 | `scope` | text | The scope of an exclusion, either 'global' if the exclusion is a global exclusion, 'site' if the exclusion is defined on the site, or NULL if included is true. |

---

## dim_software

**Description:** Dimension table containing detailed information about software discovered during scanning. This table stores comprehensive software details including vendor, family, name, version, class, and CPE identifiers for all detected software applications.

**Keys & Relationships:**

- **Primary Key:** `software_id`
- **Referenced By:** [`dim_asset_software`](#dim_asset_software), [`fact_asset_scan_software`](#fact_asset_scan_software)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `software_id` | integer | The unique identifier of the software. |
| 2 | `vendor` | text | The vendor of the software (e.g., 'Microsoft', 'Oracle', 'Adobe'). |
| 3 | `family` | text | The family of the software (e.g., 'Windows', 'Office', 'Java'). |
| 4 | `name` | text | The name of the software (e.g., 'Microsoft Office', 'Adobe Reader'). |
| 5 | `version` | text | The version of the software. |
| 6 | `software_class` | text | The class or type of software (e.g., 'Application', 'Operating System', 'Driver'). |
| 7 | `cpe` | text | The Common Platform Enumeration (CPE) identifier for the software. |

---

## dim_solution

**Description:** Dimension that provides access to all solutions defined. A solution models the information, steps, and background required to remediate a vulnerability.

**Keys & Relationships:**

- **Primary Key:** `solution_id`
- **Referenced By:** [`dim_asset_vulnerability_best_solution`](#dim_asset_vulnerability_best_solution), [`dim_asset_vulnerability_solution`](#dim_asset_vulnerability_solution), [`dim_solution_highest_supercedence`](#dim_solution_highest_supercedence), [`dim_solution_prerequisite`](#dim_solution_prerequisite), [`dim_solution_supercedence`](#dim_solution_supercedence), [`dim_vulnerability_solution`](#dim_vulnerability_solution), [`fact_remediation`](#fact_remediation)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `solution_id` | integer | The unique identifier of the solution. |
| 2 | `nexpose_id` | text | The key/identifier of the solution that uniquely identifies it within Nexpose. |
| 3 | `estimate` | interval | The amount of required time estimated to implement this solution on a single asset. This is a heuristic and may not represent the actually time required to remediate or apply the solution, depending on the environment and tools available for remediation. |
| 4 | `url` | text | An optional URL link defined for getting more information about the solution. When defined, this may be a web page defined by the vendor that provides more details on the solution, or it may be a download link to a patch. |
| 5 | `solution_type` | text | Type of the solution, one of the values: 'PATCH', 'ROLLUP' or 'WORKAROUND'. |
| 6 | `fix` | text | The steps that are a part of the fix this solution prescribes. The fix will usually contain a list of procedures that must be followed to remediate the vulnerability. The fix is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 7 | `summary` | text | A short summary of solution which describes the purpose of the solution at a high level and is suitable for use as a summarization of the solution. The summary is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 8 | `additional_data` | text | Additional information about the solution. The additional data is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 9 | `applies_to` | text | Textual representation of the types of system, software, and/or services that the solution can be applied to. If the solution is not restricted to a certain type of system, software or service, this field will be NULL. |

---

## dim_solution_highest_supercedence

**Description:** Dimension that provides access to the highest level superceding solution for every solution. If a solution has multiple superceding solutions that themselves are not superceded, all will be returned. Therefore a single solution may have multiple records returned. If a solution is not superceded by any other solution, it will be marked as being superceded by itself.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `solution_id` → [`dim_solution`](#dim_solution)
  - `superceding_solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `solution_id` | integer | The unique identifier of the solution. |
| 2 | `superceding_solution_id` | integer | The identifier of a solution that is known to supercede the solution, and which itself is not superceded (the highest level of supercedence). If the solution is not superceded, this is the same identifier as solution_id. |

---

## dim_solution_prerequisite

**Description:** Dimension that provides an association between a solution and all the prerequisite solutions that must be applied before it. If a solution has no prerequisites, it will have no records in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `solution_id` → [`dim_solution`](#dim_solution)
  - `required_solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `solution_id` | integer | The unique identifier of the solution. |
| 2 | `required_solution_id` | integer | The unique identifier of the prerequisite solution. |

---

## dim_solution_supercedence

**Description:** Dimension that provides all superceding associations between solutions. Unlike dim_solution_highest_supercedence, this dimension provides access to the entire graph of superceding relationships. If a solution does not supercede any other solution, it will not have any records in this dimension.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `solution_id` → [`dim_solution`](#dim_solution)
  - `superceding_solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `solution_id` | integer | The unique identifier of the solution. |
| 2 | `superceding_solution_id` | integer | The unique identifier of the superceding solution. |

---

## dim_tag

**Description:** Dimension for all tags that any assets within the scope of the report belong to. Each tag has either a direct association or indirection association to an asset based off site or asset group association or of dynamic membership criteria.

**Keys & Relationships:**

- **Primary Key:** `tag_id`
- **Referenced By:** [`dim_tag_asset`](#dim_tag_asset), [`fact_tag`](#fact_tag)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `tag_id` | integer | The unique identifier of the tag. |
| 2 | `tag_name` | text | The name of the tag. |
| 3 | `tag_type` | text | The type of tag (e.g., 'CRITICALITY', 'CUSTOM', 'LOCATION', 'OWNER'). |
| 4 | `source` | text | The original application that created the tag. |
| 5 | `creation_date` | timestamp | The date and time the tag was created. |
| 6 | `risk_modifier` | float8 | The risk modifier for a CRITICALITY typed tag. |
| 7 | `color` | text | The optional color of the tag, in hexadecimal notation. |

---

## dim_tag_asset

**Description:** Bridge table that stores the many-to-many relationship between tags and assets. This table captures how tags are associated with assets, including the association type (direct, site-based, or group-based) and the source of the association.

**Keys & Relationships:**

- **Primary Key:** Composite (`tag_id`, `asset_id`)
- **Foreign Keys:**
  - `tag_id` → [`dim_tag`](#dim_tag)
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `tag_id` | integer | The unique identifier of the tag. |
| 2 | `asset_id` | bigint | The unique identifier of the asset. |
| 3 | `association` | text | The type of association between the tag and asset (e.g., 'Direct', 'Site', 'Group'). |
| 4 | `site_id` | integer | The identifier of the site through which the tag is associated with the asset, if applicable. |
| 5 | `group_id` | integer | The identifier of the asset group through which the tag is associated with the asset, if applicable. |

---

## dim_vulnerability

**Description:** Dimension for a vulnerability and its associated metadata, including risk scores, CVSS vector, and title. One record is present for each vulnerability that is defined.

**Keys & Relationships:**

- **Primary Key:** `vulnerability_id`
- **Referenced By:** [`dim_asset_vulnerability_best_solution`](#dim_asset_vulnerability_best_solution), [`dim_asset_vulnerability_solution`](#dim_asset_vulnerability_solution), [`dim_vulnerability_category`](#dim_vulnerability_category), [`dim_vulnerability_exception`](#dim_vulnerability_exception), [`dim_vulnerability_exploit`](#dim_vulnerability_exploit), [`dim_vulnerability_malware_kit`](#dim_vulnerability_malware_kit), [`dim_vulnerability_reference`](#dim_vulnerability_reference), [`dim_vulnerability_solution`](#dim_vulnerability_solution), [`fact_asset_vulnerability_finding`](#fact_asset_vulnerability_finding), [`fact_asset_vulnerability_instance`](#fact_asset_vulnerability_instance), [`fact_asset_scan_vulnerability_finding`](#fact_asset_scan_vulnerability_finding), [`fact_asset_scan_vulnerability_instance`](#fact_asset_scan_vulnerability_instance), [`fact_vulnerability`](#fact_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 2 | `nexpose_id` | text | The Nexpose identifier (natural key) of the vulnerability. |
| 3 | `title` | text | A short, human-readable description of the vulnerability. The title is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 4 | `description` | text | A verbose description for the vulnerability. The description is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 5 | `date_published` | date | The date that the vulnerability was publicized by the third-party, vendor, or another authoring source. The granularity of the date is a day. |
| 6 | `date_added` | date | The date that the vulnerability was first checked by Nexpose. The granularity of the date is a day. |
| 7 | `date_modified` | date | The date that the vulnerability was last modified. The granularity of the date is a day. |
| 8 | `severity_score` | smallint | The numerical severity of the vulnerability, measured on a scale of 0 to 10 using whole numbers. |
| 9 | `severity` | text | The textual representation of the severity of the vulnerability, which is based on the severity score. The severity can be any of the following values: 'Critical', 'Severe', or 'Moderate' |
| 10 | `pci_severity_score` | smallint | The numerical PCI severity score of the vulnerability, measured on a scale of 1 to 5 using whole numbers. |
| 11 | `pci_status` | text | The compliance level of the vulnerability according to PCI standards. 'Pass' indicates the vulnerability may be present on an asset but still pass PCI compliance. 'Fail' indicates the vulnerability must not be present in order to pass PCI compliance. |
| 12 | `riskscore` | float8 | The aggregate risk score. |
| 13 | `cvss_vector` | text | The full CVSS vector in CVSS Version 2.0 notation. |
| 14 | `cvss_access_vector_id` | text | The identifier for the CVSS access vector (e.g., 'L' for Local, 'A' for Adjacent Network, 'N' for Network). |
| 15 | `cvss_access_complexity_id` | text | The identifier for the CVSS access complexity (e.g., 'H' for High, 'M' for Medium, 'L' for Low). |
| 16 | `cvss_authentication_id` | text | The identifier for the CVSS authentication requirement (e.g., 'M' for Multiple, 'S' for Single, 'N' for None). |
| 17 | `cvss_confidentiality_impact_id` | text | The identifier for the CVSS confidentiality impact (e.g., 'N' for None, 'P' for Partial, 'C' for Complete). |
| 18 | `cvss_integrity_impact_id` | text | The identifier for the CVSS integrity impact (e.g., 'N' for None, 'P' for Partial, 'C' for Complete). |
| 19 | `cvss_availability_impact_id` | text | The identifier for the CVSS availability impact (e.g., 'N' for None, 'P' for Partial, 'C' for Complete). |
| 20 | `pci_adjusted_cvss_score` | real | Value between 0 and 10 representing the CVSS score of the vulnerability, adjusted if necessary to follow PCI rules. |
| 21 | `cvss_score` | real | Value between 0 and 10 representing the CVSS score of the vulnerability. |
| 22 | `cvss_exploit_score` | real | Base score for the exploitability of a vulnerability that is used to compute the overall CVSS score. |
| 23 | `cvss_impact_score` | real | Base score for the impact of a vulnerability that is used to compute the overall CVSS score. |
| 24 | `cvss_v2_score` | real | The overall CVSS v2.0 score of the vulnerability, ranging from 0 to 10. |
| 25 | `cvss_v2_exploit_score` | real | The CVSS v2.0 exploitability score of the vulnerability. |
| 26 | `cvss_v2_impact_score` | real | The CVSS v2.0 impact score of the vulnerability. |
| 27 | `cvss_v3_vector` | text | The full CVSS vector in CVSS Version 3.0 notation. |
| 28 | `cvss_v3_attack_vector` | varchar( 1 ) | Attack Vector (AV) code that represents the CVSS attack vector value of the vulnerability. |
| 29 | `cvss_v3_attack_complexity` | varchar( 1 ) | Attack Complexity (AC) code that represents the CVSS attack complexity value of the vulnerability. |
| 30 | `cvss_v3_privileges_required` | varchar( 1 ) | Privileges Required (PR) code that represents the CVSS privilege required value of the vulnerability. |
| 31 | `cvss_v3_user_interaction` | varchar( 1 ) | User Interaction (UI) code that represents the CVSS user interaction value of the vulnerability. |
| 32 | `cvss_v3_scope` | varchar( 1 ) | Scope (S) code that represents the CVSS scope value of the vulnerability. |
| 33 | `cvss_v3_confidentiality_impact` | varchar( 1 ) | Confidentiality Impact (C) code that represents the CVSS confidentiality impact value of the vulnerability. |
| 34 | `cvss_v3_integrity_impact` | varchar( 1 ) | Integrity Impact (I) code that represents the CVSS integrity impact value of the vulnerability. |
| 35 | `cvss_v3_availability_impact` | varchar( 1 ) | Availability Impact (A) code that represents the CVSS availability impact value of the vulnerability. |
| 36 | `cvss_v3_score` | real | Value between 0 and 10 representing the CVSS Version 3.0 score of the Vulnerability. |
| 37 | `cvss_v3_impact_score` | real | Base score for the impact of a vulnerability that is used to compute the overall CVSS Version 3.0 score. |
| 38 | `cvss_v3_exploit_score` | real | Base score for the exploitability of a vulnerability that is used to compute the overall CVSS Version 3.0 score. |
| 39 | `pci_special_notes` | text | Notes attached to the vulnerability following PCI rules. |
| 40 | `denial_of_service` | bool | Signifies whether the vulnerability is classified as a denial-of-service vulnerability. |
| 41 | `exploits` | bigint | The total number of distinct exploits/modules that are known to exploit the vulnerability. |
| 42 | `malware_kits` | bigint | The total number of distinct malware kits that are known to exploit the vulnerability. |

---

## dim_vulnerability_category

**Description:** Dimension for categories that defines groups of related vulnerabilities by a common name. Each record represents a vulnerability and the associated category it belongs to. Each vulnerability can belong to multiple categories, in which case multiple records will be present, one for each category the vulnerability belongs to.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `category_id` | integer | The unique identifier of the vulnerability category. |
| 2 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 3 | `category_name` | text | The human-readable name of the vulnerability category. |

---

## dim_vulnerability_exception

**Description:** Dimension for all vulnerability exceptions that are currently applied to or are pending approval to apply to any assets. This fact includes exceptions that are pending approval, those that are actively applying, and even expired exceptions.

**Keys & Relationships:**

- **Primary Key:** `vulnerability_exception_id`
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `scope_id` → [`dim_exception_scope`](#dim_exception_scope)
  - `reason_id` → [`dim_exception_reason`](#dim_exception_reason)
  - `status_id` → [`dim_exception_status`](#dim_exception_status)
  - `site_id` → [`dim_site`](#dim_site)
  - `asset_id` → [`dim_asset`](#dim_asset)
- **Referenced By:** [`fact_asset_vulnerability_instance_excluded`](#fact_asset_vulnerability_instance_excluded)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_exception_id` | integer | The unique identifier of the vulnerability exception. |
| 2 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 3 | `scope_id` | text | The unique identifier of the exception scope. |
| 4 | `reason_id` | integer | The unique identifier of the exception reason. |
| 5 | `additional_comments` | text | Comments field populated when a state transition, such as rejection or submission, occurs. This is a user-populated field that is optional. |
| 6 | `submitted_date` | timestamp | The date that the exception was last submitted, or resubmitted for approval. If the exception has been rejected or recalled and is resubmitted, only the date of the last state transition is used. |
| 7 | `submitted_by` | text | The login name of the user that submitted the vulnerability exception for approval. |
| 8 | `review_date` | timestamp | The date when the last review of the exception request was performed. This can either be the date when the exception was last approved, or last rejected. If the exception is approved, rejected, or recalled multiple times, this is the date of the last state transition. If a review is pending, this value may be NULL. |
| 9 | `reviewed_by` | text | The login name of the user that reviewed the vulnerability exception for approval and either approved or rejected it. If the exception is still waiting for approval, this value is NULL. |
| 10 | `review_comment` | text | The last comment when the exception was reviewed, and either approved or rejected. If a review has yet to occur, this can be null. |
| 11 | `expiration_date` | date | The date at which the expiration of the exception occurs. The expiration date is interpreted as midnight on the date specified. The timestamp is converted into the timezone specified within the report configuration. |
| 12 | `status_id` | text | The unique identifier of the exception status. |
| 13 | `site_id` | integer | If the scope is 'Site', the id of the site the exception applies to. For all other scopes, the value is NULL. |
| 14 | `asset_id` | bigint | If the scope is 'Asset' or 'Instance' the id of the asset the exception applies to. For all other scopes, the value is NULL. |
| 15 | `group_id` | integer | If the scope is 'Asset Group', the id of the group the exception applies to. For all other scopes, the value is NULL. |
| 16 | `port` | integer | If the scope is 'Instance' and the exception is applying to a service, the port of the service that exception is applied to. For all other scopes, the value is NULL. |
| 17 | `key` | text | If the scope is 'Instance' and the exception is applied to a vulnerability with a secondary key, the key of the vulnerability the exception applies to. For all other scopes, the value is NULL. |

---

## dim_vulnerability_exploit

**Description:** Exploits that exploit a particular vulnerability that have been defined by external exploit data sources. Each record represents the relationship between a vulnerability and one exploit module/kit/package known to exploit that vulnerability. Each vulnerability can be associated to multiple exploits.

**Keys & Relationships:**

- **Primary Key:** `exploit_id`
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability the exploit relates to. |
| 2 | `exploit_id` | integer | The unique identifier of the exploit module. |
| 3 | `title` | text | The short name or title of the exploit which describes the name, purpose, or target of the exploit. |
| 4 | `description` | text | The description of the exploit that provides more detailed information on the purpose or target of the exploit. |
| 5 | `skill_level` | text | The skill level required to perform the exploit, one of the values: 'Expert', 'Novice', or 'Intermediate'. |
| 6 | `source` | text | The source which defined and published the exploit, one of the values: 'Exploit Database' or 'Metasploit Module'. |
| 7 | `source_key` | text | The identifier of the exploit within the source that published the exploit. This can be an internal identifier key for the exploit within the source. |

---

## dim_vulnerability_malware_kit

**Description:** Dimension for malware kits that are known to exploit a vulnerability. Each record represents the relationship between a vulnerability and an associated malware kit known to exploit that vulnerability. Each vulnerability can be associated to multiple malware kits.

**Keys & Relationships:**

- **Primary Key:** `malware_kit_id`
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability with a malware kit |
| 2 | `malware_kit_id` | integer | The unique identifier of the malware kit. |
| 3 | `name` | text | The name of the malware kit. |
| 4 | `popularity` | text | The popularity of the malware kit, which identifies how common or accessible it is. Popularity can have the following values: 'Uncommon', 'Occasional', 'Rare', 'Common', 'Favored', 'Popular', or 'Unknown'. |

---

## dim_vulnerability_reference

**Description:** Dimension for references to external data source(s) that relate to, define, or that the publishing source of a vulnerability. Each record represents the relationship between a vulnerability and an external reference or link to a defining source. Each vulnerability may be associated to multiple references.

**Keys & Relationships:**

- **Primary Key:** None (bridge/detail table)
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 2 | `source` | text | The name of a source of vulnerability information or metadata. The source is provided in all upper-case characters (for consistency with the user interface). |
| 3 | `reference` | text | The reference that keys or links into the source repository. If the source is 'URL', the reference is a URL. For other data sources such as CVE, BID, or SECUNIA, the reference is typically a key that indexes into those repositories. |

---

## dim_vulnerability_solution

**Description:** Dimension that provides access to the relationship between a vulnerability and its (direct) solutions. These solutions are only those which are directly known to remediate the vulnerability, and do not include rollups or superceding solutions. If a vulnerability has more than one solution (e.g. for multiple platforms), multiple association records will be present. If a vulnerability has no known solutions, it will have no records in this dimension.

**Keys & Relationships:**

- **Primary Key:** Composite (`vulnerability_id`, `solution_id`)
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 2 | `solution_id` | integer | The unique identifier of the solution. |

---

## dim_vulnerability_status

**Description:** Lookup table containing the different states of vulnerability findings. This table stores the various statuses that vulnerabilities can have, such as Vulnerable, Vulnerable Exploited, Vulnerable Version, or Potential.

**Keys & Relationships:**

- **Primary Key:** `status_id`
- **Referenced By:** [`fact_asset_vulnerability_finding`](#fact_asset_vulnerability_finding), [`fact_asset_vulnerability_instance`](#fact_asset_vulnerability_instance), [`fact_asset_vulnerability_instance_excluded`](#fact_asset_vulnerability_instance_excluded), [`fact_asset_scan_vulnerability_finding`](#fact_asset_scan_vulnerability_finding), [`fact_asset_scan_vulnerability_instance`](#fact_asset_scan_vulnerability_instance), [`fact_vulnerability`](#fact_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `status_id` | text | The unique identifier of the vulnerability status. |
| 2 | `description` | text | The description of the vulnerability status (e.g., 'Vulnerable', 'Vulnerable Exploited', 'Vulnerable Version', 'Potential'). |

---

## fact_all

**Description:** Accumulating snapsht fact for all assets. This convenience rollup fact aggregates across all defined assets. This fact table is guaranteed to have one and only one record at all times, even if no assets are defined.

**Keys & Relationships:**

- **Primary Key:** None (single-row aggregate table)
- **Foreign Keys:** None (aggregate of all assets)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `assets` | bigint | The total number of assets. |
| 2 | `vulnerabilities` | bigint | The sum of the count of vulnerabilities on each asset. This value is equal to the sum of the critical_vulnerabilities, severe_vulnerabilities, and moderate_vulnerabilities columns. |
| 3 | `critical_vulnerabilities` | bigint | The sum of the count of critical vulnerabilities on each asset. |
| 4 | `severe_vulnerabilities` | bigint | The sum of the count of severe vulnerabilities on each asset. |
| 5 | `moderate_vulnerabilities` | bigint | The sum of the count of moderate vulnerabilities on each asset. |
| 6 | `malware_kits` | integer | The sum of the count of malware kits on each asset. |
| 7 | `exploits` | integer | The sum of the count of exploits on each asset. |
| 8 | `vulnerabilities_with_malware_kit` | integer | The sum of the count of vulnerabilities with malware on each asset. |
| 9 | `vulnerabilities_with_exploit` | integer | The sum of the count of vulnerabilities with exploits on each asset. |
| 10 | `vulnerability_instances` | bigint | The sum of the vulnerabilities instances on each asset. |
| 11 | `riskscore` | float8 | The aggregate risk score. |
| 12 | `pci_status` | text | The overall compliance level ('Pass' or 'Fail') according to PCI standards. The status is only 'Pass' if all assets individually have a status of 'Pass' (e.g. in fact_asset) |

---

## fact_asset

**Description:** Accumulating snapshot fact table for the latest state of an asset. Each fact record represents the current summary information for an asset, from all data source across all sites the asset belongs to.

**Keys & Relationships:**

- **Primary Key:** `asset_id`
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `last_scan_id` → [`dim_scan`](#dim_scan)
  - `aggregated_credential_status_id` → [`dim_aggregated_credential_status`](#dim_aggregated_credential_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `last_scan_id` | bigint | The unique identifier of the most recent scan performed on the asset. |
| 3 | `scan_started` | timestamp | The time at which the most recent scan started for this asset. |
| 4 | `scan_finished` | timestamp | The time at which the most recent scan completed for this asset. |
| 5 | `vulnerabilities` | bigint | The number of vulnerability findings on the asset. This value is equal to the sum of critical_vulnerabilities, severe_vulnerabilities, and moderate_vulnerabilities columns. |
| 6 | `critical_vulnerabilities` | bigint | The number of vulnerability findings for vulnerabilities with a critical severity. |
| 7 | `severe_vulnerabilities` | bigint | The number of vulnerability findings for vulnerabilities with a severe severity. |
| 8 | `moderate_vulnerabilities` | bigint | The number of vulnerability findings for vulnerabilities with a moderate severity. |
| 9 | `malware_kits` | integer | The number of distinct malware kits that can exploit any vulnerabilities on the asset. |
| 10 | `exploits` | integer | The number of distinct exploit modules that can exploit any vulnerabilities on the asset. |
| 11 | `vulnerabilities_with_malware_kit` | integer | The number of vulnerabilities on the asset that have at least one malware kit. |
| 12 | `vulnerabilities_with_exploit` | integer | The number of vulnerabilities on the asset that have at least one exploit module. |
| 13 | `vulnerability_instances` | bigint | The total number of instances of all vulnerabilities. |
| 14 | `riskscore` | float8 | The computed risk score for the asset. |
| 15 | `pci_status` | text | The compliance level, either 'Pass' or 'Fail', of the asset according to PCI standards. |
| 16 | `aggregated_credential_status_id` | integer | The identifier of the aggregated credential status for the asset. |

---

## fact_asset_discovery

**Description:** Accumulating snapshot fact table that tracks the discovery timeline for assets. This table stores when assets were first discovered and when they were most recently discovered, providing historical tracking of asset presence in the environment.

**Keys & Relationships:**

- **Primary Key:** `asset_id`
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `first_discovered` | timestamp | The date and time the asset was first discovered. |
| 3 | `last_discovered` | timestamp | The date and time the asset was last discovered. |

---

## fact_asset_group

**Description:** Accumulating snapshot fact for the summary information of an asset group. This is a convenience fact for rolling up the information for assets within the membership of one or more asset groups. The summary information provided is based on the most recent data for each asset in the membership of the group. If an asset group has no assets, there will be a fact record with zero counts.

**Keys & Relationships:**

- **Primary Key:** `asset_group_id`
- **Foreign Keys:**
  - `asset_group_id` → [`dim_asset_group`](#dim_asset_group)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_group_id` | integer | The unique identifier of the asset group. |
| 2 | `assets` | bigint | The total number of assets that are in the scope of associated to the group. If the group has no assets in the current scope or membership, this value can be zero. |
| 3 | `vulnerabilities` | bigint | The sum of the count of vulnerabilities on each asset. This value is equal to the sum of the critical_vulnerabilities, severe_vulnerabilities, and moderate_vulnerabilities columns. |
| 4 | `critical_vulnerabilities` | bigint | The sum of the count of critical vulnerabilities on each asset. |
| 5 | `severe_vulnerabilities` | bigint | The sum of the count of severe vulnerabilities on each asset. |
| 6 | `moderate_vulnerabilities` | bigint | The sum of the count of moderate vulnerabilities on each asset. |
| 7 | `malware_kits` | integer | The sum of the count of malware kits on each asset. |
| 8 | `exploits` | integer | The sum of the count of exploits on each asset. |
| 9 | `vulnerabilities_with_malware_kit` | integer | The sum of the count of vulnerabilities with malware on each asset. |
| 10 | `vulnerabilities_with_exploit` | integer | The sum of the count of vulnerabilities with exploits on each asset. |
| 11 | `vulnerability_instances` | bigint | The sum of the vulnerabilities instances on each asset. |
| 12 | `riskscore` | float8 | The aggregate risk score. |
| 13 | `pci_status` | text | The overall compliance level ('Pass' or 'Fail') of the asset group according to PCI standards. The status is only 'Pass' if all assets in the group individually have a status of 'Pass' (e.g. in fact_asset) |

---

## fact_asset_policy

**Description:** Accumulating snapshot fact for all current tested policies on an asset. This fact is a convenience rollup for the fact_asset_policy_rule fact and provides a record for each tested policy on every asset. If an asset was not applicable to any rules in the policy, it will have no records in this fact table.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `policy_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `last_scan_id` → [`dim_scan`](#dim_scan)
  - `policy_id` → [`dim_policy`](#dim_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `last_scan_id` | bigint | The unique identifier of the most recent scan performed on the asset. |
| 3 | `policy_id` | bigint | The unique identifier of the policy. |
| 4 | `scope` | text | The scope of the policy (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 5 | `date_tested` | timestamp | The time at which the policy was tested against the asset. |
| 6 | `compliant_rules` | integer | The total number of rules for which the asset passed in the most recent scan for this policy. |
| 7 | `noncompliant_rules` | integer | The total number of rules for which the asset failed in the most recent scan for this policy |
| 8 | `not_applicable_rules` | integer | The total number of rules that were not applicable to the asset in the most recent scan for this policy. |
| 9 | `rule_compliance` | float8 | The ratio of passing results for the rules to the total number of scorable rules for this policy. |

---

## fact_asset_policy_rule

**Description:** Accumulating snapshot of policy rules results on an asset. This fact provides a record for each policy rule that was tested on an asset in its most recent scan.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `policy_id`, `rule_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `policy_id` → [`dim_policy`](#dim_policy)
  - `rule_id` → [`dim_policy_rule`](#dim_policy_rule)
  - `override_id` → [`dim_policy_override`](#dim_policy_override)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `policy_id` | bigint | The unique identifier of the policy. |
| 3 | `rule_id` | bigint | The unique identifier of the policy rule. |
| 4 | `scope` | text | The scope of the policy rule (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 5 | `date_tested` | timestamp | The time at which the policy rule was tested against the asset. |
| 6 | `status_id` | text | The unique identifier of the policy result status. |
| 7 | `compliance` | boolean | Whether the asset is compliant with the policy rule (true for pass, false for fail). |
| 8 | `proof` | text | The proof output from the policy rule test, demonstrating the result. |
| 9 | `override_ids` | _int8 | The array identifiers of policy overrides potentially overriding a rule test result on an asset. |
| 10 | `override_id` | bigint | The identifier of a policy override effectively overriding a rule test result on the asset. If there are more than one such overrides, the last submitted one will take precedent over the rest. |

---

## fact_asset_policy_rule_check

**Description:** Accumulating snapshot of policy rule check results on an asset. This fact provides a record for each policy rule check that was tested on an asset in its most recent scan.

**Keys & Relationships:**

- **Primary Key:** `result_id`
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `policy_id` → [`dim_policy`](#dim_policy)
  - `rule_id` → [`dim_policy_rule`](#dim_policy_rule)
  - `override_id` → [`dim_policy_override`](#dim_policy_override)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `policy_id` | bigint | The unique identifier of the policy. |
| 3 | `rule_id` | bigint | The unique identifier of the policy rule. |
| 4 | `scope` | text | The scope of the policy rule check (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 5 | `date_tested` | timestamp | The time at which the policy rule check was tested against the asset. |
| 6 | `status_id` | text | The unique identifier of the policy result status for the check. |
| 7 | `compliance` | boolean | Whether the asset is compliant with the policy rule check (true for pass, false for fail). |
| 8 | `proof` | text | The proof gathered during the evaluation of the rule check on the asset. |
| 9 | `override_ids` | _int8 | The array identifiers of policy overrides potentially overriding a rule test result on an asset. |
| 10 | `override_id` | bigint | The identifier of a policy override effectively overriding a rule test result on the asset. If there are more than one such overrides, the last submitted one will take precedent over the rest. |
| 11 | `result_id` | bigint | The unique identifier of the rule check result. |

---

## fact_asset_scan

**Description:** Transaction fact table that stores scan-specific results for each asset during individual scan executions. This table captures vulnerability counts, risk scores, PCI status, and other metrics for each asset as discovered during specific scans.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `aggregated_credential_status_id` → [`dim_aggregated_credential_status`](#dim_aggregated_credential_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `scan_started` | timestamp | The time at which the scan started for this asset. |
| 4 | `scan_finished` | timestamp | The time at which the scan completed for this asset. |
| 5 | `vulnerabilities` | bigint | The total number of vulnerabilities discovered on the asset during the scan. |
| 6 | `critical_vulnerabilities` | bigint | The number of critical vulnerabilities found on the asset during the scan. |
| 7 | `severe_vulnerabilities` | bigint | The number of severe vulnerabilities found on the asset during the scan. |
| 8 | `moderate_vulnerabilities` | bigint | The number of moderate vulnerabilities found on the asset during the scan. |
| 9 | `malware_kits` | integer | The number of malware kits associated with vulnerabilities on the asset. |
| 10 | `exploits` | integer | The number of exploits associated with vulnerabilities on the asset. |
| 11 | `vulnerabilities_with_malware_kit` | integer | The number of vulnerabilities on the asset that have associated malware kits. |
| 12 | `vulnerabilities_with_exploit` | integer | The number of vulnerabilities on the asset that have known exploits. |
| 13 | `vulnerability_instances` | bigint | The total number of vulnerability instances found on the asset during the scan. |
| 14 | `riskscore` | float8 | The computed risk score for the asset based on this scan. |
| 15 | `pci_status` | text | The overall PCI compliance status of the asset for this scan. |
| 16 | `aggregated_credential_status_id` | integer | The identifier of the aggregated credential status for the asset during this scan. |

---

## fact_asset_scan_operating_system

**Description:** Transaction fact table that stores operating system detection results for each asset during individual scan executions. This table captures OS fingerprinting information, certainty levels, and detection timestamps for each scan.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `operating_system_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `operating_system_id` → [`dim_operating_system`](#dim_operating_system)
  - `fingerprint_source_id` → [`dim_fingerprint_source`](#dim_fingerprint_source)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `date` | timestamp | The date and time the operating system was detected during the scan. |
| 4 | `operating_system_id` | integer | The unique identifier of the operating system detected. |
| 5 | `fingerprint_source_id` | integer | The unique identifier of the fingerprint source used to detect the operating system. |
| 6 | `certainty` | real | The certainty of the OS fingerprint, expressed as a decimal confidence between 0 (low) and 1.0 (high). |

---

## fact_asset_scan_policy

**Description:** Transaction fact table that stores policy compliance results for each asset during individual scan executions. This table captures policy testing outcomes, compliance ratios, and rule pass/fail counts for each asset during specific scans.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `policy_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `policy_id` → [`dim_policy`](#dim_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `policy_id` | bigint | The unique identifier of the policy tested. |
| 4 | `scope` | text | The scope of the policy evaluation (e.g., 'Asset', 'Site'). |
| 5 | `date_tested` | timestamp | The date and time the policy was tested on the asset during this scan. |
| 6 | `compliant_rules` | integer | The number of policy rules that passed (were compliant) on the asset. |
| 7 | `noncompliant_rules` | integer | The number of policy rules that failed (were non-compliant) on the asset. |
| 8 | `not_applicable_rules` | integer | The number of policy rules that were not applicable to the asset. |
| 9 | `rule_compliance` | real | The overall compliance ratio for the policy on this asset, expressed as a decimal between 0 (non-compliant) and 1.0 (fully compliant). |

---

## fact_asset_scan_service

**Description:** Transaction fact table that stores service detection results for each asset during individual scan executions. This table captures discovered services, their fingerprints, credential testing results, and associated protocol/port information for each scan.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `service_id`, `protocol_id`, `port`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)
  - `service_fingerprint_id` → [`dim_service_fingerprint`](#dim_service_fingerprint)
  - `credential_status_id` → [`dim_credential_status`](#dim_credential_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `date` | timestamp | The date and time the service was detected during the scan. |
| 4 | `service_id` | integer | The unique identifier of the service detected. |
| 5 | `protocol_id` | integer | The unique identifier of the protocol used by the service. |
| 6 | `port` | integer | The port on which the service was detected. |
| 7 | `service_fingerprint_id` | integer | The unique identifier of the service fingerprint detected. |
| 8 | `credential_status_id` | integer | The unique identifier of the credential status for this service. |

---

## fact_asset_scan_software

**Description:** Transaction fact table that stores software detection results for each asset during individual scan executions. This table captures discovered software applications, their fingerprints, certainty levels, and detection timestamps for each scan.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `software_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `software_id` → [`dim_software`](#dim_software)
  - `fingerprint_source_id` → [`dim_fingerprint_source`](#dim_fingerprint_source)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `date` | timestamp | The date and time the software was detected during the scan. |
| 4 | `software_id` | integer | The unique identifier of the software detected. |
| 5 | `fingerprint_source_id` | integer | The unique identifier of the fingerprint source used to detect the software. |

---

## fact_asset_scan_vulnerability_finding

**Description:** Transaction fact table that stores vulnerability finding summaries for each asset during individual scan executions. This table captures vulnerability discovery information, instance counts, and detection timestamps for each vulnerability found during specific scans.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `vulnerability_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `vulnerability_id` | integer | The unique identifier of the vulnerability found. |
| 4 | `date` | timestamp | The date and time the vulnerability was tested during this scan. |
| 5 | `vulnerability_instances` | integer | The number of instances of this vulnerability found on the asset during the scan. |

---

## fact_asset_scan_vulnerability_instance

**Description:** Transaction fact table that stores detailed vulnerability instance information for each asset during individual scan executions. This table captures specific vulnerability instances with their proof, status, service/port details, and detection timestamps for each scan.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `scan_id`, `vulnerability_id`, `port`, `key`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)
  - `status_id` → [`dim_vulnerability_status`](#dim_vulnerability_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 4 | `date` | timestamp | The date and time the vulnerability instance was tested during this scan. |
| 5 | `status_id` | text | The unique identifier of the vulnerability status. |
| 6 | `proof` | text | The proof output from the vulnerability check, demonstrating the vulnerability exists. |
| 7 | `key` | text | An optional key providing additional context for the vulnerability instance (e.g., registry key, file path, URL). |
| 8 | `service_id` | integer | The unique identifier of the service associated with the vulnerability instance. |
| 9 | `port` | integer | The port on which the vulnerability instance was found. |
| 10 | `protocol_id` | integer | The unique identifier of the protocol associated with the instance. |

---

## fact_asset_vulnerability_age

**Description:** Accumulating snapshot fact table that tracks the age and lifecycle of vulnerabilities on assets. This table stores vulnerability age calculations, discovery dates, reintroduction tracking, and time-based metrics for vulnerability management.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 3 | `age` | interval | The age of the vulnerability on the asset as a time interval. |
| 4 | `age_in_days` | integer | The number of days the vulnerability has been present on the asset. |
| 5 | `first_discovered` | timestamp | The date and time the vulnerability was first discovered on the asset. |
| 6 | `most_recently_discovered` | timestamp | The date and time the vulnerability was most recently discovered on the asset. |
| 7 | `reintroduced_date` | timestamp | The date and time the vulnerability was reintroduced on the asset after previously being remediated. |

---

## fact_asset_vulnerability_finding

**Description:** Accumulating snapshot fact for all current vulnerability findings on an asset. This fact is a convenience rollup for the fact_asset_vulnerability_instance fact and provides a record for each vulnerability finding on every asset. If an asset was not vulnerable to any vulnerabilities (or all instances are excluded), it will have no records in this fact table. If multiple instances of a vulnerability are found on the same asset they will be aggregated together in the instances count. This fact table should be the preferred level of grain when instance-level details (such as the port and proof) are not required. To access exploitability information for the finding refer to fact_asset_vulnerability_finding_exploit.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the most recent scan in which the vulnerability was found. |
| 3 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 4 | `date` | timestamp | The time at which the vulnerability was first found on the asset. This is the earliest date any instance on the asset was found. |
| 5 | `vulnerability_instances` | bigint | The number of instances of this finding on the asset. |

---

## fact_asset_vulnerability_instance

**Description:** Accumulating snapshot fact for all current vulnerability instances on an asset. This fact provides a record for each vulnerability instance on every asset. If an asset is not vulnerable to any vulnerabilities (or all vulnerabilities have been excluded) it will have no records in this fact table.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`, `port`, `key`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)
  - `status_id` → [`dim_vulnerability_status`](#dim_vulnerability_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the most recent scan in which the vulnerability was found. |
| 3 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 4 | `vulnerability_exception_id` | bigint | The unique identifier of the primary vulnerability exception that applies to this instance, if any. |
| 5 | `vulnerability_exception_ids` | _int8 | An array of all vulnerability exception identifiers that apply to this instance. |
| 6 | `date` | timestamp | The time at which the vulnerability was first found on the asset. This is the earliest date any instance on the asset was found. |
| 7 | `status_id` | text | The unique identifier of the vulnerability status. |
| 8 | `proof` | text | Free-form text that describes the proof which explains why the vulnerability is present on the asset. The proof is represented using HTML markup that can be "flattened" using the htmlToText() function. |
| 9 | `key` | text | Optional secondary identifier for a vulnerability result that can distinguish the result from other vulnerability instances of the same type on the system, but found in different locations (e.g. URLs). |
| 10 | `service_id` | integer | The unique identifier of the service associated with the vulnerability instance, if applicable. |
| 11 | `port` | integer | The port on which the service was running if the vulnerability was found through a network service. If the vulnerability was not found in the network service, the value is NULL. The data within this column will only contain valid port numbers (0 - 65535). |
| 12 | `protocol_id` | integer | The unique identifier of the protocol. |

---

## fact_asset_vulnerability_instance_excluded

**Description:** Accumulating snapshot fact table that stores vulnerability instances that have been excluded from compliance reporting through vulnerability exceptions. This table captures excluded instances with their associated exception information and status details.

**Keys & Relationships:**

- **Primary Key:** Composite (`asset_id`, `vulnerability_id`, `vulnerability_exception_id`, `port`, `key`)
- **Foreign Keys:**
  - `asset_id` → [`dim_asset`](#dim_asset)
  - `scan_id` → [`dim_scan`](#dim_scan)
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)
  - `vulnerability_exception_id` → [`dim_vulnerability_exception`](#dim_vulnerability_exception)
  - `service_id` → [`dim_service`](#dim_service)
  - `protocol_id` → [`dim_protocol`](#dim_protocol)
  - `status_id` → [`dim_vulnerability_status`](#dim_vulnerability_status)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `asset_id` | bigint | The unique identifier of the asset. |
| 2 | `scan_id` | bigint | The unique identifier of the scan. |
| 3 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 4 | `vulnerability_exception_id` | bigint | The unique identifier of the primary vulnerability exception that excludes this instance. |
| 5 | `vulnerability_exception_ids` | text | A comma-delimited list of all vulnerability exception identifiers that apply to this instance. |
| 6 | `date` | timestamp | The date and time the vulnerability instance was tested during this scan. |
| 7 | `status_id` | text | The unique identifier of the vulnerability status. |
| 8 | `proof` | text | The proof output from the vulnerability check, demonstrating the vulnerability exists. |
| 9 | `key` | text | An optional key providing additional context for the vulnerability instance (e.g., registry key, file path, URL). |
| 10 | `service_id` | integer | The unique identifier of the service associated with the vulnerability instance. |
| 11 | `port` | integer | The port on which the vulnerability instance was found. |
| 12 | `protocol_id` | integer | The unique identifier of the protocol associated with the instance. |

---

## fact_policy

**Description:** Accumulating snapshot fact table for a policy. This is a convenience fact to rollup assets by the policy to measure the policy's overall compliance.

**Keys & Relationships:**

- **Primary Key:** `policy_id`
- **Foreign Keys:**
  - `policy_id` → [`dim_policy`](#dim_policy)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `policy_id` | bigint | The unique identifier of the policy. |
| 2 | `scope` | text | The scope of the policy (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 3 | `rule_compliance` | float8 | The ratio of rules passing across all tested assets to the total number of scorable rules across all tested assets for this policy. |
| 4 | `total_assets` | bigint | The total number of tested assets with applicable results. An asset has applicable results if at least one rule has a pass or fail status. An asset with all rule status. |
| 5 | `compliant_assets` | bigint | The number of assets passing all scorable rules in the policy. |
| 6 | `noncompliant_assets` | bigint | The number of assets failing at least one scorable rule in the policy. |
| 7 | `not_applicable_assets` | bigint | The number of assets with no applicable rules in the policy. |
| 8 | `asset_compliance` | float8 | The ratio of assets passing all scorable rules in the policy to the total number of assets tested with the policy. |

---

## fact_policy_rule

**Description:** Accumulating snapshot fact table for a policy rule. This is a convenience fact to rollup assets by the policy rule to measure the policy rule's asset compliance.

**Keys & Relationships:**

- **Primary Key:** Composite (`policy_id`, `rule_id`)
- **Foreign Keys:**
  - `policy_id` → [`dim_policy`](#dim_policy)
  - `rule_id` → [`dim_policy_rule`](#dim_policy_rule)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `policy_id` | bigint | The unique identifier of the policy. |
| 2 | `rule_id` | bigint | The unique identifier of the policy rule. |
| 3 | `scope` | text | The scope of the policy rule (e.g., 'asset', 'asset-group', 'global', 'site'). |
| 4 | `compliant_assets` | bigint | The number of assets passing the rule. |
| 5 | `noncompliant_assets` | bigint | The number of assets failing the rule. |
| 6 | `not_applicable_assets` | bigint | The number of assets not applicable to the rule. Assets not applicable to this rule are only counted if they are applicable to at least one rule in the policy. |
| 7 | `asset_compliance` | float8 | The ratio of the assets passing the rule to the assets tested. |

---

## fact_remediation

> **Note:** This is a function, not a table

**Description:** SQL set-returning function that calculates and returns the top remediation solutions ranked by aggregate risk score. Called as `fact_remediation(count, sort_column)` where count specifies the number of results and sort_column determines the ranking order. Returns remediation recommendations with associated asset counts, vulnerability counts, and risk scores.

**Keys & Relationships:**

- **Primary Key:** `solution_id` (function parameter: count, sort_column)
- **Foreign Keys:**
  - `solution_id` → [`dim_solution`](#dim_solution)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `solution_id` | integer | The unique identifier of the remediation solution. |
| 2 | `assets` | bigint | The total number of assets affected by vulnerabilities that this solution remediates. |
| 3 | `vulnerabilities` | bigint | The total count of vulnerabilities that this solution remediates. |
| 4 | `critical_vulnerabilities` | bigint | The count of critical vulnerabilities remediated by this solution. |
| 5 | `severe_vulnerabilities` | bigint | The count of severe vulnerabilities remediated by this solution. |
| 6 | `moderate_vulnerabilities` | bigint | The count of moderate vulnerabilities remediated by this solution. |
| 7 | `malware_kits` | integer | The count of malware kits associated with vulnerabilities remediated by this solution. |
| 8 | `exploits` | integer | The count of exploits associated with vulnerabilities remediated by this solution. |
| 9 | `vulnerabilities_with_malware_kit` | integer | The count of vulnerabilities with malware kits that are remediated by this solution. |
| 10 | `vulnerabilities_with_exploit` | integer | The count of vulnerabilities with exploits that are remediated by this solution. |
| 11 | `vulnerability_instances` | bigint | The total count of vulnerability instances remediated by this solution. |
| 12 | `riskscore` | float8 | The aggregate risk score for all vulnerabilities remediated by this solution. |

---

## fact_scan

**Description:** Transaction fact table for the results of a scan and all the asset within it. This is a convenience fact to rollup assets by scans. Only scans for assets that completed fully will be included in each fact record, but the scan may be in a non-completed state (such as paused).

**Keys & Relationships:**

- **Primary Key:** `scan_id`
- **Foreign Keys:**
  - `scan_id` → [`dim_scan`](#dim_scan)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `scan_id` | integer | The unique identifier of the scan. |
| 2 | `assets` | bigint | The total number of assets in the scan. |
| 3 | `vulnerabilities` | bigint | The sum of the count of vulnerabilities on each asset. This value is equal to the sum of the critical_vulnerabilities, severe_vulnerabilities, and moderate_vulnerabilities columns. |
| 4 | `critical_vulnerabilities` | bigint | The sum of the count of critical vulnerabilities on each asset. |
| 5 | `severe_vulnerabilities` | bigint | The sum of the count of severe vulnerabilities on each asset. |
| 6 | `moderate_vulnerabilities` | bigint | The sum of the count of moderate vulnerabilities on each asset. |
| 7 | `malware_kits` | integer | The sum of the count of malware kits on each asset. |
| 8 | `exploits` | integer | The sum of the count of exploits on each asset. |
| 9 | `vulnerabilities_with_malware_kit` | integer | The sum of the count of vulnerabilities with malware on each asset. |
| 10 | `vulnerabilities_with_exploit` | integer | The sum of the count of vulnerabilities with exploits on each asset. |
| 11 | `vulnerability_instances` | bigint | The sum of the vulnerabilities instances on each asset. |
| 12 | `riskscore` | float8 | The aggregate risk score for the scan. |
| 13 | `pci_status` | text | The overall compliance level ('Pass' or 'Fail') according to PCI standards. The status is only 'Pass' if all assets individually have a status of 'Pass' (e.g. in fact_asset) |

---

## fact_site

**Description:** Accumulating snapshot fact table for a site. This is a convenience fact to rollup assets by the site(s) they belong to. If an asset belongs to more than one site, its counts will be aggregated in each and every site it belongs to. If a site has no asset, it will still have a record in this fact.

**Keys & Relationships:**

- **Primary Key:** `site_id`
- **Foreign Keys:**
  - `site_id` → [`dim_site`](#dim_site)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `site_id` | integer | The unique identifier of the site. |
| 2 | `assets` | bigint | The total number of assets in the site. |
| 3 | `vulnerabilities` | bigint | The sum of the count of vulnerabilities on each asset. This value is equal to the sum of the critical_vulnerabilities, severe_vulnerabilities, and moderate_vulnerabilities columns. |
| 4 | `critical_vulnerabilities` | bigint | The sum of the count of critical vulnerabilities on each asset. |
| 5 | `severe_vulnerabilities` | bigint | The sum of the count of severe vulnerabilities on each asset. |
| 6 | `moderate_vulnerabilities` | bigint | The sum of the count of moderate vulnerabilities on each asset. |
| 7 | `malware_kits` | integer | The sum of the count of malware kits on each asset. |
| 8 | `exploits` | integer | The sum of the count of exploits on each asset. |
| 9 | `vulnerabilities_with_malware_kit` | integer | The sum of the count of vulnerabilities with malware on each asset. |
| 10 | `vulnerabilities_with_exploit` | integer | The sum of the count of vulnerabilities with exploits on each asset. |
| 11 | `vulnerability_instances` | bigint | The sum of the vulnerabilities instances on each asset. |
| 12 | `riskscore` | float8 | The aggregate risk score for the scan. |
| 13 | `pci_status` | text | The overall compliance level ('Pass' or 'Fail') according to PCI standards. The status is only 'Pass' if all assets individually have a status of 'Pass' (e.g. in fact_asset) |

---

## fact_tag

**Description:** Accumulating snapshot fact table that tracks the age and lifecycle of vulnerabilities on assets. This table stores vulnerability age calculations, discovery dates, reintroduction tracking, and time-based metrics for vulnerability management.

**Keys & Relationships:**

- **Primary Key:** `tag_id`
- **Foreign Keys:**
  - `tag_id` → [`dim_tag`](#dim_tag)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `tag_id` | integer | The unique identifier of the tag. |
| 2 | `assets` | bigint | The total number of assets associated with this tag. |
| 3 | `vulnerabilities` | bigint | The sum of the count of vulnerabilities on each asset associated with this tag. |
| 4 | `critical_vulnerabilities` | bigint | The sum of the count of critical vulnerabilities on each asset associated with this tag. |
| 5 | `severe_vulnerabilities` | bigint | The sum of the count of severe vulnerabilities on each asset associated with this tag. |
| 6 | `moderate_vulnerabilities` | bigint | The sum of the count of moderate vulnerabilities on each asset associated with this tag. |
| 7 | `malware_kits` | integer | The sum of the count of malware kits on each asset associated with this tag. |
| 8 | `exploits` | integer | The sum of the count of exploits on each asset associated with this tag. |
| 9 | `vulnerabilities_with_malware_kit` | integer | The sum of the count of vulnerabilities with malware on each asset associated with this tag. |
| 10 | `vulnerabilities_with_exploit` | integer | The sum of the count of vulnerabilities with exploits on each asset associated with this tag. |
| 11 | `vulnerability_instances` | bigint | The sum of the vulnerability instances on each asset associated with this tag. |
| 12 | `riskscore` | float8 | The aggregate risk score for all assets associated with this tag. |
| 13 | `pci_status` | text | The overall compliance level ('Pass' or 'Fail') according to PCI standards for assets associated with this tag. |

---

## fact_vulnerability

**Description:** Accumulating snapshot fact for a vulnerability. This convenience fact rolls up assets by the vulnerabilities they are vulnerable to. Each row represents one distinct vulnerability and the results for that vulnerability. If no assets are vulnerable to a vulnerability there will still be a record in this fact table. There will always be one row in this fact table for every vulnerability defined in the dim_vulnerability dimension.

**Keys & Relationships:**

- **Primary Key:** `vulnerability_id`
- **Foreign Keys:**
  - `vulnerability_id` → [`dim_vulnerability`](#dim_vulnerability)

**Fields:**

| # | Field Name | Data Type | Description |
|---|------------|-----------|-------------|
| 1 | `vulnerability_id` | integer | The unique identifier of the vulnerability. |
| 2 | `affected_assets` | bigint | The total number of assets vulnerable to this vulnerability. |
| 3 | `affected_sites` | bigint | The total number of sites with at least one asset vulnerable to this vulnerability. |
| 4 | `vulnerability_instances` | bigint | The total number of instances across all assets of this vulnerability. |
| 5 | `first_discovered` | timestamp | The date at which this vulnerability was first discovered on any asset that is still presently vulnerable to the vulnerability. |
| 6 | `most_recently_discovered` | timestamp | The data at which the vulnerability was most recently discovered on any asset that is currently vulnerable to the vulnerability. |

---
