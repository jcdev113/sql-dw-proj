/*
==================================================================================
Stored Procedure: Load Bronze Layer (source -> Bronze)
==================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the `BULK INSERT` command to load data from csv files to bronze tables.

Parameters:
  None.
 This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
==================================================================================
Ref
  - https://learn.microsoft.com/en-us/answers/questions/1280163/bulk-insert-permission-denied-error-when-importing
  - https://stackoverflow.com/questions/35633167/sql-server-2012-permissions-issue-during-bulk-load-of-csv-file 
==================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT REPLICATE('=', 25);
		PRINT 'Loading Bronze Layer';
		PRINT REPLICATE('=', 25);
	
		PRINT REPLICATE('-', 25);
		PRINT 'Loading CRM Tables';
		PRINT REPLICATE('-', 25);

		-- bronze.crm_cust_info
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>> Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';
		-- SELECT TOP 100 * FROM bronze.crm_cust_info;
		-- SELECT COUNT(*) FROM bronze.crm_cust_info;

		-- bronze.crm_pro_info
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_pro_info';
		TRUNCATE TABLE bronze.crm_pro_info;

		PRINT'>> Inserting Data into: bronze.crm_pro_info';
		BULK INSERT bronze.crm_pro_info
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';
		-- SELECT TOP 100 * FROM bronze.crm_pro_info;
		-- SELECT COUNT(*) FROM bronze.crm_pro_info;

		-- crm_sales_details
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>> Inserting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';

		-- SELECT TOP 100 * FROM bronze.crm_sales_details;
		-- SELECT COUNT(*) FROM bronze.crm_sales_details;

		PRINT REPLICATE('-', 25);
		PRINT 'Loading ERP Tables';
		PRINT REPLICATE('-', 25);

		-- erp_cust_az12
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>> Inserting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';

		-- SELECT TOP 100 * FROM bronze.erp_cust_az12;
		-- SELECT COUNT(*) FROM bronze.erp_cust_az12;

		-- erp_loc_a101
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
	
		PRINT'>> Inserting Data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';
		-- SELECT TOP 100 * FROM bronze.erp_loc_a101;
		-- SELECT COUNT(*) FROM bronze.erp_loc_a101;

		-- erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>> Inserting Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\sqladmin\Desktop\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '';
		-- SELECT TOP 100 * FROM bronze.erp_px_cat_g1v2;
		-- SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
	END TRY
	BEGIN CATCH
		PRINT REPLICATE('=', 25);
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR Message' + ERROR_MESSAGE();
		PRINT 'ERROR Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR State' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT REPLICATE('=', 25);
	END CATCH;
END;
