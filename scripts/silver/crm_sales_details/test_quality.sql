-- Check For Unwanted Space
-- Expectations: No Result

select sls_prd_key
from silver.crm_sales_details
where sls_prd_key != trim(sls_prd_key)

-- Check Null or Negative Value
-- Expectations: No Result
select sls_quantity
from silver.crm_sales_details
where sls_quantity is null or sls_quantity < 0


-- Check Invalid Date
-- Expectations: No Result
select sls_order_dt, sls_ship_dt, sls_due_dt
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;

-- Check Sales Value (Sales = Quantity * Price)
-- Expectations: No Results
SELECT DISTINCT
sls_sales as old_sales,
sls_quantity,
sls_price as old_price,
case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
        THEN sls_quantity * abs(sls_price)
     else sls_sales
end as sls_sales,
case when sls_price is null or sls_price <= 0
        THEN sls_sales / NULLIF(sls_quantity,0)
     else sls_price
end as sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity*sls_price
or sls_sales is null or sls_quantity is null or sls_price is NULL
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0