USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_CNT]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[origen_instrumentos] [varchar](60) NOT NULL,
	[datos_instrumentos] [varchar](60) NOT NULL,
	[cond_instrumentos] [varchar](60) NOT NULL,
	[origen_monedas] [varchar](60) NOT NULL,
	[datos_monedas] [varchar](60) NOT NULL,
	[cond_monedas] [varchar](60) NOT NULL
) ON [PRIMARY]
GO
