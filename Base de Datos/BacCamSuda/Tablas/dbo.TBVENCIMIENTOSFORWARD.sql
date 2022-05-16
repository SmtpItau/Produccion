USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBVENCIMIENTOSFORWARD]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBVENCIMIENTOSFORWARD](
	[moentidad] [numeric](10, 0) NOT NULL,
	[motipmer] [char](4) NOT NULL,
	[motipope] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[mocodmon] [char](3) NOT NULL,
	[mocodcnv] [char](3) NOT NULL,
	[momonmo] [numeric](19, 4) NOT NULL,
	[moticam] [numeric](19, 4) NOT NULL,
	[moparme] [numeric](19, 8) NOT NULL,
	[moprecio] [numeric](19, 4) NOT NULL,
	[moussme] [numeric](19, 4) NOT NULL,
	[momonpe] [numeric](19, 4) NOT NULL,
	[moentre] [numeric](3, 0) NOT NULL,
	[morecib] [numeric](3, 0) NOT NULL,
	[movaluta1] [datetime] NOT NULL,
	[movaluta2] [datetime] NOT NULL,
	[mooper] [char](15) NOT NULL,
	[mofech] [datetime] NOT NULL,
	[mohora] [char](8) NOT NULL,
	[moterm] [char](12) NOT NULL,
	[motipcar] [numeric](3, 0) NOT NULL,
	[monumfut] [numeric](8, 0) NOT NULL,
	[mofecini] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOENT__398503FB]  DEFAULT (0) FOR [moentidad]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOTIP__3A792834]  DEFAULT ('') FOR [motipmer]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOTIP__3B6D4C6D]  DEFAULT ('') FOR [motipope]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MORUT__3C6170A6]  DEFAULT (0) FOR [morutcli]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOCOD__3D5594DF]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOCOD__3E49B918]  DEFAULT ('') FOR [mocodmon]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOCOD__3F3DDD51]  DEFAULT ('') FOR [mocodcnv]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOMON__4032018A]  DEFAULT (0) FOR [momonmo]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOTIC__412625C3]  DEFAULT (0) FOR [moticam]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOPAR__421A49FC]  DEFAULT (0) FOR [moparme]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOPRE__430E6E35]  DEFAULT (0) FOR [moprecio]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOUSS__4402926E]  DEFAULT (0) FOR [moussme]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOMON__44F6B6A7]  DEFAULT (0) FOR [momonpe]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOENT__45EADAE0]  DEFAULT (0) FOR [moentre]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOREC__46DEFF19]  DEFAULT (0) FOR [morecib]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOVAL__47D32352]  DEFAULT ('') FOR [movaluta1]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOVAL__48C7478B]  DEFAULT ('') FOR [movaluta2]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOOPE__49BB6BC4]  DEFAULT ('') FOR [mooper]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOFEC__4AAF8FFD]  DEFAULT ('') FOR [mofech]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOHOR__4BA3B436]  DEFAULT ('') FOR [mohora]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOTER__4C97D86F]  DEFAULT ('') FOR [moterm]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOTIP__4D8BFCA8]  DEFAULT (0) FOR [motipcar]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MONUM__4E8020E1]  DEFAULT (0) FOR [monumfut]
GO
ALTER TABLE [dbo].[TBVENCIMIENTOSFORWARD] ADD  CONSTRAINT [DF__tbVencimi__MOFEC__4F74451A]  DEFAULT ('') FOR [mofecini]
GO
