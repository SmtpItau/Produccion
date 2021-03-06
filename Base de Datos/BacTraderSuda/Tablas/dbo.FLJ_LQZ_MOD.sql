USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[FLJ_LQZ_MOD]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLJ_LQZ_MOD](
	[Marca] [char](1) NULL,
	[Instrumento] [char](20) NULL,
	[Moneda] [char](3) NULL,
	[Emisor] [char](10) NULL,
	[Nominal] [numeric](21, 8) NULL,
	[Tir] [numeric](19, 4) NULL,
	[Vpar] [numeric](19, 4) NULL,
	[Mt] [numeric](19, 4) NULL,
	[Custodia] [char](15) NULL,
	[ClaveDcv] [char](15) NULL,
	[TirCmp] [numeric](19, 4) NULL,
	[VparCmp] [numeric](19, 4) NULL,
	[MTCmp] [numeric](19, 4) NULL,
	[Utilidad] [numeric](19, 4) NULL,
	[Clasificacion] [char](15) NULL,
	[NumeroOP] [numeric](10, 0) NULL,
	[Correlativo] [numeric](3, 0) NULL,
	[Usuario] [char](15) NULL
) ON [PRIMARY]
GO
