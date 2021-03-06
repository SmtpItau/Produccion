USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MKPZ_TASA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MKPZ_TASA](
	[FECHA] [datetime] NULL,
	[Tipo] [numeric](19, 0) NULL,
	[Moneda] [char](4) NULL,
	[Vertice] [numeric](19, 0) NULL,
	[Plazo] [numeric](19, 0) NULL,
	[Inferior] [numeric](19, 0) NULL,
	[Superior] [numeric](19, 0) NULL,
	[Pizarra] [numeric](19, 4) NULL,
	[Marginal] [numeric](19, 4) NULL,
	[Costo_Fdo] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
