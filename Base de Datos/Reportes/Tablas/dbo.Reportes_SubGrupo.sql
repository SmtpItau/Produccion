USE [Reportes]
GO
/****** Object:  Table [dbo].[Reportes_SubGrupo]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes_SubGrupo](
	[Id_SubGrupo] [int] NOT NULL,
	[Id_Grupo] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL
) ON [Reportes_Data_01]
GO
