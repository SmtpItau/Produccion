USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBDETALLEINTERESES]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBDETALLEINTERESES](
	[fecha] [datetime] NOT NULL,
	[planilla_fecha] [datetime] NOT NULL,
	[planilla_numero] [numeric](6, 0) NOT NULL,
	[correlativo] [numeric](3, 0) NOT NULL,
	[concepto_capital] [char](3) NOT NULL,
	[capital] [numeric](15, 2) NOT NULL,
	[tipo_interes] [char](2) NOT NULL,
	[codigo_base_tasa] [numeric](1, 0) NOT NULL,
	[tasa_interes_anual] [numeric](9, 6) NOT NULL,
	[fecha_inicial] [datetime] NOT NULL,
	[fecha_final] [datetime] NOT NULL,
	[monto_interes] [numeric](13, 2) NOT NULL,
	[indica_pago_exterior] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO
