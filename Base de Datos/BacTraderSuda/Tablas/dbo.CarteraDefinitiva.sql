USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CarteraDefinitiva]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarteraDefinitiva](
	[rscartera] [char](3) NULL,
	[rsfecha] [datetime] NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correla] [numeric](3, 0) NOT NULL,
	[NumOper] [numeric](10, 0) NULL,
	[rsnominal] [numeric](19, 4) NULL,
	[cpvptirc] [numeric](19, 4) NOT NULL,
	[cptircomp] [numeric](19, 4) NULL,
	[rsinteres] [numeric](19, 4) NULL,
	[rsreajuste] [numeric](19, 4) NULL,
	[ValorAnterior] [numeric](19, 4) NULL,
	[cpvalcomp] [numeric](19, 4) NOT NULL,
	[cpvalcomu] [float] NOT NULL,
	[InteresAcumulado] [numeric](38, 4) NULL,
	[ReajusteAcumulado] [numeric](38, 4) NULL
) ON [PRIMARY]
GO
