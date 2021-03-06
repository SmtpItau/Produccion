USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Usuario_Perfil]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Usuario_Perfil](
	[ID_Usuario_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[ID_Perfil] [int] NULL,
	[Valor] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Usuario_Perfil] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Usuario_Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Perfil_Perfil] FOREIGN KEY([ID_Perfil])
REFERENCES [Perfil].[Perfileria_Perfil] ([ID_Perfil])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Usuario_Perfil] CHECK CONSTRAINT [FK_Usuario_Perfil_Perfil]
GO
