USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBL_CarteraGarantia_20082015]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CarteraGarantia_20082015](
	[NumeroGarantia] [numeric](10, 0) NOT NULL,
	[IdEstadoGarantia] [int] NOT NULL,
	[FechaIngresoGarantia] [datetime] NOT NULL,
	[FechaVencimientoGarantia] [datetime] NOT NULL,
	[TipoMovimiento] [int] NOT NULL,
	[CodigoCliente] [int] NOT NULL,
	[NombreCliente] [varchar](50) NOT NULL,
	[ValorTotalGarantiaCLP] [numeric](21, 7) NOT NULL,
	[ValorTotalGarantiaUM] [numeric](21, 7) NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[IdTipoGarantia] [int] NOT NULL,
	[Id_RelacionGarantiaOperacion] [numeric](10, 0) NULL
) ON [PRIMARY]
GO
