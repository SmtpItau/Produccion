USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ART84_DERIVADOS_TRASPASO_Dios29032012_NewConf]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ART84_DERIVADOS_TRASPASO_Dios29032012_NewConf](
	[RutDeudor] [char](15) NULL,
	[Modulo] [char](10) NULL,
	[Tipoper] [char](10) NULL,
	[Moneda] [numeric](5, 0) NULL,
	[Monto] [numeric](18, 0) NULL,
	[Fec_Proc] [char](8) NULL
) ON [PRIMARY]
GO
