USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdrs_aProduccion]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdrs_aProduccion](
	[rsfecha] [datetime] NOT NULL,
	[rsrutcart] [decimal](9, 0) NOT NULL,
	[rstipcart] [decimal](5, 0) NOT NULL,
	[rsnumdocu] [decimal](10, 0) NOT NULL,
	[rscorrela] [decimal](3, 0) NOT NULL,
	[rsnumoper] [decimal](10, 0) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsrutcli] [decimal](9, 0) NOT NULL,
	[rscodcli] [decimal](9, 0) NOT NULL,
	[rsvppresen] [decimal](19, 4) NOT NULL,
	[rsvppresenx] [decimal](19, 4) NOT NULL,
	[rscupamo] [decimal](19, 4) NOT NULL,
	[rscupint] [decimal](19, 4) NOT NULL,
	[rscuprea] [decimal](19, 4) NOT NULL,
	[rsflujo] [decimal](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsfecctb] [datetime] NOT NULL,
	[rsnominal] [decimal](19, 4) NOT NULL,
	[rstir] [decimal](9, 4) NOT NULL,
	[rstasfloat] [decimal](9, 4) NOT NULL,
	[rsmonpact] [decimal](3, 0) NOT NULL,
	[rsmonemi] [decimal](3, 0) NOT NULL,
	[rstasemi] [decimal](9, 4) NOT NULL,
	[rsbasemi] [decimal](3, 0) NOT NULL,
	[rscodigo] [decimal](3, 0) NOT NULL,
	[rsinteres] [decimal](19, 4) NOT NULL,
	[rsreajuste] [decimal](19, 4) NOT NULL,
	[rsintermes] [decimal](19, 4) NOT NULL,
	[rsreajumes] [decimal](19, 4) NOT NULL,
	[rsreajuste_acum] [decimal](19, 4) NOT NULL,
	[rsinteres_acum] [decimal](19, 4) NOT NULL,
	[rsforpagv] [decimal](4, 0) NOT NULL,
	[rsvalcomp] [decimal](19, 4) NOT NULL,
	[rsvalcomu] [decimal](19, 4) NOT NULL,
	[rsvalvenc] [decimal](19, 4) NOT NULL,
	[rsdurat] [float] NOT NULL,
	[rsdurmod] [float] NOT NULL,
	[rsconvex] [float] NOT NULL,
	[rsnumucup] [int] NOT NULL,
	[rsnumpcup] [int] NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rstipopero] [char](3) NOT NULL,
	[rsfeccomp] [datetime] NOT NULL,
	[rsdifrea] [decimal](19, 4) NOT NULL,
	[rsinstcam] [char](10) NOT NULL,
	[rsfecinip] [datetime] NOT NULL,
	[rsfecvtop] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [decimal](9, 0) NOT NULL,
	[rsvalinip] [decimal](19, 4) NOT NULL,
	[rsvalvtop] [decimal](19, 4) NOT NULL,
	[rstaspact] [decimal](9, 4) NOT NULL,
	[rstipobono] [char](1) NULL,
	[rscondpacto] [char](3) NULL,
	[rsmascara] [char](12) NULL,
	[rsforpagi] [decimal](4, 0) NOT NULL,
	[rstipoletra] [char](1) NULL,
	[rsvalcompcp] [decimal](19, 4) NULL,
	[rsvalcomucp] [decimal](19, 4) NULL,
	[rsinterescp] [decimal](19, 4) NULL,
	[rsreajustecp] [decimal](19, 4) NULL,
	[rsinteres_acumcp] [decimal](19, 4) NULL,
	[rsreajuste_acumcp] [decimal](19, 4) NULL,
	[rsvppresenx_emis] [decimal](19, 4) NULL,
	[rsinteres_emis] [decimal](19, 4) NULL,
	[rsreajuste_emis] [decimal](19, 4) NULL,
	[rsinteres_acum_emis] [decimal](19, 4) NULL,
	[rsreajuste_acum_emis] [decimal](19, 4) NULL,
	[rsvalor_emis] [decimal](19, 4) NULL,
	[rsvpresen_emis] [decimal](19, 4) NULL,
	[rsvalorum_emis] [decimal](19, 4) NULL,
	[rsnominal_resi] [decimal](19, 4) NULL,
	[codigo_carterasuper] [char](1) NULL,
	[prima_descuento_dia] [decimal](19, 4) NOT NULL,
	[prima_descuento_total] [decimal](19, 4) NOT NULL,
	[valor_tasa_emision] [decimal](19, 4) NOT NULL,
	[valor_par] [decimal](19, 8) NOT NULL
) ON [PRIMARY]
GO
