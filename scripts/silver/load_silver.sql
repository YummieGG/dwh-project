create or replace PROCEDURE silver.load_silver()
LANGUAGE plpgsql
as $$
DECLARE
    start_time TIMESTAMPTZ;
    end_time TIMESTAMPTZ;
    batch_start_time TIMESTAMPTZ;
    batch_end_time TIMESTAMPTZ;
BEGIN
    batch_start_time := clock_timestamp();

    start_time := clock_timestamp();
    TRUNCATE TABLE silver.crm_cust_info;
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
    where flag_last = 1;
    end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading crm_cust_info to Silver Layer duration: %',(end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE TABLE silver.crm_prd_info;
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
    from bronze.crm_prd_info;
    end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading crm_prd_info to Silver Layer duration: %',(end_time - start_time);


    start_time := clock_timestamp();
    TRUNCATE TABLE silver.crm_sales_details;
    INSERT into
    silver.crm_sales_details(
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price)
    select 
    trim(sls_ord_num) as sls_ord_num,
    trim(sls_prd_key) as sls_prd_key,
    sls_cust_id,
    case when sls_order_dt <= 0 or length(sls_order_dt::text) != 8 then NULL
        else to_date(cast(sls_order_dt as text), 'YYYYMMDD')
    end as sls_order_dt,
    case when sls_ship_dt <= 0 or length(sls_ship_dt::text) != 8 then NULL
        else to_date(sls_ship_dt::text,'YYYYMMDD')
    end as sls_ship_dt,
    case when sls_due_dt <= 0 or length(sls_due_dt::text) != 8 then NULL
        else to_date(sls_due_dt::text,'YYYYMMDD')
    end as sls_due_dt,
    case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
            THEN sls_quantity * abs(sls_price)
        else sls_sales
    end as sls_sales,
    sls_quantity,
    case when sls_price is null or sls_price <= 0
            THEN sls_sales / NULLIF(sls_quantity,0)
        else sls_price
    end as sls_price
    from bronze.crm_sales_details;
    end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading crm_sales_details to Silver Layer duration: %',(end_time - start_time);


    start_time := clock_timestamp();
    TRUNCATE TABLE silver.erp_cust_az12;
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
    FROM bronze.erp_cust_az12;
    end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading erp_cust_az12 to Silver Layer duration: %',(end_time - start_time);


    start_time := clock_timestamp();
    TRUNCATE TABLE silver.erp_loc_a101;
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
    from bronze.erp_loc_a101;
    end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading erp_loc_a101 to Silver Layer duration: %',(end_time - start_time);


    start_time := clock_timestamp();
    TRUNCATE TABLE silver.erp_px_cat_g1v2;
    INSERT INTO silver.erp_px_cat_g1v2(
    id,
    cat,
    subcat,
    maintenance    
    )
    SELECT
    id,
    cat,
    subcat,
    maintenance
    from bronze.erp_px_cat_g1v2;
    end_time := clock_timestamp();
    batch_end_time := clock_timestamp();
    RAISE NOTICE '==============================';
    RAISE NOTICE 'Loading erp_px_cat_g1v2 to Silver Layer duration: %',(end_time - start_time);

    RAISE NOTICE '============================================================';
    RAISE NOTICE 'Loading Silver Layer Total duration: %',(batch_end_time - batch_start_time);

EXCEPTION
    WHEN OTHERS THEN
        raise notice 'Error Message: %',SQLERRM;
        raise notice 'Error State: %',SQLSTATE;
END;
$$;

CALL silver.load_silver();