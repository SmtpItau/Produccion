USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_ValMercado_Garantia]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ValMercado_Garantia](
	[FechaValoriza] [datetime] NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Instrumento] [varchar](12) NOT NULL,
	[Mascara] [varchar](12) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[TIR] [numeric](9, 6) NOT NULL,
	[ValorPresenteHoy] [numeric](21, 0) NOT NULL,
	[ValorPresenteProx] [numeric](21, 0) NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Fecha]  DEFAULT ('') FOR [FechaValoriza]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Numero]  DEFAULT (0) FOR [NumeroOperacion]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Correlativo]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Instrumento]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Mascara]  DEFAULT ('') FOR [Mascara]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Nominal]  DEFAULT (0) FOR [Nominal]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercadora__TIR__]  DEFAULT (0) FOR [TIR]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__ValorPresenteHoy]  DEFAULT (0) FOR [ValorPresenteHoy]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__ValorPresenteProx]  DEFAULT (0) FOR [ValorPresenteProx]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Duratation]  DEFAULT (0) FOR [Duration]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Duratationmod]  DEFAULT (0) FOR [DurationMod]
GO
ALTER TABLE [dbo].[tbl_ValMercado_Garantia] ADD  CONSTRAINT [DF__tbl_ValMercado__Convexidad]  DEFAULT (0) FOR [Convexidad]
GO
