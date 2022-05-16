USE [MDPasivo]
GO
/****** Object:  Table [dbo].[EJECUTIVO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EJECUTIVO](
	[Rut_Entidad] [numeric](10, 0) NOT NULL,
	[Codigo_Entidad] [numeric](10, 0) NOT NULL,
	[Rut_Ejecutivo] [numeric](10, 0) NOT NULL,
	[Codigo_Ejecutivo] [numeric](10, 0) NOT NULL,
	[Nombre_Ejecutivo] [char](40) NOT NULL,
	[Area_Ejecutivo] [char](5) NOT NULL
) ON [PRIMARY]
GO
