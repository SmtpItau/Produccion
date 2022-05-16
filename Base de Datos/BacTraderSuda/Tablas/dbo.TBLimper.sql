USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBLimper]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLimper](
	[Cartera] [numeric](1, 0) NULL,
	[Instrumento] [varchar](10) NOT NULL,
	[Plazo_minimo] [numeric](6, 0) NULL,
	[Plazo_maximo] [numeric](6, 0) NULL
) ON [PRIMARY]
GO
