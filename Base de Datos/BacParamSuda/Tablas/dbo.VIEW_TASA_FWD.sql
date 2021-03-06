USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VIEW_TASA_FWD]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VIEW_TASA_FWD](
	[codigo] [numeric](5, 0) NULL,
	[plazo] [numeric](5, 0) NULL,
	[tasa_compra] [float] NULL,
	[tasa_venta] [float] NULL,
	[lleva_plazo] [numeric](1, 0) NULL,
	[tasa_nominal] [float] NULL,
	[tasa_uf] [float] NULL,
	[precio_nominal] [float] NULL,
	[punto_fwd] [float] NULL,
	[desviacion_estandar] [float] NULL,
	[tasa_var] [float] NULL,
	[desviacion1] [float] NULL,
	[desviacion2] [float] NULL,
	[desviacion3] [float] NULL,
	[desviacion_total] [float] NULL,
	[media1] [float] NULL,
	[media2] [float] NULL,
	[media3] [float] NULL,
	[media_total] [float] NULL,
	[fecha] [datetime] NULL,
	[tasa_efectiva] [float] NULL
) ON [PRIMARY]
GO
