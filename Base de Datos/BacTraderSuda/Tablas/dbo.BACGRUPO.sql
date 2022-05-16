USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BACGRUPO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BACGRUPO](
	[grupo] [numeric](2, 0) NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[cantidad] [numeric](3, 0) NOT NULL,
	[feccrea] [datetime] NOT NULL,
	[fecmod] [datetime] NOT NULL
) ON [PRIMARY]
GO
