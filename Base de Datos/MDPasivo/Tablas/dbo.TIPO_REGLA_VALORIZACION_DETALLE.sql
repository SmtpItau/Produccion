USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_REGLA_VALORIZACION_DETALLE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_REGLA_VALORIZACION_DETALLE](
	[id_detalle] [int] NOT NULL,
	[id_tipo_regla] [int] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NULL,
	[codigo_instrumento] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
