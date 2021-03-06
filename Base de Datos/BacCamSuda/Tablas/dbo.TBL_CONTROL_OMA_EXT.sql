USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_CONTROL_OMA_EXT]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONTROL_OMA_EXT](
	[Fecha] [datetime] NULL,
	[FolioContrato] [numeric](9, 0) NULL,
	[TipoTransaccion] [char](1) NULL,
	[MtoDolares] [numeric](21, 4) NULL,
	[TipoCambio] [numeric](21, 4) NULL,
	[MtoPesos] [numeric](21, 0) NULL,
	[CodigoOMA] [numeric](5, 0) NULL,
	[Estado] [char](1) NULL,
	[RutCliente] [numeric](9, 0) NULL,
	[NombreCliente] [varchar](50) NULL,
	[NemoCliente] [varchar](100) NULL,
	[Origen] [varchar](20) NULL,
	[FechaControl] [datetime] NULL
) ON [PRIMARY]
GO
