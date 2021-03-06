USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCO]    Script Date: 13-05-2022 12:16:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCO](
	[corutcart] [numeric](9, 0) NOT NULL,
	[conumdocu] [numeric](10, 0) NOT NULL,
	[cocorrela] [numeric](3, 0) NOT NULL,
	[comtocort] [numeric](19, 4) NOT NULL,
	[cocantcortd] [numeric](19, 0) NOT NULL,
	[cocantcorto] [numeric](19, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__corutcart__452EEE2D]  DEFAULT (0) FOR [corutcart]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__conumdocu__46231266]  DEFAULT (0) FOR [conumdocu]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__cocorrela__4717369F]  DEFAULT (0) FOR [cocorrela]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__comtocort__480B5AD8]  DEFAULT (0) FOR [comtocort]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__cocantcort__48FF7F11]  DEFAULT (0) FOR [cocantcortd]
GO
ALTER TABLE [dbo].[MDCO] ADD  CONSTRAINT [DF__MDCO__cocantcort__49F3A34A]  DEFAULT (0) FOR [cocantcorto]
GO
