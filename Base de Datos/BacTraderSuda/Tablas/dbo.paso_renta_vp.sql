USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[paso_renta_vp]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso_renta_vp](
	[fecproc] [datetime] NULL,
	[numdocu] [numeric](10, 0) NULL,
	[numoper] [numeric](10, 0) NULL,
	[correla] [numeric](10, 0) NULL,
	[instser] [char](10) NULL,
	[mascara] [char](10) NULL,
	[moneda] [numeric](3, 0) NULL,
	[nominal] [numeric](19, 4) NULL,
	[vpresen] [numeric](19, 4) NULL,
	[vventa] [numeric](19, 4) NULL,
	[fecven] [datetime] NULL,
	[rutcli] [numeric](9, 0) NULL,
	[codcli] [numeric](9, 0) NULL,
	[tasa] [numeric](9, 4) NULL,
	[tasacam] [numeric](9, 4) NULL,
	[basetasa] [numeric](3, 0) NULL,
	[resultado] [float] NULL,
	[seriado] [char](1) NULL,
	[codigo] [numeric](3, 0) NULL,
	[forpago] [numeric](3, 0) NULL,
	[restxventa] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
