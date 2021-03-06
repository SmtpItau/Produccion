USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[Movimientos_Impresion]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos_Impresion](
	[Numero_Operacion] [float] NULL,
	[Mercado] [char](15) NULL,
	[Tipo_Operacion] [char](10) NULL,
	[Estado_Operacion] [char](15) NULL,
	[Nombre_Cliente] [char](45) NULL,
	[Monto] [float] NULL,
	[Monto_Pesos] [float] NULL,
	[Moneda] [char](15) NULL,
	[Moneda_Conversion] [char](15) NULL,
	[Tipo_Cambio_Cierre] [float] NULL,
	[Tipo_Cambio_Costo] [float] NULL,
	[Paridad_Cierre] [float] NULL,
	[Paridad_Costo] [float] NULL,
	[FP_Pagamos] [char](25) NULL,
	[FP_Recibimos] [char](25) NULL,
	[Fecha] [char](10) NULL,
	[Hora] [char](8) NULL,
	[Usuario] [char](15) NULL,
	[Terminal] [char](15) NULL
) ON [PRIMARY]
GO
