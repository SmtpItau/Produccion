USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[PERIODICIDAD_TASAS]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIODICIDAD_TASAS](
	[Tipo_Tasa] [int] NOT NULL,
	[Nombre_Tipo] [varchar](20) NOT NULL,
	[Desde] [int] NOT NULL,
	[Hasta] [int] NOT NULL,
	[Ajuste_Pasivo] [numeric](21, 4) NOT NULL,
	[Ajuste_Activo] [numeric](21, 4) NOT NULL,
	[Glosa] [varchar](100) NOT NULL,
 CONSTRAINT [Pk_Periodicidad_Tasas] PRIMARY KEY CLUSTERED 
(
	[Tipo_Tasa] ASC,
	[Desde] ASC,
	[Hasta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_TipoTasa]  DEFAULT ((-1)) FOR [Tipo_Tasa]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_Nombre_Tipo]  DEFAULT ('-') FOR [Nombre_Tipo]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_Desde]  DEFAULT (0) FOR [Desde]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_Hasta]  DEFAULT (0) FOR [Hasta]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_Apasivo]  DEFAULT (0.0) FOR [Ajuste_Pasivo]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_AActivo]  DEFAULT (0.0) FOR [Ajuste_Activo]
GO
ALTER TABLE [dbo].[PERIODICIDAD_TASAS] ADD  CONSTRAINT [df_periodicidad_tasas_Glosa]  DEFAULT ('-') FOR [Glosa]
GO
