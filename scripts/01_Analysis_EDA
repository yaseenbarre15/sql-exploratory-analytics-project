/* Brief Exploratory Data Analysis 
*/

-- Explore all Countries Where our Customers are coming from
SELECT DISTINCT
country FROM gold.dim_customers

-- Explore all Categories of the 'Major' Products
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3

--Find the First and Last Order Date
--How many years of sales are available
SELECT MIN(order_date) AS earliest_orderdate,
MAX(order_date) AS last_orderdate,
DATEDIFF (year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

--Select Youngest and Oldest Customer
SELECT 
MIN(birthdate) as oldest_customer,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age,
MAX(birthdate) AS youngest_customer
FROM gold.dim_customers

/*========================================================================================================

Calculating Measures & Aggregations

======================================================================================================== */
 







--Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

--Find How many Items were Sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales AS total_sold

--Find the average selling price
SELECT AVG(price) AS AVG_price FROM gold.fact_sales AS avg_price

--Find the total number of orders (use distinct for duplicates)
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales 

--Find the total number of products
SELECT COUNT(product_name) AS total_products FROM gold.fact_sales AS total_products

--Find the total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

--Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) FROM gold.fact_sales

--Generate report that shows all information.

SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Quantity' as measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Average Price' as measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Orders' as measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' as measure_name, COUNT(product_name) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' as measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.dim_customers


