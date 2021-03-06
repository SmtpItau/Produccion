USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Respaldo_CurvasMEJICANAS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Respaldo_CurvasMEJICANAS](
	[FechaGeneracion] [datetime] NOT NULL,
	[CodigoCurva] [varchar](20) NOT NULL,
	[Dias] [numeric](9, 0) NOT NULL,
	[ValorBid] [float] NOT NULL,
	[ValorAsk] [float] NOT NULL,
	[Tipo] [varchar](5) NOT NULL,
	[Origen] [char](2) NOT NULL
) ON [PRIMARY]
GO
