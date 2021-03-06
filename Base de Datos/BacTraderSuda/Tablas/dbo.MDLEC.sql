USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLEC]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLEC](
	[leccodigo] [numeric](9, 0) NOT NULL,
	[leccodint] [numeric](4, 0) NOT NULL,
	[lecriesgo] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLEC] ADD  CONSTRAINT [DF__mdlec__leccodigo__7B9B496D]  DEFAULT (0) FOR [leccodigo]
GO
ALTER TABLE [dbo].[MDLEC] ADD  CONSTRAINT [DF__mdlec__leccodint__7C8F6DA6]  DEFAULT (0) FOR [leccodint]
GO
ALTER TABLE [dbo].[MDLEC] ADD  CONSTRAINT [DF__mdlec__lecriesgo__7D8391DF]  DEFAULT (' ') FOR [lecriesgo]
GO
