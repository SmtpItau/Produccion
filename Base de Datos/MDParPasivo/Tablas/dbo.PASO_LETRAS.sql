USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PASO_LETRAS]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASO_LETRAS](
	[SERIEA] [varchar](10) NULL,
	[SERIEN] [varchar](10) NULL,
	[NOMINAL] [numeric](20, 4) NULL,
	[NUMOPE] [numeric](6, 0) NULL,
	[CORRELAN] [numeric](2, 0) NULL,
	[mascara] [varchar](10) NULL
) ON [PRIMARY]
GO
