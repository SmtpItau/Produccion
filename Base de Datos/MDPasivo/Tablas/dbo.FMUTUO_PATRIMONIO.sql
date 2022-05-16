USE [MDPasivo]
GO
/****** Object:  Table [dbo].[FMUTUO_PATRIMONIO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FMUTUO_PATRIMONIO](
	[rut_cliente] [numeric](18, 0) NOT NULL,
	[codigo_cliente] [numeric](18, 0) NOT NULL,
	[patrimonio] [numeric](19, 4) NULL,
	[porcentaje_linea] [numeric](12, 4) NULL
) ON [PRIMARY]
GO
