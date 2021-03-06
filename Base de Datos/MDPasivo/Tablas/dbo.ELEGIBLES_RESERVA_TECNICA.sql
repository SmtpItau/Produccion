USE [MDPasivo]
GO
/****** Object:  Table [dbo].[ELEGIBLES_RESERVA_TECNICA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ELEGIBLES_RESERVA_TECNICA](
	[codigo] [int] NOT NULL,
	[codigo_elegible] [numeric](3, 0) NOT NULL,
	[glosa_elegible] [char](100) NOT NULL,
	[mayor] [char](5) NOT NULL,
	[partida] [numeric](5, 0) NOT NULL,
	[glosa_menos] [char](100) NOT NULL,
	[saldo_menos] [numeric](19, 4) NOT NULL,
	[reserva_menos] [numeric](19, 4) NOT NULL,
	[glosa_mas] [char](100) NOT NULL,
	[saldo_mas] [numeric](19, 4) NOT NULL,
	[reserva_mas] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
