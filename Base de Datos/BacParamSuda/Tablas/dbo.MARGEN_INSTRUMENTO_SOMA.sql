USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MARGEN_INSTRUMENTO_SOMA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA](
	[Codigo_Instrumento] [numeric](5, 0) NOT NULL,
	[Clasificacion_Riesgo] [char](3) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[Margen] [float] NOT NULL,
	[Tipo_OpSoma] [char](3) NOT NULL,
 CONSTRAINT [PkMARGEN_INSTRUMENTO_SOMA] PRIMARY KEY CLUSTERED 
(
	[Codigo_Instrumento] ASC,
	[Clasificacion_Riesgo] ASC,
	[Plazo_Desde] ASC,
	[Plazo_Hasta] ASC,
	[Tipo_OpSoma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Codigo_Instrumento]  DEFAULT (0) FOR [Codigo_Instrumento]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Clasificacion_Riesgo]  DEFAULT ('') FOR [Clasificacion_Riesgo]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Plazo_Desde]  DEFAULT (0) FOR [Plazo_Desde]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Plazo_Hasta]  DEFAULT (0) FOR [Plazo_Hasta]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Margen]  DEFAULT (0.0) FOR [Margen]
GO
ALTER TABLE [dbo].[MARGEN_INSTRUMENTO_SOMA] ADD  CONSTRAINT [df_MARGEN_INSTRUMENTO_SOMA_Tipo_OpSoma]  DEFAULT ('') FOR [Tipo_OpSoma]
GO
