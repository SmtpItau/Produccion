USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_LIMITES_TASAMAXCONV]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_LIMITES_TASAMAXCONV](
	[moneda] [numeric](5, 0) NULL,
	[rango] [numeric](5, 0) NULL,
	[plazo] [numeric](5, 0) NULL,
	[tasmax] [numeric](9, 4) NULL
) ON [PRIMARY]
GO
