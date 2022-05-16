USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCIU]    Script Date: 13-05-2022 12:16:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCIU](
	[cod_pai] [numeric](6, 0) NOT NULL,
	[cod_ciu] [numeric](6, 0) NOT NULL,
	[cod_com] [numeric](6, 0) NOT NULL,
	[nom_ciu] [char](40) NOT NULL
) ON [PRIMARY]
GO
