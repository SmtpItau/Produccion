USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LIMITE_TRANSACCION_ERROR]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TRANSACCION_ERROR](
	[FechaOperacion] [datetime] NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[Monto] [numeric](19, 4) NOT NULL,
	[Mensaje] [varchar](255) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Tipo_Control] [char](10) NOT NULL,
	[codigo_excepcion] [char](2) NOT NULL
) ON [PRIMARY]
GO
