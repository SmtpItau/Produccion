USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PERFIL_CNT]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFIL_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](10) NULL,
	[moneda_instrumento] [char](4) NULL,
	[tipo_voucher] [char](1) NULL,
	[glosa_perfil] [char](70) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_id_sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_tipo_movimiento]  DEFAULT ('') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_tipo_operacion]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_folio_perfil]  DEFAULT ((0)) FOR [folio_perfil]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_codigo_instrumento]  DEFAULT ('') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_moneda_instrumento]  DEFAULT ('') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_tipo_voucher]  DEFAULT ('') FOR [tipo_voucher]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF_PERFIL_CNT_glosa_perfil]  DEFAULT ('') FOR [glosa_perfil]
GO
