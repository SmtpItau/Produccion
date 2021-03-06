USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRP]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRP](
	[lrprutcl] [numeric](9, 0) NOT NULL,
	[lrpcodprod] [numeric](5, 0) NOT NULL,
	[lrpmaximo] [numeric](19, 0) NOT NULL,
	[lrpocupado] [numeric](19, 0) NOT NULL,
	[lrpsaldo] [numeric](19, 0) NOT NULL,
	[lrpplazo] [numeric](4, 0) NOT NULL,
	[lrpexpirac] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrprutcl__53584DE9]  DEFAULT (0) FOR [lrprutcl]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpcodpro__544C7222]  DEFAULT (0) FOR [lrpcodprod]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpmaximo__5540965B]  DEFAULT (0) FOR [lrpmaximo]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpocupad__5634BA94]  DEFAULT (0) FOR [lrpocupado]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpsaldo__5728DECD]  DEFAULT (0) FOR [lrpsaldo]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpplazo__581D0306]  DEFAULT (0) FOR [lrpplazo]
GO
ALTER TABLE [dbo].[MDLRP] ADD  CONSTRAINT [DF__mdlrp__lrpexpira__5911273F]  DEFAULT (' ') FOR [lrpexpirac]
GO
