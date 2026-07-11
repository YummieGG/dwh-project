-- ==================================================================
-- crm_cust_info
-- ==================================================================
-- Check Null and Duplicate in Primary Key
-- Expectations: No Result
select * 
from
(select count(*) over(PARTITION BY cst_id) as dup,
row_number() over(PARTITION BY cst_id order by cst_create_date desc) as flag_last,
cst_id
from silver.crm_cust_info)
t where dup > 1 or cst_id is null

-- Check For Unwanted Spaces
-- Expectations: No Result
select
cst_key,
cst_firstname,
cst_lastname,
cst_gndr,
cst_marital_status
from silver.crm_cust_info
WHERE cst_key != trim(cst_key) or cst_firstname != trim(cst_firstname)
or cst_lastname != trim(cst_lastname)
or cst_gndr != trim(cst_gndr)
or cst_marital_status != trim(cst_marital_status)

-- Data Standardization
select DISTINCT cst_gndr
from silver.crm_cust_info


-- ==================================================================
-- crm_prd_info
-- ==================================================================
-- Check Null or Negetive Integer
-- Expectations: No Result
select prd_cost
from silver.crm_prd_info
where prd_cost is null or prd_cost < 0

-- Check for Invalid Date Orders
-- Expectations: No Result
select *
from silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- Check Data Standardization
select DISTINCT prd_line
from silver.crm_prd_info

-- ==================================================================
-- crm_sales_details
-- ==================================================================
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

-- ==================================================================
-- erp_cust_az12
-- ==================================================================
-- Check Invalid cid
-- Expectations: No Results
SELECT
cid as old_cid,
case when cid like 'NAS%' then substring(cid,4,length(cid))
     else cid
end as cid,
bdate,
gen
FROM silver.erp_cust_az12
where case when cid like 'NAS%' then substring(cid,4,length(cid))
     else cid
end not in (select DISTINCT cst_key from silver.crm_cust_info)

-- Check Suspicious bdate
-- Expectations: No Results
select * from
(select bdate
from silver.erp_cust_az12
where bdate > CURRENT_DATE) t
where bdate > CURRENT_DATE

-- Check For Unwanted Space
-- Expectations: 3 Values: Unknown,Male,Female
select distinct
case when UPPER(trim(gen)) in ('M','MALE') then 'Male'
     when upper(trim(gen)) in ('F','FEMALE') then 'Female'
     else 'Unknown'
end as gen
from silver.erp_cust_az12

-- ==================================================================
-- erp_loc_a101
-- ==================================================================
-- Check For Unwanted Space
-- Expectations: No Results
select cid
from silver.erp_loc_a101
where cid not in (select cst_key from silver.crm_cust_info)

-- Check Standardization & Null Value
-- Expectations: No Null or Space Value
select DISTINCT
case when upper(trim(cntry)) in ('TH','THAILAND','THAI') then 'Thailand'
    when upper(trim(cntry)) in ('DE','GERMANY','GERMAN') then 'Germany'
    when upper(trim(cntry)) in ('AU','AUSTRALIA') then 'Australia'
    when upper(trim(cntry)) in ('USA','US','UNITEDSTATES') then 'United States'
    when upper(trim(cntry)) in ('UK','UNITEDKINGDOM') then 'United Kingdom'
    when upper(trim(cntry)) in ('CAN','CA','CANADA') then 'Canada'
    when upper(trim(cntry)) in ('FRA','FR','FRANCE') then 'France'
    when upper(trim(cntry)) = '' or upper(trim(cntry)) is null then 'Unknown'
    else cntry
end as cntry
from silver.erp_loc_a101

-- ==================================================================
-- erp_px_cat_g1v2
-- ==================================================================
-- Check Unwanted Space
-- Expectations: No Results
select *
from silver.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)

-- Check Standardization
select distinct maintenance
from silver.erp_px_cat_g1v2