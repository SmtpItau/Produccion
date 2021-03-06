USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PERFIL_DETALLE_CNT]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFIL_DETALLE_CNT](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[codigo_campo] [numeric](3, 0) NULL,
	[tipo_movimiento_cuenta] [char](1) NULL,
	[perfil_fijo] [char](1) NULL,
	[codigo_cuenta] [char](20) NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[codigo_campo_variable] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_folio_perfil]  DEFAULT ((0)) FOR [folio_perfil]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_codigo_campo]  DEFAULT ((0)) FOR [codigo_campo]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_tipo_movimiento_cuenta]  DEFAULT ('') FOR [tipo_movimiento_cuenta]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_perfil_fijo]  DEFAULT ('') FOR [perfil_fijo]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_codigo_cuenta]  DEFAULT ('') FOR [codigo_cuenta]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_correlativo_perfil]  DEFAULT ((0)) FOR [correlativo_perfil]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF_PERFIL_DETALLE_CNT_codigo_campo_variable]  DEFAULT ((0)) FOR [codigo_campo_variable]
GO
