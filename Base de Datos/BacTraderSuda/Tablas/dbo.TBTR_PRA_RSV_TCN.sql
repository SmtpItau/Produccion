USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBTR_PRA_RSV_TCN]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBTR_PRA_RSV_TCN](
	[CODIGO] [int] NOT NULL,
	[GLOSA] [char](60) NULL,
	[MONTO] [numeric](19, 4) NULL,
	[TIPO] [numeric](1, 0) NULL,
	[GLOSA_PARTIDA] [char](30) NULL
) ON [PRIMARY]
GO
