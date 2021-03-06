USE [Bacfwdsuda]
GO
/****** Object:  Table [bacuser].[TBL_CARTERA_FLUJOS101117]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[TBL_CARTERA_FLUJOS101117](
	[Ctf_Numero_OPeracion] [numeric](10, 0) NOT NULL,
	[Ctf_Correlativo] [int] NOT NULL,
	[Ctf_Numero_Credito] [numeric](10, 0) NOT NULL,
	[Ctf_Numero_Dividendo] [numeric](10, 0) NOT NULL,
	[Ctf_Plazo] [int] NOT NULL,
	[Ctf_Fecha_Vencimiento] [datetime] NOT NULL,
	[Ctf_Fecha_Fijacion] [datetime] NOT NULL,
	[Ctf_Monto_Principal] [numeric](21, 4) NOT NULL,
	[Ctf_Precio_Contrato] [numeric](21, 4) NOT NULL,
	[Ctf_Precio_Costo] [numeric](21, 4) NOT NULL,
	[Ctf_Monto_Secundario] [numeric](21, 4) NOT NULL,
	[Ctf_Spread] [numeric](21, 4) NOT NULL,
	[Ctf_Tasa_Moneda_Principal] [float] NOT NULL,
	[Ctf_Tasa_Moneda_Secundaria] [float] NOT NULL,
	[Ctf_Precio_Proyectado] [float] NOT NULL,
	[Ctf_Valor_Razonable_Activo] [float] NOT NULL,
	[Ctf_Valor_Razonable_Pasivo] [float] NOT NULL,
	[Ctf_Valor_Razonable] [float] NOT NULL,
	[Ctf_Articulo84] [float] NOT NULL
) ON [PRIMARY]
GO
