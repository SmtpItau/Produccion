USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MATRIZ_RIESGO_BEX]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATRIZ_RIESGO_BEX](
	[codigo] [char](5) NOT NULL,
	[moneda] [numeric](3, 0) NOT NULL,
	[diasdesde] [numeric](5, 0) NOT NULL,
	[diashasta] [numeric](5, 0) NOT NULL,
	[porcentaje] [numeric](8, 4) NOT NULL
) ON [PRIMARY]
GO
