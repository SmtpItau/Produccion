USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PERIODO_AMORTIZACION]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIODO_AMORTIZACION](
	[sistema] [char](3) NOT NULL,
	[tabla] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](9, 0) NOT NULL,
	[glosa] [char](25) NOT NULL,
	[dias] [numeric](9, 0) NOT NULL,
	[meses] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
