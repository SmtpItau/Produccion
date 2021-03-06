USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_Parametros]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_Parametros](
	[Id_Parametro] [int] NOT NULL,
	[Parametro] [nvarchar](50) NULL,
	[Tipo_Dato] [nvarchar](50) NULL,
	[Alias] [nvarchar](50) NULL,
	[Query] [nvarchar](255) NULL,
	[Tipo_Parametro] [char](1) NULL
) ON [Reportes_Data_01]
GO
