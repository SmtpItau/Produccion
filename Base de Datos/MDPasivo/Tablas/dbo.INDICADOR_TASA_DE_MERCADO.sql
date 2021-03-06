USE [MDPasivo]
GO
/****** Object:  Table [dbo].[INDICADOR_TASA_DE_MERCADO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDICADOR_TASA_DE_MERCADO](
	[mncodmon] [numeric](5, 0) NOT NULL,
	[codigo_frecuenciatasa] [int] NOT NULL,
	[codigo_convenciondiasbase] [int] NOT NULL,
	[codigo_tipointereses] [int] NOT NULL,
	[codigo_tipoperiodo] [int] NOT NULL,
	[codigo_moneda] [int] NOT NULL,
	[ajustar_feriados] [char](1) NOT NULL,
	[dias_referencia] [int] NOT NULL,
	[dias_periodo] [int] NOT NULL
) ON [PRIMARY]
GO
