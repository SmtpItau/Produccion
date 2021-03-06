USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_SBIF]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_SBIF](
	[sbrut] [numeric](9, 0) NOT NULL,
	[sbdv] [char](1) NOT NULL,
	[sbserbol] [char](20) NOT NULL,
	[sbfecemi] [datetime] NOT NULL,
	[sbinst] [char](3) NOT NULL,
	[sbmoneda] [char](1) NOT NULL,
	[sbfactor] [numeric](17, 5) NOT NULL,
	[sbnemo] [char](7) NOT NULL,
	[sbserie] [char](20) NULL
) ON [PRIMARY]
GO
