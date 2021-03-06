USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDFE]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDFE](
	[feano] [numeric](4, 0) NOT NULL,
	[feplaza] [numeric](3, 0) NOT NULL,
	[feene] [char](100) NOT NULL,
	[fefeb] [char](100) NOT NULL,
	[femar] [char](100) NOT NULL,
	[feabr] [char](100) NOT NULL,
	[femay] [char](100) NOT NULL,
	[fejun] [char](100) NOT NULL,
	[fejul] [char](100) NOT NULL,
	[feago] [char](100) NOT NULL,
	[fesep] [char](100) NOT NULL,
	[feoct] [char](100) NOT NULL,
	[fenov] [char](100) NOT NULL,
	[fedic] [char](100) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feano__69DD573C]  DEFAULT (0) FOR [feano]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feplaza__6AD17B75]  DEFAULT (0) FOR [feplaza]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feene__6BC59FAE]  DEFAULT (' ') FOR [feene]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fefeb__6CB9C3E7]  DEFAULT (' ') FOR [fefeb]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__femar__6DADE820]  DEFAULT (' ') FOR [femar]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feabr__6EA20C59]  DEFAULT (' ') FOR [feabr]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__femay__6F963092]  DEFAULT (' ') FOR [femay]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fejun__708A54CB]  DEFAULT (' ') FOR [fejun]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fejul__717E7904]  DEFAULT (' ') FOR [fejul]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feago__72729D3D]  DEFAULT (' ') FOR [feago]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fesep__7366C176]  DEFAULT (' ') FOR [fesep]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__feoct__745AE5AF]  DEFAULT (' ') FOR [feoct]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fenov__754F09E8]  DEFAULT (' ') FOR [fenov]
GO
ALTER TABLE [dbo].[MDFE] ADD  CONSTRAINT [DF__mdfe__fedic__76432E21]  DEFAULT (' ') FOR [fedic]
GO
