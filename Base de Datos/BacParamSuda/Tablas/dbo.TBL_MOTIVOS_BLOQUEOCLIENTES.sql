USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_MOTIVOS_BLOQUEOCLIENTES]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MOTIVOS_BLOQUEOCLIENTES](
	[codMotivo] [numeric](5, 0) NOT NULL,
	[descMotivo] [varchar](70) NOT NULL
) ON [PRIMARY]
GO
