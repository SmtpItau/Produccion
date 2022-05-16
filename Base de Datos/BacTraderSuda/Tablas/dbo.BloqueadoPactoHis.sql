USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BloqueadoPactoHis]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloqueadoPactoHis](
	[bpfechaProc] [datetime] NOT NULL,
	[bpnumdocu] [numeric](10, 0) NOT NULL,
	[bpcorrela] [numeric](3, 0) NOT NULL,
	[bpnominal] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
