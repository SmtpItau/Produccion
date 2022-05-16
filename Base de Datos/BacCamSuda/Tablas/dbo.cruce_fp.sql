USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[cruce_fp]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cruce_fp](
	[clipperfwd] [numeric](3, 0) NOT NULL,
	[clipperspt] [numeric](3, 0) NOT NULL,
	[sql] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cruce_fp] ADD  DEFAULT (0) FOR [clipperfwd]
GO
ALTER TABLE [dbo].[cruce_fp] ADD  DEFAULT (0) FOR [clipperspt]
GO
ALTER TABLE [dbo].[cruce_fp] ADD  DEFAULT (0) FOR [sql]
GO
