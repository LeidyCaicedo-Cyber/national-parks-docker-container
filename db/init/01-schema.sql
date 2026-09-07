-- 01-schema.sql - creates the database and the Parks table.
-- Runs when the db-init container executes this script.
-- Idempotent: safe to run again (IF NOT EXISTS checks).

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ParksDb')
BEGIN
    CREATE DATABASE ParksDb;
END
GO

USE ParksDb;
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Parks')
BEGIN
    CREATE TABLE Parks (
        Id          INT IDENTITY(1,1) PRIMARY KEY,
        Name        NVARCHAR(120) NOT NULL,
        State       NVARCHAR(2)   NOT NULL,
        Established INT           NOT NULL,
        Acres       INT           NOT NULL,
        Description NVARCHAR(300) NOT NULL,
        CreatedAt   DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO
