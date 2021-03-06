USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LOG_USUARIO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG_USUARIO](
	[logsistema] [char](3) NOT NULL,
	[loguser] [char](10) NOT NULL,
	[logfecha] [datetime] NOT NULL,
	[logfechaapp] [datetime] NOT NULL,
	[loghora] [char](10) NOT NULL,
	[logevento] [char](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[logsistema] ASC,
	[loguser] ASC,
	[logfecha] ASC,
	[loghora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
