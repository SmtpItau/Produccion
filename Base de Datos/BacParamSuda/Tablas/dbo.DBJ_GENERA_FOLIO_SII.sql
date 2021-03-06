USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DBJ_GENERA_FOLIO_SII]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBJ_GENERA_FOLIO_SII](
	[anno] [numeric](4, 0) NULL,
	[Modulo] [varchar](10) NULL,
	[ContratoBAC] [numeric](10, 0) NULL,
	[Estructura] [numeric](5, 0) NULL,
	[UltimoFolioUtilizado] [numeric](10, 0) NULL,
	[FechaActRegistro] [datetime] NULL,
	[Evento] [varchar](30) NULL,
	[SubEvento] [varchar](30) NULL
) ON [PRIMARY]
GO
