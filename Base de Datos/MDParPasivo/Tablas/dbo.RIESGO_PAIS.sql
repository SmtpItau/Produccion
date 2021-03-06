USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[RIESGO_PAIS]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIESGO_PAIS](
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[porcentaje] [numeric](8, 4) NOT NULL,
	[totalasignado] [numeric](19, 0) NOT NULL,
	[totalocupado] [numeric](19, 0) NOT NULL,
	[totaldisponible] [numeric](19, 0) NOT NULL,
	[totalexceso] [numeric](19, 0) NOT NULL
) ON [PRIMARY]
GO
