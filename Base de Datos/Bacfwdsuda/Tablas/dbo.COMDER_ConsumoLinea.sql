USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[COMDER_ConsumoLinea]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMDER_ConsumoLinea](
	[linea] [varchar](20) NULL,
	[TotalAsignado] [numeric](19, 0) NULL,
	[TotalOcupado] [numeric](19, 0) NULL,
	[TotalDisponible] [numeric](19, 0) NULL,
	[TotalExceso] [numeric](19, 0) NULL,
	[Moneda] [varchar](10) NULL,
	[Bloqueado] [char](1) NULL,
	[Metodologia] [varchar](50) NULL
) ON [PRIMARY]
GO
