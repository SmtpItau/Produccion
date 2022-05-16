USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CODIGO_TRANSACCION_SWIFT]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_TRANSACCION_SWIFT](
	[Id_Sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_transaccion] [numeric](3, 0) NOT NULL,
	[glosa_transaccion] [char](40) NOT NULL
) ON [PRIMARY]
GO
