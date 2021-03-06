USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[COSTOS_COMEX]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSTOS_COMEX](
	[Fecha] [datetime] NOT NULL,
	[Entre_Desde] [numeric](18, 4) NOT NULL,
	[Entre_Hasta] [numeric](18, 4) NOT NULL,
	[Costo_Compra] [numeric](18, 4) NOT NULL,
	[Costo_Venta] [numeric](18, 4) NOT NULL,
	[Spread_Compra] [numeric](18, 4) NOT NULL,
	[Spread_Venta] [numeric](18, 4) NOT NULL,
	[Spread_Trading_Compra] [numeric](18, 4) NOT NULL,
	[Spread_Trading_Venta] [numeric](18, 4) NOT NULL,
	[PERFIL_COMERCIAL] [char](6) NOT NULL,
	[MONTOMAX] [numeric](18, 4) NOT NULL,
	[CodMoneda] [numeric](5, 0) NOT NULL,
	[Costo_Compra_OutTime] [numeric](18, 4) NULL,
	[Costo_Venta_OutTime] [numeric](18, 4) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[COSTOS_COMEX] ADD  DEFAULT ('2') FOR [PERFIL_COMERCIAL]
GO
ALTER TABLE [dbo].[COSTOS_COMEX] ADD  DEFAULT (100000) FOR [MONTOMAX]
GO
ALTER TABLE [dbo].[COSTOS_COMEX] ADD  CONSTRAINT [COSTOS_COMEX_CodMoneda]  DEFAULT ((0)) FOR [CodMoneda]
GO
