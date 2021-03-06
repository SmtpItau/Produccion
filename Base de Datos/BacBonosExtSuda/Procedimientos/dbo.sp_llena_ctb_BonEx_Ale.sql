USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_llena_ctb_BonEx_Ale]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_llena_ctb_BonEx_Ale] --'20030515'  sp_helptext sp_llena_ctb_BonEx -- select * from BAC_CNT_ERRORES 
-- select * from bac_cnt_contabiliza 
       (
         @Fecha_Hoy DATETIME
       )
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Fecha_Ant DATETIME
	DECLARE @Fecha_prox DATETIME

	SELECT @Fecha_Ant = acfecante , 
               @fecha_prox = acfecprox 
          FROM text_arc_ctl_dri


	DECLARE @Control_Error    INTEGER
	DECLARE @Valor_Observado  FLOAT
	DECLARE @Rut_Central      NUMERIC(10)
	DECLARE @Habil            CHAR(1)
	DECLARE @Fecha_Paso       DATETIME
	DECLARE @VVISTA           CHAR(4)
	DECLARE @rut_estado	NUMERIC(10)
	DECLARE @RUT_CLIENTE     NUMERIC(10)  

	SELECT	@Valor_Observado = ISNULL( vmvalor, 1.0 )
	FROM	VIEW_VALOR_MONEDA
	WHERE	vmcodigo         = 994
	AND	vmfecha          = @Fecha_Hoy

	
	SELECT	@Rut_estado = 97030000

	SELECT	@RUT_CLIENTE = ACRUTPROP
	FROM	text_arc_ctl_dri

	/*=======================================================================*/
	/* LIMPIA ARCHIVO DE CONTABILIZACION                                     */
	/*=======================================================================*/
	DELETE bac_cnt_contabiliza 

	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (Bonos Exterior).'
		RETURN 1
	END
	/*=======================================================================*/
	/* Busca si el sistema esta en una fecha no habil (Fin de mes feriado)   */
	/*=======================================================================*/
	SELECT @Fecha_Paso = @Fecha_Hoy

	IF DATEDIFF( DAY, @Fecha_Hoy, @Fecha_Paso ) <> 0 BEGIN
		SELECT @Habil = 'N'
	END ELSE BEGIN
		SELECT @Habil = 'S'
	END
	-- Devengos del dia
	SELECT * INTO #tmp_mdrs
	FROM	text_rsu
	WHERE	rsfecpro     = @Fecha_Hoy
	and     rstipoper    = 'DEV'

	-- Devengos del dia, interes de operaciones que se vendieron
	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro     = @Fecha_Hoy
	AND     rstipoper    = 'DV'

	-- Vencimiento de operaciones cd - dpex - notex
	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro     = @Fecha_Ant
	and     rstipoper    = 'V'

	-- Vencimiento de operaciones bonex
	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro     = @Fecha_Hoy
	and     rstipoper    = 'VCP'
-- select * from text_rsu where rsfecpro = '20030509'

	/*=======================================================================*/
	/* Llena operaciones 		                                         */
	/*=======================================================================*/

	INSERT INTO bac_cnt_contabiliza
	(	id_sistema			, -- 01
		tipo_movimiento			, -- 02
		tipo_operacion			, -- 03
		operacion                         , -- 04
		correlativo                       , -- 05
		codigo_instrumento  		  , -- 06
		moneda_instrumento                , -- 07
		valor_compra                      , -- 08
		valor_presente           	  , -- 09
		valor_venta                       , -- 10
		utilidad                          , -- 11
		perdida                           , -- 12
		interes_papel                     , -- 13
		interes_pacto                     , -- 14
		valor_cupon                       , -- 15
		valor_comprahis                   , -- 16
		dif_ant_pacto_pos                 , -- 17
		dif_ant_pacto_neg                 , -- 18
		dif_valor_mercado_pos             , -- 19
		dif_valor_mercado_neg             , -- 20
		condicion_pacto                   , -- 21
		tipo_cliente                      , -- 22
		forma_pago                        , -- 23
		tipo_emisor                       , -- 24
		nominal		                  , -- 25 
		forma_pago_entregamos             , -- 26
		tipo_instrumento                  , -- 27
		condicion_entrega                 , -- 28
		tipo_operacion_or                 , -- 29
		instser ,			  -- 30
		documento,
		emisor,
		cartera_origen ,
		valor_final,
		clasificacion_cliente,
		interes_negativo,
		plazo,
		cliente,
		codcli,
		fecha_proceso,
		capitalpeso  ,
		ctacblecorresponsal,
		valor_cupon_peso  
                      )


	SELECT	DISTINCT 'BEX'      , -- 01
		'MOV'                           , -- 02
		a.motipoper			, -- 03
		a.monumoper        , -- 04
		a.mocorrelativo			, -- 05
		a.cod_familia			, -- 06  
		a.momonemi 			, -- 07
		a.movalcomu			, -- 08
		a.movpresen			, -- 09
		a.movalven			, -- 10
		a.moutilidad			, -- 11
		a.moperdida			, -- 12
		mointeres			, -- 13
		a.mointeres			, -- 14 (interes pacto)
		0.0				, -- 15
		a.movalcomp			, -- 16 (Val.Compra Historico)
		a.moutilidad                    , -- 17 (Dif pacto pos)
		a.moperdida                     , -- 18 (Dif Pacto neg  VBARRA 31/05/2000)
		a.moutilidad                    , -- 19 (Valor Mercado pos)
		a.moperdida                     , -- 20 (valor Mercado neg)
		1				, -- 21 (Condicion pacto)
		0				, --22  
		CONVERT( CHAR(06), a.forma_pago )  , -- 23 (Forma de pago)
		ISNULL( emgeneric, '' )       	, -- 24 (Generico de emisor)
		a.monominal			, -- 25 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
		CONVERT( CHAR(06), a.forma_pago ), -- 26
		ISNULL(e.emtipo, "0")		, -- 27 (clasificacion del emisor - tipo de bono)
		1				, -- 28
		'2'				, -- 29
		cod_nemo			, 
		monumdocu			,
		CONVERT( VARCHAR(10), morutemi ),
		motipoper			,
		movalven			,
		"0"				, 
		case	WHEN mointeres < 0 THEN (mointeres *-1)
			ELSE 0
			END,
		datediff(dd,mofecneg,mofecpago),
		morutcli			,
		mocodcli			,
		mofecpro			,
		capitalpeso 			,
		convert ( CHAR (15) , isnull(f.codigo_corres, 0)) ,
		0.0 
	FROM	text_mvt_dri 		a	,
		VIEW_CLIENTE 		c	,
		bacparamsuda..emisor 	e	,
		view_corresponsal    	f	

	WHERE	( c.clrut    =  a.morutcli  
	AND	c.clcodigo = a.mocodcli )
	AND	e.emrut      =* a.morutemi  
	AND	a.mofecpro   =  @fecha_hoy
	AND 	( f.rut_cliente = @RUT_CLIENTE
	AND       f.codigo_cliente = 1
 	AND       f.codigo_moneda =* a.momonemi
	AND 	  f.codigo_swift  =* a.corr_bco_swift
	AND 	  a.forma_pago in(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND       a.mofecpago  = a.mofecpro
	AND 	  a.mostatreg  <> 'A' 	


	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END


	/*=======================================================================*/
        /*                      OPERACIONES CON FECHA DE PAGO INHABIL            */
        /*                          Se contabiliza habil siguiente               */
        /*=======================================================================*/

	INSERT INTO bac_cnt_contabiliza
	(	id_sistema			, -- 01
		tipo_movimiento			, -- 02
		tipo_operacion			, -- 03
		operacion                         , -- 04
		correlativo                       , -- 05
		codigo_instrumento  		  , -- 06
		moneda_instrumento                , -- 07
		valor_compra                      , -- 08
		valor_presente           	  , -- 09
		valor_venta                       , -- 10
		utilidad                          , -- 11
		perdida                           , -- 12
		interes_papel                     , -- 13
		interes_pacto                     , -- 14
		valor_cupon                       , -- 15
		valor_comprahis                   , -- 16
		dif_ant_pacto_pos                 , -- 17
		dif_ant_pacto_neg                 , -- 18
		dif_valor_mercado_pos             , -- 19
		dif_valor_mercado_neg             , -- 20
		condicion_pacto                   , -- 21
		tipo_cliente                      , -- 22
		forma_pago                        , -- 23
		tipo_emisor                       , -- 24
		nominal		                  , -- 25 
	forma_pago_entregamos             , -- 26
		tipo_instrumento                  , -- 27
		condicion_entrega                 , -- 28
		tipo_operacion_or                 , -- 29
		instser ,			  -- 30
		documento,
		emisor,
		cartera_origen ,
		valor_final,
		clasificacion_cliente,
		interes_negativo,
		plazo,
		cliente,
		codcli,
		fecha_proceso,
		capitalpeso  ,
		ctacblecorresponsal,
		valor_cupon_peso  
                      )
	SELECT	distinct 'BEX'      , -- 01
		'MOV'                           , -- 02
		a.motipoper			, -- 03
		a.monumoper        , -- 04
		a.mocorrelativo			, -- 05
		a.cod_familia			, -- 06  
		a.momonemi 			, -- 07
		a.movalcomu			, -- 08
		a.movpresen			, -- 09
		a.movalven			, -- 10
		a.moutilidad			, -- 11
		a.moperdida			, -- 12
		mointeres			, -- 13
		a.mointeres			, -- 14 (interes pacto)
		0.0				, -- 15
		a.movalcomp			, -- 16 (Val.Compra Historico)
		a.moutilidad                    , -- 17 (Dif pacto pos)
		a.moperdida                     , -- 18 (Dif Pacto neg  VBARRA 31/05/2000)
		a.moutilidad                    , -- 19 (Valor Mercado pos)
		a.moperdida                     , -- 20 (valor Mercado neg)
		1				, -- 21 (Condicion pacto)
		0				, --22  
		CONVERT( CHAR(06), a.forma_pago )  , -- 23 (Forma de pago)
		ISNULL( emgeneric, '' )       	, -- 24 (Generico de emisor)
		a.monominal			, -- 25 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
		CONVERT( CHAR(06), a.forma_pago ), -- 26
		ISNULL(e.emtipo, "0")		, -- 27 (clasificacion del emisor - tipo de bono)
		1				, -- 28
		'2'				, -- 29
		cod_nemo			, 
		monumdocu			,
		CONVERT( VARCHAR(10), morutemi ),
		motipoper			,
		movalven			,
		"0"				, 
		case	when mointeres < 0 then (mointeres *-1)
			else 0
			end,
		datediff(dd,mofecneg,mofecpago),
		morutcli			,
		mocodcli			,
		mofecpro			,
		capitalpeso 			,
		convert ( char (15) , isnull(f.codigo_corres, 0)) ,
		0.0 
	FROM	text_mvt_dri 		a	,
		VIEW_CLIENTE 		c	,
		bacparamsuda..emisor 	e	,
		view_corresponsal    	f	

	WHERE	( c.clrut    =  a.morutcli  
	AND	c.clcodigo = a.mocodcli )
	AND	e.emrut      =* a.morutemi  
	AND	a.mofecpro   =  @fecha_hoy
	AND 	( f.rut_cliente = @RUT_CLIENTE
	AND       f.codigo_cliente = 1
 	AND       f.codigo_moneda =* a.momonemi
	AND 	  f.codigo_swift  =* a.corr_bco_swift
	AND 	  a.forma_pago in(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND      (  a.mofecpago  > @Fecha_Ant  AND  a.mofecpago < @fecha_hoy )
	AND 	  a.mostatreg  <> 'A' 	


	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END


-- select morutemi,* from text_mvt_dri where mofecpro = '20030429'
   /*===========================================*/
   /* Llena Devengo    				*/
   /*===========================================*/

	INSERT INTO bac_cnt_contabiliza(
		id_sistema                      , -- 01
		tipo_movimiento                 , -- 02
		tipo_operacion		        , -- 03
		operacion                       , -- 04
		correlativo             	, -- 05
		codigo_instrumento              , -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente                  , -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon                     , -- 15
		nominal    			, -- 16
		valor_comprahis     		, -- 17
		dif_ant_pacto_pos               , -- 18
		dif_ant_pacto_neg               , -- 19
		dif_valor_mercado_pos           , -- 20
		dif_valor_mercado_neg           , -- 21
		condicion_pacto                 , -- 22
		forma_pago , -- 23
		forma_pago_entregamos           , -- 24
		tipo_instrumento                , -- 25
		tipo_cliente                    , -- 26
		tipo_emisor   			, -- 27
		valor_futuro                    , -- 28
		comquien          		, -- 29
		instser,     			-- 30
		documento,
		emisor,
		clasificacion_cliente,
		valor_final,
		cartera_origen,
		interes_negativo,
		plazo,
		cliente,
		codcli,
		fecha_proceso,
		interespeso ,
		valor_cupon_peso
		)

	SELECT	'BEX'                           , -- 01
		'DEV'                           , -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.rscorrelativo	                , -- 05
		cod_familia			, -- 06
		rsmonemi			, -- 07 monpact
		rsvalcomu	     , -- 08  valor compra
		ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0 )       , -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	, -- 10	valor venta
		0.0                             , -- 11
		0.0                             , -- 12
		ISNULL( a.rsinteres, 0 )	, -- 13
		ISNULL( a.rsinteres, 0 )	, -- 14 interes pacto
		0.0				, -- 15 valor cupon
		0.0  			        ,-- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )       , -- 17 (Val.Compra Historico)
		0.0                             , -- 18 (Dif Pacto pos)
		0.0                             , -- 19 (Dif pacto neg)
		0.0                             , -- 20 (Valor Mercado pos)
		0.0                             , -- 21 (Valor Mercado neg)
		1				, -- 22 (Condicion pacto)
		1                               , -- 23 (Forma de pago)'
		1			        ,-- 24 forma de pago entregamos'
		e.emtipo		        , -- 25 (Tipo instrumento) 
		"0"				,--27   tipo cliente
		''                              , -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)         , -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END    ,-- 30
		""				,  --  cod_nemo,
		rsnumdocu			,
		CONVERT( VARCHAR(10), rsrutemis ),
		"0"				,
		ISNULL( a.rsinteres, 0 )	,
		"Cp" 				,
		(case	when rsinteres < 0 then (rsinteres * -1) else 0 end),
		(datediff(dd,rsfecneg, rsfecpago)) ,
		rsrutcli			,
		rscodcli			,
		rsfecpro			,
		abs(interespeso)		,
		0.0
	FROM	#tmp_mdrs a ,
		bacparamsuda..emisor e	
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy	
	AND	e.emrut      =* a.rsrutemis 
	AND     a.rsfecpago  < @Fecha_Hoy
	and     rstipoper    = 'DEV' 
	IF @@ERROR <> 0 BEGIN

		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1

	END

   /*===========================================*/
   /* Llena Devengo                             */ 
   /*  interes de ayer a hoy para operaciones   */
   /*  que se venden hoy                  	*/
   /*===========================================*/
      
	INSERT INTO bac_cnt_contabiliza(
		id_sistema                      , -- 01
		tipo_movimiento                 , -- 02
		tipo_operacion		        , -- 03
		operacion                       , -- 04
		correlativo             	, -- 05
		codigo_instrumento              , -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente                  , -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon                     , -- 15
		nominal    			, -- 16
		valor_comprahis     		, -- 17
		dif_ant_pacto_pos               , -- 18
		dif_ant_pacto_neg               , -- 19
		dif_valor_mercado_pos           , -- 20
		dif_valor_mercado_neg           , -- 21
		condicion_pacto                 , -- 22
		forma_pago , -- 23
		forma_pago_entregamos           , -- 24
		tipo_instrumento                , -- 25
		tipo_cliente                    , -- 26
		tipo_emisor   			, -- 27
		valor_futuro                    , -- 28
		comquien          		, -- 29
		instser,     			-- 30
		documento,
		emisor,
		clasificacion_cliente,
		valor_final,
		cartera_origen,
		interes_negativo,
		plazo,
		cliente,
		codcli,
		fecha_proceso,
		interespeso ,
		valor_cupon_peso
		)

	SELECT	'BEX'                           , -- 01
		'DEV'                           , -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.rscorrelativo	                , -- 05
		cod_familia			, -- 06
		rsmonemi			, -- 07 monpact
		rsvalcomu	     , -- 08  valor compra
		ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0 )       , -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	, -- 10	valor venta
		0.0                             , -- 11
		0.0                             , -- 12
		ISNULL( a.rsinteres, 0 )	, -- 13
		ISNULL( a.rsinteres, 0 )	, -- 14 interes pacto
		0.0				, -- 15 valor cupon
		0.0  			        ,-- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )       , -- 17 (Val.Compra Historico)
		0.0                             , -- 18 (Dif Pacto pos)
		0.0                             , -- 19 (Dif pacto neg)
		0.0                             , -- 20 (Valor Mercado pos)
		0.0                             , -- 21 (Valor Mercado neg)
		1				, -- 22 (Condicion pacto)
		1                               , -- 23 (Forma de pago)'
		1			        ,-- 24 forma de pago entregamos'
		e.emtipo		        , -- 25 (Tipo instrumento) 
		"0"				,--27   tipo cliente
		''                              , -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)         , -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END    ,-- 30
		""				,  --  cod_nemo,
		rsnumdocu			,
		CONVERT( VARCHAR(10), rsrutemis ),
		"0"				,
		ISNULL( a.rsinteres, 0 )	,
		"Cp" 				,
		(case	when rsinteres < 0 then (rsinteres * -1) else 0 end),
		(datediff(dd,rsfecneg, rsfecpago)) ,
		rsrutcli			,
		rscodcli			,
		rsfecpro			,
		abs(interespeso)		,
		0.0
	FROM	#tmp_mdrs a ,
		bacparamsuda..emisor e	
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy	
	AND	e.emrut      =* a.rsrutemis 
	AND     a.rsfecpago  < @Fecha_Hoy
	and     rstipoper    = 'DV' 
	IF @@ERROR <> 0 BEGIN
-- select * from bac_cnt_contabiliza
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1

	END

   /*===================================================*/
   /* Llena Vencimiento Cupon		-- SOLO BONEX	*/
   /*===================================================*/
	-- Contabilizacion de vencimiento cupon
	INSERT INTO bac_cnt_contabiliza(
		id_sistema                      , -- 01
		tipo_movimiento                 , -- 02
		tipo_operacion		        , -- 03
		operacion                       , -- 04
		codigo_instrumento              , -- 05
		moneda_instrumento              , -- 06
		valor_cupon                     , -- 07
		tipo_instrumento                , -- 08
		ctacblecorresponsal		, -- 09
		valor_cupon_peso		, -- 10
		correlativo			,
		nominal				,
		capitalPeso
		)
	SELECT distinct
		'BEX'                           , -- 01
		'MOV'                           , -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'VCP'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.cod_familia			, -- 05
		rsmonemi			, -- 06 monpact
		rsflujo				, -- 07 valor cupon, monto a pagar
		ISNULL(e.emtipo, 0)		, -- 08 (clasificacion del emisor - tipo de bono)
		convert ( char ( 15), isnull(f.codigo_corres, 0))  , -- 09 
		ValorCuponPeso			, -- 10
		a.rscorrelativo			,
		(case when rsfecvcto = @Fecha_Hoy then a.rsnominal   else 0 end)			,
		(case when rsfecvcto = @Fecha_Hoy then a.capitalpeso else 0 end)
-- select * from text_rsu
	FROM	#tmp_mdrs a		,
		VIEW_CLIENTE 	     c	,
		bacparamsuda..emisor e	,
		view_corresponsal    f	,
		text_mvt_dri	   car
	WHERE	( c.clrut    =  a.rsrutcli  
	AND	  c.clcodigo = a.rscodcli )
	AND	  e.emrut      =* car.morutemi  
	AND 	( f.rut_cliente = @RUT_CLIENTE
	AND       f.codigo_cliente = 1
 	AND       f.codigo_moneda =* car.momonemi
	AND 	  f.codigo_swift  =* car.corr_bco_swift
	AND 	  car.forma_pago in(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND       a.rsnumdocu = car.monumoper
        AND       a.rsfecpro = @Fecha_Hoy
	AND 	  a.cod_familia = 2000
	AND       a.rstipoper    = 'VCP'


	IF @@ERROR <> 0 BEGIN

		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1

	END


	INSERT INTO bac_cnt_contabiliza(
		id_sistema                      , -- 01
		tipo_movimiento                 , -- 02
		tipo_operacion		        , -- 03
		operacion                       , -- 04
		correlativo             	, -- 05
		codigo_instrumento              , -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente                  , -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon                     , -- 15
		nominal    			, -- 16
		valor_comprahis     		, -- 17
		dif_ant_pacto_pos               , -- 18
		dif_ant_pacto_neg               , -- 19
		dif_valor_mercado_pos           , -- 20
		dif_valor_mercado_neg           , -- 21
		condicion_pacto                 , -- 22
		forma_pago , -- 23
		forma_pago_entregamos           , -- 24
		tipo_instrumento                , -- 25
		tipo_cliente                    , -- 26
		tipo_emisor   			, -- 27
		valor_futuro                    , -- 28
		comquien          		, -- 29
		instser,     			-- 30
		documento,
		emisor,
		clasificacion_cliente,
		valor_final,
		cartera_origen,
		interes_negativo,
		plazo,
		cliente,
		codcli,
		fecha_proceso,
		interespeso ,
		valor_cupon_peso
		)

	SELECT	'BEX'                           , -- 01
		'DEV'                           , -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.rscorrelativo	                , -- 05
		cod_familia			, -- 06
		rsmonemi			, -- 07 monpact
		rsvalcomu	     , -- 08  valor compra
		ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0 )       , -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	, -- 10	valor venta
		0.0                             , -- 11
		0.0                             , -- 12
		ISNULL( a.rsinteres, 0 )	, -- 13
		ISNULL( a.rsinteres, 0 )	, -- 14 interes pacto
		0.0				, -- 15 valor cupon
		0.0  			        ,-- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )       , -- 17 (Val.Compra Historico)
		0.0                             , -- 18 (Dif Pacto pos)
		0.0                             , -- 19 (Dif pacto neg)
		0.0                             , -- 20 (Valor Mercado pos)
		0.0                             , -- 21 (Valor Mercado neg)
		1				, -- 22 (Condicion pacto)
		1                               , -- 23 (Forma de pago)'
		1			        ,-- 24 forma de pago entregamos'
		e.emtipo		        , -- 25 (Tipo instrumento) 
		"0"				,--27   tipo cliente
		''                              , -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)         , -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END    ,-- 30
		""				,  --  cod_nemo,
		rsnumdocu			,
		CONVERT( VARCHAR(10), rsrutemis ),
		"0"				,
		ISNULL( a.rsinteres, 0 )	,
		"Cp" 				,
		(case	when rsinteres < 0 then (rsinteres * -1) else 0 end),
		(datediff(dd,rsfecneg, rsfecpago)) ,
		rsrutcli			,
		rscodcli			,
		rsfecpro			,
		abs(interespeso)		,
		0.0
	FROM	#tmp_mdrs a ,
		bacparamsuda..emisor e	
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy	
	AND	e.emrut      =* a.rsrutemis 
	AND     a.rsfecpago  < @Fecha_Hoy
	AND     a.rstipoper    = 'VCP'

	IF @@ERROR <> 0 BEGIN

		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1

	END



   /*===========================================*/
   /* Llena Vencimiento CD NOTEX DPEX 		*/
   /*===========================================*/

	INSERT INTO bac_cnt_contabiliza(
		id_sistema             , -- 01
		tipo_movimiento                 , -- 02
		tipo_operacion		        , -- 03
		operacion                       , -- 04
		correlativo             	, -- 05
		codigo_instrumento              , -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente                  , -- 09
		valor_venta                     , -- 10
		interes_papel                   , -- 11
		interes_pacto                   , -- 12
		nominal    			, -- 13
		valor_comprahis     		, -- 14
		forma_pago                      , -- 15
		forma_pago_entregamos           , -- 16
		tipo_instrumento                , -- 17
		valor_futuro                    , -- 18
		documento			, -- 19
		emisor				, -- 20
		clasificacion_cliente		, -- 21
		valor_final			, -- 22
		cartera_origen			, -- 23
		interes_negativo		, -- 24
		plazo				, -- 25
		cliente				, -- 26
		codcli				, -- 27
		fecha_proceso			, -- 28
		interespeso 			,  -- 29
		valor_cupon_peso	)

	SELECT	'BEX'                           , -- 01
		'MOV'                           , -- 02
		'V'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.rscorrelativo	                , -- 05
		a.cod_familia			, -- 06
		rsmonemi			, -- 07 monpact
		rsvalcomu	               	, -- 08  valor compra
		ISNULL( a.rsinteres, 0 )        , -- 09	interes del dia
		ISNULL( a.rsvppresenx, 0 ) 	, -- 10	valor venta
		ISNULL( a.rsinteres, 0 )	, -- 11
		ISNULL( a.rsinteres_acum, 0 )	, -- 12 Valor interes acumulado o interes ganado
		rsnominal		        , -- 13 nominal peso'
		ISNULL( a.rsvppresen, 0 )       , -- 14 
		1                               , -- 15 (Forma de pago)'
		1			        , -- 16 forma de pago entregamos'
		e.emtipo		        , -- 17 (Tipo Emisor - cclasificacion emisor) 
		ISNULL(a.rsvppresenx,0)         , -- 18 (Valor Futuro para vencimiento de interbancarios)
		rsnumdocu			, -- 19
		CONVERT( VARCHAR(10), rsrutemis ),-- 20 
		"0"				, -- 21
		ISNULL( a.rsinteres, 0 )	, -- 22
		"Cp" 				, -- 23
		(case	when rsinteres < 0 then (rsinteres * -1) else 0 end),-- 24
		(datediff(dd,rsfecneg, rsfecpago)),--25
		rsrutcli			, -- 26
		rscodcli			, -- 27
		rsfecpro			, -- 28 
		abs(interespeso)		, -- 29 interes del dia en peso
		ValorPresentePeso	
	FROM	#tmp_mdrs a ,
		bacparamsuda..emisor e	
	WHERE   rsfecvcto = @Fecha_Hoy	
	AND	e.emrut      =* a.rsrutemis 
	AND 	a.cod_familia  <> 2000
	
	IF @@ERROR <> 0 BEGIN

		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1

	END

--	INSERTA TABLA DE PASO PARA LA CONTABILIDAD (BAC_CNT_CONTABILIZA_RESUMEN)
-- ***********************************************************************************+
	truncate table BAC_CNT_CONTABILIZA_RESUMEN


	INSERT INTO BAC_CNT_CONTABILIZA_RESUMEN
     (
                  id_sistema		,
                  tipo_movimiento	,
                  tipo_operacion	,
                  operacion		,
                  correlativo		,
                  codigo_instrumento	,
                  moneda_instrumento	,
            	  valor_compra		,
                  valor_presente	,
                  valor_venta		,
          utilidad		,
                  perdida		,
                  interes_papel		,
                  interes_pacto		,
                  valor_cupon		,
                  nominal		,
		  valor_comprahis	,
                  dif_ant_pacto_pos	,
                  dif_ant_pacto_neg	,
                  dif_valor_mercado_pos ,	
                  dif_valor_mercado_neg ,
                  condicion_pacto	,
                  forma_pago		,
                  tipo_instrumento	,
                  tipo_cliente		,
                  tipo_emisor		,
                  forma_pago_entregamos	,
                  valor_futuro		,
                  condicion_entrega	,
                  tipo_operacion_or	,
                  comquien		,
                  instser		,
                  documento		,
                  Emisor		,
                  tipo_bono		,
                  clasificacion_cliente	,
                  valor_final		,
                  cartera_origen	,
                  interes_positivo	,
                  interes_negativo	,
                  plazo			,
                  cliente		,
                  codcli		,
                  fecha_proceso		,
		  capitalPeso		,
                  interesPeso		,
                  ctacblecorresponsal	,
        	  valor_cupon_peso
               )

	SELECT	id_sistema,
		tipo_movimiento,
		tipo_operacion,
		operacion,
                correlativo,
                codigo_instrumento,
		moneda_instrumento,
		(valor_compra),
		(valor_presente),
		(valor_venta),
		(utilidad),
		(perdida),
		(interes_papel),
		(interes_pacto),
		(valor_cupon),
		(nominal),
		(valor_comprahis),
		(dif_ant_pacto_pos),
		(dif_ant_pacto_neg),
		(dif_valor_mercado_pos),
		(dif_valor_mercado_neg),
		condicion_pacto,
		forma_pago,
		tipo_instrumento,
		tipo_cliente,
		tipo_emisor,
		forma_pago_entregamos,
		(valor_futuro),
		condicion_entrega,
		tipo_operacion_or,
		comquien,
		'',	--instser,
		0,	--documento,
		0,	--Emisor,
		tipo_bono,
		clasificacion_cliente,
		(valor_final),
		cartera_origen,
		(interes_positivo),
		(interes_negativo),
		plazo,
                cliente,
                codcli,
		fecha_proceso,
		capitalPeso,
                interesPeso,
                ctacblecorresponsal,
		valor_cupon_peso
                -- Numero de Operacion es IDENTITY
	from	BAC_CNT_CONTABILIZA

	SET NOCOUNT OFF
	RETURN 0
END

GO
