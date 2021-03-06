USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DJAjustesContables]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DJAjustesContables](
	[Contrato] [numeric](10, 0) NULL,
	[Evento] [varchar](30) NULL,
	[SubEvento] [varchar](30) NULL,
	[FechaEvento] [datetime] NULL,
	[MontoMdaLocal] [numeric](20, 4) NULL,
	[Modulo] [varchar](30) NULL,
	[KeyCntId_sistema] [varchar](3) NULL,
	[Motivo] [varchar](200) NULL
) ON [PRIMARY]
GO
