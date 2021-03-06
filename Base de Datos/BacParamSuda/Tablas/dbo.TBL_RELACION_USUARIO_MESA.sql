USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_RELACION_USUARIO_MESA]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RELACION_USUARIO_MESA](
	[id_Usuario] [varchar](20) NOT NULL,
	[Id_Mesa] [int] NOT NULL,
 CONSTRAINT [Pk_TblRelacionUsuarioMesa] PRIMARY KEY CLUSTERED 
(
	[id_Usuario] ASC,
	[Id_Mesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RELACION_USUARIO_MESA] ADD  CONSTRAINT [df_tbl_relacion_usuario_mesa_idUsuario]  DEFAULT ('') FOR [id_Usuario]
GO
ALTER TABLE [dbo].[TBL_RELACION_USUARIO_MESA] ADD  CONSTRAINT [df_tbl_relacion_usuario_mesa_idMesa]  DEFAULT ((0)) FOR [Id_Mesa]
GO
