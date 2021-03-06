USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TEMPOPE]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMPOPE](
	[mercado] [char](4) NULL,
	[numope] [numeric](8, 0) NULL,
	[estado] [char](20) NULL,
	[clienteope] [char](40) NULL,
	[espacio1] [char](1) NULL,
	[monusd] [numeric](19, 4) NULL,
	[monpes] [numeric](19, 4) NULL,
	[tipcam] [numeric](19, 4) NULL,
	[forpagent] [char](40) NULL,
	[valutaent] [char](10) NULL,
	[forpagrec] [char](40) NULL,
	[valutarec] [char](10) NULL,
	[moneda] [char](4) NULL,
	[paridad] [numeric](19, 4) NULL,
	[fechoy] [char](10) NULL,
	[fecoper] [char](10) NULL,
	[hora] [char](10) NULL,
	[rut] [numeric](9, 0) NULL,
	[digito] [char](1) NULL,
	[nombre] [char](40) NULL,
	[cliente] [char](40) NULL,
	[monedacon] [char](9) NULL,
	[montomonori] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
