USE DataWarehouseAnalytics
GO

-- PART TO WHOLE ANALYSIS

--Which category contribute the most to overall sales?
WITH category_sales AS (
SELECT
p.category,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category)

SELECT
category,
total_sales,
SUM(total_sales) OVER () AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) *100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC

-- What are the top 10 products in sales
WITH product_sales AS(
SELECT
p.product_name,
SUM(f.sales_amount) AS total_sales
FROM
gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name)

SELECT TOP 10
product_name,
total_sales,
SUM(total_sales) OVER () AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) *100, 2), '%') AS percentage_of_total
FROM product_sales
ORDER BY total_sales DESC

-- Which 10 customers generete the most sales amount
WITH customer_sales AS (
SELECT 
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.first_name,
c.last_name)

SELECT TOP 10
first_name,
last_name,
total_sales,
SUM(total_sales) OVER () AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) *100, 2), '%') AS percentage_of_total
FROM customer_sales
ORDER BY total_sales DESC
