USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_TASA_SUPER]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TASA_SUPER](
	[Nemotecnico] [char](12) NOT NULL,
	[Tipo_Instrumento] [char](10) NOT NULL,
	[Moneda] [char](5) NOT NULL,
	[Precio] [float] NOT NULL,
	[Plazo] [float] NOT NULL,
	[Tir_Valorizacion] [float] NOT NULL,
	[Tir_Transaccion] [float] NOT NULL,
	[Categoria] [char](5) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Nemotecnico]  DEFAULT ('') FOR [Nemotecnico]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Tipo_Instrumento]  DEFAULT ('') FOR [Tipo_Instrumento]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Moneda]  DEFAULT ('') FOR [Moneda]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Precio]  DEFAULT (0.0) FOR [Precio]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Plazo]  DEFAULT (0.0) FOR [Plazo]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Tir_Valorizacion]  DEFAULT (0.0) FOR [Tir_Valorizacion]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Tir_Transaccion]  DEFAULT (0.0) FOR [Tir_Transaccion]
GO
ALTER TABLE [dbo].[LINEA_TASA_SUPER] ADD  CONSTRAINT [DF_LINEA_TASA_SUPER_Categoria]  DEFAULT ('') FOR [Categoria]
GO
