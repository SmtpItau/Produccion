USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_EjecucionProceso]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_EjecucionProceso](
	[fechaProceso] [datetime] NOT NULL,
	[flagProceso] [bit] NOT NULL
) ON [Reportes_Data_01]
GO
