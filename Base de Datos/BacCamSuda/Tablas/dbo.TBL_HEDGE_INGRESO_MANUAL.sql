USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_INGRESO_MANUAL]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_INGRESO_MANUAL](
	[Fecha_Proceso] [datetime] NOT NULL,
	[id_hedge] [int] NOT NULL,
	[Origen] [varchar](50) NOT NULL,
	[Concepto] [varchar](80) NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[Monto_Compra] [numeric](21, 4) NOT NULL,
	[Monto_Venta] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
