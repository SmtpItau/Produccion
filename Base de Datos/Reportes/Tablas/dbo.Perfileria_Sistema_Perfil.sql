USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Sistema_Perfil]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Sistema_Perfil](
	[ID_Sistema_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sistema] [int] NULL,
	[ID_Perfil] [int] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Sistema_Perfil] PRIMARY KEY CLUSTERED 
(
	[ID_Sistema_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Sistema_Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Sistema_Perfil_Perfil] FOREIGN KEY([ID_Perfil])
REFERENCES [dbo].[Perfileria_Perfil] ([ID_Perfil])
GO
ALTER TABLE [dbo].[Perfileria_Sistema_Perfil] CHECK CONSTRAINT [FK_Sistema_Perfil_Perfil]
GO
ALTER TABLE [dbo].[Perfileria_Sistema_Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Sistema_Perfil_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [dbo].[Perfileria_Sistema] ([ID_Sistema])
GO
ALTER TABLE [dbo].[Perfileria_Sistema_Perfil] CHECK CONSTRAINT [FK_Sistema_Perfil_Sistema]
GO
