USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[paso_renta_ib]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso_renta_ib](
	[fecproc] [datetime] NULL,
	[tipoper] [char](3) NULL,
	[numdocu] [numeric](10, 0) NULL,
	[instser] [char](10) NULL,
	[moneda] [numeric](3, 0) NULL,
	[nominal] [numeric](19, 4) NULL,
	[valcomp] [numeric](19, 4) NULL,
	[valcomu] [numeric](19, 4) NULL,
	[fecini] [datetime] NULL,
	[fecven] [datetime] NULL,
	[rutcli] [numeric](9, 0) NULL,
	[codcli] [numeric](9, 0) NULL,
	[tasa] [numeric](9, 4) NULL,
	[tasaefec] [numeric](9, 4) NULL,
	[tasacam] [numeric](9, 4) NULL,
	[basetasa] [numeric](3, 0) NULL,
	[resultado] [numeric](19, 4) NULL,
	[forpag] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
