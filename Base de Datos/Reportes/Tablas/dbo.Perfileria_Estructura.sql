USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Estructura]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Estructura](
	[ID_Estructura] [int] IDENTITY(1,1) NOT NULL,
	[ID_Menu] [int] NULL,
	[ID_Dependencia] [int] NULL,
	[ID_Estructura_Nivel] [int] NULL,
	[Posicion] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[ToolTip] [nvarchar](50) NULL,
	[Url] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Estructura] PRIMARY KEY CLUSTERED 
(
	[ID_Estructura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Estructura]  WITH CHECK ADD  CONSTRAINT [FK_Estructura_Estructura_Nivel] FOREIGN KEY([ID_Estructura_Nivel])
REFERENCES [dbo].[Perfileria_Estructura_Nivel] ([ID_Estructura_Nivel])
GO
ALTER TABLE [dbo].[Perfileria_Estructura] CHECK CONSTRAINT [FK_Estructura_Estructura_Nivel]
GO
ALTER TABLE [dbo].[Perfileria_Estructura]  WITH CHECK ADD  CONSTRAINT [FK_Estructura_Menu] FOREIGN KEY([ID_Menu])
REFERENCES [dbo].[Perfileria_Menu] ([ID_Menu])
GO
ALTER TABLE [dbo].[Perfileria_Estructura] CHECK CONSTRAINT [FK_Estructura_Menu]
GO
