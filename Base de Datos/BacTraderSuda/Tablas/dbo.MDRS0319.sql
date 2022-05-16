USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDRS0319]    Script Date: 13-05-2022 12:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDRS0319](
	[rsfecha] [datetime] NOT NULL,
	[rsrutcart] [numeric](9, 0) NOT NULL,
	[rstipcart] [numeric](5, 0) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rscorrela] [numeric](3, 0) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsrutcli] [numeric](9, 0) NOT NULL,
	[rscodcli] [numeric](9, 0) NOT NULL,
	[rsvppresen] [numeric](19, 4) NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rscupamo] [numeric](19, 4) NOT NULL,
	[rscupint] [numeric](19, 4) NOT NULL,
	[rscuprea] [numeric](19, 4) NOT NULL,
	[rsflujo] [numeric](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsfecctb] [datetime] NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](9, 4) NOT NULL,
	[rstasfloat] [numeric](9, 4) NOT NULL,
	[rsmonpact] [numeric](3, 0) NOT NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rstasemi] [numeric](9, 4) NOT NULL,
	[rsbasemi] [numeric](3, 0) NOT NULL,
	[rscodigo] [numeric](3, 0) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsintermes] [numeric](19, 4) NOT NULL,
	[rsreajumes] [numeric](19, 4) NOT NULL,
	[rsreajuste_acum] [numeric](19, 4) NOT NULL,
	[rsinteres_acum] [numeric](19, 4) NOT NULL,
	[rsforpagv] [numeric](4, 0) NOT NULL,
	[rsvalcomp] [numeric](19, 4) NOT NULL,
	[rsvalcomu] [numeric](19, 4) NOT NULL,
	[rsvalvenc] [numeric](19, 4) NOT NULL,
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
	[rsdifrea] [numeric](19, 4) NOT NULL,
	[rsinstcam] [char](10) NOT NULL,
	[rsfecinip] [datetime] NOT NULL,
	[rsfecvtop] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [numeric](9, 0) NOT NULL,
	[rsvalinip] [numeric](19, 4) NOT NULL,
	[rsvalvtop] [numeric](19, 4) NOT NULL,
	[rstaspact] [numeric](9, 4) NOT NULL,
	[rstipobono] [char](1) NULL,
	[rscondpacto] [char](3) NULL,
	[rsmascara] [char](12) NULL,
	[rsforpagi] [numeric](4, 0) NOT NULL,
	[rstipoletra] [char](1) NULL,
	[rsvalcompcp] [numeric](19, 4) NULL,
	[rsvalcomucp] [numeric](19, 4) NULL,
	[rsinterescp] [numeric](19, 4) NULL,
	[rsreajustecp] [numeric](19, 4) NULL,
	[rsinteres_acumcp] [numeric](19, 4) NULL,
	[rsreajuste_acumcp] [numeric](19, 4) NULL,
	[rsvppresenx_emis] [numeric](19, 4) NULL,
	[rsinteres_emis] [numeric](19, 4) NULL,
	[rsreajuste_emis] [numeric](19, 4) NULL,
	[rsinteres_acum_emis] [numeric](19, 4) NULL,
	[rsreajuste_acum_emis] [numeric](19, 4) NULL,
	[rsvalor_emis] [numeric](19, 4) NULL,
	[rsvpresen_emis] [numeric](19, 4) NULL,
	[rsvalorum_emis] [numeric](19, 4) NULL,
	[rsnominal_resi] [numeric](19, 4) NULL,
	[codigo_carterasuper] [char](1) NULL,
	[prima_descuento_dia] [numeric](19, 4) NOT NULL,
	[prima_descuento_total] [numeric](19, 4) NOT NULL,
	[valor_tasa_emision] [numeric](19, 4) NOT NULL,
	[valor_par] [numeric](19, 8) NOT NULL,
	[rsid_libro] [char](6) NULL,
	[Sucursal] [varchar](5) NOT NULL,
	[Fecha_PagoMañana] [datetime] NOT NULL,
	[Tipo_Inversion] [char](1) NOT NULL,
	[Tasa_Contrato] [numeric](9, 4) NOT NULL,
	[Valor_Contable] [numeric](19, 4) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[rsfechareal] [datetime] NOT NULL,
	[rsgarantia] [char](1) NOT NULL,
	[RsMtogarantia] [numeric](19, 0) NOT NULL,
	[RsVpTasEmiMan] [numeric](19, 0) NOT NULL,
	[RsVpTasEmiHoy] [numeric](19, 0) NOT NULL,
	[RsIntTasEmiDia] [numeric](19, 0) NOT NULL,
	[RsReaTasEmiDia] [numeric](19, 0) NOT NULL,
	[RsIntTasEmiAcu] [numeric](19, 0) NOT NULL,
	[RsReaTasEmiAcu] [numeric](19, 0) NOT NULL,
	[rsestado_mp] [char](1) NOT NULL,
	[rsmensaje_mp] [char](255) NOT NULL
) ON [PRIMARY]
GO
