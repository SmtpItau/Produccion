USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[saldos_cartera]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[saldos_cartera](
	[CUENTA] [char](8) NULL,
	[LLAVE] [char](21) NULL,
	[NMONTO] [char](10) NULL,
	[UMMONTO] [numeric](3, 0) NULL,
	[SALDO] [float] NULL,
	[CUENTASUP] [char](10) NULL
) ON [PRIMARY]
GO
