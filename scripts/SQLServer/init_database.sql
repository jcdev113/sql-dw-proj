/*
=================================================
Create Database and Schema
=================================================
Script Purpose: 
	This script creates a new database named 'DataWarehouse' affter checking if it is existing.
  If the database exists it will be dropped and recreated. Additionally, the script sets up three schemas 
  within the database: 'bronze', 'silver', and 'gold'.
    
WARNING:
	Executing the script will drop the entire 'DataWarehouse' if exists. 
  All the data previously in the db will be permanently removed. 
  Please proceed with caution and ensure full backups before running the script.
*/

USE master;
GO

-- Drop the db if it exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create 'DataWarehouse' db
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
