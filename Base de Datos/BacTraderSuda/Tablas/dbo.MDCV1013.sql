USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCV1013]    Script Date: 13-05-2022 12:16:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCV1013](
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
