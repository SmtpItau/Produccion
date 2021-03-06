USE [MDPasivo]
GO
/****** Object:  Table [dbo].[RESPALDO_MATRIZ_RIESGO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESPALDO_MATRIZ_RIESGO](
	[codigo_grupo] [char](10) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[codigo_moneda2] [numeric](5, 0) NOT NULL,
	[dias_desde] [numeric](6, 0) NOT NULL,
	[dias_hasta] [numeric](6, 0) NOT NULL,
	[porcentaje] [float] NOT NULL
) ON [PRIMARY]
GO
