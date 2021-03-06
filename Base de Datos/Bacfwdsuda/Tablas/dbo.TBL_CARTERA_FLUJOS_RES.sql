USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_CARTERA_FLUJOS_RES]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CARTERA_FLUJOS_RES](
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
	[Cfr_Estado] [char](2) NOT NULL,
 CONSTRAINT [PK_TBL_CARTERA_FLUJOS_RES] PRIMARY KEY CLUSTERED 
(
	[Cfr_Fecha_Evento] ASC,
	[Cfr_Numero_OPeracion] ASC,
	[Cfr_Correlativo] ASC,
	[Cfr_Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_numero_operacion]  DEFAULT (0) FOR [Cfr_Numero_OPeracion]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_correlativo]  DEFAULT (0) FOR [Cfr_Correlativo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_numero_credito]  DEFAULT (0) FOR [Cfr_Numero_Credito]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_numero_dividendo]  DEFAULT (0) FOR [Cfr_Numero_Dividendo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_plazo]  DEFAULT (0) FOR [Cfr_Plazo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_fecha_vencimiento]  DEFAULT ('') FOR [Cfr_Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_fecha_fijacion]  DEFAULT ('') FOR [Cfr_Fecha_Fijacion]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_monto_principal]  DEFAULT (0) FOR [Cfr_Monto_Principal]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_precio_contrato]  DEFAULT (0) FOR [Cfr_Precio_Contrato]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_precio_costo]  DEFAULT (0) FOR [Cfr_Precio_Costo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_monto_secundario]  DEFAULT (0) FOR [Cfr_Monto_Secundario]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_spread]  DEFAULT (0) FOR [Cfr_Spread]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_tasa_moneda_principal]  DEFAULT (0) FOR [Cfr_Tasa_Moneda_Principal]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_tasa_moneda_Secundaria]  DEFAULT (0) FOR [Cfr_Tasa_Moneda_Secundaria]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_precio_proyectado]  DEFAULT (0) FOR [Cfr_Precio_Proyectado]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_fecha_evento]  DEFAULT ('') FOR [Cfr_Fecha_Evento]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_fecha_proceso]  DEFAULT ('') FOR [Cfr_Fecha_Proceso]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_RES] ADD  CONSTRAINT [CT_cfr_estado]  DEFAULT ('') FOR [Cfr_Estado]
GO
