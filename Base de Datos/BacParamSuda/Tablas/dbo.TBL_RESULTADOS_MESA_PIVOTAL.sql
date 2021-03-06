USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_RESULTADOS_MESA_PIVOTAL]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL](
	[Modulo] [char](3) NOT NULL,
	[Producto] [varchar](50) NOT NULL,
	[Numero_Operacion] [numeric](9, 0) NOT NULL,
	[Documento] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](20) NOT NULL,
	[RutCliente] [numeric](12, 0) NOT NULL,
	[CodCliente] [int] NOT NULL,
	[DvCliente] [char](1) NOT NULL,
	[NombreCliente] [varchar](150) NOT NULL,
	[TipoOperacion] [varchar](25) NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
	[MonTransada] [char](5) NOT NULL,
	[MonConversion] [char](5) NOT NULL,
	[TCCierre] [numeric](21, 4) NOT NULL,
	[TCCosto] [numeric](21, 4) NOT NULL,
	[ParidadCierre] [numeric](21, 4) NOT NULL,
	[ParidadCosto] [numeric](21, 4) NOT NULL,
	[MontoPesos] [numeric](21, 4) NOT NULL,
	[Operador] [varchar](20) NOT NULL,
	[MontoDolares] [numeric](21, 4) NOT NULL,
	[ResultadoMesa] [numeric](21, 4) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Relacionado] [varchar](50) NOT NULL,
	[FolioRelacionado] [numeric](9, 0) NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[FechaVcto] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Numero_Operacion]  DEFAULT ((0)) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Documento]  DEFAULT ((0)) FOR [Documento]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Correlativo]  DEFAULT ((0)) FOR [Correlativo]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Serie]  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_RutCliente]  DEFAULT ((0)) FOR [RutCliente]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_CodCliente]  DEFAULT ((0)) FOR [CodCliente]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_DvCliente]  DEFAULT ('') FOR [DvCliente]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_NombreCliente]  DEFAULT ('') FOR [NombreCliente]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_TipoOperacion]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Monto]  DEFAULT ((0.0)) FOR [Monto]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_MonTransada]  DEFAULT ('') FOR [MonTransada]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_MonConversion]  DEFAULT ('') FOR [MonConversion]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_TCCierre]  DEFAULT ((0.0)) FOR [TCCierre]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_TCCosto]  DEFAULT ((0.0)) FOR [TCCosto]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_ParidadCierre]  DEFAULT ((0.0)) FOR [ParidadCierre]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_ParidadCosto]  DEFAULT ((0.0)) FOR [ParidadCosto]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_MontoPesos]  DEFAULT ((0.0)) FOR [MontoPesos]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Operador]  DEFAULT ('') FOR [Operador]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_MontoDolares]  DEFAULT ((0.0)) FOR [MontoDolares]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_ResultadoMesa]  DEFAULT ((0.0)) FOR [ResultadoMesa]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_Relacionado]  DEFAULT ('') FOR [Relacionado]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_FolioRelacionado]  DEFAULT ((0)) FOR [FolioRelacionado]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_FechaEmision]  DEFAULT ('') FOR [FechaEmision]
GO
ALTER TABLE [dbo].[TBL_RESULTADOS_MESA_PIVOTAL] ADD  CONSTRAINT [df_tblresultadosmesapivotal_FechaVcto]  DEFAULT ('') FOR [FechaVcto]
GO
