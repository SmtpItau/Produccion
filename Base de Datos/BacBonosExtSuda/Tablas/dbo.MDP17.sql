USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[MDP17]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDP17](
	[nomcli] [char](40) NOT NULL,
	[rutcli] [char](11) NOT NULL,
	[fecpro] [char](10) NOT NULL,
	[familia] [char](20) NOT NULL,
	[ctabcch] [int] NOT NULL,
	[moneda] [int] NOT NULL,
	[compinst] [int] NOT NULL,
	[vpresente] [numeric](19, 0) NOT NULL,
	[vmercado] [numeric](19, 0) NOT NULL,
	[salnomi] [numeric](19, 0) NOT NULL
) ON [PRIMARY]
GO
