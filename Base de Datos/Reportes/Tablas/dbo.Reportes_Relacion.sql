USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_Relacion]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_Relacion](
	[Id_Reporte] [int] NOT NULL,
	[Id_Parametro] [int] NOT NULL
) ON [Reportes_Data_01]
GO
