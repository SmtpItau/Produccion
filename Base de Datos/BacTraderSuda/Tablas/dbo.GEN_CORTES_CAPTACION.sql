USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_CORTES_CAPTACION]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_CORTES_CAPTACION](
	[tipo_operacion] [char](3) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[cortes] [numeric](5, 0) NOT NULL,
	[monto_corte] [float] NOT NULL,
	[monto_inicio] [float] NOT NULL,
	[monto_inicio_pesos] [float] NOT NULL,
	[monto_final] [float] NOT NULL
) ON [PRIMARY]
GO
