-- Assets in Policy Compliance
-- Copy the SQL query below
SELECT
        da.ip_address,
        da.host_name,
        fasp.scope AS asset_scope,
        fasp.date_tested,
        fasp.compliant_rules,
        fasp.noncompliant_rules,
        fasp.not_applicable_rules,
        fasp.rule_compliance,
        dp.title AS policy_title,
        dp.total_rules,
        dp.benchmark_name,
        dp.category,
        dpr.title AS rule_title,
        dpr.description,
        dpr.scope AS rule_scope
FROM
        fact_asset_scan_policy fasp
        JOIN dim_policy dp USING (policy_id)
        JOIN dim_policy_rule dpr USING (policy_id)
        JOIN dim_asset da USING (asset_id)
ORDER BY
        da.ip_address