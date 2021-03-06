USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_VENTAS]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[VIEW_TABLA_VENTAS]
as

	select	RUT_CARTERA			= morutcart
		,	TIPO_CARTERA		= motipcart
		,	NUMDOCU				= monumdocu
		,	CORRELA				= mocorrela
		,	INSTSER				= moinstser
		,	MASCARA				= momascara
		,	NOMINAL				= monominal
		,	VALCOMP				= movalcomp	-->	valor_compra_original
--		,	TIRCOMP				= motir
--		,	FECCOMP				= fecha_compra_original
		,	FECEMIS				= mofecemi
		,	FECVENC				= mofecven
		,	CODIGO				= mocodigo
		,	FECPCUP				= mofecpcup
		,	FECUCUP				= mofecucup
		,	FECHAPAGO			= Fecha_PagoMañana
		,	FORMAPAGOI			= moforpagi
		,	RUTCLI				= morutcli
		,	CODCLI				= mocodcli
		,	TIRCOMP				= tir_compra_original
		,	VALCOMU				= valor_compra_um_original
		,	FECCOMP				= fecha_compra_original
		,	VPRESEN				= movpresen
		,	VALORPARC			= 0.0
		,	VENTAFECHAREAL		= Fecha_PagoMañana
		,	VENTAVALOR			= movalven
		,	NUMOPER				= monumoper
		,	MONEMIS				= momonemi
		---	campos nuevos
		,	RUTEMIS				= morutemi 
		,	TASEMIS				= motasemi
		,	BASEEMIS			= mobasemi
		,	INST				= inserie
		,	PROG				= inprog
		,	VALORCONTABLE		= movpresen
		,	TIPO_LISTADO		= CASE	WHEN Fecha_PagoMañana = mofecpro THEN 'S'
										ELSE 'T'
									END --	@Pago_Hoy = M and Fecha_Pago_original <= fechaproceso = 'S'
		,	CODIGO_CARTERASUPER	= codigo_carterasuper
		,	RUTCLICOMP			= morutcli
		,	VALINIP				= movalinip -- VALOR PRESENTE A TIR DE VENTA
		,	RENTA				= Tipo_Rentabilidad
		,	VALVTOP				= movalven	
		, TIRHISTORICA			= tir_compra_original
		, BASECOMP				= mobasemi		
		, FECVENP				= ''-- fecvtop
		, TIRANTERIOR			= 0
		, SENALA				= (CASE WHEN fecha_compra_original = (select acfecproc from MDAC with(nolock)) THEN -1 ELSE 3 END)		
	from	bacTraderSuda.dbo.mdmh with(nolock)
			left join BacParamSuda.dbo.INSTRUMENTO with(nolock) on incodigo = mocodigo
	where	motipoper			= 'VP'
	and		mostatreg			= ''

		union
	
	select	RUT_CARTERA			= morutcart
		,	TIPO_CARTERA		= motipcart
		,	NUMDOCU				= monumdocu
		,	CORRELA				= mocorrela
		,	INSTSER				= moinstser
		,	MASCARA				= momascara
		,	NOMINAL				= monominal
		,	VALCOMP				= movalcomp	-->	valor_compra_original
--		,	TIRCOMP				= motir
--		,	FECCOMP				= fecha_compra_original
		,	FECEMIS				= mofecemi
		,	FECVENC				= mofecven
		,	CODIGO				= mocodigo
		,	FECPCUP				= mofecpcup
		,	FECUCUP				= mofecucup
		,	FECHAPAGO			= Fecha_PagoMañana
		,	FORMAPAGOI			= moforpagi
		,	RUTCLI				= morutcli
		,	CODCLI				= mocodcli
		,	TIRCOMP				= tir_compra_original
		,	VALCOMU				= valor_compra_um_original
		,	FECCOMP				= fecha_compra_original
		,	VPRESEN				= movpresen
		,	VALORPARC			= 0.0
		,	VENTAFECHAREAL		= Fecha_PagoMañana
		,	VENTAVALOR			= movalven
		,	NUMOPER				= monumoper
		,	MONEMIS				= momonemi
		---	campos nuevos
		,	RUTEMIS				= morutemi 
		,	TASEMIS				= motasemi
		,	BASEEMIS			= mobasemi 
		,	INST				= inserie
		,	PROG				= inprog
		,	VALORCONTABLE		= movpresen
		,	TIPO_LISTADO		= CASE	WHEN Fecha_PagoMañana = mofecpro THEN 'S'
										ELSE 'T'
									END --	@Pago_Hoy = M and Fecha_Pago_original <= fechaproceso = 'S'
		,	CODIGO_CARTERASUPER	= codigo_carterasuper
		,	RUTCLICOMP			= morutcli
		,	VALINIP				= movalinip -- VALOR PRESENTE A TIR DE VENTA
		,	RENTA				= Tipo_Rentabilidad
		,	VALVTOP				= movalven			
		, TIRHISTORICA			= tir_compra_original
		, BASECOMP				= mobasemi		
		, FECVENP				= ''-- fecvtop
		, TIRANTERIOR			= 0
		, SENALA				= (CASE WHEN fecha_compra_original = (select acfecproc from MDAC with(nolock)) THEN -1 ELSE 3 END)		
	from	bacTraderSuda.dbo.mdmo with(nolock)
			left join BacParamSuda.dbo.INSTRUMENTO with(nolock) on incodigo = mocodigo
	where	motipoper			= 'VP'
	and		mostatreg			= ''

GO
