USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[POSICION_GRUPO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSICION_GRUPO](
	[codigo_grupo] [varchar](5) NOT NULL,
	[porcentaje] [numeric](10, 4) NOT NULL,
	[totalposicion] [numeric](19, 4) NOT NULL,
	[totalocupado] [numeric](19, 4) NOT NULL,
	[totalcompra] [numeric](19, 4) NOT NULL,
	[totalventa] [numeric](19, 4) NOT NULL,
	[totaldisponible] [numeric](19, 4) NOT NULL,
	[totalexcedido] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
