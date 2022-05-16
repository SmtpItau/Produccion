USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_Conexion]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_Conexion](
	[Id_Conexion] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[Servidor] [nvarchar](255) NULL,
	[BaseDatos] [nvarchar](255) NULL,
	[Usuario] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL
) ON [Reportes_Data_01]
GO
