USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TMP_CHANGE_TASA_VI]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMP_CHANGE_TASA_VI](
	[VINUMDOCU] [numeric](10, 0) NULL,
	[VICORRELA] [numeric](3, 0) NULL,
	[VINUMOPER] [numeric](10, 0) NULL,
	[vitircomp] [numeric](8, 4) NULL,
	[tasa_mercado] [numeric](19, 4) NULL,
	[tasa_compra] [numeric](8, 4) NOT NULL
) ON [PRIMARY]
GO
