USE [MDPasivo]
GO
/****** Object:  Table [dbo].[REGLAS_VALORIZACION]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGLAS_VALORIZACION](
	[id_regla] [int] NOT NULL,
	[area] [char](5) NOT NULL,
	[sistema] [char](3) NOT NULL,
	[producto] [char](5) NOT NULL,
	[familia] [char](20) NOT NULL,
	[nemotecnico] [char](20) NOT NULL,
	[divisa1] [numeric](5, 0) NOT NULL,
	[divisa2] [numeric](5, 0) NOT NULL,
	[categoria_emisor] [char](5) NOT NULL,
	[tasa_emision] [float] NOT NULL,
	[mercado] [numeric](5, 0) NOT NULL,
	[curva1] [char](15) NOT NULL,
	[curva2] [char](15) NOT NULL,
	[id_tipo_regla] [int] NOT NULL,
	[tipoCambio] [numeric](5, 0) NOT NULL,
	[TipoValorizacion] [varchar](1) NULL
) ON [PRIMARY]
GO
