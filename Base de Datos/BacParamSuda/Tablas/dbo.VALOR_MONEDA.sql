USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VALOR_MONEDA]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALOR_MONEDA](
	[vmcodigo] [numeric](5, 0) NOT NULL,
	[vmvalor] [float] NOT NULL,
	[vmptacmp] [float] NOT NULL,
	[vmptavta] [float] NOT NULL,
	[vmfecha] [datetime] NOT NULL,
	[vmtipo] [char](1) NOT NULL,
	[vmparidad] [numeric](19, 4) NOT NULL,
	[vmparmer] [numeric](9, 4) NOT NULL,
	[vmposini] [numeric](19, 4) NOT NULL,
	[vmprecoi] [numeric](9, 4) NOT NULL,
	[vmparini] [numeric](9, 4) NOT NULL,
	[vmprecoc] [numeric](9, 4) NOT NULL,
	[vmparidc] [numeric](9, 4) NOT NULL,
	[vmposic] [numeric](19, 4) NOT NULL,
	[vmpreco] [numeric](9, 4) NOT NULL,
	[vmpreve] [numeric](9, 4) NOT NULL,
	[vmpmeco] [numeric](9, 4) NOT NULL,
	[vmpmeve] [numeric](9, 4) NOT NULL,
	[vmtotco] [numeric](19, 4) NOT NULL,
	[vmtotve] [numeric](19, 4) NOT NULL,
	[vmutili] [numeric](19, 0) NOT NULL,
	[vmparco] [numeric](19, 4) NOT NULL,
	[vmparve] [numeric](19, 4) NOT NULL,
	[vmorden] [numeric](3, 0) NOT NULL,
	[vmctacmb] [numeric](19, 0) NOT NULL,
	[vmcmbini] [numeric](19, 0) NOT NULL,
	[vmreval] [char](1) NOT NULL,
	[vmarbit] [char](1) NOT NULL,
	[vmparmer1] [numeric](12, 4) NOT NULL,
	[vmnumstgo] [numeric](3, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vmcodigo] ASC,
	[vmfecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpta__61A803EE]  DEFAULT (0) FOR [vmptacmp]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpta__629C2827]  DEFAULT (0) FOR [vmptavta]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmfec__63904C60]  DEFAULT ('') FOR [vmfecha]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmtip__64847099]  DEFAULT ('') FOR [vmtipo]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__657894D2]  DEFAULT (0) FOR [vmparidad]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__666CB90B]  DEFAULT (0) FOR [vmparmer]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpos__6760DD44]  DEFAULT (0) FOR [vmposini]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpre__6855017D]  DEFAULT (0) FOR [vmprecoi]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__694925B6]  DEFAULT (0) FOR [vmparini]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpre__6A3D49EF]  DEFAULT (0) FOR [vmprecoc]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__6B316E28]  DEFAULT (0) FOR [vmparidc]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpos__6C259261]  DEFAULT (0) FOR [vmposic]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpre__6D19B69A]  DEFAULT (0) FOR [vmpreco]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpre__6E0DDAD3]  DEFAULT (0) FOR [vmpreve]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpme__6F01FF0C]  DEFAULT (0) FOR [vmpmeco]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpme__6FF62345]  DEFAULT (0) FOR [vmpmeve]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmtot__70EA477E]  DEFAULT (0) FOR [vmtotco]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmtot__71DE6BB7]  DEFAULT (0) FOR [vmtotve]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmuti__72D28FF0]  DEFAULT (0) FOR [vmutili]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__73C6B429]  DEFAULT (0) FOR [vmparco]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__74BAD862]  DEFAULT (0) FOR [vmparve]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmord__75AEFC9B]  DEFAULT (0) FOR [vmorden]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmcta__76A320D4]  DEFAULT (0) FOR [vmctacmb]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmcmb__7797450D]  DEFAULT (0) FOR [vmcmbini]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmrev__788B6946]  DEFAULT ('') FOR [vmreval]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmarb__797F8D7F]  DEFAULT ('') FOR [vmarbit]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmpar__7A73B1B8]  DEFAULT (0) FOR [vmparmer1]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF__VALOR_MON__Vmnum__7B67D5F1]  DEFAULT (0) FOR [vmnumstgo]
GO
