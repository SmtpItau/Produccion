USE [MDPasivo]
GO
/****** Object:  Table [dbo].[ENTIDAD]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENTIDAD](
	[rccodcar] [numeric](10, 0) NOT NULL,
	[rcrut] [numeric](10, 0) NOT NULL,
	[rcdv] [char](1) NULL,
	[rcnombre] [char](50) NULL,
	[rcnumoper] [numeric](9, 0) NULL,
	[rctelefono] [char](30) NULL,
	[rcfax] [char](30) NULL,
	[rcdirecc] [char](50) NULL
) ON [PRIMARY]
GO
