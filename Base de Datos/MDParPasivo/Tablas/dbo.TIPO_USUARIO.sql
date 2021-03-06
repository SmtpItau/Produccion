USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TIPO_USUARIO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_USUARIO](
	[Tipo_Usuario] [char](15) NOT NULL,
	[Descripcion] [char](40) NOT NULL,
	[Largo_Clave] [numeric](2, 0) NOT NULL,
	[Tipo_Clave] [char](1) NOT NULL,
	[Dias_Expiracion] [numeric](5, 0) NOT NULL,
	[Activo] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Tipo_Usuario]  DEFAULT ('') FOR [Tipo_Usuario]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Largo_Clave]  DEFAULT ((0)) FOR [Largo_Clave]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Tipo_Clave]  DEFAULT ('') FOR [Tipo_Clave]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Dias_Expiracion]  DEFAULT ((0)) FOR [Dias_Expiracion]
GO
ALTER TABLE [dbo].[TIPO_USUARIO] ADD  CONSTRAINT [DF_TIPO_USUARIO_Activo]  DEFAULT ('') FOR [Activo]
GO
