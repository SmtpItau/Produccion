USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PAIS]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAIS](
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[codigo_pais_super] [numeric](5, 0) NOT NULL,
	[codigo_ISO_divisa] [char](3) NOT NULL,
	[codigo_pais_Espana] [numeric](4, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PAIS] ADD  CONSTRAINT [DF_PAIS_codigo_pais]  DEFAULT ((0)) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[PAIS] ADD  CONSTRAINT [DF_PAIS_nombre]  DEFAULT ('') FOR [nombre]
GO
ALTER TABLE [dbo].[PAIS] ADD  CONSTRAINT [DF_PAIS_codigo_pais_super]  DEFAULT ((0)) FOR [codigo_pais_super]
GO
ALTER TABLE [dbo].[PAIS] ADD  CONSTRAINT [DF_PAIS_codigo_ISO_divisa]  DEFAULT ('') FOR [codigo_ISO_divisa]
GO
ALTER TABLE [dbo].[PAIS] ADD  CONSTRAINT [DF_PAIS_codigo_pais_Espana]  DEFAULT ((0)) FOR [codigo_pais_Espana]
GO
