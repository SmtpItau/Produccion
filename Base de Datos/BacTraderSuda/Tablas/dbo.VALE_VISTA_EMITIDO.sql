USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[VALE_VISTA_EMITIDO]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALE_VISTA_EMITIDO](
	[fecha_generacion] [datetime] NOT NULL,
	[fecha_emision] [datetime] NOT NULL,
	[forma_pago] [numeric](5, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[documento_monto] [numeric](19, 0) NOT NULL,
	[documento_numero] [numeric](10, 0) NOT NULL,
	[documento_estado] [char](1) NOT NULL,
	[documento_divide] [char](1) NOT NULL,
	[documento_protege] [char](1) NOT NULL,
	[nombre_cliente] [char](50) NOT NULL,
	[codigo_transaccion] [char](1) NOT NULL,
	[numero_ctacte] [varchar](15) NOT NULL,
	[codigo_sucursal] [varchar](5) NOT NULL,
	[concepto] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fecha_generacion] ASC,
	[fecha_emision] ASC,
	[forma_pago] ASC,
	[id_sistema] ASC,
	[numero_operacion] ASC,
	[documento_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__rut_c__2831F175]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__codig__292615AE]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__docum__2A1A39E7]  DEFAULT (0) FOR [documento_monto]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__docum__2B0E5E20]  DEFAULT (1) FOR [documento_numero]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__docum__2C028259]  DEFAULT ('G') FOR [documento_estado]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__docum__2CF6A692]  DEFAULT ('N') FOR [documento_divide]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__docum__2DEACACB]  DEFAULT ('S') FOR [documento_protege]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__nombr__2EDEEF04]  DEFAULT (' ') FOR [nombre_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__codig__2FD3133D]  DEFAULT (' ') FOR [codigo_transaccion]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__numer__30C73776]  DEFAULT (' ') FOR [numero_ctacte]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__codig__31BB5BAF]  DEFAULT (' ') FOR [codigo_sucursal]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF__VALE_VIST__conce__32AF7FE8]  DEFAULT (' ') FOR [concepto]
GO
