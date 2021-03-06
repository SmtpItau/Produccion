USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ENTIDAD]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENTIDAD](
	[rccodcar] [numeric](10, 0) NOT NULL,
	[rcrut] [numeric](9, 0) NOT NULL,
	[rcdv] [char](1) NULL,
	[rcnombre] [char](50) NULL,
	[rcnumoper] [numeric](9, 0) NULL,
	[rctelefono] [char](30) NULL,
	[rcfax] [char](30) NULL,
	[rcdirecc] [char](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[rccodcar] ASC,
	[rcrut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rcdv__3AAE325E]  DEFAULT ('') FOR [rcdv]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rcnombr__3BA25697]  DEFAULT ('') FOR [rcnombre]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rcnumop__3C967AD0]  DEFAULT (0) FOR [rcnumoper]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rctelef__3D8A9F09]  DEFAULT ('') FOR [rctelefono]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rcfax__3E7EC342]  DEFAULT ('') FOR [rcfax]
GO
ALTER TABLE [dbo].[ENTIDAD] ADD  CONSTRAINT [DF__ENTIDAD__rcdirec__3F72E77B]  DEFAULT ('') FOR [rcdirecc]
GO
