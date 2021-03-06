USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[SWIFT_MOVIMIENTO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SWIFT_MOVIMIENTO](
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[tipo_mercado] [char](4) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[monto_original] [numeric](19, 4) NOT NULL,
	[monto_dolares] [numeric](19, 4) NOT NULL,
	[tipo_cambio] [numeric](19, 4) NOT NULL,
	[paridad] [numeric](19, 4) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[codigo_swift] [varchar](10) NOT NULL,
	[estado_swift] [varchar](1) NOT NULL,
	[observacion] [varchar](100) NOT NULL,
	[impreso] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fecha_operacion] ASC,
	[fecha_vencimiento] ASC,
	[id_sistema] ASC,
	[tipo_mercado] ASC,
	[codigo_producto] ASC,
	[tipo_operacion] ASC,
	[codigo_moneda] ASC,
	[estado_swift] ASC,
	[rut_cliente] ASC,
	[codigo_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__monto__4F200AB6]  DEFAULT (0) FOR [monto_original]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__monto__50142EEF]  DEFAULT (0) FOR [monto_dolares]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__tipo___51085328]  DEFAULT (0) FOR [tipo_cambio]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__parid__51FC7761]  DEFAULT (0) FOR [paridad]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__codig__52F09B9A]  DEFAULT (0) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__codig__53E4BFD3]  DEFAULT (0) FOR [codigo_plaza]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__codig__54D8E40C]  DEFAULT ('') FOR [codigo_swift]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__estad__55CD0845]  DEFAULT ('') FOR [estado_swift]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__obser__56C12C7E]  DEFAULT ('') FOR [observacion]
GO
ALTER TABLE [dbo].[SWIFT_MOVIMIENTO] ADD  CONSTRAINT [DF__SWIFT_MOV__impre__57B550B7]  DEFAULT ('N') FOR [impreso]
GO
