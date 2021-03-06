USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CARGA_INTERFAZ_SERIE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGA_INTERFAZ_SERIE](
	[Serie] [char](12) NOT NULL,
	[emisor] [numeric](9, 0) NOT NULL,
	[fecha_emision] [datetime] NOT NULL,
	[tasa_emision] [numeric](10, 4) NOT NULL,
	[tasa_real] [numeric](10, 4) NOT NULL,
	[UM] [char](10) NOT NULL,
	[BASE] [numeric](5, 0) NOT NULL,
	[Numero_Cupones] [numeric](5, 0) NOT NULL,
	[Perido_Pago] [numeric](5, 0) NOT NULL,
	[Estado] [char](10) NOT NULL,
	[Terminal] [char](20) NOT NULL
) ON [PRIMARY]
GO
