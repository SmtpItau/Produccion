USE [Reportes]
GO
/****** Object:  Table [dbo].[CNT_AUX_DET_RENTABILIDAD_RF]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CNT_AUX_DET_RENTABILIDAD_RF](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[moneda] [char](6) NULL
) ON [Reportes_Data_01]
GO
