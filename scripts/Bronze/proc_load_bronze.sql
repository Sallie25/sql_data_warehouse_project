/*-- Developing SQL load Scripts for the Bronze layer
============================================================
The method that we are going to use to load the data from the source
to the data ware house is called;-
---------------------------
	- BULK INSERT
---------------------------
Bulk insert is a method of loading massive amount of data very quickly from files like
csv files or textfiles, directly into a database.
It is diffent from the normal classical insert where the data is inserted row by row.
=========================================================================================================

-----------------------------------------------------------------------------------------------------------
TRUNCATE AND THEN LOAD - This is what we call *FULL LOAD*
- We truncate before loading in other to avoid loading the same data twice.
------------------------------------------------------------------------------------------------------------

================================================================

Creating stored Procedure

- We use stored procedure to save frequently used sql code in stored procedures in database
-------------------------------------------------------------------------------------------------------------
ADD PRINTS
- We add Prints to track execution, debug issues, and understand its flows
=================================================================

===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
--EXEC bronze.load_bronze;
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,@batch_end_time DATETIME ;-- Created two datetime variables start_time and end_time.

	BEGIN TRY -- Handles the errors in our stored procedure
		SET @batch_start_time = GETDATE(); -- This will get the exact time when we start loading the bronze layer
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================================';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------------------------------------------';
	
		SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		-- Truncate and bulk insert load for crm_cust_info table
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;


		PRINT '>> Insering Data Info: bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,-- Telling SQL where it would find the actual dat, so, it should skip the first data
			FIELDTERMINATOR = ',',-- Specifing the delimeter in which are data is seperated with.
			TABLOCK-- As SQL is loading the entire table it is going to go and lock it.
		);
		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.crm_cust_info Table: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';


		-- Quality Checks

		--	# Check to see if we have data in each column
		--  # Check to see if we have data in the correct column.
		--  #This is to ensure that has not shifted.
		-- Also count the rows in the table.
	/*
		SELECT * FROM bronze.crm_cust_info;
		SELECT COUNT(*) FROM bronze.crm_cust_info;
	*/
	     
		 SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		 -- Truncate and bulk insert load for crm_prd_info table
		 PRINT '>> Truncating Table: bronze.crm_prd_info';
		 TRUNCATE TABLE bronze.crm_prd_info;

		 PRINT '>> Inserting Data Into: bronze.crm_prd_info';

		 BULK INSERT bronze.crm_prd_info
		 FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		 WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.crm_prd_info Table: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';


	/*
		-- QA checks
		SELECT * FROM bronze.crm_prd_info;
		SELECT COUNT(*) FROM bronze.crm_prd_info;
	*/

	     SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		 -- Truncate and bulk insert load for crm_sales_details table
		 PRINT '>> Truncating Table: bronze.crm_sales_details';
		 TRUNCATE TABLE bronze.crm_sales_details;

		 PRINT '>> Inserting Data Into: bronze.crm_sales_details';

		 BULK INSERT bronze.crm_sales_details
		 FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		 WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.crm_sales_details: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';


	/*
		-- QA checks
		SELECT * FROM bronze.crm_sales_details;
		SELECT COUNT(*) FROM bronze.crm_sales_details;
	*/

		PRINT '-----------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-----------------------------------------------------';

		SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		-- Truncate and bulk insert load for erp_loc_a101 table
		 PRINT '>> Truncating Table: bronze.erp_loc_a101';
		 TRUNCATE TABLE bronze.erp_loc_a101;

		 PRINT '>> Inserting Data Into: bronze.erp_loc_a101';

		 BULK INSERT bronze.erp_loc_a101
		 FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		 WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.erp_loc_a101: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

	/*

		-- QA checks
		SELECT * FROM bronze.erp_loc_a101;
		SELECT COUNT(*) FROM bronze.erp_loc_a101;
	*/
	     SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		-- Truncate and bulk insert load for erp_cust_az12 table
		 PRINT '>> Truncating Table: bronze.erp_cust_az12';
		 TRUNCATE TABLE bronze.erp_cust_az12;

		 PRINT '>> Inserting Data Into: bronze.erp_cust_az12';

		 BULK INSERT bronze.erp_cust_az12
		 FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		 WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.erp_cust_az12: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

	/*
		-- QA checks
		SELECT * FROM bronze.erp_cust_az12;
		SELECT COUNT(*) FROM bronze.erp_cust_az12;
	*/
	    SET @start_time = GETDATE(); -- This will get the exact time when we start loading this table
		-- Truncate and bulk insert load for erp_px_cat_g1v2 table
		 PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		 TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		 PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		 BULK INSERT bronze.erp_px_cat_g1v2
		 FROM 'C:\Users\hp\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		 WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE(); -- This will get the exact time when we stop loading this table
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load this table
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '>> Load Duration for bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFf(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
	    PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	/*
	    
		-- QA checks
		 SELECT * FROM bronze.erp_px_cat_g1v2;
		 SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
	*/

	    SET @batch_end_time = GETDATE(); -- This will get the exact time when we stop loading this layer
		-- Based the start and end time values, we are going to calculate the duration or time it takes to load the layer
		-- We do this using the DATEDIFF functon. It calculates the difference beween two dates and
		-- ... it returns days,months or years.
		PRINT '============================================================================================'
		PRINT 'Loading Bronze Layer is Completed'
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFf(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY
	-- Here we design the output we want to see if the try block doesnt catch the error
		BEGIN CATCH
			PRINT '=========================================';
			PRINT 'ERROR OCCURED WHILST LOADING BRONZE LAYER';
			PRINT 'Error Message' + ERROR_MESSAGE();
			PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
            PRINT '=========================================';
			
		END CATCH
END

/*
==============================================================================================================
ERROR HANDLING
==============================================================================================================
TRY...CATCH - Here SQL runs the TRY block, and if it fails, it runs the CATCH block to handle the error.
==============================================================================================================
TRACK ETL DURATION
- This helps to Identify bottlenecks, optimize performance, monitor trends, detect issues
==============================================================================================================
DURATION OF LOADING Table calculated
==============================================================================================================
DURATION OF LOADING Bronze Layer (The Entire Batch) Calculated
==============================================================================================================


*/
