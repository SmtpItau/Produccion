USE [BacTraderSuda]
GO
/****** Object:  Table [bacuser].[MDCV_FinMesJun2012]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[MDCV_FinMesJun2012](
	[cvrutcart] [numeric](9, 0) NULL,
	[cvnumdocu] [numeric](10, 0) NULL,
	[cvcorrela] [numeric](3, 0) NULL,
	[cvnumoper] [numeric](10, 0) NULL,
	[cvcantcort] [numeric](19, 4) NULL,
	[cvmtocort] [numeric](19, 4) NULL,
	[cvstatreg] [char](1) NULL,
	[cvtipoper] [char](3) NULL
) ON [PRIMARY]
GO
