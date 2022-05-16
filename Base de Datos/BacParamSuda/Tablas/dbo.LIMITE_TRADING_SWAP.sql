USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LIMITE_TRADING_SWAP]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TRADING_SWAP](
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Codigo_Grupo] [decimal](18, 0) NOT NULL,
	[Outstanding] [float] NOT NULL,
	[Monto_Limite] [float] NOT NULL,
	[Disponible] [float] NOT NULL
) ON [PRIMARY]
GO
