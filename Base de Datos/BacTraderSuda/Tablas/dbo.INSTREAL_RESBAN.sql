USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[INSTREAL_RESBAN]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INSTREAL_RESBAN](
	[tipo_operacion] [char](5) NULL,
	[instrumento] [char](10) NULL,
	[plazo_desde] [numeric](5, 0) NULL,
	[plazo_hasta] [numeric](5, 0) NULL,
	[moneda] [numeric](5, 0) NULL,
	[instreal] [char](10) NULL
) ON [PRIMARY]
GO
