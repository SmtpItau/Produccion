USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_modalidad_cosif]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_modalidad_cosif](
	[cosif] [nvarchar](25) NULL,
	[tituloscontables] [nvarchar](100) NULL,
	[modalidad] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
