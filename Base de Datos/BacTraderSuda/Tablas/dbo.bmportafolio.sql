USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[bmportafolio]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bmportafolio](
	[fecha] [datetime] NOT NULL,
	[rutcartera] [decimal](9, 0) NOT NULL,
	[sistema] [char](10) NOT NULL,
	[producto] [char](10) NOT NULL,
	[tipoper] [char](10) NOT NULL,
	[numoper] [char](20) NOT NULL,
	[familia] [char](10) NOT NULL,
	[instser] [char](10) NOT NULL,
	[tipcarter] [char](1) NOT NULL,
	[posicion] [float] NOT NULL,
	[tasa] [float] NOT NULL,
	[base] [decimal](3, 0) NOT NULL,
	[tipotasa] [decimal](1, 0) NOT NULL,
	[monreaj] [decimal](3, 0) NOT NULL,
	[moncont] [decimal](3, 0) NOT NULL,
	[moncomp] [decimal](3, 0) NOT NULL,
	[fecinic] [datetime] NOT NULL,
	[fecvcto] [datetime] NOT NULL,
	[valinic] [float] NOT NULL,
	[valvcto] [float] NOT NULL,
	[cuentacon] [char](15) NOT NULL,
	[capitalum] [float] NOT NULL,
	[capitalclp] [float] NOT NULL,
	[interesum] [float] NOT NULL,
	[interesclp] [float] NOT NULL,
	[reajuste] [float] NOT NULL,
	[valpresen] [float] NOT NULL,
	[operador] [char](15) NOT NULL,
	[tasatrans] [float] NOT NULL,
	[fecemis] [datetime] NOT NULL,
	[tasemis] [float] NOT NULL,
	[basemis] [decimal](3, 0) NOT NULL,
	[rutemis] [decimal](9, 0) NOT NULL,
	[genemis] [char](10) NOT NULL,
	[rutclie] [decimal](9, 0) NOT NULL,
	[codclie] [decimal](10, 0) NOT NULL,
	[mascara] [char](10) NOT NULL,
	[seriado] [char](1) NOT NULL,
	[tablap12] [decimal](10, 0) NOT NULL,
	[filler1] [char](50) NOT NULL,
	[filler2] [char](50) NOT NULL,
	[filler3] [char](50) NOT NULL,
	[filler4] [char](50) NOT NULL,
	[flag_valorizador] [int] NOT NULL,
	[flag_filtro] [int] NULL
) ON [PRIMARY]
GO
