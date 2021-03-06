USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CAJA_DERIVADOS_DETALLE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CAJA_DERIVADOS_DETALLE](
	[Modulo] [varchar](3) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[Numero_Operacion] [numeric](12, 0) NOT NULL,
	[fechaLiquidacion] [date] NOT NULL,
	[Correlativo] [nchar](10) NOT NULL,
	[Tipo_Flujo] [numeric](1, 0) NOT NULL,
	[MonedaM1] [numeric](5, 0) NULL,
	[MonedaM2] [numeric](5, 0) NULL,
	[MontoM1] [numeric](19, 4) NULL,
	[MontoM2] [numeric](19, 4) NULL,
	[MontoM1Local] [numeric](19, 0) NULL,
	[MontoM2Local] [numeric](19, 4) NULL,
	[ValorMdaPagoCLP] [numeric](19, 4) NULL,
	[ValorMdaPataCLP] [numeric](19, 4) NULL,
	[ValorUSDCLP] [numeric](19, 4) NULL,
	[ParidadMdaPata] [numeric](19, 6) NULL,
	[ParidadMdaPago] [numeric](19, 6) NULL,
	[VctoNatural_Anticipo] [varchar](8) NOT NULL,
 CONSTRAINT [PK_TBL_CAJA_DERIVADOS_DETALLE1] PRIMARY KEY CLUSTERED 
(
	[Modulo] ASC,
	[Numero_Operacion] ASC,
	[fechaLiquidacion] ASC,
	[Correlativo] ASC,
	[Tipo_Flujo] ASC,
	[VctoNatural_Anticipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
