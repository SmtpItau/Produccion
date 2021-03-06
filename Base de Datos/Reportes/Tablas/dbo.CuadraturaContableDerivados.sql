USE [Reportes]
GO
/****** Object:  Table [dbo].[CuadraturaContableDerivados]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuadraturaContableDerivados](
	[fechaProceso] [datetime] NULL,
	[fechaCuadratura] [datetime] NULL,
	[codIBS] [int] NULL,
	[saldoContable] [float] NULL,
	[saldoIBS] [float] NULL,
	[Moneda] [varchar](10) NULL,
	[Sistema] [varchar](10) NULL,
	[flacActualiza] [bit] NULL
) ON [Reportes_Data_01]
GO
