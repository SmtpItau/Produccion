USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[SerieGarantia]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SerieGarantia](
	[Fecha] [date] NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correla] [numeric](10, 0) NOT NULL,
	[serie] [char](10) NOT NULL
) ON [PRIMARY]
GO
