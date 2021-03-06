USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TARIFADO_TASA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TARIFADO_TASA](
	[Fecha] [datetime] NULL,
	[Moneda] [char](4) NULL,
	[Grupo] [numeric](19, 0) NULL,
	[Plazo] [numeric](19, 0) NULL,
	[monto] [numeric](19, 4) NULL,
	[pizarra] [numeric](19, 4) NULL,
	[Marginal] [numeric](19, 4) NULL,
	[Costo_Fdo] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
