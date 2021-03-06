USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbl_stdChtd_status]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_stdChtd_status](
	[Fecha] [datetime] NOT NULL,
	[Source] [varchar](3) NOT NULL,
	[SourceReference] [varchar](20) NOT NULL,
	[Correlativo] [numeric](10, 0) NOT NULL,
	[PureDealType] [smallint] NOT NULL,
	[DateOfDeal] [datetime] NOT NULL,
	[TimeOfDeal] [varchar](8) NOT NULL,
	[Revision] [tinyint] NOT NULL,
	[Read_Date] [datetime] NOT NULL,
	[Status] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[SourceReference] ASC,
	[PureDealType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_stdChtd_status] ADD  DEFAULT ('') FOR [Source]
GO
ALTER TABLE [dbo].[tbl_stdChtd_status] ADD  DEFAULT (1) FOR [Correlativo]
GO
ALTER TABLE [dbo].[tbl_stdChtd_status] ADD  DEFAULT ('P') FOR [Status]
GO
