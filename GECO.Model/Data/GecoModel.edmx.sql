
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 08/18/2014 17:27:20
-- Generated from EDMX file: D:\Progetti\GecoGit\GECO.Model\Data\GecoModel.edmx
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

IF OBJECT_ID(N'[dbo].[FK_DocumentContent_Document]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DocumentContent] DROP CONSTRAINT [FK_DocumentContent_Document];
GO
IF OBJECT_ID(N'[dbo].[FK_DocumentContent_Content]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DocumentContent] DROP CONSTRAINT [FK_DocumentContent_Content];
GO
IF OBJECT_ID(N'[dbo].[FK_VideoContent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contents] DROP CONSTRAINT [FK_VideoContent];
GO
IF OBJECT_ID(N'[dbo].[FK_ContentAlbum]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contents] DROP CONSTRAINT [FK_ContentAlbum];
GO
IF OBJECT_ID(N'[dbo].[FK_AlbumPhoto]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Photos] DROP CONSTRAINT [FK_AlbumPhoto];
GO
IF OBJECT_ID(N'[dbo].[FK_News_inherits_Content]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contents_News] DROP CONSTRAINT [FK_News_inherits_Content];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_inherits_Content]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contents_Event] DROP CONSTRAINT [FK_Event_inherits_Content];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Contents]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contents];
GO
IF OBJECT_ID(N'[dbo].[VideoSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[VideoSet];
GO
IF OBJECT_ID(N'[dbo].[Albums]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Albums];
GO
IF OBJECT_ID(N'[dbo].[Photos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Photos];
GO
IF OBJECT_ID(N'[dbo].[Documents]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Documents];
GO
IF OBJECT_ID(N'[dbo].[Contents_News]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contents_News];
GO
IF OBJECT_ID(N'[dbo].[Contents_Event]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contents_Event];
GO
IF OBJECT_ID(N'[dbo].[DocumentContent]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DocumentContent];
GO

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
    [Text] nvarchar(max)  NOT NULL,
    [VideoId] uniqueidentifier  NULL,
    [MapUrl] nvarchar(100)  NULL,
    [AlbumId] uniqueidentifier  NULL
);
GO

-- Creating table 'VideoSet'
CREATE TABLE [dbo].[VideoSet] (
    [Id] uniqueidentifier  NOT NULL,
    [Url] nvarchar(150)  NULL,
    [EmbeddedCode] nvarchar(500)  NULL,
    [Name] nvarchar(100)  NOT NULL,
    [Description] nvarchar(300)  NOT NULL
);
GO

-- Creating table 'Albums'
CREATE TABLE [dbo].[Albums] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [AuthInfo_CreatedBy] nvarchar(50)  NOT NULL,
    [AuthInfo_Created] datetime  NOT NULL,
    [AuthInfo_ModifiedBy] nvarchar(50)  NOT NULL,
    [AuthInfo_Modified] datetime  NOT NULL
);
GO

-- Creating table 'Photos'
CREATE TABLE [dbo].[Photos] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [Path] nvarchar(300)  NOT NULL,
    [Description] nvarchar(300)  NOT NULL,
    [AlbumId] uniqueidentifier  NULL
);
GO

-- Creating table 'Documents'
CREATE TABLE [dbo].[Documents] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [Path] nvarchar(300)  NULL,
    [Description] nvarchar(300)  NULL
);
GO

-- Creating table 'Contents_News'
CREATE TABLE [dbo].[Contents_News] (
    [Date] datetime  NOT NULL,
    [ContentId] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Contents_Event'
CREATE TABLE [dbo].[Contents_Event] (
    [StartingDate] datetime  NOT NULL,
    [EndingDate] datetime  NOT NULL,
    [ContentId] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'DocumentContent'
CREATE TABLE [dbo].[DocumentContent] (
    [Documents_Id] uniqueidentifier  NOT NULL,
    [Contents_ContentId] uniqueidentifier  NOT NULL
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

-- Creating primary key on [Id] in table 'VideoSet'
ALTER TABLE [dbo].[VideoSet]
ADD CONSTRAINT [PK_VideoSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Albums'
ALTER TABLE [dbo].[Albums]
ADD CONSTRAINT [PK_Albums]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Photos'
ALTER TABLE [dbo].[Photos]
ADD CONSTRAINT [PK_Photos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Documents'
ALTER TABLE [dbo].[Documents]
ADD CONSTRAINT [PK_Documents]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [ContentId] in table 'Contents_News'
ALTER TABLE [dbo].[Contents_News]
ADD CONSTRAINT [PK_Contents_News]
    PRIMARY KEY CLUSTERED ([ContentId] ASC);
GO

-- Creating primary key on [ContentId] in table 'Contents_Event'
ALTER TABLE [dbo].[Contents_Event]
ADD CONSTRAINT [PK_Contents_Event]
    PRIMARY KEY CLUSTERED ([ContentId] ASC);
GO

-- Creating primary key on [Documents_Id], [Contents_ContentId] in table 'DocumentContent'
ALTER TABLE [dbo].[DocumentContent]
ADD CONSTRAINT [PK_DocumentContent]
    PRIMARY KEY CLUSTERED ([Documents_Id], [Contents_ContentId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Documents_Id] in table 'DocumentContent'
ALTER TABLE [dbo].[DocumentContent]
ADD CONSTRAINT [FK_DocumentContent_Document]
    FOREIGN KEY ([Documents_Id])
    REFERENCES [dbo].[Documents]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Contents_ContentId] in table 'DocumentContent'
ALTER TABLE [dbo].[DocumentContent]
ADD CONSTRAINT [FK_DocumentContent_Content]
    FOREIGN KEY ([Contents_ContentId])
    REFERENCES [dbo].[Contents]
        ([ContentId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DocumentContent_Content'
CREATE INDEX [IX_FK_DocumentContent_Content]
ON [dbo].[DocumentContent]
    ([Contents_ContentId]);
GO

-- Creating foreign key on [VideoId] in table 'Contents'
ALTER TABLE [dbo].[Contents]
ADD CONSTRAINT [FK_VideoContent]
    FOREIGN KEY ([VideoId])
    REFERENCES [dbo].[VideoSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_VideoContent'
CREATE INDEX [IX_FK_VideoContent]
ON [dbo].[Contents]
    ([VideoId]);
GO

-- Creating foreign key on [AlbumId] in table 'Contents'
ALTER TABLE [dbo].[Contents]
ADD CONSTRAINT [FK_ContentAlbum]
    FOREIGN KEY ([AlbumId])
    REFERENCES [dbo].[Albums]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ContentAlbum'
CREATE INDEX [IX_FK_ContentAlbum]
ON [dbo].[Contents]
    ([AlbumId]);
GO

-- Creating foreign key on [AlbumId] in table 'Photos'
ALTER TABLE [dbo].[Photos]
ADD CONSTRAINT [FK_AlbumPhoto]
    FOREIGN KEY ([AlbumId])
    REFERENCES [dbo].[Albums]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AlbumPhoto'
CREATE INDEX [IX_FK_AlbumPhoto]
ON [dbo].[Photos]
    ([AlbumId]);
GO

-- Creating foreign key on [ContentId] in table 'Contents_News'
ALTER TABLE [dbo].[Contents_News]
ADD CONSTRAINT [FK_News_inherits_Content]
    FOREIGN KEY ([ContentId])
    REFERENCES [dbo].[Contents]
        ([ContentId])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ContentId] in table 'Contents_Event'
ALTER TABLE [dbo].[Contents_Event]
ADD CONSTRAINT [FK_Event_inherits_Content]
    FOREIGN KEY ([ContentId])
    REFERENCES [dbo].[Contents]
        ([ContentId])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------