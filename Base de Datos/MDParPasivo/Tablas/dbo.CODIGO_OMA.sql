USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CODIGO_OMA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_OMA](
	[codigo_numerico] [numeric](3, 0) NOT NULL,
	[codigo_caracter] [char](10) NOT NULL,
	[glosa] [char](50) NOT NULL
) ON [PRIMARY]
GO
