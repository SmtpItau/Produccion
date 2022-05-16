USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalDivisionSegmento]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalDivisionSegmento](
	[Division] [nvarchar](50) NOT NULL,
	[Segmento] [nvarchar](50) NOT NULL,
	[SegmentoBAC] [nvarchar](50) NOT NULL,
	[CodigoBAC] [int] NOT NULL
) ON [PRIMARY]
GO
