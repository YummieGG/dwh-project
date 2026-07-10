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