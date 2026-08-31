USE DataWarehouseAnalytics

-- Find total customers by countries
SELECT 
country,
COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- Find total customers by gender
SELECT
gender,
COUNT(customer_key) AS total_customer_gender
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customer_gender DESC

-- Find total products by category
SELECT
category,
COUNT(product_key) AS total_products_category
FROM gold.dim_products
GROUP BY category
ORDER BY total_products_category DESC

-- What is the avg costs in each category?
SELECT
category,
AVG(cost) AS avg_cost_category
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost_category DESC

-- What is the total revenue genereted for each category?
SELECT
p.category,
SUM(f.sales_amount) AS total_revenue_category
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY category
ORDER BY total_revenue_category DESC

-- What is the total revenue genereted for each customer?
SELECT
c.customer_number,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_number,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

-- What is the distribution of sold items across countries?
SELECT
c.country,
SUM(f.quantity) as sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY sold_items DESC

