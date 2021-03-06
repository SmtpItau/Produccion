USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[FinalSerie]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinalSerie](
	[fecha] [date] NULL,
	[numdocu] [numeric](10, 0) NULL,
	[correla] [int] NULL,
	[serie] [char](10) NULL,
	[imoneda] [smallint] NULL,
	[nominal] [numeric](21, 4) NULL,
	[tasa] [numeric](9, 4) NULL,
	[vp] [numeric](22, 4) NULL,
	[vp_um] [numeric](22, 4) NULL,
	[interes] [numeric](22, 4) NULL,
	[reajuste] [numeric](22, 4) NULL,
	[vp_ayer] [numeric](22, 4) NULL
) ON [PRIMARY]
GO
