/*
==============================================================
Project  : Superstore Sales Analysis
Phase    : 07 - Returns Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
==============================================================
*/

USE sales_analysis_db;

-- ============================================
-- 🚀 Query 1 — Returned Orders
-- ============================================

SELECT
    COUNT(DISTINCT `Order ID`) AS Total_Returned_Orders
FROM returns;

-- ============================================
-- 🚀 Query 2 — Return Rate
-- ============================================

SELECT
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders,
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
    ROUND(
        (COUNT(DISTINCT r.`Order ID`) * 100.0) /
        COUNT(DISTINCT o.`Order ID`),
        2
    ) AS Return_Rate_Percentage
FROM orders o
LEFT JOIN returns r
ON o.`Order ID` = r.`Order ID`;

-- ============================================
-- 🚀 Query 3 — Returns by Region
-- ============================================

SELECT
    o.Region,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.Region
ORDER BY Returned_Orders DESC;

-- ==========================================
-- 🚀 Query 4 — Return Rate by Region (%)
-- ==========================================

SELECT
    o.Region,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders,
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
    ROUND(
        COUNT(DISTINCT r.`Order ID`) * 100.0 /
        COUNT(DISTINCT o.`Order ID`),
        2
    ) AS Return_Rate_Percentage
FROM orders o
LEFT JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.Region
ORDER BY Return_Rate_Percentage DESC;
-- ==========================================
-- 🚀 Query 5 — Top 10 Returned Products
-- ==========================================

SELECT
    o.`Product Name`,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.`Product Name`
ORDER BY Returned_Orders DESC
LIMIT 10;

-- ==========================================
-- 🚀 Query 6 — Returned Orders by Category
-- ==========================================

SELECT
    o.Category,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY Returned_Orders DESC;

-- ==========================================
-- 🚀 Query 7 — Return Rate by Category (%)
-- ==========================================

SELECT
    o.Category,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders,
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
    ROUND(
        COUNT(DISTINCT r.`Order ID`) * 100.0 /
        COUNT(DISTINCT o.`Order ID`),
        2
    ) AS Return_Rate_Percentage
FROM orders o
LEFT JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY Return_Rate_Percentage DESC;

-- ==========================================
-- 🚀 Query 8 - Top 10 Customers with Returned Orders
-- ==========================================

SELECT
    o.`Customer Name`,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`
GROUP BY o.`Customer Name`
ORDER BY Returned_Orders DESC
LIMIT 10;

-- ==========================================
-- 🚀 Query 9 — Returned Sales Amount
-- ==========================================

SELECT
    ROUND(SUM(o.Sales), 2) AS Returned_Sales
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`;

-- ==========================================
-- 🚀 Query 10 — Returned Profit Impact
-- ==========================================

SELECT
    ROUND(SUM(o.Profit), 2) AS Returned_Profit
FROM orders o
INNER JOIN returns r
ON o.`Order ID` = r.`Order ID`;










