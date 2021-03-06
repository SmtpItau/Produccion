USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[RES_ticketbonext]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RES_ticketbonext](
	[rsfecpro] [datetime] NOT NULL,
	[rsrutcart] [numeric](9, 0) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rscorrelativo] [numeric](18, 0) NULL,
	[rscartera] [char](3) NOT NULL,
	[cod_familia] [numeric](4, 0) NULL,
	[rstipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[rsrutcli] [numeric](9, 0) NOT NULL,
	[rscodcli] [numeric](9, 0) NOT NULL,
	[rsvppresen] [float] NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rscupamo] [numeric](19, 4) NOT NULL,
	[rscupint] [numeric](19, 4) NOT NULL,
	[rscuprea] [numeric](19, 4) NOT NULL,
	[rsflujo] [numeric](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](19, 7) NOT NULL,
	[rspvp] [numeric](19, 7) NOT NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rsmonpag] [numeric](3, 0) NOT NULL,
	[rstasemi] [numeric](19, 7) NOT NULL,
	[rsbasemi] [numeric](3, 0) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsreajuste_acum] [numeric](19, 4) NOT NULL,
	[rsinteres_acum] [numeric](19, 4) NOT NULL,
	[rsvalcomu] [float] NOT NULL,
	[rsvalvenc] [numeric](19, 4) NOT NULL,
	[rsnumucup] [numeric](3, 0) NOT NULL,
	[rsnumpcup] [numeric](3, 0) NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rsfecpvencap] [datetime] NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rsfecpago] [datetime] NOT NULL,
	[rsfeccomp] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [numeric](9, 0) NULL,
	[rscodemi] [numeric](1, 0) NULL,
	[rstirmerc] [numeric](19, 7) NOT NULL,
	[rspvpmerc] [numeric](19, 7) NOT NULL,
	[rsvalmerc] [numeric](19, 4) NOT NULL,
	[basilea] [numeric](1, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [numeric](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](1) NOT NULL,
	[sucursal] [smallint] NULL,
	[rsint_compra] [numeric](19, 4) NOT NULL,
	[rsprincipal] [numeric](19, 4) NOT NULL,
	[operador_banco] [char](30) NOT NULL,
	[rsfecneg] [datetime] NOT NULL,
	[rsfecpag] [datetime] NOT NULL,
	[rspfectraspaso] [datetime] NOT NULL,
	[rsajuste_traspaso] [numeric](19, 4) NOT NULL,
	[sw_tir] [numeric](1, 0) NOT NULL,
	[sw_pvp] [numeric](1, 0) NOT NULL,
	[CapitalPeso] [numeric](24, 0) NOT NULL,
	[InteresPeso] [numeric](24, 0) NOT NULL,
	[ValorCuponPeso] [numeric](24, 0) NOT NULL,
	[InteresPesoAcum] [numeric](24, 0) NOT NULL,
	[PrincipalDia] [numeric](19, 4) NOT NULL,
	[ValorPresentePeso] [numeric](19, 0) NOT NULL,
	[PrincipalDiaPeso] [numeric](24, 0) NOT NULL,
	[rsDiferenciaMerc] [float] NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[RsId_Libro] [char](10) NULL,
	[PorcjeCob] [numeric](5, 2) NULL,
	[RsTirMercParPrx] [numeric](19, 4) NULL,
	[RsTirMercCLPParPrx] [numeric](19, 4) NULL,
	[mesa_origen] [smallint] NULL,
	[mesa_destino] [smallint] NULL,
	[cartera_destino] [smallint] NULL,
	[operacion_relacionada] [smallint] NULL
) ON [PRIMARY]
GO
