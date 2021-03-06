USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDRS1]    Script Date: 13-05-2022 12:16:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDRS1](
	[rsrutcart] [numeric](9, 0) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rscorrela] [numeric](3, 0) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsrutcli] [numeric](9, 0) NOT NULL,
	[rscodcli] [numeric](9, 0) NOT NULL,
	[rsfecinip] [datetime] NOT NULL,
	[rsfecvtop] [datetime] NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsmascara] [char](10) NOT NULL,
	[rsvppresen] [numeric](19, 4) NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rscupamo] [numeric](19, 4) NOT NULL,
	[rscupint] [numeric](19, 4) NOT NULL,
	[rsfecpro] [datetime] NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsfecctb] [datetime] NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](9, 4) NOT NULL,
	[rstasest] [numeric](9, 4) NOT NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rsmonpact] [numeric](3, 0) NOT NULL,
	[rstasemi] [numeric](9, 4) NOT NULL,
	[rsbasemi] [numeric](3, 0) NOT NULL,
	[rscodigo] [numeric](3, 0) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsforpagv] [numeric](4, 0) NOT NULL,
	[rsreajuste_acumulado] [numeric](19, 4) NOT NULL,
	[rsinteres_acumulado] [numeric](19, 4) NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rsvalcomp] [numeric](19, 4) NOT NULL,
	[rsvalcomu] [numeric](19, 4) NOT NULL,
	[rsvalpactopapel] [numeric](19, 4) NOT NULL,
	[rsdurat] [float] NOT NULL,
	[rsdurmod] [float] NOT NULL,
	[rsconvex] [float] NOT NULL,
	[rsnumucup] [int] NOT NULL,
	[rsnumpcup] [int] NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rstipopero] [char](3) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL
) ON [PRIMARY]
GO
