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