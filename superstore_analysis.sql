/* 
Project: Superstore Sales Analysis
Tool: MySQL
Dataset: Kaggle Superstore Dataseet
Goal: Clean sales/profit fields and generate business KPIs]
Author: Jake Price
*/

-- 1. Preview Raw Data

SELECT *
FROM superstore_project.superstore_clean
LIMIT 20;

SELECT COUNT(*)
FROM superstore_clean;

-- 2. Data Cleaning(Currency Fix)

UPDATE superstore_clean
SET sales = REPLACE(REPLACE(sales,'£',''),',',''), 
	profit = REPLACE(REPLACE(profit,'£',''),',','');

-- 3. Convert Columns to Decimals

ALTER TABLE superstore_clean
MODIFY sales DECIMAL(12,2), 
MODIFY profit DECIMAL(12,2);

-- 4. KPIs

SELECT 
	ROUND(SUM(sales),2) AS total_sales, 
	ROUND(SUM(profit),2) AS total_profit, 
	COUNT(DISTINCT order_id) AS total_orders 
FROM superstore_clean;

-- 5. Top Cities by Profit

SELECT 
	city, 
    ROUND(SUM(profit),2) AS total_profit 
FROM superstore_clean 
GROUP BY city 
ORDER BY total_profit DESC;

-- 6. Sales Trend by Year

SELECT 
	year, 
    ROUND(sum(sales),2) AS total_sales 
FROM superstore_clean 
GROUP BY year 
ORDER BY year;

-- 7. Top Sub-categories by Profit

SELECT
	`sub-category`,
    sum(sales) AS total_sales,
    sum(profit) AS total_profit
FROM superstore_clean
GROUP BY 
	`sub-category`
ORDER BY total_profit DESC;
