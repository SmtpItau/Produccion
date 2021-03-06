USE [MDPasivo]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[usuario] [char](15) NOT NULL,
	[clave] [char](15) NOT NULL,
	[nombre] [char](40) NOT NULL,
	[tipo_usuario] [char](15) NOT NULL,
	[fecha_expira] [datetime] NOT NULL,
	[cambio_clave] [char](1) NOT NULL,
	[bloqueado] [char](1) NOT NULL,
	[clase] [char](2) NOT NULL,
	[clave_anterior1] [char](15) NOT NULL,
	[clave_anterior2] [char](15) NOT NULL,
	[clave_anterior3] [char](15) NOT NULL,
	[Largo_Clave] [numeric](2, 0) NOT NULL,
	[Tipo_Clave] [char](1) NOT NULL,
	[Dias_Expiracion] [numeric](5, 0) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[rut_usuario] [numeric](9, 0) NOT NULL,
	[dv_usuario] [char](1) NOT NULL,
	[mail_usuario] [char](100) NOT NULL,
	[activo] [char](1) NOT NULL,
	[subrogacion] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_usuario]  DEFAULT ('') FOR [usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_clave]  DEFAULT ('') FOR [clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_nombre]  DEFAULT ('') FOR [nombre]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_tipo_usuario]  DEFAULT ('') FOR [tipo_usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_fecha_expira]  DEFAULT ('') FOR [fecha_expira]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_cambio_clave]  DEFAULT ('') FOR [cambio_clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_bloqueado]  DEFAULT ('') FOR [bloqueado]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_clase]  DEFAULT ('') FOR [clase]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_clave_anterior1]  DEFAULT ('') FOR [clave_anterior1]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_clave_anterior2]  DEFAULT ('') FOR [clave_anterior2]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_clave_anterior3]  DEFAULT ('') FOR [clave_anterior3]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_Largo_Clave]  DEFAULT ((0)) FOR [Largo_Clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_Tipo_Clave]  DEFAULT ('') FOR [Tipo_Clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_Dias_Expiracion]  DEFAULT ((0)) FOR [Dias_Expiracion]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_codigo_area]  DEFAULT ('') FOR [codigo_area]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_rut_usuario]  DEFAULT ((0)) FOR [rut_usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_dv_usuario]  DEFAULT ('') FOR [dv_usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_mail_usuario]  DEFAULT ('') FOR [mail_usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_activo]  DEFAULT ('') FOR [activo]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF_USUARIO_subrogacion]  DEFAULT ('') FOR [subrogacion]
GO
