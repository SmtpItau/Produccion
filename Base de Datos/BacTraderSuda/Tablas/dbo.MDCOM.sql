USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCOM]    Script Date: 13-05-2022 12:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCOM](
	[cod_pai] [numeric](3, 0) NOT NULL,
	[cod_com] [numeric](3, 0) NOT NULL,
	[nom_com] [char](40) NOT NULL
) ON [PRIMARY]
GO
