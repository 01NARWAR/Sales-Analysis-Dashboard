/*
=========================================================
Project  : Superstore Sales Analysis
Phase    : 05 - Product Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
=========================================================
*/

USE sales_analysis_db;

-- ==========================================
-- Total Products
-- ==========================================

SELECT
    COUNT(DISTINCT `Product Name`) AS Total_Products
FROM orders;

-- ==========================================
-- Products by Category
-- ==========================================

SELECT
    Category,
    COUNT(DISTINCT `Product Name`) AS Total_Products
FROM orders
GROUP BY Category
ORDER BY Total_Products DESC;

-- ==========================================
-- Products by Sub-Category
-- ==========================================

SELECT
    `Sub-Category`,
    COUNT(DISTINCT `Product Name`) AS Total_Products
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Products DESC;

-- ==========================================
-- Top 10 Products by Sales
-- ==========================================

SELECT
    `Product Name`,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ==========================================
-- Top 10 Products by Profit
-- ==========================================

SELECT
    `Product Name`,
	ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- ==========================================
-- Top 10 Loss Making Products
-- ==========================================

SELECT
    `Product Name`,
	ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Profit ASC
LIMIT 10;

-- ==========================================
-- Product Profit Margin
-- ==========================================

SELECT
	`Product Name`,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Profit), 2) AS Total_Profit,
	ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders
GROUP BY `Product Name`
ORDER BY Profit_Margin_Percentage DESC
LIMIT 10;

-- ==========================================
-- Product Performance
-- ==========================================

SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    SUM(Quantity) AS Total_Quantity
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ==========================================
-- Product Sales Contribution
-- ==========================================

SELECT
	`Product Name`,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(
         (SUM(Sales) /
         (SELECT SUM(Sales) FROM orders)) * 100,
         2
	) AS Sales_Contribution_Percentage
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ==========================================
-- Slow Moving Products
-- ==========================================

SELECT
    `Product Name`,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Quantity ASC, Total_Sales ASC
LIMIT 10;










