USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO](
	[id_Sistema] [char](3) NOT NULL,
	[Tipo_movimiento] [varchar](5) NOT NULL,
	[Tipo_operacion] [varchar](5) NOT NULL,
	[TipoInstrumento] [int] NOT NULL,
	[Moneda] [int] NOT NULL,
	[TipoEmisor] [int] NOT NULL,
	[OrigenEmision] [int] NOT NULL,
	[ObjetoCubierto] [int] NOT NULL,
	[Contraparte] [numeric](9, 0) NOT NULL,
	[Desde] [int] NOT NULL,
	[Hasta] [int] NOT NULL,
	[CarteraNormativa] [char](10) NOT NULL,
	[SubcarteraNormativa] [char](10) NOT NULL,
	[Glosa] [varchar](155) NOT NULL,
	[CodigoCartera] [int] NOT NULL,
	[CasaMatriz] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_id_Sistema]  DEFAULT ('') FOR [id_Sistema]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_tipo_movimiento]  DEFAULT ('') FOR [Tipo_movimiento]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_tipo_operacion]  DEFAULT ('') FOR [Tipo_operacion]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_TipoInstrumento]  DEFAULT (0) FOR [TipoInstrumento]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_TipoEmisor]  DEFAULT (0) FOR [TipoEmisor]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_OrigenEmision]  DEFAULT (0) FOR [OrigenEmision]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_ObjetoCubierto]  DEFAULT (0) FOR [ObjetoCubierto]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_Contraparte]  DEFAULT (0) FOR [Contraparte]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_Desde]  DEFAULT (0) FOR [Desde]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_Hasta]  DEFAULT (0) FOR [Hasta]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_CarteraNormativa]  DEFAULT ('') FOR [CarteraNormativa]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_SubCarteraNormativa]  DEFAULT ('') FOR [SubcarteraNormativa]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_Glosa]  DEFAULT ('') FOR [Glosa]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [tbl_clasCartInst_CodigoCartera]  DEFAULT (0) FOR [CodigoCartera]
GO
ALTER TABLE [dbo].[TBL_CLASIFICACION_CARTERA_INSTRUMENTO] ADD  CONSTRAINT [DF_TBL_CLASIFICACION_CARTERA_INSTRUMENTO_CasaMatriz]  DEFAULT ((0)) FOR [CasaMatriz]
GO
