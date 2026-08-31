USE DataWarehouseAnalytics
GO

-- Cumulative analaysis

-- Calculate the total sales per month
SELECT
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)

-- Calculate the running total of sales over time (month)
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS runnig_total_sales
FROM
(
SELECT
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t

-- Calculate the running total of sales over time (reset for each year)
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY order_date) AS runnig_total_sales
FROM
(
SELECT
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t

-- Calculate the running total of sales over time (year)
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total
FROM
(
SELECT
DATETRUNC(year,order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year,order_date)
)t

-- Calculate the moving AVG price
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total,
AVG(avg_price) OVER (ORDER BY order_date) AS moving_avg_price
FROM
(
SELECT
DATETRUNC(year,order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year,order_date)
)t


