USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_COSIF_ITAU]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_COSIF_ITAU](
	[cta_corp] [nvarchar](50) NOT NULL,
	[cosif] [nvarchar](50) NOT NULL,
	[cosif_ger] [nvarchar](50) NOT NULL,
	[cosif_gl] [nvarchar](50) NOT NULL,
	[cta_cosif] [nvarchar](50) NOT NULL,
	[glosa_cosif] [nvarchar](80) NOT NULL,
	[glosa_cosif_gl] [nvarchar](80) NOT NULL,
	[categoria] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
