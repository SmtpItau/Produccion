USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEARB]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEARB](
	[arbnumope] [numeric](7, 0) NOT NULL,
	[arbtipope] [char](1) NOT NULL,
	[arbcodmon] [char](3) NOT NULL,
	[arbcodcnv] [char](3) NOT NULL,
	[arbmtomex] [numeric](19, 2) NOT NULL,
	[arbmtomus] [numeric](19, 2) NOT NULL,
	[arbmtomch] [numeric](19, 0) NOT NULL,
	[arbparida] [numeric](19, 4) NOT NULL,
	[arbobserv] [numeric](19, 4) NOT NULL,
	[arbticamx] [numeric](19, 4) NOT NULL,
	[arbnomcli] [char](35) NOT NULL,
	[arbrutcli] [numeric](9, 0) NOT NULL,
	[arbcodcli] [numeric](9, 0) NOT NULL,
	[arbrecibi] [numeric](2, 0) NOT NULL,
	[arbentreg] [numeric](2, 0) NOT NULL,
	[arbvalrec] [datetime] NOT NULL,
	[arbvalent] [datetime] NOT NULL,
	[arbparref] [numeric](19, 4) NOT NULL,
	[arbmtoref] [numeric](19, 2) NOT NULL,
	[arbdifref] [numeric](19, 2) NOT NULL,
	[arbprcref] [numeric](19, 4) NOT NULL,
	[arbfecha] [datetime] NOT NULL,
	[arbhora] [char](8) NOT NULL,
	[arbuser] [char](10) NOT NULL,
	[arbstatus] [char](1) NOT NULL,
	[arbproduc] [numeric](3, 0) NOT NULL,
	[arbcoda] [numeric](5, 0) NOT NULL,
	[arbcode] [numeric](5, 0) NOT NULL,
	[arbcodd] [numeric](5, 0) NOT NULL,
	[arbterm] [char](15) NOT NULL,
	[arbfecini] [datetime] NOT NULL,
	[arbnumfut] [numeric](8, 0) NOT NULL,
	[arbmtusbh] [numeric](19, 2) NOT NULL,
	[arbcodoma] [numeric](3, 0) NOT NULL,
	[arbtipcar] [numeric](3, 0) NOT NULL,
	[arbseek] [char](1) NOT NULL,
	[arbcodswc] [char](11) NOT NULL,
	[arbcodswr] [char](11) NOT NULL,
	[arbcuenta] [char](30) NOT NULL,
	[arbcodswe] [char](11) NOT NULL,
	[arbentidad] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK__mearb__ARBENTIDA__40CF895A] PRIMARY KEY CLUSTERED 
(
	[arbnumope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBNUMOPE__41C3AD93]  DEFAULT (0) FOR [arbnumope]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBTIPOPE__42B7D1CC]  DEFAULT (' ') FOR [arbtipope]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODMON__43ABF605]  DEFAULT (' ') FOR [arbcodmon]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODCNV__44A01A3E]  DEFAULT (' ') FOR [arbcodcnv]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBMTOMEX__45943E77]  DEFAULT (0.0) FOR [arbmtomex]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBMTOMUS__468862B0]  DEFAULT (0.0) FOR [arbmtomus]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBMTOMCH__477C86E9]  DEFAULT (0) FOR [arbmtomch]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBPARIDA__4870AB22]  DEFAULT (0.0) FOR [arbparida]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBOBSERV__4964CF5B]  DEFAULT (0.0) FOR [arbobserv]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBTICAMX__4A58F394]  DEFAULT (0.0) FOR [arbticamx]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBNOMCLI__4B4D17CD]  DEFAULT (' ') FOR [arbnomcli]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBRUTCLI__4C413C06]  DEFAULT (0) FOR [arbrutcli]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODCLI__4D35603F]  DEFAULT (0) FOR [arbcodcli]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBRECIBI__4E298478]  DEFAULT (0) FOR [arbrecibi]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBENTREG__4F1DA8B1]  DEFAULT (0) FOR [arbentreg]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBVALREC__5011CCEA]  DEFAULT (' ') FOR [arbvalrec]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBVALENT__5105F123]  DEFAULT (' ') FOR [arbvalent]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBPARREF__51FA155C]  DEFAULT (0.0) FOR [arbparref]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBMTOREF__52EE3995]  DEFAULT (0.0) FOR [arbmtoref]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBDIFREF__53E25DCE]  DEFAULT (0.0) FOR [arbdifref]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBPRCREF__54D68207]  DEFAULT (0.0) FOR [arbprcref]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBFECHA__55CAA640]  DEFAULT (' ') FOR [arbfecha]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBHORA__56BECA79]  DEFAULT (' ') FOR [arbhora]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBUSER__57B2EEB2]  DEFAULT (' ') FOR [arbuser]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBSTATUS__58A712EB]  DEFAULT (' ') FOR [arbstatus]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBPRODUC__599B3724]  DEFAULT (0) FOR [arbproduc]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODA__5A8F5B5D]  DEFAULT (0) FOR [arbcoda]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODE__5B837F96]  DEFAULT (0) FOR [arbcode]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODD__5C77A3CF]  DEFAULT (0) FOR [arbcodd]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBTERM__5D6BC808]  DEFAULT (' ') FOR [arbterm]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBFECINI__5E5FEC41]  DEFAULT (' ') FOR [arbfecini]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBNUMFUT__5F54107A]  DEFAULT (0) FOR [arbnumfut]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBMTUSBH__604834B3]  DEFAULT (0.0) FOR [arbmtusbh]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODOMA__613C58EC]  DEFAULT (0) FOR [arbcodoma]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBTIPCAR__62307D25]  DEFAULT (0) FOR [arbtipcar]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBSEEK__6324A15E]  DEFAULT (' ') FOR [arbseek]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODSWC__6418C597]  DEFAULT (' ') FOR [arbcodswc]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODSWR__650CE9D0]  DEFAULT (' ') FOR [arbcodswr]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCUENTA__66010E09]  DEFAULT (' ') FOR [arbcuenta]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBCODSWE__66F53242]  DEFAULT (' ') FOR [arbcodswe]
GO
ALTER TABLE [dbo].[MEARB] ADD  CONSTRAINT [DF__mearb__ARBENTIDA__67E9567B]  DEFAULT (0) FOR [arbentidad]
GO
