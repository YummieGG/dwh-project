-- Foreign Key Integrity
-- Expectations: No Results
select
*
from gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key = c.customer_key
left join gold.dim_products as p
on f.product_key = p.product_key
where c.customer_key is null or p.product_key is null