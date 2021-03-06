USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[bmportafolioflujos]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bmportafolioflujos](
	[fecha] [datetime] NOT NULL,
	[rutcartera] [decimal](9, 0) NOT NULL,
	[sistema] [char](10) NOT NULL,
	[producto] [char](10) NOT NULL,
	[tipoper] [char](10) NOT NULL,
	[numoper] [char](20) NOT NULL,
	[numcuot] [decimal](3, 0) NOT NULL,
	[fecpago] [datetime] NOT NULL,
	[capital] [float] NOT NULL,
	[interes] [float] NOT NULL,
	[moneda] [decimal](3, 0) NOT NULL,
	[act_pas] [char](1) NOT NULL,
	[tipoflujo] [char](1) NOT NULL,
	[tasaper] [float] NOT NULL,
	[baseper] [decimal](3, 0) NOT NULL,
	[flag_valorizador] [int] NOT NULL,
	[flag_filtro] [int] NULL
) ON [PRIMARY]
GO
