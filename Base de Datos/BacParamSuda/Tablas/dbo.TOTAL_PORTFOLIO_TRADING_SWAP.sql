USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TOTAL_PORTFOLIO_TRADING_SWAP]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOTAL_PORTFOLIO_TRADING_SWAP](
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Outstanding] [float] NOT NULL,
	[Monto_Limite] [float] NOT NULL,
	[Disponible] [float] NOT NULL,
	[Outstanding_Filial] [float] NULL
) ON [PRIMARY]
GO
