USE [BacLineas]
GO
/****** Object:  Table [dbo].[DWT_MontoLineas_Errores]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DWT_MontoLineas_Errores](
	[Numero_Operacion] [numeric](7, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](3, 0) NOT NULL,
	[ID_SISTEMA] [varchar](10) NULL,
	[Producto] [varchar](3) NULL,
	[Fecha_proceso] [datetime] NULL,
	[Error] [varchar](300) NULL,
	[ProcesoError] [varchar](100) NULL,
	[Monto] [float] NULL
) ON [PRIMARY]
GO
