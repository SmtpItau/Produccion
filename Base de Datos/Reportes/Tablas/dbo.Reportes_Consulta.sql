USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_Consulta]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_Consulta](
	[id_consulta] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[consulta] [nvarchar](500) NULL
) ON [Reportes_Data_01]
GO
