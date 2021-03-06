USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_FWD]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_FWD](
	[caFechaProceso] [datetime] NOT NULL,
	[canumoper] [numeric](10, 0) NOT NULL,
	[cafecha] [datetime] NOT NULL,
	[catipoper] [char](1) NOT NULL,
	[catipmoda] [char](1) NOT NULL,
	[mnnemo1] [char](8) NOT NULL,
	[mnnemo2] [char](8) NOT NULL,
	[camtomon1] [numeric](21, 4) NOT NULL,
	[camtomon2] [numeric](21, 4) NOT NULL,
	[capremon1] [float] NOT NULL,
	[catipcam] [float] NOT NULL,
	[cafecvcto] [datetime] NOT NULL,
	[camarktomarket] [numeric](21, 4) NOT NULL,
	[cacodpos1] [numeric](5, 0) NOT NULL,
	[caoperador] [char](15) NOT NULL,
	[ValorRazonableActivo] [float] NOT NULL,
	[ValorRazonablePasivo] [float] NOT NULL,
	[fRes_Obtenido] [float] NOT NULL,
	[catasaufclp] [float] NOT NULL,
	[catasadolar] [float] NOT NULL,
	[fVal_Obtenido] [float] NOT NULL
) ON [PRIMARY]
GO
