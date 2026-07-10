insert into silver.erp_loc_a101(
    cid,
    cntry
)
SELECT
REPLACE(cid,'-','') as cid,
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
from bronze.erp_loc_a101