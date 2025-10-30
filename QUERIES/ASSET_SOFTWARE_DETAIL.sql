-- Purpose: Software inventory per asset
-- Use Case: Software asset management, license tracking, vulnerability correlation
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- Grain: One row per software per asset
-- Estimated Rows: 10K-100K (total software installations across all assets)

SELECT
	-- Asset information
	a.asset_id                                        AS "Asset_ID",
	a.host_name                                       AS "Hostname",
	a.ip_address                                      AS "IP_Address",
	a.mac_address                                     AS "MAC_Address",
	os.name                                           AS "Operating_System",
	os.version                                        AS "OS_Version",

	-- Software information
	asw.software_id                                   AS "Software_ID",
	sw.name                                           AS "Software_Name",
	sw.vendor                                         AS "Software_Vendor",
	sw.family                                         AS "Software_Family",
	sw.software_class                                 AS "Software_Class",
	sw.version                                        AS "Software_Version",

	-- Software metadata
	sw.cpe                                            AS "CPE_Identifier"

FROM dim_asset_software asw
JOIN dim_asset a ON a.asset_id = asw.asset_id
JOIN dim_software sw ON sw.software_id = asw.software_id
LEFT JOIN dim_operating_system os ON os.operating_system_id = a.operating_system_id

ORDER BY
	a.ip_address,
	sw.vendor,
	sw.name,
	sw.version;
