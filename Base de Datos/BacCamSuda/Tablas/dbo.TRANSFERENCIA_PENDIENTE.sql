USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TRANSFERENCIA_PENDIENTE]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSFERENCIA_PENDIENTE](
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[tipo_mercado] [char](4) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[monto_original] [numeric](19, 4) NOT NULL,
	[monto_dolares] [numeric](19, 4) NOT NULL,
	[monto_pesos] [numeric](19, 0) NOT NULL,
	[tipo_cambio] [numeric](10, 4) NOT NULL,
	[paridad] [numeric](10, 4) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[codigo_swift] [varchar](10) NOT NULL,
	[forma_pago] [numeric](2, 0) NOT NULL,
	[Estado_transferencia] [varchar](1) NOT NULL,
	[monto_final] [numeric](19, 4) NOT NULL,
	[casa_matriz] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fecha_operacion] ASC,
	[fecha_vencimiento] ASC,
	[id_sistema] ASC,
	[tipo_mercado] ASC,
	[codigo_producto] ASC,
	[numero_operacion] ASC,
	[codigo_moneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__tipo___287B3EE1]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__monto__296F631A]  DEFAULT (0) FOR [monto_original]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__monto__2A638753]  DEFAULT (0) FOR [monto_dolares]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__monto__2B57AB8C]  DEFAULT (0) FOR [monto_pesos]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__tipo___2C4BCFC5]  DEFAULT (0) FOR [tipo_cambio]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__parid__2D3FF3FE]  DEFAULT (0) FOR [paridad]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__rut_c__2E341837]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__codig__2F283C70]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__codig__301C60A9]  DEFAULT (0) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__codig__311084E2]  DEFAULT (0) FOR [codigo_plaza]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__codig__3204A91B]  DEFAULT ('') FOR [codigo_swift]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__forma__32F8CD54]  DEFAULT (0) FOR [forma_pago]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__Estad__33ECF18D]  DEFAULT ('') FOR [Estado_transferencia]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__monto__34E115C6]  DEFAULT (0) FOR [monto_final]
GO
ALTER TABLE [dbo].[TRANSFERENCIA_PENDIENTE] ADD  CONSTRAINT [DF__TRANSFERE__casa___35D539FF]  DEFAULT (0) FOR [casa_matriz]
GO
