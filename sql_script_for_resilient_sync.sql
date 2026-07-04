-- =============================================================================
-- PROJECT: SUPPLY CHAIN RISK & OPERATIONAL ANALYTICS
-- =============================================================================

-- [SECTION 1: SCHEMA SETUP & DATA TYPE STANDARDIZATION]
-- Verify source data integrity
SELECT * FROM master_supply_chain LIMIT 1 ;

-- Convert text-based shipping dates to SQL DATE format for time-series analysis
ALTER TABLE master_supply_chain 
ALTER COLUMN "shipping date (DateOrders)" TYPE DATE 
USING TO_DATE(SUBSTRING("shipping date (DateOrders)", 1, 10), 'MM/DD/YYYY');

-- Create placeholders for external risk datasets
CREATE TABLE weather_table (
    Shipping_Date DATE,
    Region VARCHAR(100),
    Weather_Condition VARCHAR(50),
    Weather_Delay_Days INT,
    Risk_Severity VARCHAR(20)
);

CREATE TABLE geopolitical_table (
    Port_Region VARCHAR(100),
Major_Choke_Point VARCHAR(100),
Geopolitical_Risk_Score INT,
Avg_Weather_Delay_Days FLOAT,
Alternative_Route_Penalty_Cost INT
);

-- [SECTION 2: DATA CLEANING & PRE-PROCESSING]
-- Remove leading/trailing whitespaces to prevent JOIN failures
UPDATE master_supply_chain
SET "Order Region" = TRIM("Order Region");
UPDATE geopolitical_table
SET "port_region" = TRIM("port_region");

-- [SECTION 3: ANALYTICAL VIEW CREATION]
-- Creating a unified view using CTEs to de-duplicate and join datasets
DROP VIEW IF EXISTS UNIFIED_SUPPLY_CHAIN_ANALYSIS;
CREATE VIEW UNIFIED_SUPPLY_CHAIN_ANALYSIS AS
WITH UNIQUEWEATHER AS (
    -- Ensure one weather record per region per date to avoid data multiplication
    SELECT DISTINCT ON (TRIM("Region"), "Shipping_Date") * FROM weather_table
    ORDER BY TRIM("Region"), "Shipping_Date", "Weather_Delay_Days" DESC
),
UNIQUEGEO AS (
    -- Map geopolitical data to unique port regions
    SELECT DISTINCT ON (TRIM("port_region")) * FROM geopolitical_table
    ORDER BY TRIM("port_region")
)
SELECT
    M.*,
    W."Weather_Condition",
    W."Weather_Delay_Days",
    W."Risk_Severity",
    G."major_choke_point",
    G."geopolitical_risk_score",
    G."alternative_route_penalty_cost",
    (M."Days for shipping (real)" - M."Days for shipment (scheduled)") AS "Shipping_Delay_Variance",
    (M."Sales" / NULLIF(M."Order Item Quantity", 0)) AS "Calculated_Unit_Price"
FROM MASTER_SUPPLY_CHAIN M
LEFT JOIN UNIQUEWEATHER W 
    ON TRIM(M."Order Region") = TRIM(W."Region")
    AND M."shipping date (DateOrders)" = W."Shipping_Date"
LEFT JOIN UNIQUEGEO G 
    ON TRIM(M."Order Region") = TRIM(G."port_region");

-- [SECTION 4: DATA INTEGRITY & AUDIT]
-- Confirm the View contains exactly the same number of rows as the original transactional dataset
SELECT COUNT(*) FROM UNIFIED_SUPPLY_CHAIN_ANALYSIS;	

-- Identify regional names present in supply chain data but missing in geopolitical reference table
SELECT DISTINCT M."Order Region"
FROM master_supply_chain M
LEFT JOIN geopolitical_table G 
ON UPPER(TRIM(M."Order Region")) = UPPER(TRIM(G."port_region"))
WHERE G."port_region" IS NULL;

-- Validate that all shipments are correctly mapped to weather records (0 signifies success)
SELECT COUNT(*) 
FROM master_supply_chain M
LEFT JOIN weather_table W ON M."shipping date (DateOrders)" = W."Shipping_Date"
WHERE W."Shipping_Date" IS NULL;

-- Audit: Verify temporal range of data
SELECT MIN("shipping date (DateOrders)"), MAX("shipping date (DateOrders)") 
FROM master_supply_chain;

-- [SECTION 5: HIGH-LEVEL INSIGHTS]
-- Aggregate performance metric: Average shipping delay per weather condition
SELECT
    COALESCE("Weather_Condition", 'Clear/No Data') AS Weather_Status,
    ROUND(AVG("Days for shipping (real)"), 2) AS Avg_Shipping_Days,
    COUNT(*) AS Total_Orders
FROM UNIFIED_SUPPLY_CHAIN_ANALYSIS
GROUP BY 1
ORDER BY Avg_Shipping_Days DESC;


