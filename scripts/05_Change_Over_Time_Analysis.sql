--Change Over Time Analysis
Select 

DATETRUNC(MONTH ,order_date) as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL 
GROUP BY DATETRUNC(MONTH ,order_date)
ORDER BY DATETRUNC(MONTH ,order_date)

--Sales of Categories by Month

SELECT 
    p.category,
    DATETRUNC(month, s.order_date) AS order_month,
    SUM(s.sales_amount) AS total_sales
FROM gold.dim_products p
LEFT JOIN gold.fact_sales s
    ON p.product_key = s.product_key
WHERE s.order_date IS NOT NULL   -- optional but cleaner
GROUP BY 
    p.category, 
    DATETRUNC(month, s.order_date)
ORDER BY 
    total_sales DESC,
    order_month ;
