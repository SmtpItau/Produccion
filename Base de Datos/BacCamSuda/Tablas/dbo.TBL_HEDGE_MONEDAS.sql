USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_MONEDAS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_MONEDAS](
	[FECHA] [datetime] NOT NULL,
	[CODIGO_MONEDA] [numeric](5, 0) NOT NULL,
	[NEMO_MONEDA] [char](3) NOT NULL,
	[TIPO_CAMBIO] [float] NOT NULL,
	[SPOTCOMPRA] [float] NOT NULL,
	[SPOTVENTA] [float] NOT NULL
) ON [PRIMARY]
GO
