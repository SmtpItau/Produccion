USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_AMORTIZACION]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_AMORTIZACION](
	[Codigo_Amortizacion] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
