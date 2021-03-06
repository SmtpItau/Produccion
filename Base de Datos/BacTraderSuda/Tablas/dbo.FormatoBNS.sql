USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[FormatoBNS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormatoBNS](
	[Ndocumento] [int] NULL,
	[RutEmisor] [int] NULL,
	[Origen] [char](3) NULL,
	[Refe] [char](1) NULL,
	[Trans] [int] NULL,
	[Currency] [char](3) NULL,
	[Issuer] [char](60) NULL,
	[Rate] [numeric](19, 4) NULL,
	[IssueDate] [datetime] NULL,
	[BuyDate] [datetime] NULL,
	[Maturdate] [datetime] NULL,
	[Parvalue] [float] NULL,
	[Bookvalue] [numeric](19, 4) NULL,
	[Mrktprice] [numeric](19, 4) NULL,
	[Residency] [char](5) NULL,
	[Ctryrisk] [char](2) NULL,
	[Industry] [char](1) NULL,
	[Yield] [numeric](19, 4) NULL,
	[PortFolio] [int] NULL,
	[CuentaBSA] [char](20) NULL,
	[Glaccount] [int] NULL,
	[dif_mer] [numeric](19, 4) NULL,
	[cta_cap] [numeric](10, 0) NULL,
	[cta_mer] [numeric](10, 0) NULL
) ON [PRIMARY]
GO
