USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TRAMO_TESORERIA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRAMO_TESORERIA](
	[id_sistema] [char](3) NOT NULL,
	[codigo_tramo] [numeric](3, 0) NOT NULL,
	[dia_ini] [numeric](10, 0) NULL,
	[dia_fin] [numeric](10, 0) NULL
) ON [PRIMARY]
GO
