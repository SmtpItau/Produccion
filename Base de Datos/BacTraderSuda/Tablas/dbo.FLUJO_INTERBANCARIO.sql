USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[FLUJO_INTERBANCARIO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLUJO_INTERBANCARIO](
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[fecha_proceso] [datetime] NOT NULL,
	[codigo_producto] [varchar](5) NOT NULL,
	[monto_operacion] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rut_cliente] ASC,
	[codigo_cliente] ASC,
	[fecha_proceso] ASC,
	[codigo_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
