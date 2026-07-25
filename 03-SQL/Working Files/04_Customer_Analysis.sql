/*
===============================================
Project  : Superstore Sales Analysis
Phase    : 04 - Customer Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
===============================================
*/
USE sales_analysis_db;

-- ===========================================
-- Total Customers
-- ===========================================

SELECT
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM orders;

-- ===========================================
-- Customers by Segment
-- ===========================================

SELECT
    Segment,
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM orders
GROUP BY Segment
ORDER BY Total_Customers DESC;

-- ===========================================
-- Top 10 Customers by Sales
-- ===========================================

SELECT
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ===========================================
-- Top 10 Customers by Profit
-- ===========================================

SELECT
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- ===========================================
-- Top 10 Loss Making Customers
-- ===========================================

SELECT
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Profit ASC
LIMIT 10;

-- ===========================================
-- Customer Lifetime Value
-- ===========================================

SELECT
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ===========================================
-- Average Order Value per Customer
-- ===========================================

SELECT
`Customer Name`,
COUNT(DISTINCT `Order ID`) AS Total_Orders,
ROUND(SUM(Sales), 2) AS Total_Sales,
ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS Average_Order_Value
FROM orders
GROUP BY `Customer Name`
ORDER BY Average_Order_Value DESC
LIMIT 10;

-- ==========================================
-- Customer Purchase Frequency
-- ==========================================

SELECT
`Customer Name`,
COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Orders DESC
LIMIT 10;

-- ==========================================
-- Repeat Customer Analysis
-- ==========================================

SELECT
COUNT(*) AS Repeat_Customers
FROM
(
SELECT
`Customer ID`
FROM orders
GROUP BY `Customer ID`
HAVING COUNT(DISTINCT `Order ID`) > 1
) AS Repeat_Customer;

-- ==========================================
-- Customer Sales Contribution
-- ==========================================

SELECT
`Customer Name`,
ROUND(SUM(Sales),2) AS Total_Sales,
ROUND(
(SUM(Sales) /
(SELECT SUM(Sales) FROM orders)) * 100,
2
) AS Sales_Contribution_Percentage
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

















