-- Purpose: High-level metrics for executive reporting and board presentations.
-- Use Case: C-level reporting, risk dashboards, compliance summaries.
-- Data Sources: Rapid7 InsightVM Reporting Data Model
-- References: 
--   - https://docs.rapid7.com/insightvm/understanding-the-reporting-data-model-facts/
--   - https://docs.rapid7.com/insightvm/understanding-the-reporting-data-model-dimensions/
--   - https://github.com/rapid7/insightvm-sql-queries/tree/master/sql-query-export


SELECT
  -- Site and scope information
  s.name AS site_name,
  COUNT(DISTINCT a.asset_id) AS total_assets,
  COUNT(DISTINCT CASE WHEN i.asset_id IS NOT NULL THEN a.asset_id END) AS scanned_assets,
  COUNT(DISTINCT i.asset_id) AS affected_assets,
  COUNT(DISTINCT v.vulnerability_id) AS total_vulnerabilities,
  COUNT(DISTINCT CASE WHEN i.date >= CURRENT_DATE - INTERVAL '30 days' THEN i.vulnerability_id END) AS vulns_discovered_last_30_days,
  COUNT(*) AS vulnerability_instances,
  COUNT(DISTINCT CASE WHEN v.severity = 'Critical' THEN v.vulnerability_id END) AS critical_vulns,
  COUNT(DISTINCT CASE WHEN v.severity = 'Severe' THEN v.vulnerability_id END) AS severe_vulns,
  COUNT(DISTINCT CASE WHEN v.severity = 'Moderate' THEN v.vulnerability_id END) AS moderate_vulns,
  COUNT(DISTINCT CASE WHEN COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) >= 9.0 THEN a.asset_id END) AS high_risk_assets,
  COUNT(DISTINCT CASE WHEN v.exploits > 0 THEN v.vulnerability_id END) AS exploitable_vulns,
  COUNT(CASE WHEN v.exploits > 0 THEN 1 END) AS exploitable_vuln_instances,
  COUNT(DISTINCT CASE WHEN v.exploits > 0 AND v.severity = 'Critical' THEN v.vulnerability_id END) AS exploitable_critical_vulns,
  COUNT(CASE WHEN v.exploits > 0 AND v.severity = 'Critical' THEN 1 END) AS exploitable_critical_vuln_instances,
  COUNT(DISTINCT CASE WHEN v.exploits > 0 AND v.severity = 'Severe' THEN v.vulnerability_id END) AS exploitable_severe_vulns,
  COUNT(CASE WHEN v.exploits > 0 AND v.severity = 'Severe' THEN 1 END) AS exploitable_severe_vuln_instances,
  COUNT(DISTINCT CASE WHEN v.exploits > 0 AND v.severity = 'Moderate' THEN v.vulnerability_id END) AS exploitable_moderate_vulns,
  COUNT(CASE WHEN v.exploits > 0 AND v.severity = 'Moderate' THEN 1 END) AS exploitable_moderate_vuln_instances,
  COUNT(DISTINCT CASE WHEN v.malware_kits > 0 THEN v.vulnerability_id END) AS malware_associated_vulns,
  MAX(COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0)) AS max_cvss_score,
  CAST(AVG(COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0)) AS DECIMAL(10,2)) AS avg_cvss_score,
  COUNT(DISTINCT CASE WHEN COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) >= 9.0 THEN v.vulnerability_id END) AS critical_cvss_vulns,
  COUNT(DISTINCT CASE WHEN COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) BETWEEN 7.0 AND 8.9 THEN v.vulnerability_id END) AS high_cvss_vulns,
  DATE(CURRENT_TIMESTAMP) AS query_execution_date

FROM dim_site s
JOIN dim_scope_site ss ON ss.site_id = s.site_id
JOIN dim_site_asset dsa ON dsa.site_id = s.site_id
JOIN dim_asset a ON a.asset_id = dsa.asset_id
LEFT JOIN fact_asset_vulnerability_instance i ON i.asset_id = a.asset_id
LEFT JOIN dim_vulnerability v ON v.vulnerability_id = i.vulnerability_id

WHERE COALESCE(v.cvss_v3_score, v.cvss_v2_score, v.cvss_score, 0) > 0

GROUP BY s.name, s.site_id
ORDER BY affected_assets DESC;