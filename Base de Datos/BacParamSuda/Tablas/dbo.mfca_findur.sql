USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[mfca_findur]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfca_findur](
	[Fecha_proceso] [datetime] NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Producto] [char](4) NOT NULL,
	[Numero_operación] [numeric](10, 0) NOT NULL,
	[Monto] [float] NOT NULL,
	[Rut_Contraparte] [char](15) NOT NULL,
	[Codigo_cliente] [numeric](5, 0) NOT NULL,
	[Monto_Garantias] [float] NOT NULL,
	[Tipo_operación] [char](3) NOT NULL,
	[Tipo_negocio] [numeric](5, 0) NOT NULL,
	[Tipo_porcentaje] [numeric](5, 0) NOT NULL,
	[Fecha_vencimiento] [datetime] NOT NULL,
	[MTM_proyectado] [float] NOT NULL
) ON [PRIMARY]
GO
