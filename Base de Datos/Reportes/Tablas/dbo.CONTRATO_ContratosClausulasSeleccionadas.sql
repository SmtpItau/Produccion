USE [Reportes]
GO
/****** Object:  Table [dbo].[CONTRATO_ContratosClausulasSeleccionadas]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRATO_ContratosClausulasSeleccionadas](
	[Rut_Cliente] [numeric](9, 0) NULL,
	[Cod_Cliente] [numeric](9, 0) NULL,
	[Numero_Operacion] [numeric](7, 0) NULL,
	[Sistema] [varchar](10) NULL,
	[Contrato] [varchar](10) NULL,
	[Categoria] [varchar](20) NULL,
	[Clausula] [varchar](10) NULL
) ON [PRIMARY]
GO
