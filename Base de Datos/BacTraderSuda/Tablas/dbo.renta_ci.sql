USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[renta_ci]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[renta_ci](
	[fecproc] [datetime] NULL,
	[tipoper] [char](3) NULL,
	[numoper] [numeric](10, 0) NULL,
	[moneda] [numeric](3, 0) NULL,
	[valinip] [numeric](19, 4) NULL,
	[valvtop] [numeric](19, 4) NULL,
	[fecini] [datetime] NULL,
	[fecven] [datetime] NULL,
	[rutcli] [numeric](9, 0) NULL,
	[codcli] [numeric](9, 0) NULL,
	[tasa] [numeric](9, 4) NULL,
	[tasaefec] [numeric](9, 4) NULL,
	[tasacam] [numeric](9, 4) NULL,
	[basetasa] [numeric](3, 0) NULL,
	[resultado] [float] NULL,
	[forpagi] [numeric](3, 0) NULL,
	[forpagv] [numeric](3, 0) NULL,
	[dif_flo] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
