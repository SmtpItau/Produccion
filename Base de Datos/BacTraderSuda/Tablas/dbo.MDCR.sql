USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCR]    Script Date: 13-05-2022 12:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCR](
	[crrutcart] [numeric](9, 0) NULL,
	[crnumdocu] [numeric](10, 0) NULL,
	[crnumoper] [numeric](10, 0) NULL,
	[crcorrela] [numeric](3, 0) NULL,
	[crinstser] [char](10) NULL,
	[crvalcomp] [numeric](19, 0) NULL,
	[crvalcomu] [float] NULL,
	[crnumucup] [numeric](3, 0) NULL,
	[crfecucup] [datetime] NULL,
	[crfecpcup] [datetime] NULL,
	[crvptirc] [numeric](19, 4) NULL,
	[crcapitalc] [numeric](19, 4) NULL,
	[crinteresc] [numeric](19, 0) NULL,
	[crreajustc] [numeric](19, 0) NULL,
	[crvalinip] [numeric](19, 0) NULL,
	[crintpac] [numeric](19, 0) NULL,
	[crreapac] [numeric](19, 0) NULL,
	[crvalpac] [numeric](19, 0) NULL,
	[crtircomp] [numeric](8, 4) NULL,
	[crmoneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
