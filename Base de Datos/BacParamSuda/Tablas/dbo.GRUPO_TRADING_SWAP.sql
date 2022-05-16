USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[GRUPO_TRADING_SWAP]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_TRADING_SWAP](
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Codigo_Grupo] [decimal](18, 0) NOT NULL,
	[Tramo_Desde] [decimal](18, 0) NOT NULL,
	[Tramo_Hasta] [decimal](18, 0) NOT NULL,
	[Descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO
