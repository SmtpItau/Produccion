USE [BacLineas]
GO
/****** Object:  Table [dbo].[DWT_LineasDRV]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DWT_LineasDRV](
	[nNumeroOperacion] [numeric](7, 0) NULL,
	[nRutCliente] [numeric](10, 0) NULL,
	[nCodigoCliente] [numeric](3, 0) NULL,
	[nMontoCorporativo] [numeric](21, 4) NULL,
	[nSistema] [varchar](10) NULL,
	[nProducto] [varchar](10) NULL,
	[nMetodologia] [int] NULL,
	[nPlazo] [int] NULL,
	[nfechavencimiento] [datetime] NULL,
	[nPadreHijo] [numeric](1, 0) NULL,
	[nMonedaLineaSistema] [numeric](5, 0) NULL,
	[nMonedaLineaGeneral] [numeric](5, 0) NULL,
	[nMontoCorporativoLS] [float] NULL,
	[nMontoCorporativoLG] [float] NULL
) ON [PRIMARY]
GO
