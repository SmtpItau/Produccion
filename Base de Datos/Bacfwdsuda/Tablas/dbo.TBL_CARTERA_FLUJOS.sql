USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_CARTERA_FLUJOS]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CARTERA_FLUJOS](
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
	[Ctf_Articulo84] [float] NOT NULL,
 CONSTRAINT [PK_TBL_CARTERA_FLUJO] PRIMARY KEY CLUSTERED 
(
	[Ctf_Numero_OPeracion] ASC,
	[Ctf_Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_numero_operacion]  DEFAULT (0) FOR [Ctf_Numero_OPeracion]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_correlativo]  DEFAULT (0) FOR [Ctf_Correlativo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_numero_credito]  DEFAULT (0) FOR [Ctf_Numero_Credito]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_numero_dividendo]  DEFAULT (0) FOR [Ctf_Numero_Dividendo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_plazo]  DEFAULT (0) FOR [Ctf_Plazo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_fecha_vencimiento]  DEFAULT ('') FOR [Ctf_Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_fecha_fijacion]  DEFAULT ('') FOR [Ctf_Fecha_Fijacion]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_monto_principal]  DEFAULT (0) FOR [Ctf_Monto_Principal]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_precio_contrato]  DEFAULT (0) FOR [Ctf_Precio_Contrato]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_precio_costo]  DEFAULT (0) FOR [Ctf_Precio_Costo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_monto_secundario]  DEFAULT (0) FOR [Ctf_Monto_Secundario]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_spread]  DEFAULT (0) FOR [Ctf_Spread]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_tasa_moneda_principal]  DEFAULT (0) FOR [Ctf_Tasa_Moneda_Principal]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_tasa_moneda_Secundaria]  DEFAULT (0) FOR [Ctf_Tasa_Moneda_Secundaria]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_precio_proyectado]  DEFAULT (0) FOR [Ctf_Precio_Proyectado]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_valor_razonable_activo]  DEFAULT (0) FOR [Ctf_Valor_Razonable_Activo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_valor_razonable_pasivo]  DEFAULT (0) FOR [Ctf_Valor_Razonable_Pasivo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_valor_razonable]  DEFAULT (0) FOR [Ctf_Valor_Razonable]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS] ADD  CONSTRAINT [CT_ctf_articulo84]  DEFAULT (0) FOR [Ctf_Articulo84]
GO
