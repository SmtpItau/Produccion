USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CarteraArreglo]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarteraArreglo](
	[Fecha] [date] NULL,
	[numdocu] [numeric](10, 0) NULL,
	[correla] [int] NULL,
	[serie] [char](10) NULL,
	[nominal] [numeric](21, 4) NULL,
	[tasa] [numeric](9, 4) NULL,
	[vp] [numeric](22, 4) NULL,
	[vp_ayer] [numeric](22, 4) NULL,
	[interes] [numeric](38, 4) NULL,
	[reajuste] [numeric](22, 4) NULL,
	[ValCupon] [numeric](38, 4) NOT NULL,
	[Capital] [numeric](22, 4) NULL,
	[Registro] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
