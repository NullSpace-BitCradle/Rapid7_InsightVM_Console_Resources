-- Purpose: Policy compliance results with overrides
-- Use Case: Compliance reporting, policy violation tracking, audit preparation
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- Grain: One row per policy rule per asset
-- Estimated Rows: 10K-100K (policy rules tested across all assets)
## This query passes validation but fails to fully execute thus requiring additional investigation.

SELECT
	-- Asset information
	a.asset_id                                        AS "Asset_ID",
	a.host_name                                       AS "Hostname",
	a.ip_address                                      AS "IP_Address",
	a.mac_address                                     AS "MAC_Address",
	os.name                                           AS "Operating_System",
	os.version                                        AS "OS_Version",

	-- Policy information
	p.policy_id                                       AS "Policy_ID",
	p.title                                           AS "Policy_Title",
	p.description                                     AS "Policy_Description",
	p.scope                                           AS "Policy_Scope",

	-- Policy group information
	pg.group_id                                       AS "Policy_Group_ID",
	pg.title                                          AS "Policy_Group_Title",
	pg.description                                    AS "Policy_Group_Description",

	-- Policy rule information
	pr.rule_id                                        AS "Rule_ID",
	pr.title                                          AS "Rule_Title",
	pr.description                                    AS "Rule_Description",
	pr.scope                                          AS "Rule_Scope",
	pr.severity                                       AS "Rule_Severity",
	pr.role                                           AS "Rule_Role",

	-- Policy rule test information
	prt.test_id                                       AS "Test_ID",
	prt.test_name                                     AS "Test_Name",
	prt.test_type                                     AS "Test_Type",
	prt.test_version                                  AS "Test_Version",
	prt.entity_name                                   AS "Test_Entity_Name",
	prt.operation                                     AS "Test_Operation",
	prt.entity_value                                  AS "Test_Entity_Value",

	-- Compliance results
	fapr.status_id                                    AS "Compliance_Status_ID",
	prs.description                                   AS "Compliance_Status",
	fapr.date_tested                                  AS "Date_Tested",
	fapr.compliance                                   AS "Compliance_Result",

	-- Policy rule check details
	faprc.result_id                                   AS "Check_Result_ID",
	faprc.status_id                                   AS "Check_Status_ID",
	prs_check.description                             AS "Check_Status",
	faprc.date_tested                                 AS "Check_Date_Tested",
	faprc.compliance                                  AS "Check_Compliance_Result",
	htmlToText(faprc.proof)                           AS "Check_Proof",

	-- Override information
	po.override_id                                    AS "Override_ID",
	po.submitted_by                                   AS "Override_Submitted_By",
	po.submit_time                                    AS "Override_Submit_Time",
	po.reviewed_by                                    AS "Override_Reviewed_By",
	po.review_state_id                                AS "Override_Review_State_ID",
	pos.description                                   AS "Override_Review_State",
	po.new_status_id                                  AS "Override_New_Status_ID",
	po.comments                                       AS "Override_Comments",
	po.effective_time                                 AS "Override_Effective_Time",
	po.expiration_time                                AS "Override_Expiration_Time",

	-- NIST control mappings
	prcn.cce_item_id                                  AS "CCE_Item_ID",
	prcn.platform                                     AS "CCE_Platform",
	prcn.control_name                                 AS "Control_Name",
	prcn.date_published                               AS "Control_Date_Published"

FROM fact_asset_policy_rule fapr
JOIN dim_asset a ON a.asset_id = fapr.asset_id
JOIN dim_policy p ON p.policy_id = fapr.policy_id
JOIN dim_policy_rule pr ON pr.rule_id = fapr.rule_id
LEFT JOIN dim_operating_system os ON os.operating_system_id = a.operating_system_id
LEFT JOIN dim_policy_group pg ON pg.policy_id = p.policy_id AND pg.group_id = pr.parent_group_id
LEFT JOIN dim_policy_rule_test prt ON prt.rule_id = pr.rule_id
LEFT JOIN dim_policy_result_status prs ON prs.status_id = fapr.status_id
LEFT JOIN fact_asset_policy_rule_check faprc ON faprc.asset_id = fapr.asset_id AND faprc.policy_id = fapr.policy_id AND faprc.rule_id = fapr.rule_id
LEFT JOIN dim_policy_result_status prs_check ON prs_check.status_id = faprc.status_id
LEFT JOIN dim_policy_override po ON po.override_id = fapr.override_id
LEFT JOIN dim_policy_result_status pos ON pos.status_id = po.review_state_id
LEFT JOIN dim_policy_rule_cce_platform_nist_control_mapping prcn ON prcn.rule_id = pr.rule_id

ORDER BY
	a.ip_address,
	p.title,
	pr.title,
	fapr.date_tested DESC;
