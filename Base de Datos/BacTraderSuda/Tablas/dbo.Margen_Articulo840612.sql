USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Margen_Articulo840612]    Script Date: 13-05-2022 12:16:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Margen_Articulo840612](
	[Numdocu] [numeric](10, 0) NULL,
	[Numoper] [numeric](10, 0) NULL,
	[Correla] [numeric](3, 0) NULL,
	[Modulo] [char](3) NULL,
	[Fec_Proc] [datetime] NULL,
	[RutDeudor] [numeric](9, 0) NULL,
	[Instrumento] [char](20) NULL,
	[Mascara] [char](20) NULL,
	[Nominal] [numeric](19, 4) NULL,
	[Fecha_compra] [datetime] NULL,
	[Fecha_emi] [datetime] NULL,
	[Seriado] [char](1) NULL,
	[Codigo] [numeric](5, 0) NULL,
	[Tir] [numeric](19, 4) NULL,
	[Moneda] [numeric](5, 0) NULL,
	[Tipoper] [char](3) NULL,
	[Monto] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
