USE [BacCamSuda]
GO
/****** Object:  Table [bacuser].[TBL_OPERACIONES_OMA_EXTERNAS_100816]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[TBL_OPERACIONES_OMA_EXTERNAS_100816](
	[Fecha] [datetime] NOT NULL,
	[FolioContrato] [numeric](9, 0) NOT NULL,
	[TipoTransaccion] [char](1) NOT NULL,
	[MtoDolares] [numeric](21, 4) NOT NULL,
	[TipoCambio] [numeric](21, 4) NOT NULL,
	[MtoPesos] [numeric](21, 0) NOT NULL,
	[CodigoOMA] [numeric](5, 0) NOT NULL,
	[Estado] [char](1) NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[NombreCliente] [varchar](50) NOT NULL,
	[Notificada] [bit] NULL,
	[SpreadTrading] [numeric](21, 4) NULL,
	[SpreadComercial] [numeric](21, 4) NULL,
	[Origen] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
