USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_LOG]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_LOG](
	[logsistema] [char](3) NOT NULL,
	[loguser] [char](10) NOT NULL,
	[logfecha] [datetime] NOT NULL,
	[loghora] [char](10) NOT NULL,
	[logevento] [char](255) NOT NULL
) ON [PRIMARY]
GO
