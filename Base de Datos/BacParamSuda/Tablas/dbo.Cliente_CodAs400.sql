USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Cliente_CodAs400]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente_CodAs400](
	[clrut] [numeric](9, 0) NOT NULL,
	[clcodigo] [numeric](9, 0) NOT NULL,
	[clnombre] [char](70) NULL,
	[Codigo_AS400] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
