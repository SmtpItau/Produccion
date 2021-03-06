USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Estructura_Rol]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Estructura_Rol](
	[ID_Rol_Estructura] [int] IDENTITY(1,1) NOT NULL,
	[ID_Rol] [int] NULL,
	[ID_Estructura] [int] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Estructura_Rol] PRIMARY KEY CLUSTERED 
(
	[ID_Rol_Estructura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Estructura_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Estructura] FOREIGN KEY([ID_Estructura])
REFERENCES [Perfil].[Perfileria_Estructura] ([ID_Estructura])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Estructura_Rol] CHECK CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Estructura]
GO
ALTER TABLE [Perfil].[Perfileria_Estructura_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [Perfil].[Perfileria_Rol] ([ID_Rol])
GO
ALTER TABLE [Perfil].[Perfileria_Estructura_Rol] CHECK CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Rol]
GO
