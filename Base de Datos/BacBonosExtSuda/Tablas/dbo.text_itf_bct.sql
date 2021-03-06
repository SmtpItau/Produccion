USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_itf_bct]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_itf_bct](
	[numdocu] [char](12) NOT NULL,
	[familia] [numeric](4, 0) NOT NULL,
	[instrumento] [char](20) NOT NULL,
	[vcto] [datetime] NOT NULL,
	[cuenta_bech] [char](15) NOT NULL,
	[cuenta_sbif] [numeric](4, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf___numdo__335592AB]  DEFAULT (' ') FOR [numdocu]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf___famil__3449B6E4]  DEFAULT (0) FOR [familia]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf___instr__353DDB1D]  DEFAULT (' ') FOR [instrumento]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf_b__vcto__3631FF56]  DEFAULT (' ') FOR [vcto]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf___cuent__3726238F]  DEFAULT (' ') FOR [cuenta_bech]
GO
ALTER TABLE [dbo].[text_itf_bct] ADD  CONSTRAINT [DF__text_itf___cuent__381A47C8]  DEFAULT (0) FOR [cuenta_sbif]
GO
