USE DataWarehouseAnalytics

-- Which 5 products generate the highest revenue?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON P.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5 
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON P.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

-- Find the TOP 10 customers who have generated the highest revenue (window function)
SELECT *
FROM (
	SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_sales,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_customer
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON c.customer_key = f.customer_key
	GROUP BY 
	c.customer_id,
	c.first_name,
	c.last_name)t
WHERE rank_customer <= 10

-- The 3 customers with the fewest orders placed

SELECT TOP 3 
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders

