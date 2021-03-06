USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_MOVIMIENTO_CTA_CTE]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE](
	[cuenta_corta] [char](10) NOT NULL,
	[tipo_movimiento] [char](1) NOT NULL,
	[numero_cheque] [numeric](10, 0) NOT NULL,
	[fecha_movimiento] [datetime] NOT NULL,
	[monto] [float] NOT NULL,
	[tipo_operacion] [char](4) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[conciliado] [char](1) NOT NULL,
	[fecha_conciliacion] [datetime] NOT NULL,
	[estado] [char](1) NOT NULL,
	[forma_pago] [char](4) NULL,
	[codigo_banco] [char](6) NULL,
	[numero_cuenta] [char](20) NULL,
	[observacion] [char](40) NULL,
	[tipo_ingreso] [char](1) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Numer__0737E4A2]  DEFAULT (0) FOR [numero_cheque]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Fecha__082C08DB]  DEFAULT (' ') FOR [fecha_movimiento]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Monto__09202D14]  DEFAULT (0) FOR [monto]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Tipo___0A14514D]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Opera__0B087586]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Conci__0BFC99BF]  DEFAULT ('N') FOR [conciliado]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Fecha__0CF0BDF8]  DEFAULT (' ') FOR [fecha_conciliacion]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Forma__0DE4E231]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Codig__0ED9066A]  DEFAULT (' ') FOR [codigo_banco]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Numer__0FCD2AA3]  DEFAULT (' ') FOR [numero_cuenta]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Obser__10C14EDC]  DEFAULT (' ') FOR [observacion]
GO
ALTER TABLE [dbo].[GEN_MOVIMIENTO_CTA_CTE] ADD  CONSTRAINT [DF__GEN_MOVIM__Tipo___14C6E9EA]  DEFAULT (' ') FOR [tipo_ingreso]
GO
