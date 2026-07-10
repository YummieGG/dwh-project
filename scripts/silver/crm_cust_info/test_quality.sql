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

-- Big Picture
select * from silver.crm_cust_info;