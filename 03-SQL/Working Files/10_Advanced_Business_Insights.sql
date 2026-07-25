/*
==============================================================
Project  : Superstore Sales Analysis
Phase    : 10 - Advanced Business Insights
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
==============================================================
*/

USE sales_analysis_db;

-- ==========================================================
-- 🚀 Query 1 – Top 10 Most Profitable Customers
-- ==========================================================

SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY
    `Customer ID`,
    `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- ==========================================================
-- 🚀 Query 2 – Top 10 Loss-Making Customers
-- ==========================================================

SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY
    `Customer ID`,
    `Customer Name`
ORDER BY Total_Profit ASC
LIMIT 10;

-- ==========================================================
-- 🚀 Query 3 – Top 10 Most Profitable Products
-- ==========================================================

SELECT
    `Product ID`,
    `Product Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY
    `Product ID`,
    `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- ==========================================================
-- 🚀 Query 4 – Top 10 Loss-Making Products
-- ==========================================================

SELECT
    `Product ID`,
    `Product Name`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY
    `Product ID`,
    `Product Name`
ORDER BY Total_Profit ASC
LIMIT 10;

-- ==========================================================
-- 🚀 Query 5 - High Discount vs Profit Analysis
-- ==========================================================

SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Avg_Profit
FROM orders
GROUP BY Discount
ORDER BY Discount;

-- ==========================================================
-- 🚀 Query 6 – Category-wise Profit Margin (%)
-- ==========================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM orders
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

-- ==========================================================
-- 🚀 Query 7 – State-wise Profit Margin (%)
-- ==========================================================

SELECT
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM orders
GROUP BY State
HAVING SUM(Sales) > 0
ORDER BY Profit_Margin_Percent DESC
LIMIT 10;

-- ==========================================================
-- 🚀 Query 8 – Pareto Analysis (80/20 Rule)
-- ==========================================================

WITH Customer_Sales AS
(
    SELECT
        `Customer ID`,
        `Customer Name`,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY
        `Customer ID`,
        `Customer Name`
)

SELECT
    `Customer ID`,
    `Customer Name`,
    Total_Sales,
    ROUND(
        SUM(Total_Sales) OVER (
            ORDER BY Total_Sales DESC
        ),
        2
    ) AS Running_Sales,
    ROUND(
        (
            SUM(Total_Sales) OVER (ORDER BY Total_Sales DESC)
            /
            SUM(Total_Sales) OVER ()
        ) * 100,
        2
    ) AS Cumulative_Percentage
FROM Customer_Sales
ORDER BY Total_Sales DESC;

-- ==========================================================
-- Query 9 - Customer Lifetime Value (CLV)
-- ==========================================================

SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Lifetime_Sales,
    ROUND(SUM(Profit), 2) AS Lifetime_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM orders
GROUP BY
    `Customer ID`,
    `Customer Name`
ORDER BY Lifetime_Sales DESC
LIMIT 10;

-- ==========================================================
-- Query 10 - Executive Dashboard Summary
-- ==========================================================

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    COUNT(DISTINCT `Customer ID`) AS Total_Customers,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS Sales_Per_Order
FROM orders;


































