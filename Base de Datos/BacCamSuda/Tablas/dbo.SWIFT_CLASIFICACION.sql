USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[SWIFT_CLASIFICACION]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SWIFT_CLASIFICACION](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[tipo_mercado] [char](4) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[clasificacion_cliente] [numeric](5, 0) NOT NULL,
	[codigo_mensaje_swift] [varchar](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[codigo_producto] ASC,
	[tipo_mercado] ASC,
	[codigo_moneda] ASC,
	[tipo_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
