-- ============================================================
--   SUPERSTORE SALES — DATA CLEANING SCRIPT (Step 3)
--   Tool: DBeaver (SQLite)
--   Dataset: train.csv
-- ============================================================


-- ============================================================
-- FIX 1 — REMOVE DUPLICATE ROWS
-- ============================================================

-- Check duplicates first
SELECT "Order ID", "Product ID", Sales, COUNT(*) AS Count
FROM train
GROUP BY "Order ID", "Product ID", Sales
HAVING COUNT(*) > 1;

-- Delete duplicate (keep first, remove extra)
DELETE FROM train
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM train
    GROUP BY "Order ID", "Product ID", Sales
);

-- Verify duplicates removed
SELECT COUNT(*) AS Total_Rows_After_Cleaning FROM train;


-- ============================================================
-- FIX 2 — FIX POSTAL CODE (Number to Text)
-- ============================================================

-- Check postal codes less than 5 digits
SELECT "Postal Code", COUNT(*) AS Count
FROM train
WHERE LENGTH("Postal Code") < 5
GROUP BY "Postal Code";

-- Add leading zero where missing
UPDATE train
SET "Postal Code" = '0' || "Postal Code"
WHERE LENGTH("Postal Code") < 5;

-- Verify fix
SELECT DISTINCT LENGTH("Postal Code") AS Code_Length
FROM train;


-- ============================================================
-- FIX 3 — ADD SHIPPING DURATION COLUMN
-- ============================================================

-- Add new column
ALTER TABLE train ADD COLUMN Shipping_Duration INTEGER;

-- Calculate shipping days
UPDATE train
SET Shipping_Duration = 
    CAST(JULIANDAY("Ship Date") - JULIANDAY("Order Date") AS INTEGER);

-- Verify new column
SELECT 
    "Order ID",
    "Order Date",
    "Ship Date",
    Shipping_Duration AS Shipping_Days
FROM train
LIMIT 10;

-- Check average shipping duration
SELECT 
    ROUND(AVG(Shipping_Duration), 1) AS Avg_Shipping_Days,
    MIN(Shipping_Duration)           AS Min_Days,
    MAX(Shipping_Duration)           AS Max_Days
FROM train;


-- ============================================================
-- FIX 4 — FLAG SALES OUTLIERS
-- ============================================================

-- Add outlier flag column
ALTER TABLE train ADD COLUMN Sales_Outlier TEXT;

-- Flag sales above 10000 as outlier
UPDATE train
SET Sales_Outlier = CASE
    WHEN Sales > 10000 THEN 'Yes'
    ELSE 'No'
END;

-- Check how many outliers flagged
SELECT Sales_Outlier, COUNT(*) AS Count
FROM train
GROUP BY Sales_Outlier;

-- View outlier records
SELECT 
    "Order ID",
    "Customer Name",
    "Product Name",
    ROUND(Sales, 2) AS Sales,
    Sales_Outlier
FROM train
WHERE Sales_Outlier = 'Yes'
ORDER BY Sales DESC;


-- ============================================================
-- FINAL — VERIFY CLEANED DATASET
-- ============================================================

SELECT 
    COUNT(*)                                    AS Total_Rows,
    COUNT(DISTINCT "Order ID")                  AS Unique_Orders,
    COUNT(DISTINCT "Customer ID")               AS Unique_Customers,
    ROUND(MIN(Sales), 2)                        AS Min_Sales,
    ROUND(MAX(Sales), 2)                        AS Max_Sales,
    ROUND(AVG(Sales), 2)                        AS Avg_Sales,
    ROUND(AVG(Shipping_Duration), 1)            AS Avg_Shipping_Days,
    COUNT(CASE WHEN Sales_Outlier='Yes' THEN 1 END) AS Total_Outliers
FROM train;
