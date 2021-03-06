USE [Reportes]
GO
/****** Object:  Table [dbo].[ADENDUM_InformacionOPCIONES]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADENDUM_InformacionOPCIONES](
	[ID] [numeric](10, 0) NULL,
	[Numero_Contrato] [numeric](18, 0) NULL,
	[Folio] [numeric](18, 0) NULL,
	[Estado] [varchar](50) NULL,
	[Estructura] [numeric](10, 0) NULL,
	[Fecha_Modif_Contrato] [varchar](50) NULL,
	[Fecha_Contrato] [varchar](40) NULL,
	[Tipo_Operacion] [varchar](50) NULL,
	[Estilo_Opcion] [varchar](80) NULL,
	[Cantidad_Moneda_Ext] [numeric](21, 2) NULL,
	[Moneda_Liquidacion] [varchar](50) NULL,
	[Comprador_opcion] [varchar](80) NULL,
	[Vendedor_opcion] [varchar](200) NULL,
	[Rut_Cliente] [varchar](10) NULL,
	[Modalidad_Cumplimiento] [varchar](50) NULL,
	[Domicilio_Cliente] [varchar](100) NULL,
	[Fono_Cliente] [varchar](20) NULL,
	[Fax_Cliente] [varchar](20) NULL,
	[Nombre_Apoderado_uno] [varchar](100) NULL,
	[Rut_Apoderado_uno] [varchar](10) NULL,
	[Nombre_Apoderado_dos] [varchar](100) NULL,
	[Rut_Apoderado_dos] [varchar](10) NULL,
	[Nombre_Apoderado_Cliente_uno] [varchar](100) NULL,
	[Rut_Apoderado_Cliente_uno] [varchar](10) NULL,
	[Nombre_Apoderado_Cliente_dos] [varchar](100) NULL,
	[Rut_Apoderado_Cliente_dos] [varchar](10) NULL,
	[Fecha_Nuevo_CCG] [varchar](40) NULL
) ON [PRIMARY]
GO
