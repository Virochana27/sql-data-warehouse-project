--==========================================================
--Quality Check for bronze.crm_cust_info table
--==========================================================

--Check for nulls or duplicates in the primary key
--Expectation : No result

SELECT 
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id IS NULL;

-- Check for unwanted spaces
-- Expectation: No results
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname!=TRIM(cst_firstname);

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname!=TRIM(cst_lastname);

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr!=TRIM(cst_gndr);

--Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info

--==========================================================
--Quality Check for bronze.crm_prd_info
--==========================================================

-- Check for unwanted spaces
-- Expectation: No results
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm!=TRIM(prd_nm);

-- Check for nulls or negative no.s
-- Expectation: No results 
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost<0

--Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--Check for invalid date orders
SELECT * 
FROM bronze.crm_prd_info
WHERE prd_end_dt<prd_start_dt

--==========================================================
--Quality Check for bronze.crm_sales_details
--==========================================================

--Check for invalid dates
  SELECT 
    NULLIF(sls_order_dt,0) AS sls_order_dt
  FROM bronze.crm_sales_details
  WHERE sls_order_dt<=0 
    OR LEN(sls_order_dt)!=8 
    OR sls_order_dt>20500101 
    OR sls_order_dt< 19000101

  SELECT 
    NULLIF(sls_ship_dt,0) AS sls_ship_dt
  FROM bronze.crm_sales_details
  WHERE sls_ship_dt<=0 
    OR LEN(sls_ship_dt)!=8 
    OR sls_ship_dt >20500101 
    OR sls_ship_dt< 19000101

  SELECT 
    NULLIF(sls_due_dt,0) AS sls_due_dt
  FROM bronze.crm_sales_details
  WHERE sls_due_dt<=0 
    OR LEN(sls_due_dt)!=8 
    OR sls_due_dt >20500101 
    OR sls_due_dt< 19000101

  --Check for invalid date orders
  SELECT 
    *
  FROM bronze.crm_sales_details
  WHERE sls_order_dt>sls_ship_dt OR sls_order_dt>sls_due_dt

  --Check data consistency: Between sales, quantity and price
  -- >> Sales = Quantity*Price
  -- >> Values must not be NULL, zero, or negative.

  SELECT 
  sls_sales,
  sls_quantity,
  sls_price
  FROM bronze.crm_sales_details
  WHERE sls_sales!=sls_quantity*sls_price
  OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
  OR sls_sales<=0 OR sls_quantity<=0 OR sls_price<=0

--==========================================================
--Quality Check for bronze.erp_cust_az12
--==========================================================

--Identify out of range dates
SELECT DISTINCT
bdate
FROM bronze.erp_cust_az12
WHERE bdate<'1925-01-01' OR bdate>GETDATE()

--Data Standardization and Consistency
SELECT DISTINCT gen
FROM bronze.erp_cust_az12

--==========================================================
--Quality Check for bronze.erp_loc_a101
--==========================================================

--Data Standardization and consistency
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry

--==========================================================
--Quality Check for bronze.erp_px_cat_g1v2
--==========================================================

--check for unwanted spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat !=TRIM(cat) OR subcat!=TRIM(subcat) OR maintenance!=TRIM(maintenance)

--Data standardization & consistency
SELECT DISTINCT
	cat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT
	subcat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT
	maintenance
FROM bronze.erp_px_cat_g1v2

