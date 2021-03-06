USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CONTROL_PRECIO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROL_PRECIO](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_subproducto] [char](15) NOT NULL,
	[spread_minimo] [float] NOT NULL,
	[spread_maximo] [float] NOT NULL,
	[nplazo_minimo] [float] NOT NULL,
	[nplazo_maximo] [float] NOT NULL
) ON [PRIMARY]
GO
