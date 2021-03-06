USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdc08]    Script Date: 13-05-2022 12:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdc08](
	[cuenta] [char](12) NULL,
	[moneda] [numeric](9, 0) NULL,
	[tipo_tasa] [numeric](1, 0) NULL,
	[fechaven] [datetime] NULL,
	[amortizacion] [numeric](19, 4) NULL,
	[tir] [numeric](19, 4) NULL,
	[saldo] [numeric](19, 4) NULL,
	[inversion] [numeric](5, 0) NULL,
	[tipo_cuenta] [char](2) NULL,
	[mascara] [char](12) NULL,
	[inumdocu] [numeric](10, 0) NULL,
	[inumoper] [numeric](10, 0) NULL,
	[icorre] [numeric](3, 0) NULL,
	[interes] [numeric](19, 4) NULL,
	[cupon] [int] NULL
) ON [PRIMARY]
GO
