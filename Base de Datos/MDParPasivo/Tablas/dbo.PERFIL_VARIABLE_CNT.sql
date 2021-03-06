USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PERFIL_VARIABLE_CNT]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFIL_VARIABLE_CNT](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[valor_dato_campo] [varchar](30) NOT NULL,
	[codigo_cuenta] [char](20) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERFIL_VARIABLE_CNT] ADD  CONSTRAINT [DF_PERFIL_VARIABLE_CNT_folio_perfil]  DEFAULT ((0)) FOR [folio_perfil]
GO
ALTER TABLE [dbo].[PERFIL_VARIABLE_CNT] ADD  CONSTRAINT [DF_PERFIL_VARIABLE_CNT_correlativo_perfil]  DEFAULT ((0)) FOR [correlativo_perfil]
GO
ALTER TABLE [dbo].[PERFIL_VARIABLE_CNT] ADD  CONSTRAINT [DF_PERFIL_VARIABLE_CNT_valor_dato_campo]  DEFAULT ('') FOR [valor_dato_campo]
GO
ALTER TABLE [dbo].[PERFIL_VARIABLE_CNT] ADD  CONSTRAINT [DF_PERFIL_VARIABLE_CNT_codigo_cuenta]  DEFAULT ('') FOR [codigo_cuenta]
GO
