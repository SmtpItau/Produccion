USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_BASE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_BASE](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Base] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL,
	[Base] [char](3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TIPO_BASE] ADD  CONSTRAINT [DF_TIPO_BASE_Id_Sistema]  DEFAULT ('') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[TIPO_BASE] ADD  CONSTRAINT [DF_TIPO_BASE_Codigo_Base]  DEFAULT ((0)) FOR [Codigo_Base]
GO
ALTER TABLE [dbo].[TIPO_BASE] ADD  CONSTRAINT [DF_TIPO_BASE_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
ALTER TABLE [dbo].[TIPO_BASE] ADD  CONSTRAINT [DF_TIPO_BASE_Base]  DEFAULT ('') FOR [Base]
GO
