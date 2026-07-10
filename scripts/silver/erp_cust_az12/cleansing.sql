insert into silver.erp_cust_az12(
    cid,
    bdate,
    gen
)
SELECT
case when cid like 'NAS%' then substring(cid,4,length(cid))
     else cid
end as cid,
case when bdate > CURRENT_DATE then NULL
     else bdate
end as bdate,
case when UPPER(trim(gen)) in ('M','MALE') then 'Male'
     when upper(trim(gen)) in ('F','FEMALE') then 'Female'
     else 'Unknown'
end as gen
FROM bronze.erp_cust_az12

select * from silver.erp_cust_az12