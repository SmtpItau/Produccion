USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDREG]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDREG](
	[cod_pai] [numeric](3, 0) NOT NULL,
	[cod_reg] [numeric](3, 0) NOT NULL,
	[nom_reg] [char](40) NOT NULL
) ON [PRIMARY]
GO
