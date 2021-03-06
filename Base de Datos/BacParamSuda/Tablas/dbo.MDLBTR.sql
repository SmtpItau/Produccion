USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MDLBTR]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLBTR](
	[fecha] [datetime] NOT NULL,
	[sistema] [char](5) NOT NULL,
	[tipo_mercado] [char](12) NOT NULL,
	[tipo_operacion] [char](6) NOT NULL,
	[estado_envio] [char](5) NOT NULL,
	[numero_operacion] [numeric](9, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[moneda] [numeric](5, 0) NOT NULL,
	[monto_operacion] [numeric](21, 4) NOT NULL,
	[forma_pago] [numeric](5, 0) NOT NULL,
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[liquidada] [char](1) NOT NULL,
	[RecRutBanco] [numeric](10, 0) NULL,
	[RecCodBanco] [numeric](10, 0) NULL,
	[RecCodSwift] [varchar](20) NULL,
	[RecDireccion] [varchar](70) NULL,
	[RecCtaCte] [varchar](20) NULL,
	[Tipo_Movimiento] [char](1) NOT NULL,
	[GlosaAnticipo] [varchar](150) NULL,
	[Id_Paquete] [numeric](10, 0) NOT NULL,
	[Estado_Paquete] [char](1) NOT NULL,
	[Reservado] [char](50) NOT NULL,
	[Secuencia] [numeric](10, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fecha] ASC,
	[sistema] ASC,
	[tipo_operacion] ASC,
	[numero_operacion] ASC,
	[Tipo_Movimiento] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [fecha]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [sistema]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [tipo_mercado]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [estado_envio]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [moneda]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [forma_pago]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [fecha_operacion]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [fecha_vencimiento]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [liquidada]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [RecRutBanco]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [RecCodBanco]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [RecCodSwift]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [RecDireccion]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [RecCtaCte]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [Tipo_Movimiento]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT (' ') FOR [GlosaAnticipo]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((0)) FOR [Id_Paquete]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('D') FOR [Estado_Paquete]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ('') FOR [Reservado]
GO
ALTER TABLE [dbo].[MDLBTR] ADD  DEFAULT ((1)) FOR [Secuencia]
GO
