USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_CONTROL]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_CONTROL](
	[codigo_control] [char](5) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL
) ON [PRIMARY]
GO
