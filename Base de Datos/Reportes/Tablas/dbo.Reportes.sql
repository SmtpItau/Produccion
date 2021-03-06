USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes](
	[Id_Reporte] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Nombre] [nvarchar](50) NULL,
	[Nombre_Archivo] [nvarchar](50) NULL,
	[Id_Grupo] [int] NULL,
	[Id_Conexion] [int] NULL,
	[Metodo] [nchar](10) NULL,
	[Visible] [int] NULL,
	[PermiteMail] [int] NULL,
	[Mail_Asunto] [nvarchar](200) NULL,
	[Mail_Body] [nvarchar](500) NULL,
	[id_Subgrupo] [int] NULL
) ON [Reportes_Data_01]
GO
