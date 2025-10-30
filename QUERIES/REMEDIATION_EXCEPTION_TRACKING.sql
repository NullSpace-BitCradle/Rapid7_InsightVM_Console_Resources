-- Purpose: Track remediation solutions, priorities, prerequisites, and exception status
-- Use Case: Remediation planning, exception management, SLA tracking, solution prioritization
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- Grain: One row per asset-vulnerability combination with full solution context
-- Estimated Rows: 50K-200K (active vulnerabilities with solutions)

WITH vuln_categories AS (
	SELECT
		vulnerability_id,
		string_agg(DISTINCT category_name, ', ') AS vuln_category
	FROM dim_vulnerability_category
	GROUP BY vulnerability_id
),
asset_tags AS (
	SELECT
		ta.asset_id,
		string_agg(DISTINCT t.tag_name || ' (' || t.tag_type || ')', ', ') AS asset_tags
	FROM dim_tag_asset ta
	JOIN dim_tag t ON ta.tag_id = t.tag_id
	GROUP BY ta.asset_id
),
asset_groups AS (
	SELECT
		aga.asset_id,
		string_agg(DISTINCT ag.name, ', ') AS asset_groups
	FROM dim_asset_group_asset aga
	JOIN dim_asset_group ag ON aga.asset_group_id = ag.asset_group_id
	GROUP BY aga.asset_id
),
all_solutions AS (
	SELECT
		avs.asset_id,
		avs.vulnerability_id,
		string_agg(DISTINCT s.nexpose_id, ', ') AS all_solution_ids,
		string_agg(DISTINCT s.solution_type, ', ') AS all_solution_types,
		COUNT(DISTINCT s.solution_id) AS solution_count
	FROM dim_asset_vulnerability_solution avs
	JOIN dim_solution s ON avs.solution_id = s.solution_id
	GROUP BY avs.asset_id, avs.vulnerability_id
),
solution_prerequisites AS (
	SELECT
		avs.asset_id,
		avs.vulnerability_id,
		string_agg(DISTINCT pr.required_solution_id::text, ', ') AS prerequisite_solution_ids
	FROM dim_asset_vulnerability_solution avs
	JOIN dim_solution_prerequisite pr ON avs.solution_id = pr.solution_id
	GROUP BY avs.asset_id, avs.vulnerability_id
),
vuln_exceptions AS (
	SELECT
		ve.asset_id,
		ve.vulnerability_id,
		ve.vulnerability_exception_id,
		ve.status_id,
		es.description AS exception_status,
		ve.submitted_date,
		ve.submitted_by,
		ve.review_date,
		ve.reviewed_by,
		ve.expiration_date,
		ve.additional_comments,
		er.description AS exception_reason,
		esc.description AS exception_scope
	FROM dim_vulnerability_exception ve
	LEFT JOIN dim_exception_status es ON es.status_id = ve.status_id
	LEFT JOIN dim_exception_reason er ON er.reason_id = ve.reason_id
	LEFT JOIN dim_exception_scope esc ON esc.scope_id = ve.scope_id
	WHERE ve.asset_id IS NOT NULL
)
SELECT
	-- Asset information
	a.asset_id                                        AS "Asset_ID",
	a.host_name                                       AS "Hostname",
	a.ip_address                                      AS "IP_Address",
	a.mac_address                                     AS "MAC_Address",
	os.name                                           AS "Operating_System",
	os.version                                        AS "OS_Version",
	at.asset_tags                                     AS "Asset_Tags",
	ag.asset_groups                                   AS "Asset_Groups",

	-- Vulnerability information
	v.vulnerability_id                                AS "Vuln_ID",
	v.nexpose_id                                      AS "Vuln_Key",
	v.title                                           AS "Vuln_Title",
	vc.vuln_category                                  AS "Vuln_Category",
	v.severity                                        AS "Severity",
	COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) AS "CVSS_Score",
	v.exploits                                        AS "Exploits",
	v.malware_kits                                    AS "Malware_Kits",

	-- Vulnerability age tracking
	va.age_in_days                                    AS "Vuln_Age_Days",
	va.first_discovered                               AS "First_Discovered",
	va.most_recently_discovered                       AS "Most_Recent_Discovered",
	va.reintroduced_date                              AS "Reintroduced_Date",

	-- Best solution information
	ds.solution_id                                    AS "Best_Solution_ID",
	ds.nexpose_id                                     AS "Best_Solution_Key",
	ds.solution_type                                  AS "Best_Solution_Type",
	htmlToText(ds.summary)                            AS "Best_Solution_Summary",
	htmlToText(ds.fix)                                AS "Best_Solution_Fix",
	htmlToText(ds.additional_data)                    AS "Best_Solution_Additional_Data",
	ds.estimate                                       AS "Best_Solution_Estimate",
	ds.url                                            AS "Best_Solution_URL",
	ds.applies_to                                     AS "Best_Solution_Applies_To",

	-- All available solutions
	alls.all_solution_ids                             AS "All_Solution_IDs",
	alls.all_solution_types                           AS "All_Solution_Types",
	alls.solution_count                               AS "Available_Solution_Count",

	-- Solution prerequisites
	prereq.prerequisite_solution_ids                  AS "Prerequisite_Solution_IDs",

	-- Exception information
	ve.vulnerability_exception_id                     AS "Exception_ID",
	ve.exception_status                               AS "Exception_Status",
	ve.exception_reason                               AS "Exception_Reason",
	ve.exception_scope                                AS "Exception_Scope",
	ve.submitted_date                                 AS "Exception_Submitted",
	ve.submitted_by                                   AS "Exception_Submitted_By",
	ve.review_date                                    AS "Exception_Review_Date",
	ve.reviewed_by                                    AS "Exception_Reviewed_By",
	ve.expiration_date                                AS "Exception_Expiration",
	ve.additional_comments                            AS "Exception_Comments",

	-- SLA tracking
	CASE 
		WHEN va.age_in_days IS NULL THEN 'Unknown'
		WHEN va.age_in_days <= 30 THEN 'Within SLA'
		WHEN va.age_in_days <= 90 THEN 'At Risk'
		ELSE 'Overdue'
	END                                               AS "SLA_Status",

	-- Priority scoring
	CASE 
		WHEN v.severity = 'Critical' AND v.exploits > 0 THEN 'P1 - Critical with Exploit'
		WHEN v.severity = 'Critical' THEN 'P2 - Critical'
		WHEN v.severity = 'Severe' AND v.exploits > 0 THEN 'P2 - Severe with Exploit'
		WHEN v.severity = 'Severe' THEN 'P3 - Severe'
		WHEN v.severity = 'Moderate' AND v.exploits > 0 THEN 'P3 - Moderate with Exploit'
		ELSE 'P4 - Standard'
	END                                               AS "Remediation_Priority"

FROM fact_asset_vulnerability_instance i
JOIN dim_asset a ON a.asset_id = i.asset_id
JOIN dim_vulnerability v ON v.vulnerability_id = i.vulnerability_id
LEFT JOIN dim_operating_system os ON os.operating_system_id = a.operating_system_id
LEFT JOIN fact_asset_vulnerability_age va ON va.asset_id = i.asset_id AND va.vulnerability_id = i.vulnerability_id
LEFT JOIN dim_asset_vulnerability_best_solution davbs
       ON davbs.asset_id = i.asset_id AND davbs.vulnerability_id = i.vulnerability_id
LEFT JOIN dim_solution ds ON ds.solution_id = davbs.solution_id
LEFT JOIN vuln_categories vc ON vc.vulnerability_id = v.vulnerability_id
LEFT JOIN asset_tags at ON at.asset_id = a.asset_id
LEFT JOIN asset_groups ag ON ag.asset_id = a.asset_id
LEFT JOIN all_solutions alls ON alls.asset_id = i.asset_id AND alls.vulnerability_id = i.vulnerability_id
LEFT JOIN solution_prerequisites prereq ON prereq.asset_id = i.asset_id AND prereq.vulnerability_id = i.vulnerability_id
LEFT JOIN vuln_exceptions ve ON ve.asset_id = i.asset_id AND ve.vulnerability_id = i.vulnerability_id

WHERE COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) > 0

ORDER BY
	CASE 
		WHEN v.severity = 'Critical' AND v.exploits > 0 THEN 1
		WHEN v.severity = 'Critical' THEN 2
		WHEN v.severity = 'Severe' AND v.exploits > 0 THEN 3
		WHEN v.severity = 'Severe' THEN 4
		WHEN v.severity = 'Moderate' AND v.exploits > 0 THEN 5
		ELSE 6
	END,
	va.age_in_days DESC NULLS LAST,
	a.ip_address,
	v.title;
