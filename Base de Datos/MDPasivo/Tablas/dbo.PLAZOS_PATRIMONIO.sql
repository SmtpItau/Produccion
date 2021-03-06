USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PLAZOS_PATRIMONIO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAZOS_PATRIMONIO](
	[Tipo_Plazo] [char](1) NOT NULL,
	[Numero_Correlativo] [numeric](3, 0) NOT NULL,
	[Rango_Desde] [numeric](3, 0) NOT NULL,
	[Rango_Hasta] [numeric](3, 0) NOT NULL,
	[Factor_Computo] [numeric](10, 2) NOT NULL,
	[Fecha_Desde] [datetime] NOT NULL,
	[Fecha_Hasta] [datetime] NOT NULL,
	[RcCodCar] [numeric](10, 0) NOT NULL,
	[RcRut] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
