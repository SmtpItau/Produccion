USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Publicacion]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Publicacion](
	[ID_Publicacion] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sistema] [int] NULL,
	[ID_Ambiente] [int] NULL,
	[HOST_IP] [nvarchar](50) NULL,
	[HOST_PORT] [int] NULL,
	[HOST_PATH] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Perfileria_Publicacion] PRIMARY KEY CLUSTERED 
(
	[ID_Publicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Ambiente] FOREIGN KEY([ID_Ambiente])
REFERENCES [Perfil].[Perfileria_Ambiente] ([ID_Ambiente])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Publicacion] CHECK CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Ambiente]
GO
ALTER TABLE [Perfil].[Perfileria_Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [Perfil].[Perfileria_Sistema] ([ID_Sistema])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Publicacion] CHECK CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Sistema]
GO
