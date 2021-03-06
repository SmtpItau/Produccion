USE [Bacfwdsuda]
GO
/****** Object:  Table [bacuser].[TBL_CARTERA_FLUJOS_RES101117]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[TBL_CARTERA_FLUJOS_RES101117](
	[Cfr_Numero_OPeracion] [numeric](10, 0) NOT NULL,
	[Cfr_Correlativo] [int] NOT NULL,
	[Cfr_Numero_Credito] [numeric](10, 0) NOT NULL,
	[Cfr_Numero_Dividendo] [numeric](10, 0) NOT NULL,
	[Cfr_Plazo] [int] NOT NULL,
	[Cfr_Fecha_Vencimiento] [datetime] NOT NULL,
	[Cfr_Fecha_Fijacion] [datetime] NOT NULL,
	[Cfr_Monto_Principal] [numeric](21, 4) NOT NULL,
	[Cfr_Precio_Contrato] [numeric](21, 4) NOT NULL,
	[Cfr_Precio_Costo] [numeric](21, 4) NOT NULL,
	[Cfr_Monto_Secundario] [numeric](21, 4) NOT NULL,
	[Cfr_Spread] [numeric](21, 4) NOT NULL,
	[Cfr_Tasa_Moneda_Principal] [float] NOT NULL,
	[Cfr_Tasa_Moneda_Secundaria] [float] NOT NULL,
	[Cfr_Precio_Proyectado] [float] NOT NULL,
	[Cfr_Fecha_Evento] [datetime] NOT NULL,
	[Cfr_Fecha_Proceso] [datetime] NOT NULL,
	[Cfr_Estado] [char](2) NOT NULL
) ON [PRIMARY]
GO
