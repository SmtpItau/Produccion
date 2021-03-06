USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_TESORERIA_FOLIOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_TESORERIA_FOLIOS](
	[tipo_documento] [numeric](2, 0) NULL,
	[correla_interno] [numeric](19, 0) NULL,
	[folio_inicio] [numeric](19, 0) NULL,
	[folio_actual] [numeric](19, 0) NULL,
	[folio_termino] [numeric](19, 0) NULL,
	[estado] [char](1) NULL
) ON [PRIMARY]
GO
