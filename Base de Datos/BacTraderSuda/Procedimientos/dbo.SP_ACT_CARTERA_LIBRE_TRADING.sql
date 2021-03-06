USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CARTERA_LIBRE_TRADING]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_CARTERA_LIBRE_TRADING]	(	@IdSistema	CHAR(3)= ''	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@FEC_PROC_RF_MN		DATETIME
	,	@FEC_ANT_RF_MN		DATETIME
	,	@FEC_PROC_RF_MX		DATETIME
	,	@FEC_ANT_RF_MX		DATETIME
	,	@FEC_PROC_FORWARD	DATETIME
	,	@FEC_ANT_FORWARD	DATETIME
	,	@FEC_PROC_SWAP		DATETIME
	,	@FEC_ANT_SWAP		DATETIME

	------------------------------------------------- Renta Fija M/N -------------------------------------------------
--	BEGIN TRAN
		
	/*********************** CARTERA PROPIA *****************************/		
	IF @IDSISTEMA = 'BTR' BEGIN
		
		SELECT	@FEC_ANT_RF_MN		= acfecante
		,	@FEC_PROC_RF_MN		= acfecproc
 		FROM	BACTRADERSUDA..MDAC
		
		DELETE	TBL_CARTERA_LIBRE_TRADING 
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
		AND	Clt_Sistema	= 'BTR'
		
		INSERT INTO TBL_CARTERA_LIBRE_TRADING
		(	Clt_FechaProc
		,	Clt_Sistema
		,	Clt_TipOper
		,	Clt_Libro
		,	Clt_CarteraSuper
		,	Clt_SubCartera
		,	Clt_CarteraFin
		,	Clt_RutCart
		,	Clt_RutCli
		,	Clt_Modalidad
		,	Clt_NumOper
		,	Clt_NumDocu
		,	Clt_NumCorr
		,	Clt_Instrum
		,	Clt_Mascara
		,	Clt_Codigo
		,	Clt_Seriado
		,	Clt_RutEmi
		,	Clt_GenEmi
		,	Clt_FechaIni
		,	Clt_FechaFin
		,	Clt_FecUCup
		,	Clt_FecPCup
		,	Clt_MonEmi
		,	Clt_MonConv
		,	Clt_TC_PP_Ini
		,	Clt_TM_PP_Val
		,	Clt_Nominal_MonCont
		,	Clt_VPTC_ValAct
		,	Clt_VPTM_ValAct
		,	Clt_Res_VM_VP
		)
		SELECT	'Clt_FechaProc'		= @FEC_PROC_RF_MN
		,	'Clt_Sistema'		= 'BTR'
		,	'Clt_TipOper'		= 'CP'
		,	'Clt_Libro'		= id_libro
		,	'Clt_CarteraSuper'	= codigo_carterasuper
		,	'Clt_SubCartera'	= ''
		,	'Clt_CarteraFin'	= cptipcart
		,	'Clt_RutCart'		= cprutcart
		,	'Clt_RutCli'		= cprutcli
		,	'Clt_Modalidad'		= ''
		,	'Clt_NumOper'		= cpnumdocuo
		,	'Clt_NumDocu'		= cpnumdocu
		,	'Clt_NumCorr'		= cpcorrela
		,	'Clt_Instrum'		= cpinstser 
		,	'Clt_Mascara'		= cpmascara
		,	'Clt_Codigo'		= cpcodigo
		,	'Clt_Seriado'		= cpseriado
		,	'Clt_RutEmi'		= 0
		,	'Clt_GenEmi'		= ''
		,	'Clt_FechaIni'		= cpfecemi
		,	'Clt_FechaFin'		= cpfecven
		,	'Clt_FecUCup'		= cpfecucup
		,	'Clt_FecPCup'		= cpfecpcup
		,	'Clt_MonEmi'		= 0
		,	'Clt_MonConv'		= 0. 
		,	'Clt_TC_PP_Ini'		= cptircomp
		,	'Clt_TM_PP_Val'		= 0.	--> Calcular 
		,	'Clt_Nominal_MonCont'	= cpnominal
		,	'Clt_VPTC_ValAct'	= cpvptirc
		,	'Clt_VPTM_ValAct'	= 0.	--> Calcular
		,	'Clt_Res_VM_VP'		= 0.	--> Calcular
		FROM	MDCP
		WHERE	cpnominal 	> 0	

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL INSERTAR DESDE MDCP - CARTERA PROPIA'
			RETURN
		END

		UPDATE	TBL_CARTERA_LIBRE_TRADING
		SET	Clt_RutEmi	= ISNULL(serutemi,0)
		,	Clt_MonEmi	= ISNULL(semonemi,0)
		FROM	VIEW_SERIE A
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
		AND	Clt_Sistema	= 'BTR'
		AND	Clt_TipOper	= 'CP'
		AND	Clt_Seriado	= 'S'	
		AND	Clt_Codigo	= 20	
		AND	secodigo	= Clt_Codigo
		AND	LEN(semascara)	= 6
		AND	semascara	= Clt_Mascara
			
		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL ACTUALIZAR LOS DATOS DEL EMISOR 20 - 6 - CARTERA PROPIA'
			RETURN
		END
			
		UPDATE	TBL_CARTERA_LIBRE_TRADING
		SET	Clt_RutEmi	= ISNULL(serutemi,0)
		,	Clt_MonEmi	= ISNULL(semonemi,0)
		FROM	VIEW_SERIE A
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
		AND	Clt_Sistema	= 'BTR'
		AND	Clt_TipOper	= 'CP'
		AND	Clt_Seriado	= 'S'	
		AND	Clt_Codigo	= 20	
		AND	secodigo	= Clt_Codigo
		AND	LEN(semascara)	> 6
		AND	semascara	= Clt_Instrum

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL ACTUALIZAR LOS DATOS DEL EMISOR 20 - >6 - CARTERA PROPIA'
			RETURN
		END	

		UPDATE	TBL_CARTERA_LIBRE_TRADING
		SET	Clt_RutEmi	= ISNULL(serutemi,0)
		,	Clt_MonEmi	= ISNULL(semonemi,0)
		FROM	VIEW_SERIE A
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
		AND	Clt_Sistema	= 'BTR'
		AND	Clt_TipOper	= 'CP'
		AND	Clt_Seriado	= 'S'	
		AND	Clt_Codigo	<> 20	
		AND	secodigo	= Clt_Codigo
		AND	semascara	= Clt_Instrum

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL ACTUALIZAR LOS DATOS DEL EMISOR - <> 20 - CARTERA PROPIA'
			RETURN
		END

		UPDATE	TBL_CARTERA_LIBRE_TRADING
		SET	Clt_RutEmi	= ISNULL(nsrutemi,0)
		,	Clt_MonEmi	= ISNULL(nsmonemi,0)
		FROM	VIEW_NOSERIE A
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
		AND	Clt_Sistema	= 'BTR'
		AND	Clt_TipOper	= 'CP'
		AND	Clt_Seriado	= 'N'
		AND	nsnumdocu    	= Clt_NumDocu
		AND	nscorrela	= Clt_NumCorr

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL ACTUALIZAR LOS DATOS DEL EMISOR - CARTERA PROPIA'
			RETURN
		END
			/*********************** INTERMEDIADOS *****************************/

		INSERT INTO TBL_CARTERA_LIBRE_TRADING
		(	Clt_FechaProc
		,	Clt_Sistema
		,	Clt_TipOper
		,	Clt_Libro
		,	Clt_CarteraSuper
		,	Clt_SubCartera
		,	Clt_CarteraFin
		,	Clt_RutCart
		,	Clt_RutCli
		,	Clt_Modalidad
		,	Clt_NumOper
		,	Clt_NumDocu
		,	Clt_NumCorr
		,	Clt_Instrum
		,	Clt_Mascara
		,	Clt_Codigo
		,	Clt_Seriado
		,	Clt_RutEmi
		,	Clt_GenEmi
		,	Clt_FechaIni
		,	Clt_FechaFin
		,	Clt_FecUCup
		,	Clt_FecPCup
		,	Clt_MonEmi
		,	Clt_MonConv
		,	Clt_TC_PP_Ini
		,	Clt_TM_PP_Val
		,	Clt_Nominal_MonCont
		,	Clt_VPTC_ValAct
		,	Clt_VPTM_ValAct
		,	Clt_Res_VM_VP
		)
		SELECT	'Clt_FechaProc'		= @FEC_PROC_RF_MN
		,	'Clt_Sistema'		= 'BTR'
		,	'Clt_TipOper'		= 'VI'
		,	'Clt_Libro'		= id_libro
		,	'Clt_CarteraSuper'	= codigo_carterasuper
		,	'Clt_SubCartera'	= ''
		,	'Clt_CarteraFin'	= Tipo_Cartera_Financiera
		,	'Clt_RutCart'		= virutcart
		,	'Clt_RutCli'		= virutcli
		,	'Clt_Modalidad'		= ''
		,	'Clt_NumOper'		= vinumoper
		,	'Clt_NumDocu'		= vinumdocu
		,	'Clt_NumCorr'		= vicorrela
		,	'Clt_Instrum'		= viinstser 
		,	'Clt_Mascara'		= vimascara
		,	'Clt_Codigo'		= vicodigo
		,	'Clt_Seriado'		= viseriado
		,	'Clt_RutEmi'		= virutemi
		,	'Clt_GenEmi'		= ''
		,	'Clt_FechaIni'		= vifecemi
		,	'Clt_FechaFin'		= vifecven
		,	'Clt_FecUCup'		= vifecucup
		,	'Clt_FecPCup'		= vifecpcup
		,	'Clt_MonEmi'		= vimonemi
		,	'Clt_MonConv'		= 0.
		,	'Clt_TC_PP_Ini'		= vitircomp
		,	'Clt_TM_PP_Val'		= 0.	--> Calcular 
		,	'Clt_Nominal_MonCont'	= vinominal
		,	'Clt_VPTC_ValAct'	= vivptirc
		,	'Clt_VPTM_ValAct'	= 0.	--> Calcular
		,	'Clt_Res_VM_VP'		= 0.	--> Calcular
		FROM	MDVI
		WHERE	vitipoper = 'CP'

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL INSERTAR DESDE MDVI - VENTAS CON PACTO'
			RETURN
		END

		UPDATE	TBL_CARTERA_LIBRE_TRADING
		SET	Clt_genemi	= emgeneric
		FROM	BACPARAMSUDA..EMISOR
		WHERE	Clt_Sistema	= 'BTR'
		AND	Clt_GenEmi	= ''
		AND	emrut		= Clt_RutEmi

		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR ACTUALIZAR EL GENERICO DEL EMISOR'
			RETURN
		END
	END
					/****************************************************/
	------------------------------------------------- Renta Fija M/X -------------------------------------------------

	IF @IDSISTEMA = 'BEX' BEGIN

		SELECT	@FEC_ANT_RF_MX		= acfecante
		,	@FEC_PROC_RF_MX		= acfecproc
 		FROM	BACBONOSEXTSUDA..text_arc_ctl_dri
		
		DELETE	TBL_CARTERA_LIBRE_TRADING 
		WHERE	Clt_FechaProc	= @FEC_PROC_RF_MX
		AND	Clt_Sistema	= 'BEX'	

		INSERT INTO TBL_CARTERA_LIBRE_TRADING
		(	Clt_FechaProc
		,	Clt_Sistema
		,	Clt_TipOper
		,	Clt_RutCart
		,	Clt_Libro
		,	Clt_CarteraSuper
		,	Clt_SubCartera
		,	Clt_CarteraFin
		,	Clt_RutCli
		,	Clt_Modalidad
		,	Clt_NumOper
		,	Clt_NumDocu
		,	Clt_NumCorr
		,	Clt_Instrum
		,	Clt_Codigo
		,	Clt_RutEmi
		,	Clt_FecEmi
		,	Clt_FechaIni
		,	Clt_FechaFin
		,	Clt_TasaEmi
		,	Clt_BaseEmi
		,	Clt_MonEmi
		,	Clt_MonConv
		,	Clt_TC_PP_Ini
		,	Clt_TM_PP_Val
		,	Clt_Nominal_MonCont
		,	Clt_TipoTasa
		,	Clt_VPTC_ValAct
		,	Clt_VPTM_ValAct
		,	Clt_Res_VM_VP
		)
		SELECT	'Clt_FechaProc'		= @FEC_PROC_RF_MX
		,	'Clt_Sistema'		= 'BEX'
		,	'Clt_TipOper'		= 'CP'
		,	'Clt_RutCart'		= cprutcart
		,	'Clt_Libro'		= A.Id_Libro
		,	'Clt_CarteraSuper'	= A.codigo_carterasuper
		,	'Clt_SubCartera'	= ''
		,	'Clt_CarteraFin'	= A.tipo_cartera_financiera
		,	'Clt_RutCli'		= cprutcli
		,	'Clt_Modalidad'		= ''
		,	'Clt_NumOper'		= cpnumdocu
		,	'Clt_NumDocu'		= cpnumdocu
		,	'Clt_NumCorr'		= cpcorrelativo
		,	'Clt_Instrum'		= A.id_instrum
		,	'Clt_Codigo'		= A.cod_familia
		,	'Clt_RutEmi'		= cprutemi
		,	'Clt_FecEmi'		= cpfecemi
		,	'Clt_FechaIni'		= cpfecpago
		,	'Clt_FechaFin'		= cpfecven
		,	'Clt_TasaEmi'		= cptasemi
		,	'Clt_BaseEmi'		= cpbasemi
		,	'Clt_MonEmi'		= cpmonemi
		,	'Clt_MonConv'		= cpvalcomu
		,	'Clt_TC_PP_Ini'		= cptircomp
		,	'Clt_TM_PP_Val'		= 0. 
		,	'Clt_Nominal_MonCont'	= cpnominal
		,	'Clt_TipoTasa'		= A.tipo_tasa
		,	'Clt_VPTC_ValAct'	= cpvptirc
		,	'Clt_VPTM_ValAct'	= 0.	
		,	'Clt_Res_VM_VP'		= 0.	
		FROM	BACBONOSEXTSUDA..text_ctr_inv	A
		,	BACBONOSEXTSUDA..text_mvt_dri	B
		WHERE	cpnominal	> 0
		AND	mofecpro	= cpfeccomp
		AND	morutcart	= cprutcart 
		AND	monumoper	= cpnumdocu
		AND	monumdocu	= cpnumdocu
		AND	mocorrelativo	= cpcorrelativo
		AND	motipoper	= 'CP'
		
		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL INSERTAR DESDE CARTERA BONOS EN EL EXTERIOR'
			RETURN
		END
	END
						
	------------------------------------------------- FORWARD  -------------------------------------------------

	IF @IDSISTEMA = 'BFW' BEGIN

		SELECT	@FEC_ANT_FORWARD	= acfecante
		,	@FEC_PROC_FORWARD	= acfecproc
 		FROM	BACFWDSUDA..MFAC
		
		DELETE	TBL_CARTERA_LIBRE_TRADING 
		WHERE	Clt_FechaProc	= @FEC_PROC_FORWARD
		AND	Clt_Sistema	= 'BFW'
		
		INSERT INTO TBL_CARTERA_LIBRE_TRADING
		(	Clt_FechaProc
		,	Clt_Sistema
		,	Clt_TipOper
		,	Clt_Tipo_Mov
		,	Clt_Libro
		,	Clt_CarteraSuper
		,	Clt_SubCartera
		,	Clt_CarteraFin
		,	Clt_RutCli
		,	Clt_Modalidad
		,	Clt_NumOper
		,	Clt_NumDocu
		,	Clt_NumCorr
		,	Clt_Seriado
		,	Clt_Instrum
		,	Clt_Codigo
		,	Clt_RutEmi
		,	Clt_FechaIni
		,	Clt_FechaFin
		,	clt_fecucup
		,	Clt_MonEmi
		,	Clt_CodMon
		,	Clt_TasaEmi
		,	Clt_MonConv
		,	Clt_TC_PP_Ini
		,	Clt_TM_PP_Val
		,	Clt_Nominal_MonCont
		,	Clt_VPTC_ValAct
		,	Clt_VPTM_ValAct
		,	Clt_Res_VM_VP
		)
		SELECT	'Clt_FechaProc'		= @FEC_PROC_FORWARD
		,	'Clt_Sistema'		= 'BFW'
		,	'Clt_TipOper'		= cacodpos1
		,	'Clt_Tipo_Mov'		= catipoper
		,	'Clt_Libro'		= calibro
		,	'Clt_CarteraSuper'	= cacartera_normativa
		,	'Clt_SubCartera'	= casubcartera_normativa
		,	'Clt_CarteraFin'	= cacodcart
		,	'Clt_RutCli'		= cacodigo
		,	'Clt_Modalidad'		= catipmoda
		,	'Clt_NumOper'		= canumoper
		,	'Clt_NumDocu'		= 0.
		,	'Clt_NumCorr'		= 1
		,	'Clt_Seriado'		= caseriado
		,	'Clt_Instrum'		= caserie
		,	'Clt_Codigo'		= cabroker
		,	'Clt_RutEmi'		= 0
		,	'Clt_FechaIni'		= cafecha
		,	'Clt_FechaFin'		= cafecvcto
		,	'clt_fecucup'		= cafecEfectiva
		,	'Clt_MonEmi'		= cacodmon1
		,	'Clt_CodMon'		= cacodmon2
		,	'Clt_TasaEmi'		= catipcam
		,	'Clt_MonConv'		= FLOOR( caequmon1 )
		,	'Clt_TC_PP_Ini'		= capremon1 --CASE cacodpos1 WHEN 2 THEN caparmon1 ELSE capremon1 END
		,	'Clt_TM_PP_Val'		= 0. 
		,	'Clt_Nominal_MonCont'	= camtomon1
		,	'Clt_VPTC_ValAct'	= 0
		,	'Clt_VPTM_ValAct'	= 0.
		,	'Clt_Res_VM_VP'		= 0.
		FROM	BACFWDSUDA..MFCA
		
		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL INSERTAR DESDE CARTERA FORWARD'
			RETURN
		END
	END

	------------------------------------------------- SWAP  -------------------------------------------------
		
	IF @IDSISTEMA = 'PCS' BEGIN

		SELECT	@FEC_ANT_SWAP		= fechaant
		,	@FEC_PROC_SWAP		= fechaproc
 		FROM	BACSWAPSUDA..SwapGeneral	
		
		DELETE	TBL_CARTERA_LIBRE_TRADING 
		WHERE	Clt_FechaProc	= @FEC_PROC_SWAP
		AND	Clt_Sistema	= 'PCS'
		
		INSERT INTO TBL_CARTERA_LIBRE_TRADING
		(	Clt_FechaProc
		,	Clt_Sistema
		,	Clt_TipOper
		,	Clt_Tipo_Mov
		,	Clt_Libro
		,	Clt_CarteraSuper
		,	Clt_SubCartera
		,	Clt_CarteraFin
		,	Clt_RutCli
		,	Clt_Modalidad
		,	Clt_NumOper
		,	Clt_NumDocu
		,	Clt_NumCorr
		,	Clt_Estado
		,	Clt_Instrum
		,	Clt_RutEmi
		,	Clt_FechaIni
		,	Clt_FechaFin
		,	Clt_FecPCup
		,	Clt_FecUCup
		,	Clt_Spread
		,	Clt_Periodo
		,	Clt_Interes
		,	Clt_BaseEmi
		,	Clt_Codigo
		,	Clt_TasaEmi
		,	Clt_Zcr
		,	Clt_MonEmi
		,	Clt_MonConv
		,	Clt_Saldo
		,	Clt_TC_PP_Ini
		,	Clt_TM_PP_Val
		,	Clt_Nominal_MonCont
		,	Clt_VPTC_ValAct
		,	Clt_VPTM_ValAct
		,	Clt_Res_VM_VP
		)	
		SELECT	'Clt_FechaProc'		= @FEC_PROC_SWAP
		,	'Clt_Sistema'		= 'PCS'
		,	'Clt_TipOper'		= tipo_swap
		,	'Clt_Tipo_Mov'		= Tipo_flujo
		,	'Clt_Libro'		= car_Libro
		,	'Clt_CarteraSuper'	= car_Cartera_Normativa
		,	'Clt_SubCartera'	= car_SubCartera_Normativa
		,	'Clt_CarteraFin'	= cartera_inversion
		,	'Clt_RutCli'		= rut_cliente
		,	'Clt_Modalidad'		= modalidad_pago
		,	'Clt_NumOper'		= numero_operacion
		,	'Clt_NumDocu'		= 0.
		,	'Clt_NumCorr'		= numero_flujo
		,	'Clt_Estado'		= LTRIM(RTRIM(CONVERT(CHAR,estado_flujo)))
		,	'Clt_Instrum'		= ''
		,	'Clt_RutEmi'		= 0
		,	'Clt_FechaIni'		= fecha_inicio
		,	'Clt_FechaFin'		= fecha_cierre
		,	'Clt_FecPCup'		= fecha_inicio_flujo
		,	'Clt_FecUCup'		= fecha_vence_flujo
		,	'Clt_Spread'		= CASE Tipo_Flujo WHEN 1 THEN compra_spread		WHEN 2 THEN venta_spread		END
		,	'Clt_Periodo'		= CASE Tipo_Flujo WHEN 1 THEN compra_codamo_interes	WHEN 2 THEN venta_codamo_interes	END
		,	'Clt_Interes'		= CASE Tipo_Flujo WHEN 1 THEN compra_interes		WHEN 2 THEN venta_interes		END
		,	'Clt_BaseEmi'		= CASE Tipo_Flujo WHEN 1 THEN compra_base		WHEN 2 THEN venta_base			END
		,	'Clt_Codigo'		= CASE Tipo_Flujo WHEN 1 THEN compra_codigo_tasa	WHEN 2 THEN venta_codigo_tasa		END
		,	'Clt_TasaEmi'		= CASE Tipo_Flujo WHEN 1 THEN compra_valor_tasa		WHEN 2 THEN venta_valor_tasa		END
		,	'Clt_Zcr'		= CASE Tipo_Flujo WHEN 1 THEN compra_zcr		WHEN 2 THEN venta_zcr			END
		,	'Clt_MonEmi'		= CASE Tipo_Flujo WHEN 1 THEN compra_moneda		WHEN 2 THEN venta_moneda		END
		,	'Clt_MonConv'		= CASE Tipo_Flujo WHEN 1 THEN compra_amortiza		WHEN 2 THEN venta_amortiza		END
		,	'Clt_Saldo'		= CASE Tipo_Flujo WHEN 1 THEN compra_saldo		WHEN 2 THEN venta_saldo			END
		,	'Clt_TC_PP_Ini'		= CASE Tipo_Flujo WHEN 1 THEN compra_mercado_tasa	WHEN 2 THEN venta_mercado_tasa		END
		,	'Clt_TM_PP_Val'		= 0. 
		,	'Clt_Nominal_MonCont'	= CASE Tipo_Flujo WHEN 1 THEN compra_capital		WHEN 2 THEN venta_capital		END
		,	'Clt_VPTC_ValAct'	= Valor_RazonableMO
		,	'Clt_VPTM_ValAct'	= 0.
		,	'Clt_Res_VM_VP'		= 0.
		FROM	BACSWAPSUDA..CARTERA	A
		WHERE	compra_capital	> 0 
		
		IF @@ERROR <> 0 BEGIN 		
--			ROLLBACK TRAN 
			PRINT 'ERROR AL INSERTAR DESDE CARTERA SWAP'
			RETURN
		END
	END

--	COMMIT TRAN
/*
	SELECT	*
	FROM	TBL_CARTERA_LIBRE_TRADING 
	WHERE	Clt_FechaProc	= @FEC_PROC_RF_MN
	AND	Clt_Sistema	= 'BTR'

	UNION ALL

	SELECT	*
	FROM	TBL_CARTERA_LIBRE_TRADING 
	WHERE	Clt_FechaProc	= @FEC_PROC_RF_MX
	AND	Clt_Sistema	= 'BEX'

	UNION ALL

	SELECT	*
	FROM	TBL_CARTERA_LIBRE_TRADING 
	WHERE	Clt_FechaProc	= @FEC_PROC_FORWARD
	AND	Clt_Sistema	= 'BFW'

	UNION ALL

	SELECT	*
	FROM	TBL_CARTERA_LIBRE_TRADING 
	WHERE	Clt_FechaProc	= @FEC_PROC_SWAP
	AND	Clt_Sistema	= 'PCS'


	ORDER
	BY	Clt_Sistema
	,	Clt_TipOper
*/
	SET NOCOUNT OFF

END






GO
