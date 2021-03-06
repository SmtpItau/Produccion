USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Estructura_Rol]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Estructura_Rol](
	[ID_Rol_Estructura] [int] IDENTITY(1,1) NOT NULL,
	[ID_Rol] [int] NULL,
	[ID_Estructura] [int] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Estructura_Rol] PRIMARY KEY CLUSTERED 
(
	[ID_Rol_Estructura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Estructura_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Estructura_Rol_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [dbo].[Perfileria_Rol] ([ID_Rol])
GO
ALTER TABLE [dbo].[Perfileria_Estructura_Rol] CHECK CONSTRAINT [FK_Estructura_Rol_Rol]
GO
ALTER TABLE [dbo].[Perfileria_Estructura_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Estructura] FOREIGN KEY([ID_Estructura])
REFERENCES [dbo].[Perfileria_Estructura] ([ID_Estructura])
GO
ALTER TABLE [dbo].[Perfileria_Estructura_Rol] CHECK CONSTRAINT [FK_Perfileria_Estructura_Rol_Perfileria_Estructura]
GO
