USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MENS_CARGACAPTATERCEROS]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENS_CARGACAPTATERCEROS](
	[Nnumdocu] [numeric](10, 0) NOT NULL,
	[ncorrela_corte] [numeric](3, 0) NOT NULL,
	[ncorrela_oper] [numeric](5, 0) NOT NULL,
	[NnumdocuDAP] [numeric](10, 0) NOT NULL,
	[ncorrelaDAP] [numeric](3, 0) NOT NULL,
	[cmensaje] [char](50) NOT NULL
) ON [PRIMARY]
GO
