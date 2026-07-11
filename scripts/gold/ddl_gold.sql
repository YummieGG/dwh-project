-- Customer Dimensions
create view gold.dim_customers as
select
    row_number() over(order by cst_id) as customer_key, -- Surrogate Key
    ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name,
    la.cntry as country,
    case when ci.cst_gndr != 'Unknown' then ci.cst_gndr -- CRM is Master for Gender Infomation
        else COALESCE(ca.gen,'Unknown')
    end as gender,
    ci.cst_marital_status as marital_status,
    ca.bdate as birthdate,
    ci.cst_create_date as create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid

-- Product Dimensions
create view gold.dim_products as
select
    row_number() over(ORDER BY pn.prd_start_dt,pn.prd_key) as product_key, -- Surrogate Key
    pn.prd_id as product_id,
    pn.prd_key as product_number,
    pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pc.cat as category,
    pc.subcat as subcategory,
    pn.prd_cost as cost,
    pn.prd_line as product_line,
    pc.maintenance,
    pn.prd_start_dt as start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
on pn.cat_id = pc.id
where pn.prd_end_dt is null -- Filter Historical Data Out

-- Sales Details Facts
create view gold.fact_sales as 
select 
    sls_ord_num as order_number,
    pr.product_key,
    cu.customer_key,
    sls_order_dt as order_date,
    sls_ship_dt as ship_date,
    sls_due_dt as due_date,
    sls_sales as sales_amount,
    sls_quantity as quantity,
    sls_price as price
from silver.crm_sales_details as sa
left join gold.dim_products as pr
on sa.sls_prd_key = pr.product_number
left join gold.dim_customers as cu
on sa.sls_cust_id = cu.customer_id
