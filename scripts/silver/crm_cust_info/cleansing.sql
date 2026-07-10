insert into silver.crm_cust_info(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
select
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lastname,
case when upper(trim(cst_marital_status)) = 'S' then 'Single'
     when upper(trim(cst_marital_status)) = 'M' then 'Married'
     else 'Unknown'
end cst_marital_status,
case when upper(trim(cst_gndr)) = 'F' then 'Female'
     when upper(trim(cst_gndr)) = 'M' then 'Male'
     else 'Unknown'
end cst_gndr,
cst_create_date
from
	(select
	*,
	count(*) over(partition by cst_id) as duplicate,
	row_number() over(partition by cst_id order by cst_create_date desc) as flag_last
	from bronze.crm_cust_info
	where cst_id is not null) t
where flag_last = 1

