USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MIS_CON_BAC_UTIL_TC]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MIS_CON_BAC_UTIL_TC](
	[MES_CONTABLE] [numeric](6, 0) NULL,
	[SOURCE_ID] [char](14) NULL,
	[OPERACION] [char](20) NULL,
	[PRODUCT_ID] [char](16) NULL,
	[ISO_COUNTRY] [char](3) NULL,
	[EMPRESA_ID] [char](3) NULL,
	[BRANCH_CD] [char](3) NULL,
	[CLIENTE_ID] [char](12) NULL,
	[FULL_NAME] [char](80) NULL,
	[FAMILIA] [char](4) NULL,
	[PRODUCT_TYPE_CD] [char](4) NULL,
	[FECHA_CONTABLE] [char](8) NULL,
	[FECHA_INTERFAZ] [char](8) NULL,
	[FECHA_APERTURA_OPERAC] [char](8) NULL,
	[FECHA_INICIO] [char](8) NULL,
	[FECHA_VCMTO] [char](8) NULL,
	[FECHA_RENOVACION] [char](8) NULL,
	[FECHA_PROX_CAMBIO_TASA] [char](8) NULL,
	[ISO_CURRENCY_CD] [char](3) NULL,
	[TIPO_MONEDA] [char](1) NULL,
	[TIPO_OPERACION] [char](1) NULL,
	[PERIODICIDAD_DE_FLUJOS] [char](5) NULL,
	[IND_TASA_TRANSFERENCIA] [char](2) NULL,
	[NRO_CUOTAS_FLUJO_SWAP] [char](5) NULL,
	[TASA_INTERES] [numeric](18, 8) NULL,
	[TASA_TIPO_PARIDAD] [numeric](18, 5) NULL,
	[CAP_MONE_ORIGEN] [numeric](18, 2) NULL,
	[CAP_MONE_LOCAL] [numeric](18, 2) NULL,
	[MONTO_UTIL_ORIGEN] [numeric](18, 5) NULL,
	[MONTO_UTIL_LOCAL] [numeric](18, 5) NULL
) ON [PRIMARY]
GO
