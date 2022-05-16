USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CATEGORIA_CARTERASUPER]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA_CARTERASUPER](
	[codigo_carterasuper] [char](5) NOT NULL,
	[nombre_carterasuper] [char](20) NOT NULL,
	[Clasificacion_Qh] [char](1) NOT NULL,
	[Estado] [numeric](1, 0) NOT NULL,
	[RESPONSABLE] [char](20) NOT NULL,
	[LIBRO] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_codigo_carterasuper]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_nombre_carterasuper]  DEFAULT ('') FOR [nombre_carterasuper]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_Clasificacion_Qh]  DEFAULT ('') FOR [Clasificacion_Qh]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_Estado]  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_RESPONSABLE]  DEFAULT ('') FOR [RESPONSABLE]
GO
ALTER TABLE [dbo].[CATEGORIA_CARTERASUPER] ADD  CONSTRAINT [DF_CATEGORIA_CARTERASUPER_LIBRO]  DEFAULT ('') FOR [LIBRO]
GO
