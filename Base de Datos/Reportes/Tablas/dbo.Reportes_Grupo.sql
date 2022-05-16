USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_Grupo]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_Grupo](
	[Id_Grupo] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Ruta_Archivos] [nvarchar](500) NULL,
	[Orden] [int] NULL,
	[Visible] [int] NULL
) ON [Reportes_Data_01]
GO
