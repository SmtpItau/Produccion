USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_ART84_INPADDON]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ART84_INPADDON](
	[ID_TICKET] [int] NULL,
	[RUT_CLIENTE] [decimal](10, 0) NULL,
	[CODIGO_CLIENTE] [int] NULL,
	[MONTO] [decimal](18, 0) NULL,
	[PLAZO] [int] NULL,
	[SISTEMA] [varchar](6) NULL,
	[COD_MONEDA] [varchar](4) NULL,
	[CLASIFICACION_MONEDA] [varchar](10) NULL,
	[TIPO_DE_CAMBIO_MON] [numeric](21, 4) NULL,
	[TIPO_DE_CAMBIO_USD] [numeric](21, 4) NULL,
	[CODIGOPRODUCTO] [varchar](20) NULL,
	[RIESGO_NORMATIVO] [int] NULL,
	[CANASTA_1] [numeric](21, 4) NULL,
	[CANASTA_2] [numeric](21, 4) NULL,
	[ADDON] [numeric](21, 4) NULL,
	[FECHA_PROCESO] [datetime] NULL,
	[MTM] [decimal](18, 0) NULL,
	[MONTO_AFECTO] [decimal](18, 0) NULL
) ON [PRIMARY]
GO
