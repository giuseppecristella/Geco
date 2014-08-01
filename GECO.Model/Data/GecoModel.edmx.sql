
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/28/2014 18:24:36
-- Generated from EDMX file: D:\Progetti\GeCo\GECO.Model\GECO.Model\Data\GecoModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Geco];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Contents'
CREATE TABLE [dbo].[Contents] (
    [ContentId] uniqueidentifier  NOT NULL,
    [AuthInfo_CreatedBy] nvarchar(50)  NOT NULL,
    [AuthInfo_Created] datetime  NOT NULL,
    [AuthInfo_ModifiedBy] nvarchar(50)  NOT NULL,
    [AuthInfo_Modified] datetime  NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [ShortDescription] nvarchar(300)  NULL,
    [LongDescription] nvarchar(500)  NULL,
    [Text] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ContentId] in table 'Contents'
ALTER TABLE [dbo].[Contents]
ADD CONSTRAINT [PK_Contents]
    PRIMARY KEY CLUSTERED ([ContentId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------