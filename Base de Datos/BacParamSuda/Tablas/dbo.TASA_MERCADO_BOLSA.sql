USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASA_MERCADO_BOLSA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_MERCADO_BOLSA](
	[Fecha] [datetime] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Emisor] [varchar](10) NOT NULL,
	[Instrumento] [varchar](15) NOT NULL,
	[Tasa] [float] NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Emisor]  DEFAULT ('') FOR [Emisor]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Instrumento]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Tasa]  DEFAULT (0.0) FOR [Tasa]
GO
ALTER TABLE [dbo].[TASA_MERCADO_BOLSA] ADD  CONSTRAINT [df_TasaMercado_Bolsa_Monto]  DEFAULT (0.0) FOR [Monto]
GO
