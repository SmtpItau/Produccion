USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfach]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfach](
	[acrutprop] [numeric](9, 0) NOT NULL,
	[acdigprop] [char](1) NOT NULL,
	[acnomprop] [char](50) NOT NULL,
	[acdirprop] [char](50) NOT NULL,
	[actelefono] [char](14) NOT NULL,
	[acfax] [char](14) NOT NULL,
	[acfecante] [datetime] NOT NULL,
	[acfecproc] [datetime] NOT NULL,
	[acfecprox] [datetime] NOT NULL,
	[acsucmesa] [numeric](3, 0) NOT NULL,
	[acofimesa] [numeric](3, 0) NOT NULL,
	[accodmonloc] [numeric](3, 0) NOT NULL,
	[accodmondol] [numeric](3, 0) NOT NULL,
	[accodmonuf] [numeric](3, 0) NOT NULL,
	[accodmondolobs] [numeric](3, 0) NOT NULL,
	[acnumoper] [numeric](10, 0) NOT NULL,
	[accorrel] [numeric](10, 0) NOT NULL,
	[acnumdecimales] [numeric](2, 0) NOT NULL,
	[acpais] [numeric](3, 0) NOT NULL,
	[acplaza] [numeric](3, 0) NOT NULL,
	[accodempresa] [numeric](9, 0) NOT NULL,
	[accodclie] [numeric](9, 0) NOT NULL,
	[actipocalculo] [char](1) NOT NULL,
	[actipparfwd] [numeric](2, 0) NOT NULL,
	[actcaparfwd] [numeric](2, 0) NOT NULL,
	[acsw_pd] [char](1) NOT NULL,
	[acsw_fd] [char](1) NOT NULL,
	[acsw_ciemefwd] [char](1) NOT NULL,
	[acsw_devenfwd] [char](1) NOT NULL,
	[acsw_contafwd] [char](1) NOT NULL,
	[acnumlogs] [int] NULL,
	[accodbcch] [numeric](3, 0) NOT NULL,
	[acdesviacionestandar] [numeric](10, 4) NOT NULL
) ON [PRIMARY]
GO
