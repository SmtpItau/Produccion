USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tmp_monedafactor]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_monedafactor](
	[mncodmon] [numeric](5, 0) NOT NULL,
	[mnfactor] [numeric](9, 0) NULL
) ON [PRIMARY]
GO
