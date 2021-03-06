USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdrs_Itau_AjustePPA]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdrs_Itau_AjustePPA](
	[rsfecha] [datetime] NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rscorrela] [numeric](3, 0) NOT NULL,
	[rsnominal] [numeric](38, 4) NULL,
	[rsvalcomp] [numeric](38, 4) NULL,
	[rsvalcomu] [numeric](38, 4) NULL
) ON [PRIMARY]
GO
