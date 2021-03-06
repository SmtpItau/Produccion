USE [Reportes]
GO
/****** Object:  Table [dbo].[CONTRATO_Contratos_Impresos]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRATO_Contratos_Impresos](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [int] NOT NULL,
	[Num_Oper] [numeric](9, 0) NOT NULL,
	[Sistema] [char](10) NOT NULL,
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
