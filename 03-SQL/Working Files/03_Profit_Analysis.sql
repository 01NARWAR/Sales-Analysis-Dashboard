/*
==========================================================================

Project  : Superstore Sales Analysis
Phase    : 03 - Profit Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar

==========================================================================
*/
USE sales_analysis_db;

-- =====================================================
-- Profit by Region
-- =====================================================

SELECT
    Region,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Region
ORDER BY Total_Profit DESC;

-- =====================================================
-- Profit by Segment
-- =====================================================

SELECT
    Segment,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY Segment
ORDER BY Total_Profit DESC;

-- =====================================================
-- Profit by Category
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY Category
ORDER BY Total_Profit DESC;

-- =====================================================
-- Profit by Sub-Category
-- =====================================================

SELECT
    `Sub-Category`,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC;

-- =====================================================
-- Loss Making Sub-Category
-- =====================================================

SELECT
    `Sub-Category`,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC;

-- =====================================================
-- Profit by State
-- =====================================================

SELECT
    State,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY State
ORDER BY Total_Profit DESC;

-- =====================================================
-- Profit by City
-- =====================================================

SELECT
    City,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY City
ORDER BY Total_Profit DESC
LIMIT 10;

-- =====================================================
-- Profit by Year
-- =====================================================

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Order_Year;

-- =====================================================
-- Profit by Month
-- =====================================================

SELECT
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Month,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY 
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y'));

-- =====================================================
-- Top 10 Profitable Customers
-- =====================================================

SELECT
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- =====================================================
-- Top 10 Loss Making Customers
-- =====================================================

SELECT
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Profit ASC
LIMIT 10;

-- =====================================================
-- Profit Margin Analysis
-- =====================================================

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders;















