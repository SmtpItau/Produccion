USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PARAMETROS_RESERVA_TECNICA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARAMETROS_RESERVA_TECNICA](
	[sistema] [char](3) NOT NULL,
	[parametro] [int] NOT NULL,
	[codigo_parametro] [int] NOT NULL,
	[glosa_parametro] [char](60) NOT NULL,
	[monto_1] [numeric](19, 4) NOT NULL,
	[monto_2] [numeric](19, 4) NOT NULL,
	[tipo_partida] [int] NOT NULL,
	[glosa_partida] [char](30) NOT NULL
) ON [PRIMARY]
GO
