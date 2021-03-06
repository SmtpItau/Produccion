USE [BacLineas]
GO
/****** Object:  Table [dbo].[DWT_MontoLineas]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DWT_MontoLineas](
	[Numero_Operacion] [numeric](7, 0) NOT NULL,
	[Identificacion_Cliente] [varchar](15) NOT NULL,
	[Moneda_Origen] [char](4) NOT NULL,
	[Facility] [char](3) NOT NULL,
	[Moneda_Valores] [char](4) NOT NULL,
	[Nocional_Origen] [numeric](13, 0) NOT NULL,
	[Monto_Articulo_84] [numeric](15, 0) NOT NULL,
	[Monto_Corporativo] [numeric](15, 0) NOT NULL,
	[Secuencia_Subcliente] [numeric](9, 0) NOT NULL,
	[Rut] [numeric](9, 0) NOT NULL,
	[DV] [char](1) NULL,
	[Codigo] [numeric](3, 0) NOT NULL,
	[NombreCliente] [varchar](30) NULL,
	[ID_SISTEMA] [varchar](10) NULL,
	[Fecha_proceso] [datetime] NULL,
	[Metodologia] [int] NULL
) ON [PRIMARY]
GO
