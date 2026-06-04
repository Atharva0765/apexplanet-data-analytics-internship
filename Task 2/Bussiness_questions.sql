Q1 — Top 5 Products by Revenue
SELECT 
    "Product Name",
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM train
GROUP BY "Product Name"
ORDER BY Total_Revenue DESC
LIMIT 5;

Q2 — Which Region has Highest Sales?
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM train
GROUP BY Region
ORDER BY Total_Sales DESC;

Q3 — Monthly Sales Trend
SELECT 
    SUBSTR("Order Date", 7, 4) AS Year,
    SUBSTR("Order Date", 4, 2) AS Month,
    ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM train
GROUP BY Year, Month
ORDER BY Year, Month;

Q4 — Best Customer Segment
SELECT 
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM train
GROUP BY Segment
ORDER BY Total_Sales DESC;

Q5 — Most Used Ship Mode
SELECT 
    "Ship Mode",
    COUNT(*) AS Total_Orders
FROM train
GROUP BY "Ship Mode"
ORDER BY Total_Orders DESC;4

Q6 — Top 5 Customers
SELECT 
    "Customer Name",
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM train
GROUP BY "Customer Name"
ORDER BY Total_Sales DESC
LIMIT 5;

Q7 — Highest Avg Order Value
SELECT 
    "Sub-Category",
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM train
GROUP BY "Sub-Category"
ORDER BY Avg_Order_Value DESC
LIMIT 10;