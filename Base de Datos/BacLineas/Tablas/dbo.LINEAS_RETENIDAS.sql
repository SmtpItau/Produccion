USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEAS_RETENIDAS]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEAS_RETENIDAS](
	[Fecha] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [varchar](5) NOT NULL,
	[tipo_operacion] [varchar](5) NOT NULL,
	[numero_operacion] [numeric](9, 0) NOT NULL,
	[rut_emisor] [numeric](10, 0) NOT NULL,
	[cod_emisor] [numeric](3, 0) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[cod_cliente] [numeric](3, 0) NOT NULL,
	[monto_linea] [numeric](21, 4) NOT NULL,
	[monto_operacion] [numeric](21, 4) NOT NULL,
	[monto_pesos] [numeric](21, 4) NOT NULL,
	[tir] [numeric](21, 4) NOT NULL,
	[porcentaje] [numeric](21, 4) NOT NULL,
	[forma_pago] [numeric](5, 0) NOT NULL,
	[fecha_pago] [datetime] NOT NULL,
	[estado_liberacion] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Producto]  DEFAULT ('') FOR [codigo_producto]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Operacion]  DEFAULT (0) FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_NumOper]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_RutEmisor]  DEFAULT (0) FOR [rut_emisor]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Codemisor]  DEFAULT (0) FOR [cod_emisor]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_RutCliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_CodCliente]  DEFAULT (0) FOR [cod_cliente]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_MontoLinea]  DEFAULT (0.0) FOR [monto_linea]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_MontoOperacion]  DEFAULT (0.0) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_MontoPesos]  DEFAULT (0.0) FOR [monto_pesos]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_tir]  DEFAULT (0.0) FOR [tir]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Porcentaje]  DEFAULT (0.0) FOR [porcentaje]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_FormaPago]  DEFAULT (0) FOR [forma_pago]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_fecha_pago]  DEFAULT ('') FOR [fecha_pago]
GO
ALTER TABLE [dbo].[LINEAS_RETENIDAS] ADD  CONSTRAINT [df_LinRet_Estado]  DEFAULT ('N') FOR [estado_liberacion]
GO
