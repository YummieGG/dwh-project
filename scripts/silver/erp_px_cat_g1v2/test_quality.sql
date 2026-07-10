-- Check Unwanted Space
-- Expectations: No Results
select *
from silver.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)

-- Check Standardization
select distinct maintenance
from silver.erp_px_cat_g1v2