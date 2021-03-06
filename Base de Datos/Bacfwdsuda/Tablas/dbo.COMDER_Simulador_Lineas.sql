USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[COMDER_Simulador_Lineas]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMDER_Simulador_Lineas](
	[Origen] [varchar](9) NULL,
	[FechaProceso] [datetime] NULL,
	[Cliente] [varchar](50) NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[TipoOperacion] [varchar](10) NULL,
	[Producto] [varchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Monto] [float] NULL,
	[Precio] [float] NULL,
	[idMoneda] [int] NULL,
	[Moneda] [char](8) NULL,
	[Operador] [char](15) NULL,
	[UsoLinea] [float] NULL,
	[Anular] [bit] NOT NULL,
	[UsuarioLog] [varchar](20) NULL
) ON [PRIMARY]
GO
