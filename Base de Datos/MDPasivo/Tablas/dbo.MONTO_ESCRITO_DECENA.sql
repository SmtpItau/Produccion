USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MONTO_ESCRITO_DECENA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONTO_ESCRITO_DECENA](
	[glosa] [char](20) NOT NULL,
	[indice] [int] NOT NULL,
	[Rut_Entidad] [numeric](10, 0) NOT NULL,
	[Codigo_Entidad] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
