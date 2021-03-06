USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_FLUJO_CAJA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_FLUJO_CAJA](
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_pago] [datetime] NOT NULL,
	[moneda] [char](4) NOT NULL,
	[tipo_operacion] [char](4) NOT NULL,
	[operacion] [numeric](10, 0) NULL,
	[rut_cliente] [numeric](10, 0) NULL,
	[codigo_rut] [numeric](5, 0) NULL,
	[monto] [float] NULL,
	[forma_pago] [char](4) NULL,
	[tipo_movimiento] [char](1) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Opera__7F96C2DA]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Rut_C__008AE713]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Codig__017F0B4C]  DEFAULT (0) FOR [codigo_rut]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Monto__02732F85]  DEFAULT (0) FOR [monto]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Forma__036753BE]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[GEN_FLUJO_CAJA] ADD  CONSTRAINT [DF__GEN_FLUJO__Tipo___045B77F7]  DEFAULT (' ') FOR [tipo_movimiento]
GO
