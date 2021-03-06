USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_Detalle_Opciones]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_Detalle_Opciones](
	[IDDetalleParametros] [int] IDENTITY(1,1) NOT NULL,
	[Sistema] [varchar](50) NULL,
	[CodIBS] [int] NULL,
	[EstadoCod] [varchar](50) NULL,
	[EstructuraCod] [int] NULL,
	[CallPut] [varchar](10) NULL,
	[CompraVenta] [char](1) NULL,
	[TipoCriterio] [int] NOT NULL
) ON [Reportes_Data_01]
GO
