-- crm_prd_info: Cleansing
insert into silver.crm_prd_info(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
select
prd_id,
replace(substring(prd_key,1,5),'-','_') as cat_id,
substring(prd_key,7,length(prd_key)) as prd_key,
trim(prd_nm) as prd_nm,
COALESCE(prd_cost,0) as prd_cost,
case upper(trim(prd_line))
     when 'M' then 'Mountain'
     when 'R' then 'Road'
     when 'S' then 'Other Sales'
     when 'T' then 'Touring'
     else 'Unknown'
end prd_line,
prd_start_dt,
lead(prd_start_dt) over(PARTITION BY prd_key ORDER BY prd_start_dt ASC)-1 as prd_end_dt
from bronze.crm_prd_info