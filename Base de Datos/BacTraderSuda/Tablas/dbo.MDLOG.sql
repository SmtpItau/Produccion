USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLOG]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLOG](
	[Logevento] [char](20) NOT NULL,
	[Logterm] [char](12) NOT NULL,
	[Loguser] [char](10) NOT NULL,
	[logfecha] [datetime] NOT NULL,
	[loghorai] [char](10) NOT NULL,
	[loghoraf] [char](10) NOT NULL,
	[logmensaje] [char](255) NOT NULL,
	[logtipoope] [numeric](1, 0) NOT NULL,
	[logtiposis] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO
