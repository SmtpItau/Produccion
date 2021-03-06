USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_Detalle_Pasivos]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_Detalle_Pasivos](
	[IDDetalleParametros] [int] IDENTITY(1,1) NOT NULL,
	[Sistema] [varchar](10) NOT NULL,
	[CodIBS] [int] NOT NULL,
	[NombreSerie] [varchar](20) NOT NULL,
	[Tipo_Bono] [varchar](10) NOT NULL,
	[PlanCuenta] [varchar](50) NOT NULL,
	[TipoCriterio] [int] NOT NULL
) ON [Reportes_Data_01]
GO
