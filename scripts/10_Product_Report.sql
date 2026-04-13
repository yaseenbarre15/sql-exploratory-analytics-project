/* 
=======================================================================================
Product Report
=======================================================================================
Purpose:
- This report consolidates key product metrics and behaviors.

Highlights:
1. Gathers essential fields such as product name, category, subcategory, and cost.
2. Segment products by revenue to identiy High-Performers, Mid-Range, or Low-performers.
3. Aggregates product-level metrics: 
- total orders
- total sales
- total quantity sold
- total customers (unique)
- lifespan (months)
4. Calculates valuable KPIs: 
- recency (months since last sale)
- average order revenue (AOR)
- average monthly revenue
=======================================================================================
*/

/*-----------------------------------------------------------------------------
1) First Query: Retrieves all relevant columns
-----------------------------------------------------------------------------
*/

CREATE VIEW gold.report_product AS
WITH primary_query AS (
SELECT


s.order_number ,
s.order_date,
s.customer_key ,
s.quantity ,
s.sales_amount,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost


FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
WHERE order_date IS NOT NULL
) 
, product_aggregation AS (

/*-----------------------------------------------------------------------------
2) Second Query: Performs Key Aggregations and Transformations
-----------------------------------------------------------------------------
*/
SELECT

product_key,
product_name,
category,
subcategory,
cost,
COUNT ( DISTINCT order_number) as total_orders,
COUNT (DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity,
SUM(sales_amount) as total_sales,
DATEDIFF(month, MIN(order_date) , MAX(order_date)) AS lifespan,
MAX ( order_date) AS last_sale_date,
ROUND(AVG(CAST(sales_amount AS FLOAT)/ NULLIF(quantity, 0)),1) AS avg_selling_price
FROM primary_query 
GROUP BY
product_key,
product_name,
category,
subcategory,
cost
) 
/*-----------------------------------------------------------------------------
3) Final Query: Combines all product results into one output
-----------------------------------------------------------------------------
*/
SELECT 
product_key,
product_name,
category,
subcategory,
cost,
last_sale_date,
DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
CASE WHEN total_sales > 50000 THEN 'High Performer'	
	 WHEN total_sales >= 10000 THEN 'Mid-Range'
	 ELSE 'Low-Performer'
	 END AS product_segment,
	 lifespan,
	 total_orders,
	 total_sales,
	 total_quantity,
	 total_customers,
	 avg_selling_price,
-- Average order Revenue (AOR)
CASE
	WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
	END AS avg_order_revenue,
-- Average Monthly Revenue
CASE
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation
