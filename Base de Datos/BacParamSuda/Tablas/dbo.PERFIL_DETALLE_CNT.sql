USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PERFIL_DETALLE_CNT]    Script Date: 13-05-2022 10:58:10 ******/
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
	[codigo_campo_variable] [numeric](3, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[folio_perfil] ASC,
	[correlativo_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF__PERFIL_DE__Codig__6677A603]  DEFAULT (0) FOR [codigo_campo]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF__PERFIL_DE__Tipo___676BCA3C]  DEFAULT ('') FOR [tipo_movimiento_cuenta]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF__PERFIL_DE__Perfi__685FEE75]  DEFAULT ('') FOR [perfil_fijo]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF__PERFIL_DE__Codig__695412AE]  DEFAULT ('') FOR [codigo_cuenta]
GO
ALTER TABLE [dbo].[PERFIL_DETALLE_CNT] ADD  CONSTRAINT [DF__PERFIL_DE__Codig__6A4836E7]  DEFAULT (0) FOR [codigo_campo_variable]
GO
