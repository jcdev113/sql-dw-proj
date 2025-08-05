/*
======================================================================
DDL Script: Create Bronze Tables
======================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping
  tables if they are already exist.
  Run this script to re-define the DDL structure of 'bronze' tables
======================================================================
Ref: 
- https://stackoverflow.com/questions/7887011/how-to-drop-a-table-if-it-exists
======================================================================
*/

IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
 
-- For SQL Server 2016 and above
-- DROP TABLE IF EXISTS bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
	cst_id				INT,
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE
);


IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_pro_info;

CREATE TABLE bronze.crm_pro_info (
	prd_id		 INT,
	prd_key		 NVARCHAR(50),
	prd_nm		 NVARCHAR(50),
	prd_cost	 INT,
	prd_line	 NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt	 DATE
);


IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num  NVARCHAR(50),
	sls_prd_key  NVARCHAR(50),
	sls_cust_id	 INT,
	sls_order_dt INT,
	sls_ship_dt	 INT,
	sls_due_dt	 INT,
	sls_sales	 INT,
	sls_quantity INT,
	sls_price	 INT
);

IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
	cid   NVARCHAR(50),
	cntry NVARCHAR(50)
);

IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
	cid   NVARCHAR(50),
	bdate DATE,
	gen   NVARCHAR(50)
);

IF OBJECT_ID('bronze.crm_pro_info', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
	id		   NVARCHAR(50), 
	cat		   NVARCHAR(50),
	subcat	   NVARCHAR(50),
	maintenace NVARCHAR(50)
);
