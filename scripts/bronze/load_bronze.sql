create or replace PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql AS $$
DECLARE
    start_time TIMESTAMPTZ;
    end_time TIMESTAMPTZ;
    batch_start_time TIMESTAMPTZ;
    batch_end_time TIMESTAMPTZ;

begin 
    batch_start_time := clock_timestamp();
    /* CRM */
    start_time := clock_timestamp();
    RAISE notice 'Loading crm Tables';
    TRUNCATE bronze.crm_cust_info;
    COPY bronze.crm_cust_info
    from '/Users/Shared/dwh_data/source_crm/cust_info.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading crm_cust_info duration: %',(end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE bronze.crm_prd_info;
    COPY bronze.crm_prd_info
    from '/Users/Shared/dwh_data/source_crm/prd_info.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading crm_prd_info duration: %',(end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE bronze.crm_sales_details;
    COPY bronze.crm_sales_details
    from '/Users/Shared/dwh_data/source_crm/sales_details.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading crm_sales_details duration: %',(end_time - start_time);

    /* ERP */
    start_time := clock_timestamp();
    raise notice 'Loading erp Tables';
    TRUNCATE bronze.erp_cust_az12;
    COPY bronze.erp_cust_az12
    from '/Users/Shared/dwh_data/source_erp/CUST_AZ12.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading erp_cust_az12 duration: %',(end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE bronze.erp_loc_a101;
    COPY bronze.erp_loc_a101
    from '/Users/Shared/dwh_data/source_erp/LOC_A101.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading erp_loc_a101 duration: %',(end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE bronze.erp_px_cat_g1v2;
    COPY bronze.erp_px_cat_g1v2
    from '/Users/Shared/dwh_data/source_erp/PX_CAT_G1V2.csv'
    DELIMITER ','
    CSV HEADER;
    end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading erp_px_cat_g1v2 duration: %',(end_time - start_time);

    batch_end_time := clock_timestamp();
    raise notice '===========================================================';
    raise notice 'Loading Batch Duration: %',(batch_end_time - batch_start_time);

EXCEPTION
    WHEN OTHERS THEN
        raise notice 'Error Message: %',SQLERRM;
        raise notice 'Error State: %',SQLSTATE;
END;
$$;



call bronze.load_bronze();