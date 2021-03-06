USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[paso_renta_resumen]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso_renta_resumen](
	[fecproc] [datetime] NULL,
	[interb] [numeric](19, 4) NULL,
	[cartera_cpl] [numeric](19, 4) NULL,
	[cartera_lpl] [numeric](19, 4) NULL,
	[pactos_ci] [numeric](19, 4) NULL,
	[pactos_vi] [numeric](19, 4) NULL,
	[ventas_cpl] [numeric](19, 4) NULL,
	[ventas_lpl] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
