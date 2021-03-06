USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBTR_COD_ELG]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBTR_COD_ELG](
	[CODIGO] [int] NOT NULL,
	[GLOSA] [char](100) NULL,
	[MAYOR] [char](5) NULL,
	[PARTIDA] [numeric](5, 0) NULL,
	[GLOSA_MENOS] [char](100) NULL,
	[SALDO_MENOS] [numeric](19, 4) NULL,
	[RESERVA_MENOS] [numeric](19, 4) NULL,
	[GLOSA_MAS] [char](100) NULL,
	[SALDO_MAS] [numeric](19, 4) NULL,
	[RESERVA_MAS] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
