USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CARTERA_PV01]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_PV01](
	[NUMDOCU] [numeric](10, 0) NULL,
	[NUMOPER] [numeric](10, 0) NULL,
	[CORRELA] [numeric](10, 0) NULL,
	[SERIE] [char](12) NULL,
	[FECHA_FLUJO] [datetime] NULL,
	[FLUJO] [float] NULL,
	[TIR_MERCADO] [float] NULL,
	[TIPO_CARTERA] [char](1) NULL,
	[EST_CARTERA] [char](1) NULL,
	[MONEDA] [numeric](5, 0) NULL,
	[CODIGO] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
