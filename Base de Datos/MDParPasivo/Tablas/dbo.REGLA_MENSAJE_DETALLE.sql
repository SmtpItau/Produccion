USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[REGLA_MENSAJE_DETALLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGLA_MENSAJE_DETALLE](
	[numero_regla] [numeric](10, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[opcion_menu] [char](30) NOT NULL
) ON [PRIMARY]
GO
