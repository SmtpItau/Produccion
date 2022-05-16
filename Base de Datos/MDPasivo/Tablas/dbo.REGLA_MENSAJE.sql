USE [MDPasivo]
GO
/****** Object:  Table [dbo].[REGLA_MENSAJE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGLA_MENSAJE](
	[numero_regla] [numeric](10, 0) NOT NULL,
	[nombre_regla] [char](100) NOT NULL,
	[para] [char](255) NOT NULL,
	[cc] [char](255) NOT NULL,
	[otros] [char](255) NOT NULL,
	[asunto] [char](255) NOT NULL,
	[estado] [char](1) NOT NULL
) ON [PRIMARY]
GO
