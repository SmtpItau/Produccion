USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_EVENTO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_EVENTO](
	[codigo_producto] [char](5) NOT NULL,
	[codigo_evento] [char](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[id_sistema] [char](3) NOT NULL
) ON [PRIMARY]
GO
