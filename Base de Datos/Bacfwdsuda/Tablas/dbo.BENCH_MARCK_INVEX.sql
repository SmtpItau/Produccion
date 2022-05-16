USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[BENCH_MARCK_INVEX]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BENCH_MARCK_INVEX](
	[Fecha] [datetime] NOT NULL,
	[Instrumento] [char](20) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Desde] [numeric](9, 0) NOT NULL,
	[Hasta] [numeric](9, 0) NOT NULL,
	[Tasa] [float] NOT NULL
) ON [PRIMARY]
GO
