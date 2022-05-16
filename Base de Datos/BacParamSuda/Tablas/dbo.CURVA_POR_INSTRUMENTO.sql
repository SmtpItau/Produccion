USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CURVA_POR_INSTRUMENTO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVA_POR_INSTRUMENTO](
	[incodigo] [decimal](3, 0) NOT NULL,
	[mncodmon] [decimal](5, 0) NOT NULL,
	[codigo_curva] [decimal](3, 0) NOT NULL
) ON [PRIMARY]
GO
