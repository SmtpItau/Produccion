USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PLAZA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAZA](
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[glosa] [varchar](10) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
