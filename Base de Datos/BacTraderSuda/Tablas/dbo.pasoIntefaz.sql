USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[pasoIntefaz]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pasoIntefaz](
	[cuenta] [char](12) NULL,
	[moneda] [numeric](9, 0) NOT NULL,
	[tipo_tasa] [numeric](1, 0) NULL,
	[fecven] [char](8) NULL,
	[amortizacion] [numeric](19, 4) NULL,
	[tir] [numeric](19, 4) NULL,
	[saldo] [numeric](19, 4) NULL,
	[inversion] [numeric](5, 0) NULL,
	[tipo_cuenta] [char](2) NULL,
	[mascara] [char](12) NULL
) ON [PRIMARY]
GO
