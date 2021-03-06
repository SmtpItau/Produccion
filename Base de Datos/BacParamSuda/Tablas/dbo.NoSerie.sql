USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[NoSerie]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoSerie](
	[nsrutcart] [numeric](9, 0) NOT NULL,
	[nsnumdocu] [numeric](10, 0) NOT NULL,
	[nscorrela] [numeric](3, 0) NOT NULL,
	[nsrutemi] [numeric](9, 0) NOT NULL,
	[nsmonemi] [numeric](3, 0) NOT NULL,
	[nstasemi] [numeric](9, 4) NOT NULL,
	[nsbasemi] [numeric](3, 0) NOT NULL,
	[nsfecemi] [datetime] NOT NULL,
	[nsfecven] [datetime] NOT NULL,
	[nsserie] [char](12) NOT NULL,
	[nscodigo] [numeric](3, 0) NOT NULL,
	[corresponsal] [char](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nsrutcart] ASC,
	[nsnumdocu] ASC,
	[nscorrela] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsrutem__2EBD5CC5]  DEFAULT (0) FOR [nsrutemi]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsmonem__2FB180FE]  DEFAULT (0) FOR [nsmonemi]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nstasem__30A5A537]  DEFAULT (0) FOR [nstasemi]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsbasem__3199C970]  DEFAULT (0) FOR [nsbasemi]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsfecem__328DEDA9]  DEFAULT ('') FOR [nsfecemi]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsfecve__338211E2]  DEFAULT ('') FOR [nsfecven]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nsserie__3476361B]  DEFAULT ('') FOR [nsserie]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NoSerie__nscodig__356A5A54]  DEFAULT (0) FOR [nscodigo]
GO
ALTER TABLE [dbo].[NoSerie] ADD  CONSTRAINT [DF__NOSERIE__corresp__0A21A04A]  DEFAULT ('') FOR [corresponsal]
GO
