USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tbl_carTicketRtaFija]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_carTicketRtaFija](
	[Fecha_Operacion] [datetime] NOT NULL,
	[Numero_Documento] [numeric](10, 0) NOT NULL,
	[Correlativo] [smallint] NOT NULL,
	[Numero_Documento_Relacion] [numeric](10, 0) NOT NULL,
	[Correlativo_Relacion] [smallint] NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[CodCarteraOrigen] [smallint] NOT NULL,
	[CodMesaOrigen] [smallint] NOT NULL,
	[Tipo_Operacion] [varchar](3) NOT NULL,
	[Nemotecnico] [varchar](10) NOT NULL,
	[Mascara] [varchar](10) NOT NULL,
	[CodigoInstrumento] [smallint] NOT NULL,
	[Moneda] [numeric](3, 0) NOT NULL,
	[Seriado] [varchar](1) NOT NULL,
	[Valor_Nominal] [numeric](19, 4) NOT NULL,
	[Tir] [numeric](9, 4) NOT NULL,
	[pvp] [numeric](9, 4) NOT NULL,
	[vpar] [numeric](9, 4) NOT NULL,
	[Tir_Estimada] [numeric](9, 4) NOT NULL,
	[Valor_Presente] [numeric](19, 4) NOT NULL,
	[Valor_Compra] [numeric](19, 4) NOT NULL,
	[Valor_Compra_UM] [numeric](19, 4) NOT NULL,
	[Valor_Tasa_Emision] [numeric](19, 4) NOT NULL,
	[Valor_PrimaDescto] [numeric](19, 4) NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL,
	[Valor_InicialPacto] [numeric](19, 4) NOT NULL,
	[Valor_VencimientoPacto] [numeric](19, 4) NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL,
	[NumeroUltCupon] [smallint] NOT NULL,
	[FechaUltCupon] [datetime] NOT NULL,
	[FechaProxCupon] [datetime] NOT NULL,
	[PagoHoy] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Numero_Documento]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Numero_Documento_Relacion]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Correlativo_Relacion]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [CodCarteraOrigen]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [CodMesaOrigen]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT ('') FOR [Nemotecnico]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT ('') FOR [Mascara]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [CodigoInstrumento]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Seriado]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_Nominal]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Tir]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [pvp]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [vpar]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Tir_Estimada]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_Presente]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_Compra]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_Compra_UM]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_Tasa_Emision]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_PrimaDescto]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Duration]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [DurationMod]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_InicialPacto]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [Valor_VencimientoPacto]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT ('') FOR [Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [NumeroUltCupon]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [FechaUltCupon]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [FechaProxCupon]
GO
ALTER TABLE [dbo].[tbl_carTicketRtaFija] ADD  DEFAULT (0) FOR [PagoHoy]
GO
