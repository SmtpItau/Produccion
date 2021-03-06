USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[DETALLE_VOUCHER_31012015]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VOUCHER_31012015](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Cuenta] [char](20) NOT NULL,
	[Tipo_Monto] [char](1) NOT NULL,
	[Monto] [float] NOT NULL,
	[MonedaCuenta] [numeric](5, 0) NOT NULL,
	[CtaCorresponsal] [char](10) NOT NULL
) ON [PRIMARY]
GO
