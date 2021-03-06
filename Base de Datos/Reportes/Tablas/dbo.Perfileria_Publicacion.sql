USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Publicacion]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Publicacion](
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Ambiente] FOREIGN KEY([ID_Ambiente])
REFERENCES [dbo].[Perfileria_Ambiente] ([ID_Ambiente])
GO
ALTER TABLE [dbo].[Perfileria_Publicacion] CHECK CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Ambiente]
GO
ALTER TABLE [dbo].[Perfileria_Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [dbo].[Perfileria_Sistema] ([ID_Sistema])
GO
ALTER TABLE [dbo].[Perfileria_Publicacion] CHECK CONSTRAINT [FK_Perfileria_Publicacion_Perfileria_Sistema]
GO
