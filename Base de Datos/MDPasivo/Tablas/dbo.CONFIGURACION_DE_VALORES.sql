USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CONFIGURACION_DE_VALORES]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONFIGURACION_DE_VALORES](
	[codigo_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[nombre_original_campo] [char](30) NOT NULL,
	[descripcion_campo] [char](30) NOT NULL,
	[tipo_campo] [char](15) NOT NULL,
	[largo] [numeric](2, 0) NOT NULL,
	[presicion] [numeric](1, 0) NOT NULL,
	[correlativo] [numeric](2, 0) NOT NULL,
	[valor_numerico] [numeric](19, 4) NOT NULL,
	[valor_caracter] [char](100) NOT NULL,
	[ayuda_campo] [char](200) NOT NULL,
	[estado_campo] [char](1) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL
) ON [PRIMARY]
GO
