-- Percentage of Compliance to Policy
-- Copy the SQL query below
SELECT
	dp.title as "Policy Title",
	fp.total_assets as "Assets Policy Scanned",
	ROUND((100.0 * fp.asset_compliance), 2) as "% Compliance To Policy"
FROM
	fact_policy fp
	JOIN dim_policy dp ON dp.policy_id = fp.policy_id
WHERE
	fp.scope like 'Custom'
	AND dp.scope like 'Custom'
	-- NOTE: Replace 'ESI%' with your organization's policy name prefix
	AND dp.title like 'ESI%'