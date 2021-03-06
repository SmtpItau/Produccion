USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CargaOperaciones_DefectoValores]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CargaOperaciones_DefectoValores](
	[idProducto] [smallint] NOT NULL,
	[idOperacion] [smallint] NOT NULL,
	[idMoneda1] [smallint] NOT NULL,
	[idMoneda2] [smallint] NOT NULL,
	[idPlataforma] [smallint] NOT NULL,
	[idCliente] [int] NOT NULL,
	[Default_sModalidad] [char](1) NOT NULL,
	[Default_iFormaPagoMN] [smallint] NOT NULL,
	[Default_iFormaPagoMX] [smallint] NOT NULL,
	[Default_iCodCorresponsal] [numeric](9, 0) NOT NULL,
	[Default_iCodCorresponsal_Desde] [numeric](5, 0) NOT NULL,
	[Default_iCodCorresponsal_Donde] [numeric](5, 0) NOT NULL,
	[Default_iCodCorresponsal_Quien] [numeric](5, 0) NOT NULL,
	[Default_iPL_Corres_Desde] [numeric](5, 0) NOT NULL,
	[Default_iPL_Corres_Donde] [numeric](5, 0) NOT NULL,
	[Default_iPL_Corres_Quien] [numeric](5, 0) NOT NULL,
	[Default_sCodigoComercio] [varchar](6) NOT NULL,
	[Default_sCodigoOMA] [varchar](5) NOT NULL,
	[Default_sCodigoConcepto] [varchar](3) NOT NULL,
	[Default_sCodigoUsuario] [varchar](15) NOT NULL,
	[Default_sCodAreaResponable] [varchar](6) NOT NULL,
	[Default_sCodCartNormativa] [varchar](6) NOT NULL,
	[Default_sCodSubCartNormativa] [varchar](6) NOT NULL,
	[Default_sCodigoLibro] [varchar](6) NOT NULL,
	[Default_iCodidogCartera] [numeric](5, 0) NOT NULL,
	[Default_iCodigoBroker] [numeric](5, 0) NOT NULL,
	[Default_iTipRetiro] [numeric](5, 0) NOT NULL,
	[Default_Tipo_Pantalla] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC,
	[idOperacion] ASC,
	[idMoneda1] ASC,
	[idMoneda2] ASC,
	[idPlataforma] ASC,
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idProducto]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idOperacion]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idMoneda1]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idMoneda2]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idPlataforma]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [idCliente]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sModalidad]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iFormaPagoMN]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iFormaPagoMX]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodCorresponsal]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodCorresponsal_Desde]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodCorresponsal_Donde]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodCorresponsal_Quien]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iPL_Corres_Desde]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iPL_Corres_Donde]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iPL_Corres_Quien]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodigoComercio]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodigoOMA]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodigoConcepto]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodigoUsuario]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodAreaResponable]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodCartNormativa]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodSubCartNormativa]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ('') FOR [Default_sCodigoLibro]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodidogCartera]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iCodigoBroker]
GO
ALTER TABLE [dbo].[CargaOperaciones_DefectoValores] ADD  DEFAULT ((0)) FOR [Default_iTipRetiro]
GO
