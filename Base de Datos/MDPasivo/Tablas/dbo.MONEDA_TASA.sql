USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MONEDA_TASA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_TASA](
	[Codigo_Moneda] [numeric](5, 0) NOT NULL,
	[Codigo_Tasa] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
