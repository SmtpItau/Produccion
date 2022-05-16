USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_RELACIONES]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RELACIONES](
	[Rel_IdCodigo1] [char](10) NOT NULL,
	[Rel_IdCodigo2] [char](10) NOT NULL,
	[Rel_IdRelacion1] [char](10) NOT NULL,
	[Rel_IdRelacion2] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RELACIONES] ADD  CONSTRAINT [DF__TBL_RELAC__Rel_I__33F57C80]  DEFAULT ('') FOR [Rel_IdRelacion2]
GO
