/*
======================================================================================
Project  : Superstore Sales Analysis
Phase    : 02 - Sales Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
=======================================================================================
*/

USE sales_analysis_db;

-- =====================================================
-- Sales by Region
-- =====================================================

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY Region
ORDER BY Total_Sales DESC;

-- =====================================================
-- Sales by Segment
-- =====================================================

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- =====================================================
-- Sales by Category
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY Category
ORDER BY Total_Sales DESC;

-- =====================================================
-- Sales by Sub-Category
-- =====================================================

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC;

-- =====================================================
-- Bottom 10 Selling Sub-Categories
-- =====================================================

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Sales ASC
LIMIT 10;

-- =====================================================
-- Sales by State
-- =====================================================

SELECT
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY State
ORDER BY Total_Sales DESC;

-- =====================================================
-- Sales by City
-- =====================================================

SELECT
    City,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10;

-- =====================================================
-- Sales by Year
-- =====================================================

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Order_Year;

-- =====================================================
-- Sales by Month
-- =====================================================

SELECT
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
		 MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) 
ORDER BY MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y'));













