USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SINACOFI]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINACOFI](
	[clrut] [numeric](10, 0) NOT NULL,
	[clcodigo] [numeric](10, 0) NOT NULL,
	[clnumsinacofi] [char](4) NOT NULL,
	[clnomsinacofi] [char](4) NOT NULL,
	[datatec] [char](5) NOT NULL,
	[bolsa] [char](10) NOT NULL,
	[nombredata] [char](70) NOT NULL,
	[standardChartered] [char](10) NULL,
	[barclays] [char](10) NULL,
	[citibank] [char](10) NULL,
	[SourceBac] [char](3) NULL,
	[BankDealinkCoded] [varchar](20) NULL,
	[Terminal] [varchar](20) NULL,
	[System] [varchar](50) NULL,
	[SOfData] [int] NULL,
	[CodigoSwifth] [varchar](20) NOT NULL,
	[PlataformaExterna] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clrut] ASC,
	[clcodigo] ASC,
	[clnumsinacofi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  CONSTRAINT [DF__SINACOFI__Datate__76590811]  DEFAULT ('') FOR [datatec]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  CONSTRAINT [DF__SINACOFI__Bolsa__774D2C4A]  DEFAULT ('') FOR [bolsa]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT ('') FOR [nombredata]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT ('') FOR [standardChartered]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT ('') FOR [barclays]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT ('') FOR [citibank]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT ('') FOR [CodigoSwifth]
GO
ALTER TABLE [dbo].[SINACOFI] ADD  DEFAULT (0) FOR [PlataformaExterna]
GO
