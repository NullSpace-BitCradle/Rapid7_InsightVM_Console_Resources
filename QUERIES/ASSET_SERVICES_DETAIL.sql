-- Purpose: Detailed service inventory per asset
-- Use Case: Service discovery, port management, service vulnerability analysis
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- Grain: One row per service per asset
-- Estimated Rows: 5K-50K (total services across all assets)

SELECT
	-- Asset information
	a.asset_id                                        AS "Asset_ID",
	a.host_name                                       AS "Hostname",
	a.ip_address                                      AS "IP_Address",
	a.mac_address                                     AS "MAC_Address",
	os.name                                           AS "Operating_System",
	os.version                                        AS "OS_Version",

	-- Service information
	asvc.service_id                                   AS "Service_ID",
	s.name                                            AS "Service_Name",
	asvc.port                                         AS "Service_Port",
	p.name                                            AS "Protocol",
	asvc.certainty                                    AS "Service_Certainty",

	-- Service fingerprinting
	sf.name                                           AS "Fingerprint_Name",
	sf.vendor                                         AS "Fingerprint_Vendor",
	sf.family                                         AS "Fingerprint_Family",
	sf.version                                        AS "Fingerprint_Version",

	-- Credential status
	asvc_cred.credential_status_id                   AS "Credential_Status_ID",
	cs.credential_status_description                 AS "Credential_Status"

FROM dim_asset_service asvc
JOIN dim_asset a ON a.asset_id = asvc.asset_id
JOIN dim_service s ON s.service_id = asvc.service_id
LEFT JOIN dim_operating_system os ON os.operating_system_id = a.operating_system_id
LEFT JOIN dim_protocol p ON p.protocol_id = asvc.protocol_id
LEFT JOIN dim_asset_service_credential asvc_cred ON asvc_cred.asset_id = asvc.asset_id AND asvc_cred.service_id = asvc.service_id
LEFT JOIN dim_credential_status cs ON cs.credential_status_id = asvc_cred.credential_status_id
LEFT JOIN dim_service_fingerprint sf ON sf.service_fingerprint_id = asvc.service_fingerprint_id

ORDER BY
	a.ip_address,
	asvc.port,
	s.name;
