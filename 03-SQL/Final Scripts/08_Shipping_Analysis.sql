/*
==============================================================
Project  : Superstore Sales Analysis
Phase    : 08 - Shipping Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
==============================================================
*/

USE sales_analysis_db;

-- ==========================================================
-- Query 1 - Total Orders by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM orders
GROUP BY `Ship Mode`
ORDER BY Total_Orders DESC;

-- ==========================================================
-- Query 2 - Sales by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Ship Mode`
ORDER BY Total_Sales DESC;

-- ==========================================================
-- Query 3 - Profit by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Ship Mode`
ORDER BY Total_Profit DESC;

-- ==========================================================
-- Query 4 - Average Sales per Order by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(AVG(Sales), 2) AS Average_Sales
FROM orders
GROUP BY `Ship Mode`
ORDER BY Average_Sales DESC;

-- ==========================================================
-- Query 5 - Average Profit per Order by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(AVG(Profit), 2) AS Average_Profit
FROM orders
GROUP BY `Ship Mode`
ORDER BY Average_Profit DESC;

-- ==========================================================
-- Query 6 - Sales Contribution by Ship Mode (%)
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(
        (SUM(Sales) / (SELECT SUM(Sales) FROM orders)) * 100,
        2
    ) AS Sales_Contribution_Percentage
FROM orders
GROUP BY `Ship Mode`
ORDER BY Total_Sales DESC;

-- ==========================================================
-- Query 7 - Average Shipping Days
-- ==========================================================

SELECT
    `Ship Mode`,
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
                STR_TO_DATE(`Order Date`, '%m/%d/%Y')
            )
        ),
        2
    ) AS Average_Shipping_Days
FROM orders
GROUP BY `Ship Mode`
ORDER BY Average_Shipping_Days;
-- Note:
-- Order Date and Ship Date were stored as VARCHAR.
-- STR_TO_DATE() was used before DATEDIFF() to calculate shipping days correctly.

-- ==========================================================
-- Query 8 - Orders Delivered After More Than 5 Days
-- ==========================================================

SELECT
    COUNT(*) AS Delayed_Orders
FROM orders
WHERE DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
      ) > 5;

-- ==========================================================
-- Query 9 - Delayed Orders by Ship Mode
-- ==========================================================

SELECT
    `Ship Mode`,
    COUNT(*) AS Delayed_Orders
FROM orders
WHERE DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
      ) > 5
GROUP BY `Ship Mode`
ORDER BY Delayed_Orders DESC;

-- ======================================================
-- Query 10 - Shipping Performance Summary
-- ======================================================

SELECT
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,

    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
                STR_TO_DATE(`Order Date`, '%m/%d/%Y')
            )
        ),
        2
    ) AS Average_Shipping_Days,

    ROUND(
        (SUM(Sales) /
        (SELECT SUM(Sales) FROM orders)) * 100,
        2
    ) AS Sales_Contribution_Percentage

FROM orders

GROUP BY `Ship Mode`

ORDER BY Total_Sales DESC;


