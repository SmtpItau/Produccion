USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_COMPROBANTES]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_COMPROBANTES](
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_rut] [numeric](3, 0) NOT NULL,
	[monto_operacion] [float] NOT NULL,
	[moneda] [char](3) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[numero_comprobante] [numeric](10, 0) NOT NULL,
	[estado] [char](1) NOT NULL,
	[tipo_comprobante] [numeric](2, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Id_Si__745A1A58]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Tipo___754E3E91]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Rut_C__764262CA]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Codig__77368703]  DEFAULT (0) FOR [codigo_rut]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Monto__782AAB3C]  DEFAULT (0) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Moned__791ECF75]  DEFAULT ('') FOR [moneda]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Numer__7A12F3AE]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Numer__7B0717E7]  DEFAULT (0) FOR [numero_comprobante]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Estad__7BFB3C20]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Tipo___7CEF6059]  DEFAULT (0) FOR [tipo_comprobante]
GO
ALTER TABLE [dbo].[GEN_COMPROBANTES] ADD  CONSTRAINT [DF__GEN_COMPR__Corre__7DE38492]  DEFAULT (0) FOR [correlativo]
GO
