/*
Bronze Layer

This script contains Data Loading (ETL Ingestion) operations used to  populate Bronze layer tables in SQL Server. 
It loads raw data extracted from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) 
source systems into staging tables without applying transformations. 

parameters
  none
It does not return any values
EXEC bronze.load_bronze
is used to execute (run) a stored procedure named load_bronze that exists inside the bronze schema.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @StartTime DATETIME,@EndTime DATETIME, @batchStartTime DATETIME,@batchEndTime DATETIME
	BEGIN TRY
	SET @batchStartTime=GETDATE()
		PRINT('=============================================================================')
		PRINT('creating the bronze layer')
		PRINT('=============================================================================')
		--------------------------------------------------------------------------------------
		PRINT('------------------------------------------------------------------------------')
		PRINT('creating the  CRM table')
		PRINT('------------------------------------------------------------------------------')
		---------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('>> Truncating table: bronze.crm_cust_info')
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT('Inserting the data into: bronze.crm_cust_info')
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @EndTime=GETDATE()
		PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		--------------------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('>> Truncating table: bronze.crm_prd_info')
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT('Inserting the data into: bronze.crm_prd_info')
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @EndTime=GETDATE()
		PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		---------------------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('>> Truncating table: bronze.crm_sales_details')
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT('Inserting the data into:  bronze.crm_sales_details')
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)

		SET @EndTime=GETDATE()
	PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		--------------------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('=============================================================================')
		PRINT('creating the  ERP table')
		PRINT('=============================================================================')
		PRINT('>> Truncating table: bronze.erp_LOC_A101')
		TRUNCATE TABLE bronze.erp_LOC_A101
		PRINT('Inserting the data into:  bronze.erp_LOC_A101')
		BULK INSERT bronze.erp_LOC_A101
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)

		SET @EndTime=GETDATE()
	PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		---------------------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('>> Truncating table: bronze.erp_CUST_AZ12')
		TRUNCATE TABLE bronze.erp_CUST_AZ12
		PRINT('Inserting the data into: bronze.erp_CUST_AZ12')
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)

		SET @EndTime=GETDATE()
	PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		-------------------------------------------------------------------------------------------------------
		SET @StartTime=GETDATE()
		PRINT('>> Truncating table: bronze.erp_PX_CAT_G1V2')
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2
		PRINT('Inserting the data into: bronze.erp_PX_CAT_G1V2')
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'D:\pc\DATABASES\FILESS\sql-wharehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @EndTime=GETDATE()
		PRINT('time for loading data is '+ CAST( DATEDIFF(second,@StartTime,@EndTime) AS NVARCHAR)+ ' seconds')
		SET @batchEndTime=GETDATE()
		PRINT('=============================================================================')

		PRINT('Loading Bronze layer is complete')
		PRINT('time for loading bronze layer is '+ CAST( DATEDIFF(second,@batchStartTime,@batchEndTime) AS NVARCHAR)+ ' seconds')
		
	END TRY
	BEGIN CATCH
	PRINT('=============================================================================')
	PRINT('Error occured durring the loading of bronze layer')
	PRINT('error massage'+ ERROR_MESSAGE())
	PRINT('error massage'+ CAST( ERROR_NUMBER() AS NVARCHAR))
	PRINT('error massage'+ CAST(ERROR_MESSAGE() AS NVARCHAR))
	END CATCH
END
