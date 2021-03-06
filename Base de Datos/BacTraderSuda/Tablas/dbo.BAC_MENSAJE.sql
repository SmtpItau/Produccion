USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_MENSAJE]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_MENSAJE](
	[user_envia] [char](10) NULL,
	[mensaje] [char](255) NULL,
	[user_rte] [char](10) NULL,
	[correla] [float] NULL,
	[tipo] [numeric](4, 0) NULL,
	[fecha] [datetime] NULL,
	[hora] [char](10) NULL
) ON [PRIMARY]
GO
