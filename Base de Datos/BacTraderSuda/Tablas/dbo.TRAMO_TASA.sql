USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TRAMO_TASA]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRAMO_TASA](
	[NEMOTECNICO_INSTRUMENTO] [char](12) NOT NULL,
	[DESDE] [int] NULL,
	[HASTA] [int] NULL,
	[CLASIFICACION] [char](15) NOT NULL,
	[TASA_CURVA_BASE] [numeric](9, 4) NULL,
	[ID_NIVEL_RIESGO] [varchar](2) NULL
) ON [PRIMARY]
GO
