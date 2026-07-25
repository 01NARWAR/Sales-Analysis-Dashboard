/*
==============================================================
Project  : Superstore Sales Analysis
Phase    : 09 - Time Series Analysis
Database : sales_analysis_db
Tool     : MySQL Workbench
Author   : Sunil Kumar
==============================================================
*/

USE sales_analysis_db;

-- ==========================================================
-- Query 1 - Year-wise Sales Analysis
-- ==========================================================

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Order_Year;

-- ==========================================================
-- Query 2 - Month-wise Sales Trend
-- ==========================================================

SELECT
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_No,
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Month_No;

-- ==========================================================
-- Query 3 - Year-wise Profit Analysis
-- ==========================================================

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Order_Year;

-- ==========================================================
-- Query 4 - Month-wise Profit Analysis
-- ==========================================================

SELECT
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_No,
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Month_No;

-- ==========================================================
-- Query 5 - Quarterly Sales Analysis
-- ==========================================================

SELECT
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Quarter_No,
    CONCAT('Q', QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))) AS Quarter_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
    CONCAT('Q', QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')))
ORDER BY
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y'));

-- ==========================================================
-- Query 6 - Best Sales Month
-- ==========================================================

SELECT
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Total_Sales DESC
LIMIT 1;

-- ==========================================================
-- Query 7 - Worst Sales Month
-- ==========================================================

SELECT
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM orders
GROUP BY MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY Total_Sales ASC
LIMIT 1;

-- ==========================================================
-- Query 8 - Running Total Sales (Window Function)
-- ==========================================================

SELECT
    Order_Year,
    Total_Sales,
    SUM(Total_Sales) OVER (
        ORDER BY Order_Year
    ) AS Running_Total_Sales
FROM
(
    SELECT
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
) AS Yearly_Sales;

-- ==========================================================
-- Query 9 - Month-over-Month (MoM) Growth %
-- ==========================================================

WITH Monthly_Sales AS
(
    SELECT
        MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_No,
        MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month_Name,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY
        MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
        MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
)

SELECT
    Month_No,
    Month_Name,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Month_No) AS Previous_Month_Sales,
    ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month_No))
            / LAG(Total_Sales) OVER (ORDER BY Month_No)
        ) * 100,
        2
    ) AS MoM_Growth_Percent
FROM Monthly_Sales
ORDER BY Month_No;

-- ==========================================================
-- Query 10 - Year-over-Year (YoY) Growth %
-- ==========================================================

WITH Yearly_Sales AS
(
    SELECT
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
)

SELECT
    Order_Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Order_Year) AS Previous_Year_Sales,
    ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Order_Year))
            / LAG(Total_Sales) OVER (ORDER BY Order_Year)
        ) * 100,
        2
    ) AS YoY_Growth_Percent
FROM Yearly_Sales
ORDER BY Order_Year;



