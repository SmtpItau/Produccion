USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Menu]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Menu](
	[ID_Menu] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sistema] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID_Menu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [Perfil].[Perfileria_Sistema] ([ID_Sistema])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Menu] CHECK CONSTRAINT [FK_Menu_Sistema]
GO
