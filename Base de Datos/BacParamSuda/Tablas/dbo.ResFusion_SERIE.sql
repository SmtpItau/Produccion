USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ResFusion_SERIE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResFusion_SERIE](
	[secodigo] [decimal](5, 0) NOT NULL,
	[semascara] [char](12) NOT NULL,
	[seserie] [char](12) NOT NULL,
	[serutemi] [decimal](9, 0) NOT NULL,
	[sefecemi] [datetime] NULL,
	[sefecven] [datetime] NULL,
	[setasemi] [decimal](8, 4) NOT NULL,
	[setera] [decimal](8, 4) NOT NULL,
	[sebasemi] [decimal](5, 0) NOT NULL,
	[semonemi] [decimal](5, 0) NOT NULL,
	[secupones] [decimal](5, 0) NOT NULL,
	[sediavcup] [decimal](5, 0) NOT NULL,
	[sepervcup] [decimal](5, 2) NULL,
	[setipvcup] [char](1) NOT NULL,
	[seplazo] [decimal](5, 2) NULL,
	[setipamort] [decimal](5, 0) NOT NULL,
	[senumamort] [decimal](5, 0) NOT NULL,
	[seffijos] [char](1) NOT NULL,
	[sebascup] [decimal](5, 0) NOT NULL,
	[sedecs] [decimal](5, 0) NOT NULL,
	[secorte] [decimal](9, 0) NOT NULL,
	[setotalemitido] [float] NOT NULL,
	[primer_vcto_variable] [char](1) NOT NULL,
	[primer_vencimiento] [datetime] NOT NULL,
	[tipo_letra] [char](1) NOT NULL
) ON [PRIMARY]
GO
