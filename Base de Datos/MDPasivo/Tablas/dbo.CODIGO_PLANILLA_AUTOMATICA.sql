USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CODIGO_PLANILLA_AUTOMATICA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_PLANILLA_AUTOMATICA](
	[codigo_producto] [char](5) NOT NULL,
	[tipo_cliente] [numeric](5, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[vencimiento_fisico] [char](1) NOT NULL,
	[comercio] [char](6) NOT NULL,
	[condicion] [varchar](10) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[Nacionalidad] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO
