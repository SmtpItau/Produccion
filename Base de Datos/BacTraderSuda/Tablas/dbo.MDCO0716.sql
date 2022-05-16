USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCO0716]    Script Date: 13-05-2022 12:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCO0716](
	[corutcart] [numeric](9, 0) NOT NULL,
	[conumdocu] [numeric](10, 0) NOT NULL,
	[cocorrela] [numeric](3, 0) NOT NULL,
	[comtocort] [numeric](19, 4) NOT NULL,
	[cocantcortd] [numeric](9, 0) NOT NULL,
	[cocantcorto] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
