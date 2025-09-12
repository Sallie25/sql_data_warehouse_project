 /*-- Data Profiling - Explore the data to identify column names and data types
 =============================================================================
  Bronze Naming convention rules
  ================================================
  1. All names must start with the source name, and table names must match their
original names without renaming.
  2. <sourcesystem>_<entity>
    - <sourcesystem>: Name of source system such as (crm, erp) in our case study.
    - <entity>: Exact table names from the source system.
    - Example: crm_customer_info -- Customer information from the CRM system.
 ================================================================================================
 
 -- Create SQL DDL scripts for ALL CSV files in the CRM and ERP systems for the Bronze Layer

===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

-- crm source systems tables
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL -- This means if it returns a number
      DROP TABLE bronze.crm_prd_info; -- Then, drop it before running the next line of scripts that recreates the table
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id  INT,
    prd_key  NVARCHAR(50),
    prd_nm   NVARCHAR(50),
    pd_cost  INT,
    prd_line  NVARCHAR(50),
    prd_start_dt  DATETIME,
    prd_end_dt    DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
     DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

-- erp source sytems tables
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO


