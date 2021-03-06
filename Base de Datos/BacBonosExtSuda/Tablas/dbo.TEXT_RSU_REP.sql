USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[TEXT_RSU_REP]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEXT_RSU_REP](
	[rsfecpro] [datetime] NOT NULL,
	[rsrutcart] [decimal](9, 0) NOT NULL,
	[rsnumdocu] [decimal](10, 0) NOT NULL,
	[rsnumoper] [decimal](10, 0) NOT NULL,
	[rscorrelativo] [char](10) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[cod_familia] [decimal](4, 0) NULL,
	[rstipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[rsrutcli] [decimal](9, 0) NOT NULL,
	[rscodcli] [decimal](9, 0) NOT NULL,
	[rsvppresen] [float] NOT NULL,
	[rsvppresenx] [decimal](19, 4) NOT NULL,
	[rscupamo] [decimal](19, 4) NOT NULL,
	[rscupint] [decimal](19, 4) NOT NULL,
	[rscuprea] [decimal](19, 4) NOT NULL,
	[rsflujo] [decimal](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsnominal] [decimal](19, 4) NOT NULL,
	[rstir] [decimal](19, 7) NOT NULL,
	[rspvp] [decimal](19, 7) NOT NULL,
	[rsmonemi] [decimal](3, 0) NOT NULL,
	[rsmonpag] [decimal](3, 0) NOT NULL,
	[rstasemi] [decimal](19, 7) NOT NULL,
	[rsbasemi] [decimal](3, 0) NOT NULL,
	[rsinteres] [decimal](19, 4) NOT NULL,
	[rsreajuste] [decimal](19, 4) NOT NULL,
	[rsreajuste_acum] [decimal](19, 4) NOT NULL,
	[rsinteres_acum] [decimal](19, 4) NOT NULL,
	[rsvalcomu] [float] NOT NULL,
	[rsvalvenc] [decimal](19, 4) NOT NULL,
	[rsnumucup] [decimal](3, 0) NOT NULL,
	[rsnumpcup] [decimal](3, 0) NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rsfecpvencap] [datetime] NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rsfecpago] [datetime] NOT NULL,
	[rsfeccomp] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [decimal](9, 0) NULL,
	[rscodemi] [decimal](1, 0) NULL,
	[rstirmerc] [decimal](19, 7) NOT NULL,
	[rspvpmerc] [decimal](19, 7) NOT NULL,
	[rsvalmerc] [decimal](19, 4) NOT NULL,
	[basilea] [decimal](1, 0) NOT NULL,
	[tipo_tasa] [decimal](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [decimal](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](1) NOT NULL,
	[sucursal] [smallint] NOT NULL,
	[calce] [char](1) NOT NULL,
	[rsint_compra] [decimal](19, 4) NOT NULL,
	[rsprincipal] [decimal](19, 4) NOT NULL,
	[operador_banco] [char](30) NOT NULL,
	[rsfecneg] [datetime] NOT NULL,
	[rsfecpag] [datetime] NOT NULL,
	[corr_cli_nombre] [char](50) NOT NULL,
	[corr_cli_cta] [char](30) NOT NULL,
	[corr_cli_aba] [char](9) NOT NULL,
	[corr_cli_pais] [char](15) NOT NULL,
	[corr_cli_ciud] [char](15) NOT NULL,
	[corr_cli_swift] [char](30) NOT NULL,
	[corr_cli_ref] [char](30) NOT NULL,
	[rspfectraspaso] [datetime] NOT NULL,
	[rsajuste_traspaso] [decimal](19, 4) NOT NULL,
	[sw_tir] [decimal](1, 0) NOT NULL,
	[sw_pvp] [decimal](1, 0) NOT NULL,
	[CapitalPeso] [decimal](24, 0) NOT NULL,
	[InteresPeso] [decimal](24, 0) NOT NULL,
	[ValorCuponPeso] [decimal](24, 0) NOT NULL,
	[InteresPesoAcum] [decimal](24, 0) NOT NULL,
	[PrincipalDia] [decimal](19, 4) NOT NULL,
	[ValorPresentePeso] [decimal](19, 0) NOT NULL,
	[PrincipalDiaPeso] [decimal](24, 0) NOT NULL
) ON [PRIMARY]
GO
