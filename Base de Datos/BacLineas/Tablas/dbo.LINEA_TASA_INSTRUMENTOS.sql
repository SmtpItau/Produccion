USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_TASA_INSTRUMENTOS]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TASA_INSTRUMENTOS](
	[InCodigo] [numeric](5, 0) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[Porcentaje_Minimo] [float] NOT NULL,
	[Porcentaje_Maximo] [float] NOT NULL,
	[TasaSuper] [numeric](10, 6) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_InCodigo]  DEFAULT (0) FOR [InCodigo]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_Plazo_Desde]  DEFAULT (0) FOR [Plazo_Desde]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_Plazo_Hasta]  DEFAULT (0) FOR [Plazo_Hasta]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_Porcentaje_Minimo]  DEFAULT (0) FOR [Porcentaje_Minimo]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_Porcentaje_Maximo]  DEFAULT (0) FOR [Porcentaje_Maximo]
GO
ALTER TABLE [dbo].[LINEA_TASA_INSTRUMENTOS] ADD  CONSTRAINT [DF_LINEA_TASA_INSTRUMENTOS_TasaSuper]  DEFAULT (0) FOR [TasaSuper]
GO
