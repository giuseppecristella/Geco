USE [MateraArredamenti]
GO
--/****** Object:  User [peppe]    Script Date: 22/09/2014 22:30:11 ******/
CREATE USER [peppe] FOR LOGIN [peppe] WITH DEFAULT_SCHEMA=[MSSql34290]
GO
ALTER ROLE [db_owner] ADD MEMBER [peppe]
GO
/****** Object:  Schema [MSSql34290]    Script Date: 22/09/2014 22:30:11 ******/
CREATE SCHEMA [MSSql34290]
GO
/****** Object:  StoredProcedure [MSSql34290].[AddAlbum]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [MSSql34290].[AddAlbum]
	@Caption nvarchar(50),
	@IsPublic bit
AS
	INSERT INTO [Albums] ([Caption],[IsPublic]) VALUES (@Caption, @IsPublic)
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[AddPhoto]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[AddPhoto]
		@AlbumID int,
		@Caption nvarchar(50),
		@BytesOriginal image,
		@BytesFull image,
		@BytesPoster image,
		@BytesThumb image
AS
	INSERT INTO [Photos] (
		[AlbumID],
		[BytesOriginal],
		[Caption],
		[BytesFull],
		[BytesPoster],
		[BytesThumb] )
	VALUES (
		@AlbumID,
		@BytesOriginal,
		@Caption,
		@BytesFull,
		@BytesPoster,
		@BytesThumb )
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[EditAlbum]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[EditAlbum]
	@Caption nvarchar(50),
	@IsPublic bit,
	@AlbumID int
AS
	UPDATE [Albums] 
	SET 
		[Caption] = @Caption, 
		[IsPublic] = @IsPublic 
	WHERE 
		[AlbumID] = @AlbumID
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[EditPhoto]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[EditPhoto]
	@Caption nvarchar(50),
	@PhotoID int
AS
	UPDATE [Photos]
	SET [Caption] = @Caption
	WHERE [PhotoID]	= @PhotoID
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[GetAlbums]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[GetAlbums]
	@IsPublic bit
AS
	SELECT 
		[Albums].[AlbumID], 
		[Albums].[Caption], 
		[Albums].[IsPublic], 
		Count([Photos].[PhotoID]) AS NumberOfPhotos 
	FROM [Albums] LEFT JOIN [Photos] 
		ON [Albums].[AlbumID] = [Photos].[AlbumID] 
	WHERE
		([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	GROUP BY 
		[Albums].[AlbumID], 
		[Albums].[Caption], 
		[Albums].[IsPublic]
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[GetFirstPhoto]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[GetFirstPhoto]
	@AlbumID int,
	@Size int,
	@IsPublic bit
AS
	IF @Size = 1
		SELECT TOP 1 [BytesThumb] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [Albums].[AlbumID] = @AlbumID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 2
		SELECT TOP 1 [BytesPoster] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [Albums].[AlbumID] = @AlbumID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 3
		SELECT TOP 1 [BytesFull] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [Albums].[AlbumID] = @AlbumID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 4
		SELECT TOP 1 [BytesOriginal] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [Albums].[AlbumID] = @AlbumID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE
		SELECT TOP 1 [BytesPoster] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [Albums].[AlbumID] = @AlbumID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[GetNonEmptyAlbums]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[GetNonEmptyAlbums]
AS
	SELECT 
		[Albums].[AlbumID]
	FROM [Albums] LEFT JOIN [Photos] 
		ON [Albums].[AlbumID] = [Photos].[AlbumID] 
	WHERE
		[Albums].[IsPublic] = 1
	GROUP BY 
		[Albums].[AlbumID], 
		[Albums].[Caption], 
		[Albums].[IsPublic]
	HAVING
		Count([Photos].[PhotoID]) > 0
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[GetPhoto]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[GetPhoto]
	@PhotoID int,
	@Size int,
	@IsPublic bit
AS
	IF @Size = 1
		SELECT TOP 1 [BytesThumb] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [PhotoID] = @PhotoID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 2
		SELECT TOP 1 [BytesPoster] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [PhotoID] = @PhotoID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 3
		SELECT TOP 1 [BytesFull] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [PhotoID] = @PhotoID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE IF @Size = 4
		SELECT TOP 1 [BytesOriginal] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [PhotoID] = @PhotoID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
	ELSE
		SELECT TOP 1 [BytesPoster] FROM [Photos] LEFT JOIN [Albums] ON [Albums].[AlbumID] = [Photos].[AlbumID] WHERE [PhotoID] = @PhotoID AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[GetPhotos]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[GetPhotos]
	@AlbumID int,
	@IsPublic bit
AS
	SELECT *
	FROM [Photos] LEFT JOIN [Albums]
		ON [Albums].[AlbumID] = [Photos].[AlbumID] 
	WHERE [Photos].[AlbumID] = @AlbumID
		AND ([Albums].[IsPublic] = @IsPublic OR [Albums].[IsPublic] = 1)
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[RemoveAlbum]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[RemoveAlbum]
	@AlbumID int
AS
	DELETE FROM [Albums] WHERE [AlbumID] = @AlbumID
RETURN


GO
/****** Object:  StoredProcedure [MSSql34290].[RemovePhoto]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MSSql34290].[RemovePhoto]
	@PhotoID int
AS
	DELETE FROM [Photos]
	WHERE [PhotoID]	= @PhotoID
RETURN


GO
/****** Object:  Table [MSSql34290].[Albums]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MSSql34290].[Albums](
	[AlbumID] [int] NOT NULL,
	[Caption] [nvarchar](50) NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[NewsEventoID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [MSSql34290].[Aree]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Aree](
	[AreaID] [int] NOT NULL,
	[AreaDescrizione] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Aziende]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Aziende](
	[Titolo] [varchar](50) NULL,
	[Descrizione] [text] NULL,
	[PathVideo] [varchar](50) NULL,
	[IdAzienda] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Giornali]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Giornali](
	[IdGiornale] [int] NOT NULL,
	[TitoloGiornale] [varchar](50) NULL,
	[DescGiornale] [varchar](100) NULL,
	[PathGiornale] [varchar](250) NOT NULL,
	[PathCopertina] [varchar](250) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Marche]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Marche](
	[MarcaID] [int] NOT NULL,
	[MarcaDescrizione] [varchar](max) NULL,
	[MarcaIDProduttore] [nchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[NewsEventi]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[NewsEventi](
	[News_ID] [int] NOT NULL,
	[Fonte] [varchar](100) NOT NULL,
	[Titolo] [varchar](100) NOT NULL,
	[Testo] [text] NOT NULL,
	[Data] [datetime] NOT NULL,
	[Autore] [varchar](100) NULL,
	[Descrizione] [text] NULL,
	[Tipo] [varchar](50) NULL,
	[UrlFotoHome] [varchar](max) NULL,
	[Allegati] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[NewsLetter]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[NewsLetter](
	[email] [varchar](max) NULL,
	[idUtente] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Outlet]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Outlet](
	[ProdottoID] [int] NOT NULL,
	[ProdottoNome] [varchar](50) NULL,
	[ProdottoDescHome] [varchar](50) NULL,
	[ProdottoDescScheda] [varchar](max) NULL,
	[ProdottoPrezzo] [decimal](18, 0) NULL,
	[ProdottoPrezzoSconto] [decimal](18, 0) NULL,
	[ProdottoInVetrina] [bit] NULL,
	[ProdottoFoto] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Photos]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MSSql34290].[Photos](
	[PhotoID] [int] NOT NULL,
	[AlbumID] [int] NOT NULL,
	[Caption] [nvarchar](50) NOT NULL,
	[BytesOriginal] [image] NOT NULL,
	[BytesFull] [image] NOT NULL,
	[BytesPoster] [image] NOT NULL,
	[BytesThumb] [image] NOT NULL,
	[Ordine] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [MSSql34290].[sysdiagrams]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[sysdiagrams](
	[name] [nvarchar](128) NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[Tipologia]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[Tipologia](
	[TipologiaID] [int] NOT NULL,
	[TipologiaAreaID] [int] NOT NULL,
	[TipologiaDescrizione] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [MSSql34290].[UtentiOutlet]    Script Date: 22/09/2014 22:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [MSSql34290].[UtentiOutlet](
	[ID_UtenteOutlet] [int] NOT NULL,
	[Nome_UtenteOutlet] [varchar](50) NOT NULL,
	[Cognome_UtenteOutlet] [varchar](50) NOT NULL,
	[Email_UtenteOutlet] [varchar](50) NOT NULL,
	[Tel_UtenteOutlet] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
