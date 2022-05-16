USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfcch]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfcch](
	[ccposcmp] [numeric](3, 0) NOT NULL,
	[ccopecmp] [numeric](10, 0) NOT NULL,
	[ccposvta] [numeric](3, 0) NOT NULL,
	[ccopevta] [numeric](10, 0) NOT NULL,
	[ccmonto] [numeric](21, 4) NOT NULL,
	[ccfecven] [datetime] NOT NULL,
	[ccfecuact] [datetime] NOT NULL,
	[ccusuario] [char](10) NOT NULL
) ON [PRIMARY]
GO
