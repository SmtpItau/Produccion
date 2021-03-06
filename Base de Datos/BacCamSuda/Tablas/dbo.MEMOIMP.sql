USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEMOIMP]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMOIMP](
	[monumope] [numeric](7, 0) NOT NULL,
	[motipope] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[mocodmon] [char](3) NOT NULL,
	[momonmo] [numeric](19, 4) NOT NULL,
	[moussme] [numeric](19, 4) NOT NULL,
	[moticam] [numeric](19, 4) NOT NULL,
	[motctra] [numeric](19, 4) NOT NULL,
	[motcfin] [numeric](19, 4) NOT NULL,
	[moparme] [numeric](19, 8) NOT NULL,
	[mopar30] [numeric](19, 8) NOT NULL,
	[moparfi] [numeric](19, 8) NOT NULL,
	[mooper] [char](10) NOT NULL,
	[mofech] [datetime] NOT NULL,
	[motipmer] [char](4) NOT NULL,
	[spread] [numeric](19, 4) NOT NULL,
	[resul] [numeric](19, 4) NOT NULL,
	[spreadf] [numeric](19, 4) NOT NULL,
	[resulf] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MONUMOP__55BFB948]  DEFAULT (0) FOR [monumope]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOTIPOP__56B3DD81]  DEFAULT ('') FOR [motipope]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MORUTCL__57A801BA]  DEFAULT (0) FOR [morutcli]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOCODCL__589C25F3]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOCODMO__59904A2C]  DEFAULT ('') FOR [mocodmon]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOMONMO__5A846E65]  DEFAULT (0) FOR [momonmo]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOUSSME__5B78929E]  DEFAULT (0) FOR [moussme]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOTICAM__5C6CB6D7]  DEFAULT (0) FOR [moticam]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOTCTRA__5D60DB10]  DEFAULT (0) FOR [motctra]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOTCFIN__5E54FF49]  DEFAULT (0) FOR [motcfin]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOPARME__5F492382]  DEFAULT (0) FOR [moparme]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOPAR30__603D47BB]  DEFAULT (0) FOR [mopar30]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOPARFI__61316BF4]  DEFAULT (0) FOR [moparfi]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOOPER__6225902D]  DEFAULT ('') FOR [mooper]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOFECH__6319B466]  DEFAULT ('') FOR [mofech]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__MOTIPME__640DD89F]  DEFAULT ('') FOR [motipmer]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__SPREAD__6501FCD8]  DEFAULT (0) FOR [spread]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__RESUL__65F62111]  DEFAULT (0) FOR [resul]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__SPREADF__66EA454A]  DEFAULT (0) FOR [spreadf]
GO
ALTER TABLE [dbo].[MEMOIMP] ADD  CONSTRAINT [DF__memoimp__RESULF__67DE6983]  DEFAULT (0) FOR [resulf]
GO
