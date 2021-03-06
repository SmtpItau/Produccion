USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_INTER_PV03]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_INTER_PV03](
	[id_sistema] [char](3) NOT NULL,
	[rango] [char](5) NOT NULL,
	[periodo] [char](1) NOT NULL,
	[mto_act_uf] [float] NOT NULL,
	[dur_act_uf] [float] NOT NULL,
	[pv01_act_uf] [float] NOT NULL,
	[mto_act_clp] [float] NOT NULL,
	[dur_act_clp] [float] NOT NULL,
	[pv01_act_clp] [float] NOT NULL,
	[mto_act_usd] [float] NOT NULL,
	[dur_act_usd] [float] NOT NULL,
	[pv01_act_usd] [float] NOT NULL,
	[mto_act_mx] [float] NOT NULL,
	[dur_act_mx] [float] NOT NULL,
	[pv01_act_mx] [float] NOT NULL,
	[mto_pas_uf] [float] NOT NULL,
	[dur_pas_uf] [float] NOT NULL,
	[pv01_pas_uf] [float] NOT NULL,
	[mto_pas_clp] [float] NOT NULL,
	[dur_pas_clp] [float] NOT NULL,
	[pv01_pas_clp] [float] NOT NULL,
	[mto_pas_usd] [float] NOT NULL,
	[dur_pas_usd] [float] NOT NULL,
	[pv01_pas_usd] [float] NOT NULL,
	[mto_pas_mx] [float] NOT NULL,
	[dur_pas_mx] [float] NOT NULL,
	[pv01_pas_mx] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__id_si__5D2C9C3D]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__rango__5E20C076]  DEFAULT ('') FOR [rango]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__perio__5F14E4AF]  DEFAULT ('') FOR [periodo]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_a__600908E8]  DEFAULT (0) FOR [mto_act_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_a__60FD2D21]  DEFAULT (0) FOR [dur_act_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___61F1515A]  DEFAULT (0) FOR [pv01_act_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_a__62E57593]  DEFAULT (0) FOR [mto_act_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_a__63D999CC]  DEFAULT (0) FOR [dur_act_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___64CDBE05]  DEFAULT (0) FOR [pv01_act_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_a__65C1E23E]  DEFAULT (0) FOR [mto_act_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_a__66B60677]  DEFAULT (0) FOR [dur_act_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___67AA2AB0]  DEFAULT (0) FOR [pv01_act_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_a__689E4EE9]  DEFAULT (0) FOR [mto_act_mx]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_a__69927322]  DEFAULT (0) FOR [dur_act_mx]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___6A86975B]  DEFAULT (0) FOR [pv01_act_mx]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_p__6B7ABB94]  DEFAULT (0) FOR [mto_pas_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_p__6C6EDFCD]  DEFAULT (0) FOR [dur_pas_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___6D630406]  DEFAULT (0) FOR [pv01_pas_uf]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_p__6E57283F]  DEFAULT (0) FOR [mto_pas_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_p__6F4B4C78]  DEFAULT (0) FOR [dur_pas_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___703F70B1]  DEFAULT (0) FOR [pv01_pas_clp]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_p__713394EA]  DEFAULT (0) FOR [mto_pas_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_p__7227B923]  DEFAULT (0) FOR [dur_pas_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___731BDD5C]  DEFAULT (0) FOR [pv01_pas_usd]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__mto_p__74100195]  DEFAULT (0) FOR [mto_pas_mx]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__dur_p__750425CE]  DEFAULT (0) FOR [dur_pas_mx]
GO
ALTER TABLE [dbo].[BAC_INTER_PV03] ADD  CONSTRAINT [DF__bac_inter__pv01___75F84A07]  DEFAULT (0) FOR [pv01_pas_mx]
GO
