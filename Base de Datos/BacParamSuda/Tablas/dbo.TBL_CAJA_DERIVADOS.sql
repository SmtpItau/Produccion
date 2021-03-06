USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CAJA_DERIVADOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CAJA_DERIVADOS](
	[Modulo] [varchar](3) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[Numero_Operacion] [numeric](12, 0) NOT NULL,
	[fechaLiquidacion] [date] NOT NULL,
	[Correlativo] [nchar](10) NOT NULL,
	[Rut_Contraparte] [numeric](13, 0) NULL,
	[Codigo_Contraparte] [numeric](5, 0) NULL,
	[Compra_moneda] [numeric](5, 0) NULL,
	[Venta_Moneda] [numeric](5, 0) NULL,
	[MonedaM1] [numeric](5, 0) NULL,
	[MontoM1] [numeric](19, 4) NULL,
	[FormaPago1] [numeric](5, 0) NOT NULL,
	[MonedaM2] [numeric](5, 0) NULL,
	[MontoM2] [numeric](19, 4) NULL,
	[FormaPago2] [numeric](5, 0) NOT NULL,
	[MontoM1Local] [numeric](19, 0) NULL,
	[MontoM2Local] [numeric](19, 4) NULL,
	[Modalidad_Pago] [varchar](1) NULL,
	[Tipo_Flujo] [numeric](1, 0) NOT NULL,
	[VctoNatural_Anticipo] [varchar](8) NOT NULL,
	[fecha_Inicio_Flujo] [datetime] NULL,
	[fecha_Vence_Flujo] [datetime] NULL,
	[Operador] [varchar](20) NULL,
 CONSTRAINT [PK_TBL_CAJA_DERIVADOS_1] PRIMARY KEY CLUSTERED 
(
	[Modulo] ASC,
	[Numero_Operacion] ASC,
	[fechaLiquidacion] ASC,
	[Correlativo] ASC,
	[Tipo_Flujo] ASC,
	[VctoNatural_Anticipo] ASC,
	[FormaPago1] ASC,
	[FormaPago2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
