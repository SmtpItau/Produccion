USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_PARAMETROS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_PARAMETROS](
	[fec_ayer_gen] [datetime] NULL,
	[fec_hoy_gen] [datetime] NULL,
	[fec_manana_gen] [datetime] NULL,
	[fec_ayer_adm] [datetime] NULL,
	[fec_hoy_adm] [datetime] NULL,
	[fec_manana_adm] [datetime] NULL,
	[fec_ayer_accion] [datetime] NULL,
	[fec_hoy_accion] [datetime] NULL,
	[fec_manana_accion] [datetime] NULL,
	[rut_corredora] [numeric](10, 0) NULL,
	[fecha_ultimo_mercado] [datetime] NULL,
	[emisor_central] [char](6) NULL,
	[registro_svs] [char](5) NULL,
	[emisor_corredora] [char](6) NULL,
	[monto_minimo_pactos] [numeric](18, 4) NULL,
	[moneda_monto_minimo] [char](4) NULL,
	[numero_voucher_apertura] [numeric](10, 0) NULL,
	[ano_voucher_apertura] [numeric](4, 0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_PARAMETROS] ADD  CONSTRAINT [DF__GEN_PARAM__Monto__59463169]  DEFAULT (0) FOR [monto_minimo_pactos]
GO
ALTER TABLE [dbo].[GEN_PARAMETROS] ADD  CONSTRAINT [DF__GEN_PARAM__Moned__5A3A55A2]  DEFAULT (' ') FOR [moneda_monto_minimo]
GO
ALTER TABLE [dbo].[GEN_PARAMETROS] ADD  CONSTRAINT [DF__GEN_PARAM__Numer__5B2E79DB]  DEFAULT (0) FOR [numero_voucher_apertura]
GO
ALTER TABLE [dbo].[GEN_PARAMETROS] ADD  CONSTRAINT [DF__GEN_PARAM__Ano_V__5C229E14]  DEFAULT (0) FOR [ano_voucher_apertura]
GO
