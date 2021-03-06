USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_MDIV]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_MDIV](
	[fecha_proceso] [datetime] NOT NULL,
	[cuenta] [char](12) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[moneda] [char](3) NOT NULL,
	[debe] [numeric](21, 4) NOT NULL,
	[haber] [numeric](21, 4) NOT NULL,
	[saldo_debe] [numeric](21, 4) NOT NULL,
	[saldo_haber] [numeric](21, 4) NOT NULL,
	[saldo_pesos] [numeric](21, 0) NOT NULL,
	[debe_haber] [char](1) NOT NULL
) ON [PRIMARY]
GO
