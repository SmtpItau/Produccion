USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDMM]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDMM](
	[mmnumoper] [numeric](10, 0) NULL,
	[mmnumdocu] [numeric](10, 0) NULL,
	[mmrutcart] [numeric](9, 0) NULL,
	[mmcorrela] [numeric](3, 0) NULL,
	[mmvptirc] [numeric](19, 4) NULL,
	[mmtirc] [numeric](9, 4) NULL,
	[mmtasarg] [numeric](7, 4) NULL,
	[mmvalor] [numeric](19, 4) NULL,
	[mmtipoper] [char](5) NULL,
	[mmcorvent] [numeric](3, 0) NULL,
	[mminstser] [char](12) NULL,
	[mmfecven] [datetime] NULL,
	[mmrango1] [numeric](5, 2) NULL,
	[mmrango2] [numeric](5, 2) NULL,
	[mmrutemp] [char](12) NULL,
	[mmnomemp] [char](30) NULL,
	[mmutil] [numeric](19, 0) NULL,
	[mmfecpro] [datetime] NULL,
	[mmcodinst] [char](10) NULL,
	[mmfecini] [datetime] NULL,
	[mmfecter] [datetime] NULL,
	[mmmoneda] [char](5) NULL,
	[mmnominal] [numeric](19, 4) NULL,
	[mmpvp] [numeric](9, 4) NULL,
	[mmvp_um] [numeric](19, 4) NULL,
	[mmvan] [float] NOT NULL,
	[mmvpar] [float] NULL,
	[mmvalor_prox] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDMM] ADD  CONSTRAINT [DF__MDMM__mmvan__7CDA51C0]  DEFAULT (0) FOR [mmvan]
GO
ALTER TABLE [dbo].[MDMM] ADD  CONSTRAINT [DF__MDMM__mmvpar__7DCE75F9]  DEFAULT (0) FOR [mmvpar]
GO
ALTER TABLE [dbo].[MDMM] ADD  CONSTRAINT [DF__MDMM__mmvalor_pr__7EC29A32]  DEFAULT (0) FOR [mmvalor_prox]
GO
