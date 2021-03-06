USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[VALE_VISTA_EMITIDO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALE_VISTA_EMITIDO](
	[fecha_generacion] [datetime] NOT NULL,
	[fecha_emision] [datetime] NOT NULL,
	[forma_pago] [numeric](2, 0) NOT NULL,
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
	[tipo_operacion] [char](3) NOT NULL,
	[documento_correlativo] [numeric](3, 0) NOT NULL,
	[Entregamos_Recibimos] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_fecha_generacion]  DEFAULT ('') FOR [fecha_generacion]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_fecha_emision]  DEFAULT ('') FOR [fecha_emision]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_forma_pago]  DEFAULT ((0)) FOR [forma_pago]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_id_sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_codigo_producto]  DEFAULT ('') FOR [codigo_producto]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_numero_operacion]  DEFAULT ((0)) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_rut_cliente]  DEFAULT ((0)) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_codigo_cliente]  DEFAULT ((0)) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_monto]  DEFAULT ((0)) FOR [documento_monto]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_numero]  DEFAULT ((0)) FOR [documento_numero]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_estado]  DEFAULT ('') FOR [documento_estado]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_divide]  DEFAULT ('') FOR [documento_divide]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_protege]  DEFAULT ('') FOR [documento_protege]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_nombre_cliente]  DEFAULT ('') FOR [nombre_cliente]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_codigo_transaccion]  DEFAULT ('') FOR [codigo_transaccion]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_numero_ctacte]  DEFAULT ('') FOR [numero_ctacte]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_codigo_sucursal]  DEFAULT ('') FOR [codigo_sucursal]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_concepto]  DEFAULT ('') FOR [concepto]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_tipo_operacion]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_documento_correlativo]  DEFAULT ((0)) FOR [documento_correlativo]
GO
ALTER TABLE [dbo].[VALE_VISTA_EMITIDO] ADD  CONSTRAINT [DF_VALE_VISTA_EMITIDO_Entregamos_Recibimos]  DEFAULT ('') FOR [Entregamos_Recibimos]
GO
