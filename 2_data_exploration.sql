USE DataWarehouseAnalytics

-- DATABASE EXPLORATION
-------------------------------------------

-- Explore all objects in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore all columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
--=========================================

-- DIMENSION EXPLORATION
-------------------------------------------

-- Explore all countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all categories 
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3
--=========================================

-- DATE EXPLORATION
-------------------------------------------

-- Find the date of the first and last oreder
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
FROM gold.fact_sales

-- How many years of sales are avaiable
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year,MIN(order_date), MAX(order_date)) AS order_range_year
FROM gold.fact_sales

-- Find the youngest and the oldest customer
SELECT
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers

