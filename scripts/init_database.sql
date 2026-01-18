/* 
========================================
Create Database and Schemas
========================================

Script Purpose:
	This script creates a new database and three schemas.

*/
--Create Database 'DataWarehouse'

USE master;

CREATE DATABASE DataWarehouse;

USE DataWarehouse;

--Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

