USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBTR_MNL_ME]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBTR_MNL_ME](
	[CODIGO] [int] NOT NULL,
	[GLOSA] [char](60) NULL,
	[MONTO_EXIGIBLE] [numeric](19, 4) NULL,
	[MONTO_OCUPADO] [numeric](19, 4) NULL,
	[PARTIDA] [char](30) NULL
) ON [PRIMARY]
GO
