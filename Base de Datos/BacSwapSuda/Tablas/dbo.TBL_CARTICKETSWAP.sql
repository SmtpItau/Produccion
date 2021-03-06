USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[TBL_CARTICKETSWAP]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CARTICKETSWAP](
	[Fecha_operacion] [datetime] NOT NULL,
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_operacion_relacional] [numeric](7, 0) NOT NULL,
	[Cantidad_flujo] [numeric](3, 0) NOT NULL,
	[Ticker] [varchar](255) NOT NULL,
	[Modalidad] [char](1) NOT NULL,
	[Moneda_Compra] [numeric](3, 0) NOT NULL,
	[Valor_Nominal_Compra] [numeric](19, 4) NOT NULL,
	[Frecuencia_Pago_Compra] [numeric](3, 0) NOT NULL,
	[Frecuencia_Capital_Compra] [numeric](3, 0) NOT NULL,
	[Indicador_Compra] [numeric](3, 0) NOT NULL,
	[Tasa_Compra] [numeric](12, 8) NOT NULL,
	[Conteo_Dias_Compra] [numeric](3, 0) NOT NULL,
	[Fecha_Efectiva_Compra] [datetime] NOT NULL,
	[Fecha_Inicio_Compra] [datetime] NOT NULL,
	[Fecha_Penultimo_Pago_Compra] [datetime] NOT NULL,
	[Fecha_Madurez_Compra] [datetime] NOT NULL,
	[Moneda_Pago_Compra] [numeric](3, 0) NOT NULL,
	[Medio_Pago_Compra] [numeric](3, 0) NOT NULL,
	[Moneda_Venta] [numeric](3, 0) NOT NULL,
	[Valor_Nominal_Venta] [numeric](19, 4) NOT NULL,
	[Frecuencia_Pago_Venta] [numeric](3, 0) NOT NULL,
	[Frecuencia_Capital_Venta] [numeric](3, 0) NOT NULL,
	[Indicador_Venta] [numeric](3, 0) NOT NULL,
	[Tasa_Venta] [numeric](12, 8) NOT NULL,
	[Conteo_Dias_Venta] [numeric](3, 0) NOT NULL,
	[Fecha_Efectiva_Venta] [datetime] NOT NULL,
	[Fecha_Inicio_Venta] [datetime] NOT NULL,
	[Fecha_Penultimo_Venta] [datetime] NOT NULL,
	[Fecha_Madurez_Venta] [datetime] NOT NULL,
	[Moneda_Pago_Venta] [numeric](3, 0) NOT NULL,
	[Medio_Pago_Venta] [numeric](3, 0) NOT NULL,
	[CodCarteraOrigen] [smallint] NOT NULL,
	[CodMesaOrigen] [smallint] NOT NULL,
	[CodCarteraDestino] [smallint] NOT NULL,
	[CodMesaDestino] [smallint] NOT NULL,
	[Fecha_Vcto_Ultimo_Pago] [datetime] NOT NULL,
	[Usuario] [varchar](10) NOT NULL,
	[IntercPrinc] [int] NOT NULL,
	[OrigenCurva] [char](2) NOT NULL,
	[ActivoTir] [float] NOT NULL,
	[PasivoTir] [float] NOT NULL,
	[ActivoTirCnv] [float] NOT NULL,
	[PasivoTirCnv] [float] NOT NULL,
	[FxRate] [float] NOT NULL,
 CONSTRAINT [PK_TBL_CARTICKETSWAP] PRIMARY KEY NONCLUSTERED 
(
	[Fecha_operacion] ASC,
	[numero_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_operacion]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [numero_operacion_relacional]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Cantidad_flujo]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Ticker]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Modalidad]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Moneda_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Valor_Nominal_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Frecuencia_Pago_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Frecuencia_Capital_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Indicador_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Conteo_Dias_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Efectiva_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Inicio_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Penultimo_Pago_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Madurez_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Moneda_Pago_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Medio_Pago_Compra]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Moneda_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Valor_Nominal_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Frecuencia_Pago_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Frecuencia_Capital_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Indicador_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Conteo_Dias_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Efectiva_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Inicio_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Penultimo_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Madurez_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Moneda_Pago_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [Medio_Pago_Venta]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [CodCarteraOrigen]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [CodMesaOrigen]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [CodCarteraDestino]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [CodMesaDestino]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Fecha_Vcto_Ultimo_Pago]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT ('') FOR [OrigenCurva]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [ActivoTir]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [PasivoTir]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [ActivoTirCnv]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [PasivoTirCnv]
GO
ALTER TABLE [dbo].[TBL_CARTICKETSWAP] ADD  DEFAULT (0) FOR [FxRate]
GO
