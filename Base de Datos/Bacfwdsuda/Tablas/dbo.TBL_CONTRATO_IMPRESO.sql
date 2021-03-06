USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_CONTRATO_IMPRESO]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONTRATO_IMPRESO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [int] NOT NULL,
	[Num_Oper] [numeric](9, 0) NOT NULL,
	[Fecha_Impresion] [datetime] NOT NULL,
	[Hora_Impresion] [char](8) NOT NULL,
	[Cod_Dcto_Fisico] [char](10) NOT NULL,
	[Cod_Dcto] [char](10) NOT NULL,
	[Rut_ApoderadoBco1] [numeric](9, 0) NOT NULL,
	[Rut_ApoderadoBco2] [numeric](9, 0) NOT NULL,
	[Rut_ApoderadoCli1] [numeric](9, 0) NOT NULL,
	[Rut_ApoderadoCli2] [numeric](9, 0) NOT NULL,
	[Numero_Avales] [int] NOT NULL,
	[Categoria_Dcto] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Rut_cliente]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Cod_Cliente]  DEFAULT (0) FOR [Cod_Cliente]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Num_Oper]  DEFAULT (0) FOR [Num_Oper]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Fecha_Impresion]  DEFAULT ('01011900') FOR [Fecha_Impresion]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Hora_Impresion]  DEFAULT ('') FOR [Hora_Impresion]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Cod_Dcto_Fisico]  DEFAULT ('') FOR [Cod_Dcto_Fisico]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Cod_Dcto]  DEFAULT ('') FOR [Cod_Dcto]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Rut_ApoderadoBco1]  DEFAULT (0) FOR [Rut_ApoderadoBco1]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Rut_ApoderadoBco2]  DEFAULT (0) FOR [Rut_ApoderadoBco2]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Rut_ApoderadoCli1]  DEFAULT (0) FOR [Rut_ApoderadoCli1]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Rut_ApoderadoCli2]  DEFAULT (0) FOR [Rut_ApoderadoCli2]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  CONSTRAINT [Tci_Numero_Avales]  DEFAULT (0) FOR [Numero_Avales]
GO
ALTER TABLE [dbo].[TBL_CONTRATO_IMPRESO] ADD  DEFAULT ('') FOR [Categoria_Dcto]
GO
