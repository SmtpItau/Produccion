USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PERFIL_CNT]    Script Date: 13-05-2022 10:58:10 ******/
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
	[glosa_perfil] [char](70) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_movimiento] ASC,
	[tipo_operacion] ASC,
	[folio_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF__PERFIL_CN__Codig__3DBFA933]  DEFAULT ('') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF__PERFIL_CN__Moned__3EB3CD6C]  DEFAULT ('') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF__PERFIL_CN__Tipo___3FA7F1A5]  DEFAULT ('') FOR [tipo_voucher]
GO
ALTER TABLE [dbo].[PERFIL_CNT] ADD  CONSTRAINT [DF__PERFIL_CN__Glosa__409C15DE]  DEFAULT ('') FOR [glosa_perfil]
GO
