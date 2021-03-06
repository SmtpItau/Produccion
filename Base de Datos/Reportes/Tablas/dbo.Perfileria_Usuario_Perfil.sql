USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Usuario_Perfil]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Usuario_Perfil](
	[ID_Usuario_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [int] NULL,
	[ID_Perfil] [int] NULL,
	[Valor] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Usuario_Perfil] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Usuario_Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Perfil_Perfil] FOREIGN KEY([ID_Perfil])
REFERENCES [dbo].[Perfileria_Perfil] ([ID_Perfil])
GO
ALTER TABLE [dbo].[Perfileria_Usuario_Perfil] CHECK CONSTRAINT [FK_Usuario_Perfil_Perfil]
GO
ALTER TABLE [dbo].[Perfileria_Usuario_Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Perfil_Usuario] FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Perfileria_Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Perfileria_Usuario_Perfil] CHECK CONSTRAINT [FK_Usuario_Perfil_Usuario]
GO
