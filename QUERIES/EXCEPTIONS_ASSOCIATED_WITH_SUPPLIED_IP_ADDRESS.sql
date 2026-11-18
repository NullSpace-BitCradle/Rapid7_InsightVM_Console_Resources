-- Exceptions associated with supplied IP Address
-- Copy the SQL query below
-- Replace <IP Address> in the WHERE clause with the address to look up.
SELECT
    dve.*
FROM
    dim_vulnerability_exception AS dve
    JOIN dim_asset AS da USING (asset_id)
WHERE
    da.ip_address = '<IP Address>'