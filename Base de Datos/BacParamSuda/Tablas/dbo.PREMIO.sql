USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PREMIO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PREMIO](
	[prcodigo] [numeric](3, 0) NOT NULL,
	[prserie] [char](12) NOT NULL,
	[prcupon] [numeric](3, 0) NOT NULL,
	[prpremio] [numeric](9, 4) NOT NULL
) ON [PRIMARY]
GO
