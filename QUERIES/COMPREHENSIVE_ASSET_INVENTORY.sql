-- Purpose: Complete asset context including tags, groups, services, software
-- Use Case: Asset inventory management, asset grouping, compliance reporting
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- Grain: One row per asset with aggregated context
-- Estimated Rows: 1K-10K (total assets in environment)

WITH asset_tags AS (
	SELECT
		ta.asset_id,
		string_agg(DISTINCT t.tag_name || ' (' || t.tag_type || ')', ', ') AS asset_tags,
		string_agg(DISTINCT t.tag_name, ', ') AS tag_names_only
	FROM dim_tag_asset ta
	JOIN dim_tag t ON ta.tag_id = t.tag_id
	GROUP BY ta.asset_id
),
asset_groups AS (
	SELECT
		aga.asset_id,
		string_agg(DISTINCT ag.name, ', ') AS asset_groups,
		COUNT(DISTINCT ag.asset_group_id) AS group_count
	FROM dim_asset_group_asset aga
	JOIN dim_asset_group ag ON aga.asset_group_id = ag.asset_group_id
	GROUP BY aga.asset_id
),
asset_services AS (
	SELECT
		asvc.asset_id,
		COUNT(DISTINCT asvc.service_id) AS service_count,
		string_agg(DISTINCT s.name, ', ') AS service_names
	FROM dim_asset_service asvc
	JOIN dim_service s ON asvc.service_id = s.service_id
	GROUP BY asvc.asset_id
),
asset_software AS (
	SELECT
		asw.asset_id,
		COUNT(DISTINCT asw.software_id) AS software_count,
		string_agg(DISTINCT sw.name || ' ' || COALESCE(sw.version, ''), ', ') AS software_versions
	FROM dim_asset_software asw
	JOIN dim_software sw ON asw.software_id = sw.software_id
	GROUP BY asw.asset_id
),
asset_users AS (
	SELECT
		aua.asset_id,
		COUNT(DISTINCT aua.name) AS user_count,
		string_agg(DISTINCT aua.name, ', ') AS user_names
	FROM dim_asset_user_account aua
	GROUP BY aua.asset_id
)
SELECT
	-- Asset identification
	a.asset_id                                        AS "Asset_ID",
	a.host_name                                       AS "Hostname",
	a.ip_address                                      AS "IP_Address",
	a.mac_address                                     AS "MAC_Address",
	a.match_value                                     AS "Match_Value",

	-- Operating system information
	os.name                                           AS "Operating_System",
	os.version                                        AS "OS_Version",
	os.architecture                                   AS "OS_Architecture",
	ht.description                                    AS "Host_Type",

	-- Site information
	site.name                                         AS "Site_Name",
	site.description                                  AS "Site_Description",

	-- Asset context
	at.asset_tags                                     AS "Asset_Tags",
	at.tag_names_only                                 AS "Tag_Names_Only",
	ag.asset_groups                                   AS "Asset_Groups",
	ag.group_count                                    AS "Asset_Group_Count",

	-- Service inventory
	asvc.service_count                                AS "Service_Count",
	asvc.service_names                                AS "Service_Names",

	-- Software inventory
	asw.software_count                                AS "Software_Count",
	asw.software_versions                             AS "Software_Versions",

	-- User accounts
	au.user_count                                     AS "User_Count",
	au.user_names                                     AS "User_Names",

	-- Vulnerability summary (from fact_asset)
	fa.vulnerabilities                                AS "Total_Vulnerabilities",
	fa.critical_vulnerabilities                       AS "Critical_Vulnerabilities",
	fa.severe_vulnerabilities                         AS "Severe_Vulnerabilities",
	fa.moderate_vulnerabilities                       AS "Moderate_Vulnerabilities",
	fa.malware_kits                                   AS "Malware_Kits",
	fa.exploits                                       AS "Exploits",
	fa.vulnerabilities_with_malware_kit               AS "Vulns_With_Malware_Kit",
	fa.vulnerabilities_with_exploit                   AS "Vulns_With_Exploit",

	-- Scan information
	fa.last_scan_id                                   AS "Last_Scan_ID",
	fa.scan_started                                   AS "Last_Scan_Started",
	fa.scan_finished                                  AS "Last_Scan_Finished",
	a.last_assessed_for_vulnerabilities              AS "Last_Vuln_Assessment",

	-- Discovery information
	fad.first_discovered                              AS "First_Discovered",
	fad.last_discovered                               AS "Last_Discovered",

	-- Risk scoring
	fa.riskscore                                      AS "Risk_Score",

	-- Credential status
	acs.aggregated_credential_status_description     AS "Credential_Status"

FROM dim_asset a
JOIN dim_site_asset dsa ON dsa.asset_id = a.asset_id
JOIN dim_site site ON site.site_id = dsa.site_id
LEFT JOIN dim_operating_system os ON os.operating_system_id = a.operating_system_id
LEFT JOIN dim_host_type ht ON ht.host_type_id = a.host_type_id
LEFT JOIN fact_asset fa ON fa.asset_id = a.asset_id
LEFT JOIN fact_asset_discovery fad ON fad.asset_id = a.asset_id
LEFT JOIN dim_aggregated_credential_status acs ON acs.aggregated_credential_status_id = fa.aggregated_credential_status_id
LEFT JOIN asset_tags at ON at.asset_id = a.asset_id
LEFT JOIN asset_groups ag ON ag.asset_id = a.asset_id
LEFT JOIN asset_services asvc ON asvc.asset_id = a.asset_id
LEFT JOIN asset_software asw ON asw.asset_id = a.asset_id
LEFT JOIN asset_users au ON au.asset_id = a.asset_id

ORDER BY
	fa.riskscore DESC NULLS LAST,
	a.ip_address;
