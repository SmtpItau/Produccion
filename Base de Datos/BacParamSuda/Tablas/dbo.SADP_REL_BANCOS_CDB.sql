USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_REL_BANCOS_CDB]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_REL_BANCOS_CDB](
	[ban_id] [varchar](4) NOT NULL,
	[ban_codigo] [varchar](10) NOT NULL,
	[ban_nombre] [varchar](30) NOT NULL,
	[ban_emisor] [varchar](10) NOT NULL,
	[ban_equivale] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
