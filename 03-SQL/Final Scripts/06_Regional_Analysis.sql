/*
=========================================================
Project  : Superstore Sales Analysis
Phase    : 06 - Regional Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
=========================================================
*/

USE sales_analysis_db;

-- ============================================
-- Total Sales by Region
-- ============================================

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM orders
GROUP BY Region
ORDER BY Total_Sales DESC;

-- ============================================
-- Total Profit by Region
-- ============================================

SELECT
    Region,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Region
ORDER BY Total_Profit DESC;

-- ============================================
-- Total Orders by Region
-- ============================================

SELECT
    Region,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM orders
GROUP BY Region
ORDER BY Total_Orders DESC;


-- ============================================
-- Total Customers by Region
-- ============================================

SELECT
    Region,
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM orders
GROUP BY Region
ORDER BY Total_Customers DESC;

-- ============================================
-- Average Sales per Order by Region
-- ============================================

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS Average_Order_Value
FROM orders
GROUP BY Region
ORDER BY Average_Order_Value DESC;

-- ============================================
-- Profit Margin by Region
-- ============================================

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders
GROUP BY Region
ORDER BY Profit_Margin_Percentage DESC;

-- ============================================
-- Top 10 States by Sales
-- ============================================

SELECT
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- ============================================
-- Top 10 States by Profit
-- ============================================

SELECT
    State,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 10;

-- ============================================
-- Top 10 Loss Making States
-- ============================================

SELECT
    State,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY State
ORDER BY Total_Profit ASC
LIMIT 10;

-- ============================================
-- Sales Contribution by Region
-- ============================================

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(
        (SUM(Sales) / (SELECT SUM(Sales) FROM orders)) * 100,
        2
    ) AS Sales_Contribution_Percentage
FROM orders
GROUP BY Region
ORDER BY Total_Sales DESC;
