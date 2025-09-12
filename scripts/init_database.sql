/*
=============================================================
Create Database and Schemas
=============================================================

What Is a Database?
----------------------------------------------------------------
A database is a structured collection of data that is stored and accessed electronically. 

It’s designed to efficiently store, retrieve, and manage data.

Think of it as the entire system where data lives.

It contains schemas, which are like compartments or folders that group related objects together.
================================================================================================

What Is a Schema?
---------------------------------------------------------------------------------------------------
A schema is a logical grouping within a database. It helps organize database objects such as:

Tables (where actual data is stored)

Views (virtual tables based on queries)

Stored procedures (predefined operations)

Indexes (for faster searching)

So if you’re working with a database for a school system:

The database might be called SchoolDB

Inside it, you might have schemas like Students, Teachers, and Courses

Each schema contains tables and other objects relevant to that category.


Hence, Schemas are like folders or containers that helps us keep things organize.
As we had decided in the Data architecture to use the medallion type, we would be having three layers 
hence we woud be creating three schemas. The bronze,silver and gold.

===========================================================================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


USE master; -- System database for creating other databases.
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO 

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO -- This is like a seperator, that seperates batches when working with multiple SQL statements.


CREATE SCHEMA silver;
GO


CREATE SCHEMA gold;
GO

-- Now, we can start developing each layer individually.
