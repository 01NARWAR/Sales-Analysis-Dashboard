/*
================================================================================================================
Project  : Superstore Sales Analysis
Phase    : 01 - KPI Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
=================================================================================================================
*/
USE sales_analysis_db;

-- ============================================
-- KPI 1 : Total Sales
-- ============================================

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders;

-- ============================================
-- KPI 2 : Total Profit
-- ============================================

SELECT
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders;

-- ============================================
-- KPI 3 : Total Quantity
-- ============================================

SELECT
SUM(Quantity) AS Total_Quantity
FROM orders;

-- =====================================================
-- KPI 4 : Total Orders
-- =====================================================

SELECT
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM orders;

-- =====================================================
-- KPI 5 : Total Customers
-- =====================================================

SELECT
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM orders;

-- =====================================================
-- KPI 6 : Average Sales (Sales per Order)
-- =====================================================

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT `Order ID`),
	2
    ) AS Average_Sales
FROM orders;

-- =====================================================
-- KPI 7 : Average Profit per Order
-- =====================================================

SELECT
    ROUND(
         SUM(Profit) / COUNT(DISTINCT `Order ID`),
        2
    ) AS Average_Profit
FROM orders;

-- =====================================================
-- KPI 8 : Return Rate
-- =====================================================

SELECT
    ROUND(
         COUNT(DISTINCT r.`Order ID`) / COUNT(DISTINCT o.`Order ID`) * 100,
        2
    ) AS Return_Rate
FROM orders o
LEFT JOIN returns r
ON o.`Order ID` = r.`Order ID`;

-- =====================================================
-- KPI 9 : Total Returned Orders
-- =====================================================
SELECT
    COUNT(DISTINCT `Order ID`) AS Total_Returned
FROM returns;




