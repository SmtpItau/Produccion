USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CTB_BONEX]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LLENA_CTB_BONEX]
(  
       @Fecha_Hoy   DATETIME  -- = '20181016'
)
AS
BEGIN
   -- SP_LLENA_CTB_BONEX '20181016'
   SET NOCOUNT ON

	DECLARE @Fecha_Ant			DATETIME
	DECLARE @Fecha_prox 		        DATETIME
	DECLARE @Indicador 			INTEGER --nuevo_campo
	DECLARE @Fecha_Ant_mvt       	        DATETIME
	DECLARE @Fecha_Hoy_mvt      	        DATETIME
	DECLARE @Control_Error   		INTEGER
	DECLARE @Valor_Observado  		FLOAT
	DECLARE @Fecha_DolarObs		        DATETIME
	DECLARE @Rut_Central      		NUMERIC(10)
	DECLARE @VVISTA           		CHAR(4)
	DECLARE @rut_estado			NUMERIC(10)
	DECLARE @RUT_CLIENTE     		NUMERIC(10)  
       	DECLARE @iDolarContableDia         	NUMERIC(21,4)
        DECLARE @iDolarContableRev         	NUMERIC(21,4)
        DECLARE @indi                   		NUMERIC(01) 
	SELECT  @Fecha_Ant  = acfecante 
       	,       @fecha_prox = acfecprox 
       	FROM    TEXT_ARC_CTL_DRI

	SELECT	@Valor_Observado = ISNULL( Tipo_Cambio, 1.0 )
	FROM	BACPARAMSUDA..VALOR_MONEDA_CONTABLE
	WHERE	Codigo_Moneda         = 994
	AND	Fecha		      = @Fecha_Hoy


	
	SELECT	@Rut_estado  = 97030000
	SELECT	@RUT_CLIENTE = acrutprop
	FROM	TEXT_ARC_CTL_DRI

	-- =======================================================================
	-- LIMPIA ARCHIVO DE CONTABILIZACION                                    			           
	-- =======================================================================
	DELETE bac_cnt_contabiliza 

	IF @@ERROR <> 0 
	BEGIN
	   SET NOCOUNT OFF
	   PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (Bonos Exterior).'
	   RETURN 1
	END

	DELETE	FROM	BAC_CNT_CONTABILIZA_HISTORICA
			WHERE	FechaContable	= ( SELECT acfecproc FROM TEXT_ARC_CTL_DRI with(nolock) )

	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'ERROR_PROC Falla Borrado de Bac_Cnt_Contabiliza_Historica (Bonos Exterior).'
	   RETURN 1
	END


	--=======================================================================
	-- Busca si el sistema esta en una fecha no habil (Fin de mes feriado) o especial
	--=======================================================================
	DECLARE @feriado          NUMERIC (01)
	,	@feriadoIniMes    NUMERIC (01)
	,	@dfecfmes         DATETIME
	,	@dfecImes         DATETIME

 	SELECT @dfecfmes = DATEADD(DAY,DATEPART(DAY,@Fecha_prox) * -1,@Fecha_prox)   
       	SELECT @dfecImes = DATEADD(DAY,DATEPART(DAY,@Fecha_Hoy)* -1,DATEADD(DAY, 1, @Fecha_Hoy))  

       	EXECUTE sp_feriado @dfecfmes,6 , @feriado output
       	EXECUTE sp_feriado @dfecImes,6 , @feriadoIniMes output
	--=================================================================================
	
	-- Devengos del dia
	SELECT	* 
	INTO	#TMP_MDRS
	FROM	TEXT_RSU
	WHERE	rsfecpro	= @Fecha_Hoy
	AND	rstipoper	= 'DEV'
	AND	rsinteres	<> 0	

	-- Devengos del dia, interes de operaciones que se vENDieron
	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro	= @Fecha_Hoy
	AND     rstipoper	= 'DV'

	-- Vencimiento de operaciones cd - dpex - notex

	-- MAP 2016-06-20 Fin de mes Especial
	if month(@Fecha_Ant) <>  month(@Fecha_Hoy)
	    select @Fecha_Ant = EOMONTH(@Fecha_Ant)

	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro	= @Fecha_Ant
	AND     rstipoper	= 'V'           

	-- Vencimiento de operaciones bonex
	INSERT INTO #tmp_mdrs
	SELECT *
	FROM	text_rsu
	WHERE	rsfecpro	= @Fecha_Hoy
	AND     rstipoper	= 'VCP'
 
 	/*=======================================================================*/
	/* Contabilizacion tasas de Mercado*/
	/*=======================================================================*/
         	SELECT @Fecha_Ant_mvt  = @Fecha_Ant
         	SELECT @Fecha_Hoy_mvt  = @Fecha_Hoy

	 DELETE TEXT_MVT_DRI_TAS_MERC

	---====================================================================================
	IF @feriado < 0 AND SUBSTRING(CONVERT(CHAR(08),@Fecha_Ant,112),1,6) < SUBSTRING(CONVERT(CHAR(08),@fecha_hoy,112),1,6)
--	IF @feriado < 0 AND DATEPART(MONTH,@Fecha_Ant) < DATEPART(MONTH,@fecha_hoy)
	 BEGIN
 	    SET @indi = 1 
            IF  @dfecImes = @fecha_hoy    
                EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 0
          ELSE
               IF @feriadoIniMes <> -1
	            EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 0
               ELSE
                   EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 0
	  
         END
	ELSE
           IF @feriado < 0 AND  SUBSTRING(CONVERT(CHAR(08),@Fecha_Ant,112),1,6) = SUBSTRING(CONVERT(CHAR(08),@fecha_hoy,112),1,6)
--           IF @feriado < 0 AND DATEPART(MONTH,@Fecha_Ant) = DATEPART(MONTH,@fecha_hoy)

            BEGIN 
              SET @indi = 1 
	      EXECUTE sp_ins_mvt_dIF_merc @Fecha_Ant , 0    
            END
	   ELSE
            BEGIN
	      SET @indi = 1 
              IF  @dfecImes = @fecha_hoy 
                BEGIN 
                  EXECUTE sp_ins_mvt_dIF_merc @Fecha_Ant , 0 
                END
              ELSE
                IF @feriadoIniMes <> -1
                  BEGIN
            	  EXECUTE sp_ins_mvt_dIF_merc @Fecha_Ant , 0 
                  END   
                ELSE 
                  IF @dfecfmes =@fecha_hoy
                    BEGIN  
                    EXECUTE sp_ins_mvt_dIF_merc @Fecha_Ant , 0 
                    END  
                  ELSE    
                    BEGIN

                        IF (@fecha_hoy > @dfecImes)  AND  (@Fecha_Ant = @dfecfmes) AND (@dfecfmes <> -1) -- NUEVO
                        BEGIN
                             EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 0
                        END
                        ELSE
                        BEGIN
                             EXECUTE sp_ins_mvt_dIF_merc @Fecha_Ant , 0   --NUEVO      
                        END
                    END 
            END

       IF @feriado < 0 AND SUBSTRING(CONVERT(CHAR(08),@fecha_hoy,112),1,6) = SUBSTRING(CONVERT(CHAR(08),@dfecfmes,112),1,6) AND @indi = 1
--       IF @feriado < 0 AND DATEPART(MONTH,@fecha_hoy) = DATEPART(MONTH,@dfecfmes) AND @indi = 1

          Begin 
            SET @indi = 0 
            If   @Fecha_Hoy <= @dfecfmes    
              EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 1              
            Else
              EXECUTE sp_ins_mvt_dIF_merc @dfecfmes , 1              
          End
          
       ELSE  
          IF @indi = 1
           Begin 
             SET @indi = 0 
             IF   @Fecha_Hoy <= @dfecfmes   
                EXECUTE sp_ins_mvt_dIF_merc @fecha_hoy , 1              
             ELSE   
         	EXECUTE sp_ins_mvt_dIF_merc @fecha_hoy , 1   
          End

	/***************************************************************************************************************/
	/******************************* ACTUALIZA PORCENTAJE COBERTURA VALORIZACION MERCADO ***************************/
	/***************************************************************************************************************/

	DECLARE @FechaBusquedaValorizacion	DATETIME
	,	@FechaBusquedaValorizacionAyer	DATETIME

	IF SUBSTRING(CONVERT(CHAR(08),@fecha_hoy,112),1,6) < SUBSTRING(CONVERT(CHAR(08),@Fecha_Prox,112),1,6) BEGIN
		SELECT	@FechaBusquedaValorizacion = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@Fecha_Prox,112),1,6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL
	END
	ELSE BEGIN
		SELECT	@FechaBusquedaValorizacion = @fecha_hoy --FECHA HOY
	END

	IF SUBSTRING(CONVERT(CHAR(08),@Fecha_Ant,112),1,6) < SUBSTRING(CONVERT(CHAR(08),@fecha_hoy,112),1,6) BEGIN
		SELECT	@FechaBusquedaValorizacionAyer = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@fecha_hoy,112),1,6) + '01') --FIN DE MES (ANTERIOR) HABIL O NO HABIL
	END
	ELSE BEGIN
		SELECT	@FechaBusquedaValorizacionAyer = @fecha_Ant
	END

	UPDATE	TEXT_MVT_DRI_TAS_MERC --VALORIZACION MERCADO
	SET	PorcjeCob	= (nMontoCubrir * 100) / monominal
	FROM	TEXT_MVT_DRI_TAS_MERC			A
	,	BACTRADERSUDA..DETALLE_COBERTURAS	B
	WHERE	A.mofecpro		= @FechaBusquedaValorizacion
	AND	B.cSistema		= 'BTR'
	AND	B.nDocumento		= A.monumdocu
	AND	B.nCorrelativo		= A.mocorrelativo
	AND	A.monumoper		= B.nDocumento

	--======================================================================================
	--Obtiene el dolar para la fecha indicada.
	EXECUTE dbo.SP_ENTREGA_DOLAR_CONTABLE_DIARIO @Fecha_Hoy , @iDolarContableDia OUTPUT,@iDolarContableRev OUTPUT
	--====================================================================================== 
        /*=======================================================================*/
	/* Llena operaciones 		                                         */
	/*=======================================================================*/



	INSERT INTO bac_cnt_contabiliza
	(	id_sistema			, -- 01
		tipo_movimiento			, -- 02
		tipo_operacion			, -- 03
		operacion                       , -- 04
		correlativo                     , -- 05
		codigo_instrumento  		, -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente           	, -- 09
		valor_venta                     , -- 10
		utilidad                      	, -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon             	, -- 15
		valor_comprahis            	, -- 16
		dIF_ant_pacto_pos               , -- 17	--- este.
		dIF_ant_pacto_neg               , -- 18 	--- y este.
		dIF_valor_mercado_pos           , -- 19
		dIF_valor_mercado_neg           , -- 20
		condicion_pacto                 , -- 21
		tipo_cliente                    , -- 22
		forma_pago                      , -- 23
		tipo_emisor                     , -- 24
		nominal		                , -- 25 
		forma_pago_entregamos           , --  26
		tipo_instrumento                , -- 27
		condicion_entrega  		, -- 28
		tipo_operacion_or               , -- 29
		instser 			, -- 30
		documento			, -- 31
		emisor				, -- 32
		cartera_origen 			, -- 33
		valor_final			, -- 34 
		clasIFicacion_cliente		, -- 35
		interes_negativo		, -- 36
		plazo				, -- 37
		cliente				, -- 38
		codcli				, -- 39
		fecha_proceso			, -- 40
		capitalpeso  			, -- 41
		ctacblecorresponsal		, -- 42
		valor_cupon_peso                , --43
		tipo_cartera			,

		Utilidad_Avr_Patrimonio,	--> Ventas AFS
		Perdida_Avr_Patrimonio,		--> Ventas AFS
		Diferencia_Precio_Pos,		--> Ventas AFS
		Diferencia_Precio_Neg		--> Ventas AFS
		
		) --44 

	SELECT	DISTINCT 'BEX'      		, -- 01
		'MOV'    			, -- 02
		a.motipoper			, -- 03
		a.monumoper        		, -- 04
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
		CASE	WHEN modIFsb > 0 THEN modIFsb   	-- 17 (DIF pacto pos)
			ELSE 0	END			,
		CASE	WHEN modIFsb < 0 THEN (modIFsb *-1)   -- 18 (DIF Pacto neg  VBARRA 31/05/2000)
			ELSE 0 	END		,
		a.moutilidad           		, 	-- 19 (Valor Mercado pos)
		a.moperdida                   	, 	-- 20 (valor Mercado neg)
		1				, 	-- 21 (Condicion pacto)
		0				, 	--22  
		CONVERT( CHAR(06), a.forma_pago )  , 	-- 23 (Forma de pago)
		ISNULL( emgeneric, '' )       	, 	-- 24 (Generico de emisor)
		a.monominal			, 	-- 25 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
		CONVERT( CHAR(06), a.forma_pago ), 	-- 26
		ISNULL(e.emtipo, '0')		, 	-- 27 (clasIFicacion del emisor - tipo de bono)
		1				, 	-- 28
		'2'				, 	-- 29
		cod_nemo			, 	-- 30
		monumdocu			,	-- 31
		CONVERT( VARCHAR(10), morutemi ),	-- 32
		motipoper			,	-- 33
		movalven			,	-- 34
		'0'				, 	-- 35
		CASE	WHEN mointeres < 0 THEN (mointeres *-1)
			ELSE 0
			END			,	-- 36
		DATEDIFF(dd,mofecneg,mofecpago) ,	-- 37
		morutcli			,	-- 38
		mocodcli			,	-- 39
		mofecpro			,	-- 40
		capitalpeso 			,	-- 41
		CONVERT ( CHAR (15) , ISNULL(f.codigo_corres, 0)) , --42
		0.0				, 					-- 43
		0				

	,	Utilidad_Avr_Patrimonio		= round(case when a.Resultado_Dif_Mercado	>= 0 then abs(a.Resultado_Dif_Mercado)	else 0 end,2)	--> Ventas AFS
	,	Perdida_Avr_Patrimonio		= round(case when a.Resultado_Dif_Mercado	<  0 then abs(a.Resultado_Dif_Mercado)	else 0 end,2)	--> Ventas AFS
	,	Diferencia_Precio_Pos		= round(case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end,2)	--> Ventas AFS
	,	Diferencia_Precio_Neg		= round(case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end,2)	--> Ventas AFS
	FROM	text_mvt_dri	 	a	
			INNER JOIN 	VIEW_CLIENTE				c	ON (c.clrut			= a.morutcli  
														AND	c.clcodigo		= a.mocodcli)
	/*		right OUTER JOIN view_corresponsal    	f	ON	f.codigo_moneda = a.momonemi 
														AND	f.codigo_swIFt  = a.corr_bco_swIFt
	*/

			right OUTER JOIN	(	select	distinct rut_cliente, codigo_cliente, codigo_moneda, codigo_swift, codigo_corres
									from	BacParamSuda.dbo.CORRESPONSAL 
									where	codigo_corres	<> 0
								)	f	ON	f.codigo_moneda = a.momonemi 
										AND	f.codigo_swIFt  = a.corr_bco_swIFt

														
			right outer join bacparamsuda..emisor 	e	ON	e.emrut			= a.morutemi
	WHERE a.mofecpro   =  @fecha_hoy
	AND	 (f.rut_cliente = @RUT_CLIENTE
	AND	  f.codigo_cliente = 1

	AND	a.forma_pago in(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND	a.mofecpago  = a.mofecpro
	AND	a.mostatreg  <> 'A' 	
	
	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END

	/*=======================================================================*/
	/* Llena operaciones  tasas de mercado		              */
	/*=======================================================================*/



	SELECT	DISTINCT  
                id_sistema         = 'BEX'      	 , -- 01  
		tipo_movimiento    = 'TMF'               , -- 02
		tipo_operacion     = 'TMCP' 		 , -- 03
		a.monumoper        			 , -- 04
		Correlativo        = IDENTITY(INT)	 , -- 05	, --a.mocorrelativo			
		a.cod_familia				 , -- 06  
		a.momonemi 				 , -- 07
		a.movalcomu				 , -- 08
		a.movpresen				 , -- 09
		a.movalven				 , -- 10
		moutilidad	= ISNULL(CASE	WHEN a.codigo_carterasuper = 'T' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ
					ELSE  CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modIFsb > 0 THEN ABS((a.modIFsb * CASE WHEN (a.PorcjeCob /100) = 0 THEN 1 ELSE (a.PorcjeCob /100)END) * (CASE WHEN  a.momonemi = 13 THEN @Valor_Observado
					 ELSE (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha= @Fecha_Hoy AND Codigo_Moneda= a.momonemi)END))
							WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modIFsb > 0 
							 THEN ABS(ISNULL((VMA.rsDiferenciaMerc * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb) * (CASE WHEN a.momonemi =13 THEN @iDolarContableRev ELSE 
(SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha = @Fecha_Ant AND Codigo_Moneda=a.momonemi) END) ) * -1
							WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modIFsb < 0 THEN 0
							WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modIFsb < 0 THEN 0 * -1
							WHEN a.motipoper = 'TM' AND a.modIFsb	= 0 THEN 0
							ELSE a.moutilidad END  
				  END,0.0) , -- 11 (DIF_Valor_Mercado_Pos_CLP)
		moperdida	= ISNULL(CASE	WHEN a.codigo_carterasuper = 'T' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ
					ELSE  CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modIFsb > 0 THEN 0 
							WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modIFsb > 0 THEN 0 * -1
							WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modIFsb < 0 THEN ABS((a.modIFsb * CASE WHEN (a.PorcjeCob /100) = 0 THEN 1 ELSE (a.PorcjeCob /100)END) * (CASE WHEN  a.momonemi = 13 THEN @Valor_Observado 
							ELSE (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha= @Fecha_Hoy AND Codigo_Moneda= a.momonemi)END))
							WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modIFsb < 0 THEN ABS(ISNULL((VMA.rsDiferenciaMerc * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 
							THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb) * (CASE WHEN a.momonemi =13 THEN @iDolarContableRev ELSE (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha = @Fecha_Ant AND Codigo_Moneda=a.momonemi) END))  * -1
							WHEN a.motipoper = 'TM' AND a.modIFsb	= 0 THEN 0
							ELSE a.moperdida END  
				  END,0.0)	, -- 12 (DIF_Valor_Mercado_Neg_CLP) 
		tt                 = mointeres		, -- 13
		a.mointeres				, -- 14 (interes pacto)
		valor_cupon        = 0.0		, -- 15
		a.movalcomp				, -- 16 (Val.Compra Historico) 
		dIF_pac_pos        = CASE WHEN modIFsb > 0 THEN modIFsb   	
			                  ELSE                  0				 
			             END           	, -- 17 (DIF pacto pos)
		dIF_pac_neg        = CASE WHEN modIFsb < 0 THEN abs(modIFsb)   
			                  ELSE                  0
			             END                , -- 18 (DIF Pacto neg)

		dIF_valMerc_Pos	= CASE	WHEN a.codigo_carterasuper = 'P' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ
--		dIF_valMerc_Pos	= CASE	WHEN a.codigo_carterasuper <> 'T' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ = 'P'  -- MNAVARRO <> 'T'
					ELSE CASE	WHEN a.modIFsb >= 0 AND a.motipoper = 'TM' AND a.mostatreg = ' ' THEN ABS((a.modIFsb * CASE WHEN (a.PorcjeCob /100) = 0 THEN 1 ELSE (a.PorcjeCob /100)END))
							WHEN a.modIFsb >= 0 AND a.motipoper = 'TM' AND a.mostatreg = 'R' THEN ABS(ISNULL((VMA.rsDiferenciaMerc * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb)) * -1
							WHEN a.modIFsb <  0 AND a.motipoper = 'TM' AND a.mostatreg = ' ' THEN 0
							WHEN a.modIFsb <  0 AND a.motipoper = 'TM' AND a.mostatreg = 'R' THEN 0              * -1
							ELSE a.moutilidad END 
				   END , -- 19 (dIFerencia Valor Mercado Pos Mx) 
		dIF_valMerc_Neg	= CASE	WHEN a.codigo_carterasuper = 'P' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ
--		dIF_valMerc_Neg	= CASE	WHEN a.codigo_carterasuper <> 'T' THEN 0 -- CRISTIAN MASCAREÑO YAÑEZ = 'P'  -- MNAVARRO <> 'T'
					ELSE CASE	WHEN a.modIFsb >= 0 AND a.motipoper = 'TM' AND a.mostatreg = ' ' THEN 0 
							WHEN a.modIFsb >= 0 AND a.motipoper = 'TM' AND a.mostatreg = 'R' THEN 0              * -1
							WHEN a.modIFsb <  0 AND a.motipoper = 'TM' AND a.mostatreg = ' ' THEN ABS((a.modIFsb * CASE WHEN (a.PorcjeCob /100) = 0 THEN 1 ELSE (a.PorcjeCob /100)END))
							WHEN a.modIFsb <  0 AND a.motipoper = 'TM' AND a.mostatreg = 'R' THEN ABS(ISNULL((VMA.rsDiferenciaMerc * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb)) * -1
							ELSE a.moperdida END 
				   END , -- 20 (dIFerencia Valor Mercado Neg Mx) 
       		Condicion_pact            = 1  , -- 21 (Condicion pacto)

		Tipo_cliente		= 0					,	
		FormaPago             = CONVERT(CHAR(06), a.forma_pago )            , -- 23 (Forma de pago)
		GenericoEmisor        = ISNULL(e.emgeneric, '' )       	            , -- 24 (Generico de emisor)
		a.monominal					                    , -- 25 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
		FormaPagoEntregamos   = CONVERT(CHAR(06), a.forma_pago )            , -- 26
		Tipo_Instrumento      = ISNULL(e.emtipo, '0')		            , -- 27 (clasIFicacion del emisor - tipo de bono)
		Condicion_entrega     = 1				            , -- 28
		TipoOperacion_r       = '2'				            , -- 29
		a.cod_nemo					                    , -- 30
		monumdocu					                    , -- 31
		emisor                = CONVERT(VARCHAR(10), morutemi )	            , -- 32
		motipoper					                    , -- 33
		valor_final           = movalven		                    , -- 34
		ClasIFica_Cliente     = '0'			                    , -- 35
		interes_negativo      = CASE WHEN mointeres < 0 THEN (mointeres *-1)
			                     ELSE 0 END                             , -- 36
		plazo                 = DATEDIFF(dd,mofecneg,mofecpago)		    , -- 37
		morutcli						            , -- 38
		mocodcli					                    , -- 39
		mofecpro					                    , -- 40
		a.capitalpeso 					         , -- 41
		catcorresponsal       = CONVERT(CHAR(15),ISNULL(f.codigo_corres,0)) , -- 42
		valor_cuponpeso       = 0.0                                          -- 43
	,	tipo_cartera		= 0
	,	EstObj			= CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' THEN (CASE WHEN ISNULL(a.PorcjeCob,0)  <> 0 THEN 'CBTO' ELSE 'DCBTO' END )
						WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' THEN (CASE WHEN ISNULL(VMA.PorcjeCob,0) <> 0 THEN 'CBTO' ELSE 'DCBTO' END )
						WHEN a.motipoper <> 'TM' THEN '' END	
        INTO    #TMP2
	FROM	TEXT_MVT_DRI_TAS_MERC      a	LEFT JOIN TEXT_RSU VMA	ON	VMA.rsfecpro		= @FechaBusquedaValorizacionAyer
									AND	VMA.rstipoper		= 'DEV'
									AND	VMA.rsnumdocu		= a.monumdocu
									AND	VMA.rsnumoper		= a.monumoper
									AND	VMA.rscorrelativo	= a.mocorrelativo
						LEFT JOIN BACPARAMSUDA..EMISOR		e	ON	e.emrut          = a.morutemi
	/*					LEFT JOIN BACPARAMSUDA..CORRESPONSAL	f	ON	f.rut_cliente    =  @Rut_Cliente
												AND	f.codigo_cliente =  1
												AND	f.codigo_moneda  = a.momonemi
												AND	f.codigo_swIFt   = a.corr_bco_swIFt
	*/												
		
						LEFT JOIN	(	select	distinct rut_cliente, codigo_cliente, codigo_moneda, codigo_swift, codigo_corres
										from	BacParamSuda.dbo.CORRESPONSAL 
										where	codigo_corres	<> 0
									)	f		ON	f.rut_cliente    =  @Rut_Cliente
												AND	f.codigo_cliente =  1
												AND	f.codigo_moneda  = a.momonemi
												AND	f.codigo_swIFt   = a.corr_bco_swIFt

		
        ,       bacparamsuda..CLIENTE      c 
	WHERE   a.mofecpro       =  CONVERT(CHAR(8),@fecha_hoy,112)
	AND	a.forma_pago     IN (0,2,11, 12, 13, 14, 111, 112, 113,122)
	AND	a.mostatreg      <> 'A' 	
        AND (c.clrut          =  a.morutcli	AND c.clcodigo = a.mocodcli)


	INSERT INTO BAC_CNT_CONTABILIZA
	(	id_sistema			, -- 01
		tipo_movimiento			, -- 02
		tipo_operacion			, -- 03
		operacion                       , -- 04
		correlativo                     , -- 05
		codigo_instrumento  		, -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente           	, -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon            , -- 15
		valor_comprahis            	, -- 16
		dIF_ant_pacto_pos               , -- 17	--- este.
		dIF_ant_pacto_neg               , -- 18 --- y este.
		dIF_valor_mercado_pos           , -- 19
		dIF_valor_mercado_neg           , -- 20
		condicion_pacto                 , -- 21
		tipo_cliente                    , -- 22
		forma_pago                      , -- 23
		tipo_emisor                     , -- 24
		nominal		                , -- 25 
		forma_pago_entregamos           , -- 26
		tipo_instrumento , -- 27
		condicion_entrega  		, -- 28
		tipo_operacion_or               , -- 29
		instser 			, -- 30
		documento			, -- 31
		emisor				, -- 32
		cartera_origen 			, -- 33
		valor_final			, -- 34 
		clasIFicacion_cliente		, -- 35
		interes_negativo		, -- 36
		plazo				, -- 37
		cliente				, -- 38
		codcli				, -- 39
		fecha_proceso			, -- 40
		capitalpeso  			, -- 41
		ctacblecorresponsal		, -- 42
		valor_cupon_peso                , -- 43
		tipo_cartera			, -- 44
		EstObj				)
	SELECT	* 
	FROM	#TMP2

	IF @@ERROR <> 0 
        BEGIN
	   SET NOCOUNT OFF
	   PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS BONEX ARCHIVO CONTABILIZA.'
	   RETURN 1
	END
	
	/*========================================================================*/
       	/*                      OPERACIONES CON FECHA DE PAGO INHABIL            			*/
       	/*                          Se contabiliza habil siguiente              				             */
       	/*========================================================================*/

	INSERT INTO bac_cnt_contabiliza
	(	id_sistema			, -- 01
		tipo_movimiento			, -- 02
		tipo_operacion			, -- 03
		operacion                       , -- 04
		correlativo                     , -- 05
		codigo_instrumento  		, -- 06
		moneda_instrumento 		, -- 07
		valor_compra                    , -- 08
		valor_presente           	, -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                        	, -- 12
		interes_papel                   , -- 13
		interes_pacto                   , -- 14
		valor_cupon            		, -- 15
		valor_comprahis                 , -- 16
		dIF_ant_pacto_pos               , -- 17
		dIF_ant_pacto_neg               , -- 18
		dIF_valor_mercado_pos           , -- 19
		dIF_valor_mercado_neg           , -- 20
		condicion_pacto                 , -- 21
		tipo_cliente                    , -- 22
		forma_pago                      , -- 23
		tipo_emisor                     , -- 24
		nominal		                , -- 25 
		forma_pago_entregamos   	, -- 26
		tipo_instrumento                , -- 27
		condicion_entrega               , -- 28
		tipo_operacion_or               , -- 29
		instser 			, -- 30
		documento			, -- 31
		emisor				, -- 32
		cartera_origen 			, -- 33
		valor_final			, -- 34
		clasIFicacion_cliente		, -- 35
		interes_negativo		, -- 36
		plazo				, -- 37
		cliente				, -- 38
		codcli				, -- 39
		fecha_proceso			, -- 40
		capitalpeso  			, -- 41
		ctacblecorresponsal		, -- 42
		valor_cupon_peso                , -- 43
		tipo_cartera			

	,	Utilidad_Avr_Patrimonio
	,	Perdida_Avr_Patrimonio
	,	Diferencia_Precio_Pos
	,	Diferencia_Precio_Neg

		) -- 44
						 

	SELECT	distinct 'BEX'      		, -- 01
		'MOV'                        	, -- 02
		a.motipoper			, -- 03
		a.monumoper        		, -- 04
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
		a.moutilidad                    , -- 17 (DIF pacto pos)
		a.moperdida                     , -- 18 (DIF Pacto neg  VBARRA 31/05/2000)
		a.moutilidad                   	, -- 19 (Valor Mercado pos)
		a.moperdida                     , -- 20 (valor Mercado neg)
		1				, -- 21 (Condicion pacto)
		0				, --22  
		CONVERT( CHAR(06), a.forma_pago )  	, -- 23 (Forma de pago)
		ISNULL( emgeneric, '' )       		, -- 24 (Generico de emisor)
		a.monominal				, -- 25 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
		CONVERT( CHAR(06), a.forma_pago )	, -- 26
		ISNULL(e.emtipo, '0')		, -- 27 (clasIFicacion del emisor - tipo de bono)
		1				, -- 28
		'2'				, -- 29
		cod_nemo			, -- 30
		monumdocu			, -- 31 
		CONVERT( VARCHAR(10), morutemi ), -- 32
		motipoper			, -- 33	
		movalven			, -- 34
		'0'				, -- 35
		CASE	when mointeres < 0 then (mointeres *-1)
			ELSE 0
			END			, -- 36
		DATEDIFF(dd,mofecneg,mofecpago)	, -- 37
		morutcli			, -- 38
		mocodcli			, -- 39
		mofecpro			, -- 40
		capitalpeso 			, -- 41
		CONVERT ( CHAR (15) , ISNULL(f.codigo_corres, 0)) , -- 42
		0.0				, -- 43
		0		
	
	,	Utilidad_Avr_Patrimonio		= case when a.Resultado_Dif_Mercado	>= 0 then abs(a.Resultado_Dif_Mercado)	else 0 end	--> Ventas AFS
	,	Perdida_Avr_Patrimonio		= case when a.Resultado_Dif_Mercado	<  0 then abs(a.Resultado_Dif_Mercado)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	
	FROM	TEXT_MVT_DRI 		a	
	INNER JOIN VIEW_CLIENTE		c
	ON ( c.clrut    =  a.morutcli  
	AND	c.clcodigo = a.mocodcli )
	RIGHT OUTER JOIN BACPARAMSUDA..EMISOR 	e
	on e.emrut  = a.morutemi	
/*		RIGHT OUTER JOIN VIEW_CORRESPONSAL    	f
		on f.codigo_swIFt  = a.corr_bco_swIFt
		AND f.codigo_moneda = a.momonemi	
*/		
	
		RIGHT OUTER JOIN	(	select	distinct rut_cliente, codigo_cliente, codigo_moneda, codigo_swift, codigo_corres
							from	BacParamSuda.dbo.CORRESPONSAL 
							where	codigo_corres	<> 0
						)	f	on f.codigo_swIFt  = a.corr_bco_swIFt AND f.codigo_moneda = a.momonemi	



	WHERE a.mofecpro   =  @fecha_hoy
	AND	( f.rut_cliente = @RUT_CLIENTE
	AND	f.codigo_cliente = 1
 
	AND	a.forma_pago IN(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND	(  a.mofecpago  > @Fecha_Ant  AND  a.mofecpago < @fecha_hoy )
	AND	a.mostatreg  <> 'A' 	


	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END

   	/*===========================================*/
   	/* Llena Devengo    				*/
   	/*===========================================*/

	INSERT INTO bac_cnt_contabiliza(
		id_sistema		, --01
		tipo_movimiento		, --02
		tipo_operacion		, --03
		operacion		, --04
		correlativo		, --05
		codigo_instrumento	, --06
		moneda_instrumento	, --07
		valor_compra		, --08
		valor_presente		, --09
		valor_venta		, --10
		utilidad			, --11
		perdida			, --12
		interes_papel		, --13
		interes_pacto		, --14
		valor_cupon		, --15
		nominal			, --16
		valor_comprahis		, --17
		dIF_ant_pacto_pos	, --18
		dIF_ant_pacto_neg	, --19
		dIF_valor_mercado_pos	, --20
		dIF_valor_mercado_neg	, --21
		condicion_pacto		, --22
		forma_pago		, --23
		forma_pago_entregamos , --24
		tipo_instrumento		, --25
		tipo_cliente		, --26
		tipo_emisor		, --27
		valor_futuro		, --28
		comquien		, --29
		instser			, --30
		documento		, --31
		emisor			, --32
		clasIFicacion_cliente	, --33
		valor_final		, --34
		cartera_origen		, --35
		interes_negativo		, --36
		plazo			, --37
		cliente			, --38
		codcli			, --39
		fecha_proceso		, --40
		interespeso 		, --41
		valor_cupon_peso	,
		tipo_cartera		) 

	SELECT 'BEX'                		        , -- 01
		'DEV'                 		        , -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'			                , -- 03
		a.rsnumoper		                , -- 04 rsnumoper
		1, -- valor 1 para dIFerenciar el monto int.que falta contab. para completar cupon. delice a.rscorrelativo	             , -- 05
		cod_familia		                , -- 06
		rsmonemi		                , -- 07 monpact
		rsvalcomu	     	                , -- 08  valor compra
		ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0 )	, -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	        , -- 10	valor venta
		0.0                                     , -- 11
		0.0                                     , -- 12
		ISNULL( a.rsinteres, 0 )	        , -- 13
		ISNULL( a.rsinteres, 0 )	        , -- 14 interes pacto
		0.0			                , -- 15 valor cupon
		0.0  			                ,-- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )               , -- 17 (Val.Compra Historico)
		0.0                             	, -- 18 (DIF Pacto pos)
		0.0                             	, -- 19 (DIF pacto neg)
		0.0                             	, -- 20 (Valor Mercado pos)
		0.0                             	, -- 21 (Valor Mercado neg)
		1			          , -- 22 (Condicion pacto)
		1                               	, -- 23 (Forma de pago)'
		1			                , -- 24 forma de pago entregamos'
		e.emtipo		                , -- 25 (Tipo instrumento) 
		'0'			                , -- 27   tipo cliente
		''                              	, -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)     		, -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END	,-- 30
		''			                ,  --31  cod_nemo,
		rsnumdocu		                ,  --32
		CONVERT( VARCHAR(10), rsrutemis )       , --33
		'0'				        , --34
		ISNULL( a.rsinteres, 0 )		, --35
		'Cp' 				        , --36
		(CASE	when rsinteres < 0 then (rsinteres * -1) ELSE 0 END), --37
		(DATEDIFF(dd,rsfecneg, rsfecpago))      , --38
		rsrutcli				, --39
		rscodcli				, --40
		rsfecpro				, --41
		abs(interespeso)			, --42
		0.0					, ---43
		0
	FROM	#tmp_mdrs a 
	RIGHT OUTER JOIN bacparamsuda..emisor e
	on e.emrut      = a.rsrutemis	
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy	

	AND	a.rsfecpago  < @Fecha_Hoy
	AND	rstipoper    = 'DEV' 
	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END

   	/*===========================================*/
   	/* Llena Devengo                             */ 
   	/*  interes de ayer a hoy para operaciones   */
   	/*  que se vENDen hoy                  	*/
   	/*===========================================*/
	INSERT INTO bac_cnt_contabiliza(
		id_sistema 		                , -- 01
		tipo_movimiento                 	, -- 02
		tipo_operacion		        	, -- 03
		operacion                       	, -- 04
		correlativo             		, -- 05
		codigo_instrumento              	, -- 06
		moneda_instrumento              	, -- 07
		valor_compra 	                        , -- 08
		valor_presente                  	, -- 09
		valor_venta                     	, -- 10
		utilidad                        	, -- 11
		perdida                         	, -- 12
		interes_papel                   	, -- 13
		interes_pacto                 	        , -- 14
		valor_cupon                     	, -- 15
		nominal    			        , -- 16
        	valor_comprahis     		        , -- 17
		dIF_ant_pacto_pos               	, -- 18
		dIF_ant_pacto_neg         	        , -- 19
		dIF_valor_mercado_pos           	, -- 20
		dIF_valor_mercado_neg           	, -- 21
		condicion_pacto                 	, -- 22
		forma_pago 			        , -- 23
		forma_pago_entregamos           	, -- 24
		tipo_instrumento                	, -- 25
		tipo_cliente                    	, -- 26
		tipo_emisor   			        , -- 27
		valor_futuro                    	, -- 28
		comquien          			, -- 29
		instser				        , -- 30
		documento			        , -- 31
		emisor				        , -- 32
		clasIFicacion_cliente		        , -- 33
		valor_final			        , -- 34
		cartera_origen			        , -- 35
		interes_negativo			, -- 36
		plazo				        , -- 37
		cliente				        , -- 38
		codcli				        , -- 39
		fecha_proceso			        , -- 40
		interespeso 			        , -- 41
		valor_cupon_peso		        ,
		tipo_cartera				) 

	SELECT	'BEX'                     	, -- 01
		'DEV'                           	, -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'				        , -- 03
		a.rsnumoper                     	, -- 04 rsnumoper
		a.rscorrelativo	                	, -- 05
		cod_familia			        , -- 06
		rsmonemi			        , -- 07 monpact
		rsvalcomu	     		        , -- 08  valor compra
		ISNULL( a.rsinteres, 0 )                , -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	        , -- 10	valor venta
		0.0                             	, -- 11
		0.0                             	, -- 12
		ISNULL( a.rsinteres, 0 )		, -- 13
		ISNULL( a.rsinteres, 0 )		, -- 14 interes pacto
		0.0				        , -- 15 valor cupon
		0.0  			        	,-- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )       	, -- 17 (Val.Compra Historico)
		0.0                             	, -- 18 (DIF Pacto pos)
		0.0                             	, -- 19 (DIF pacto neg)
		0.0                             	, -- 20 (Valor Mercado pos)
		0.0                             	, -- 21 (Valor Mercado neg)
		1				        , -- 22 (Condicion pacto)
		1                               	, -- 23 (Forma de pago)'
		1			        	, -- 24 forma de pago entregamos'
		e.emtipo		        	, -- 25 (Tipo instrumento) 
		'0'				    , -- 27   tipo cliente
		''         	, -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)         	, -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END    ,-- 30
		''				        , -- 31  cod_nemo,
		rsnumdocu			        , -- 32
		CONVERT( VARCHAR(10), rsrutemis )       , -- 33
		'0'				        , -- 34 
		ISNULL( a.rsinteres, 0 )		, -- 35
		'Cp' 				        , -- 36 
		(CASE	when rsinteres < 0 then (rsinteres * -1) ELSE 0 END), -- 37
		(DATEDIFF(dd,rsfecneg, rsfecpago))      , --38
		rsrutcli				, --39
		rscodcli				, --40
		rsfecpro				, --41
		abs(interespeso)			, --42
		0.0				        , --43
		0
	FROM	#tmp_mdrs 		a 
	RIGHT OUTER JOIN bacparamsuda..emisor	e
	on e.emrut      = a.rsrutemis 	
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy		
	AND	a.rsfecpago  <= @Fecha_Hoy
	AND	rstipoper    = 'DV' 
	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END

   	/*===================================================*/
   	/* Llena Vencimiento Cupon		-- SOLO BONEX	*/
   	/*===================================================*/
	-- Contabilizacion de vencimiento cupon
	INSERT INTO bac_cnt_contabiliza(
		id_sistema                      	, -- 01
		tipo_movimiento              	        , -- 02
		tipo_operacion		                , -- 03
		operacion                       	, -- 04
		codigo_instrumento                      , -- 05
		moneda_instrumento                      , -- 06
		valor_cupon                             , -- 07
		tipo_instrumento             	        , -- 08
		ctacblecorresponsal	                , -- 09
		valor_cupon_peso	                , -- 10
		correlativo		                , -- 11
		nominal			                , -- 12
		capitalPeso		)
	SELECT distinct
		'BEX'                           	, -- 01
		'MOV'                           	, -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'VCP'	    		                , -- 03
		a.rsnumoper                             , -- 04 rsnumoper
		a.cod_familia		                , -- 05
		rsmonemi		                , -- 06 monpact
		rsflujo			                , -- 07 valor cupon, monto a pagar
		ISNULL(e.emtipo, 0)	                , -- 08 (clasIFicacion del emisor - tipo de bono)
		CONVERT ( char ( 15), ISNULL(f.codigo_corres, 0))  , -- 09 
		ValorCuponPeso		                , -- 10
		a.rscorrelativo		                , -- 11
		(CASE when rsfecvcto = @Fecha_Hoy then a.rsnominal   ELSE 0 END)	, --12
		(CASE when rsfecvcto = @Fecha_Hoy then a.capitalpeso ELSE 0 END)	  --13

	FROM	#tmp_mdrs		a

/*			right outer join view_corresponsal	f on f.codigo_cliente = 1
*/
		
		right outer join	(	select	distinct rut_cliente, codigo_cliente, codigo_moneda, codigo_swift, codigo_corres
								from	BacParamSuda.dbo.CORRESPONSAL 
								where	codigo_corres	<> 0
							)	f on f.codigo_cliente = 1



	inner join text_mvt_dri		car
 	on	f.codigo_moneda = car.momonemi
	AND	f.codigo_swIFt  = car.corr_bco_swIFt	
	INNER JOIN VIEW_CLIENTE		c
	ON ( c.clrut    =  a.rsrutcli  
	AND	c.clcodigo = a.rscodcli )
	RIGHT OUTER JOIN bacparamsuda..emisor 	e
	on 	e.emrut  = car.morutemi
	
	WHERE ( f.rut_cliente = @RUT_CLIENTE
	AND	car.forma_pago in(2,11, 12, 13, 14, 111, 112, 113,122 )	)
	AND	a.rsnumdocu = car.monumoper
        	AND	a.rsfecpro = @Fecha_Hoy
	AND	a.cod_familia = 2000
	AND	a.rstipoper    = 'VCP'

	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END
	/**************************************************************************************/
	/*  Contabilizacion de interes devengado que falta antes el corte cupon   */
	/**************************************************************************************/
	INSERT INTO bac_cnt_contabiliza(
		id_sistema                    , -- 01
		tipo_movimiento                 	, -- 02
		tipo_operacion		        	, -- 03
		operacion                       	, -- 04
		correlativo             		, -- 05
		codigo_instrumento              	, -- 06
		moneda_instrumento     	, -- 07
		valor_compra                    	, -- 08
		valor_presente                  	, -- 09
		valor_venta                     	, -- 10
		utilidad                        	, -- 11
		perdida                         	, -- 12
		interes_papel                   	, -- 13
		interes_pacto                  		, -- 14
		valor_cupon                    	 	, -- 15
		nominal    			        , -- 16
		valor_comprahis     		        , -- 17
		dIF_ant_pacto_pos               	, -- 18
		dIF_ant_pacto_neg               	, -- 19
		dIF_valor_mercado_pos           	, -- 20
		dIF_valor_mercado_neg           	, -- 21
		condicion_pacto                 	, -- 22
		forma_pago 			        , -- 23
		forma_pago_entregamos           	, -- 24
		tipo_instrumento                	, -- 25
		tipo_cliente                    	, -- 26
		tipo_emisor   			        , -- 27
		valor_futuro                    	, -- 28
		comquien          			, -- 29
		instser				        ,--  30
		documento			        ,--  31
		emisor				        ,--  32
		clasIFicacion_cliente		        ,--  33
		valor_final			        ,--  34
		cartera_origen			        ,--  35
		interes_negativo			,--  36
		plazo				        ,--  37
		cliente				        ,--  38
		codcli				        ,--  39
		fecha_proceso			        ,--  40
		interespeso 			        ,--  41
		valor_cupon_peso		        )--  42

	SELECT	'BEX'                           	, -- 01
		'DEV'                           	, -- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)
		'DCP'				        , -- 03
		a.rsnumoper                    		, -- 04 rsnumoper
		2, -- a.rscorrelativo	              	, -- 05
		cod_familia			        , -- 06
		rsmonemi			        , -- 07 monpact
		rsvalcomu	     		        , -- 08  valor compra
		ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0 ) , -- 09	valor presente
		ISNULL( a.rsvppresenx, 0 ) 	        , -- 10	valor venta
		0.0                             	, -- 11
		0.0                             	, -- 12
		ISNULL( a.rsinteres, 0 )		, -- 13
		ISNULL( a.rsinteres, 0 )		, -- 14 interes pacto
		0.0				        , -- 15 valor cupon
		0.0  			        	, -- ' 16 nominal peso'
		ISNULL( a.rsvppresen, 0 )       	, -- 17 (Val.Compra Historico)
		0.0      		                , -- 18 (DIF Pacto pos)
		0.0                            		, -- 19 (DIF pacto neg)
		0.0                             	, -- 20 (Valor Mercado pos)
		0.0 		                        , -- 21 (Valor Mercado neg)
		1				        , -- 22 (Condicion pacto)
		1                   		        , -- 23 (Forma de pago)'
		1			        	, -- 24 forma de pago entregamos'
		e.emtipo		        	, -- 25 (Tipo instrumento) 
		'0'				        , -- 27   tipo cliente
		''                              	, -- 28 (Generico de emisor)
		ISNULL(a.rsvppresenx,0)         	, -- 29 (Valor Futuro para vencimiento de interbancarios)
		CASE	WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END    ,-- 30
		''				        , -- 31  cod_nemo,
		rsnumdocu			        , --32
		CONVERT( VARCHAR(10), rsrutemis )       , --33
		'0'				        , --34
		ISNULL( a.rsinteres, 0 )		, --35
		'Cp' 				        , --36
		(CASE	when rsinteres < 0 then (rsinteres * -1) ELSE 0 END), --37
		(DATEDIFF(dd,rsfecneg, rsfecpago))      , --38
		rsrutcli				, --39
		rscodcli				, --40
		rsfecpro				, --41
		abs(interespeso)			, --42
		0.0				          --43
	FROM	#tmp_mdrs		a
	RIGHT OUTER JOIN bacparamsuda..emisor 	e	
	on e.emrut      = a.rsrutemis
	WHERE ( rsfecpro    >= @Fecha_Hoy
	AND	rsfecpro    <  @fecha_prox )
	AND	rsfeccomp   <  @Fecha_Hoy		
	AND	a.rsfecpago  < @Fecha_Hoy
	AND	 a.rstipoper    = 'VCP'

	IF @@ERROR <> 0 BEGIN

		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END

   	/*===========================================*/
   	/* Llena Vencimiento CD NOTEX DPEX 		*/
   	/*===========================================*/
	 INSERT INTO bac_cnt_contabiliza(
		id_sistema    		        , -- 01
		tipo_movimiento                 	, -- 02
		tipo_operacion		       	        , -- 03
		operacion                       	, -- 04
		correlativo             		, -- 05
		codigo_instrumento              	, -- 06
		moneda_instrumento              	, -- 07
		valor_compra                    	, -- 08
		valor_presente                  	, -- 09
		valor_venta                     	, -- 10
		interes_papel                   	, -- 11
		interes_pacto                   	, -- 12
		nominal    			        , -- 13
		valor_comprahis     		        , -- 14
		forma_pago                      	, -- 15
		forma_pago_entregamos           	, -- 16
		tipo_instrumento                	, -- 17
		valor_futuro                    	, -- 18
		documento			        , -- 19
		emisor				        , -- 20
		clasIFicacion_cliente		        , -- 21
		valor_final			        , -- 22
		cartera_origen			        , -- 23
		interes_negativo			, -- 24
		plazo				        , -- 25
		cliente				        , -- 26
		codcli				        , -- 27
		fecha_proceso			        , -- 28
		interespeso 			        , -- 29
		valor_cupon_peso		        ) -- 30
	SELECT	'BEX'                           , -- 01
		'MOV'                           , -- 02
		'V'				, -- 03
		a.rsnumoper                     , -- 04 rsnumoper
		a.rscorrelativo	            	, -- 05
		a.cod_familia			, -- 06
		rsmonemi			, -- 07 monpact
		rsvalcomu	               	, -- 08  valor compra
		ISNULL( a.rsinteres, 0 )        , -- 09	interes del dia
		ISNULL( a.rsvppresenx, 0 ) 	, -- 10	valor venta
		ISNULL( a.rsinteres, 0 )	, -- 11
		ISNULL( a.rsinteres_acum, 0 )	, -- 12 Valor interes acumulado o interes ganado
		rsnominal		        , -- 13 nominal peso'
		ISNULL( a.rsvppresen, 0 )       , -- 14 
		12                              , -- 15 (Forma de pago)'
		1			        , -- 16 forma de pago entregamos'
		e.emtipo		        , -- 17 (Tipo Emisor - cclasIFicacion emisor) 
		ISNULL(case when a.cod_familia = 2002 then a.rsflujo /* Mnavarro 25 Feb 2019 */  else  a.rsvppresenx end,0)       	, -- 18 (Valor Futuro para vencimiento de interbancarios)
		rsnumdocu			, -- 19
		CONVERT( VARCHAR(10), rsrutemis ),-- 20 
		'0'				, -- 21
		ISNULL( a.rsinteres, 0 )	, -- 22
		'Cp' 				, -- 23
		(CASE	when rsinteres < 0 then (rsinteres * -1) ELSE 0 END),-- 24
		(DATEDIFF(dd,rsfecneg, rsfecpago))	, -- 25
		rsrutcli			, -- 26
		rscodcli			, -- 27
		rsfecpro			, -- 28 
		abs(interespeso)		, -- 29 interes del dia en peso
		ValorPresentePeso		  -- 30
	FROM	#tmp_mdrs 		a 
	RIGHT OUTER JOIN bacparamsuda..emisor 	e
	on e.emrut      = a.rsrutemis	
	WHERE   rsfecvcto = @Fecha_Hoy	

	AND	a.cod_familia  <> 2000
	AND	 a.rstipoper  = 'V'      -- select rsfecvcto, * from Text_rsu where rsfecpro = '20160502' and rstipoper  = 'V' 
	
	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO BONEX ARCHIVO CONTABILIZA.'
		RETURN 1
	END


	/****************************************************************************************************************/
	/***************************** ACTUALIZACION CODIGO TIPO_CARTERA (BAC_CNT_CONTABILIZA ***************************/
	/****************************************************************************************************************/

	CREATE TABLE #TEMPORAL
	(	id_sistema	CHAR(03) 
	,	tipo_movimiento	CHAR(05)
	,	tipo_operacion	CHAR(05)
	,	operacion	NUMERIC(10,0)
	,	documento	NUMERIC(10,0)
	,	correlativo	NUMERIC(3,0)
	,	estadocobertura	CHAR(05)
	,	CodClas		CHAR(10)
	,	Estado		CHAR(01)
	)

	INSERT INTO #TEMPORAL
	SELECT	id_sistema 
	,	tipo_movimiento 
	,	tipo_operacion
	,	operacion    
	,	documento
	,	correlativo
	,	EstObj
	,	''
	,	'N'
	FROM	BAC_CNT_CONTABILIZA

	DECLARE	@IdSistema		CHAR(03)
	,	@Tipo_Movimiento	CHAR(05)
	,	@Tipo_Operacion		CHAR(05)
	,	@NumOpe			NUMERIC(10,0)
	,	@NumDocu		NUMERIC(10,0)
	,	@NumCorre		NUMERIC(03)
	,	@EstadoCobertura	CHAR(05)
	,	@CodClas		CHAR(10)
	,	@Estado			CHAR(01)

	WHILE 1 = 1 BEGIN

		SELECT	@CodClas = '*'

		SET ROWCOUNT 1

		SELECT	@IdSistema		= id_sistema 
		,	@Tipo_Movimiento	= tipo_movimiento
		,	@Tipo_Operacion		= tipo_operacion
		,	@NumOpe			= operacion
		,	@NumDocu		= documento
		,	@NumCorre		= correlativo
		,	@EstadoCobertura	= estadocobertura
		,	@CodClas		= CodClas
		FROM	#TEMPORAL
		WHERE	Estado			= 'N'

		SET ROWCOUNT 0

		IF @CodClas = '*'
			BREAK

		EXECUTE @CodClas = BACPARAMSUDA.DBO.SP_CON_CLASIFICACION_CARTERA	@IdSistema 
										,	@Tipo_Movimiento 
										,	@Tipo_Operacion 
										,	@NumOpe    
										,	@NumDocu 
										,	@NumCorre
										,	@EstadoCobertura
		SET NOCOUNT ON

		UPDATE	#TEMPORAL
		SET	CodClas		= @CodClas
		,	Estado		= 'S'
		WHERE	id_sistema	= @IdSistema 
		AND	tipo_movimiento	= @Tipo_Movimiento
		AND	tipo_operacion	= @Tipo_Operacion
		AND	operacion	= @NumOpe
		AND	documento	= @NumDocu
		AND	correlativo	= @NumCorre
		AND	estadocobertura	= @EstadoCobertura
	END

	UPDATE	BAC_CNT_CONTABILIZA
	SET	TIPO_CARTERA		= CodClas
	FROM	#TEMPORAL		A
	WHERE	BAC_CNT_CONTABILIZA.id_sistema		= A.id_sistema
	AND	BAC_CNT_CONTABILIZA.tipo_movimiento	= A.tipo_movimiento
	AND	BAC_CNT_CONTABILIZA.tipo_operacion	= A.tipo_operacion
	AND	BAC_CNT_CONTABILIZA.operacion		= A.operacion
	AND	BAC_CNT_CONTABILIZA.documento		= A.documento
	AND	BAC_CNT_CONTABILIZA.correlativo		= A.correlativo
	AND	BAC_CNT_CONTABILIZA.EstObj 		= A.EstadoCobertura

	-- ***********************************************************************************+
	-- INSERTA TABLA DE PASO PARA LA CONTABILIDAD (BAC_CNT_CONTABILIZA_RESUMEN)
	-- ***********************************************************************************+
	TRUNCATE TABLE BAC_CNT_CONTABILIZA_RESUMEN

	INSERT INTO BAC_CNT_CONTABILIZA_RESUMEN
     	(
                  	id_sistema		, --01
                 	tipo_movimiento		, --02
                 	tipo_operacion		, --03
                  	operacion		, --04
                 	correlativo		, --05
                  	codigo_instrumento	, --06
                  	moneda_instrumento	, --07
            	     	valor_compra		, --08
                  	valor_presente		, --09
                  	valor_venta		, --10
          		utilidad		, --11
                  	perdida			, --12
       		        interes_papel		, --13
                  	interes_pacto		, --14
                  	valor_cupon		, --15
                  	nominal			, --16
		        valor_comprahis		, --17
                  	dIF_ant_pacto_pos	, --18
                  	dIF_ant_pacto_neg	, --19
                  	dIF_valor_mercado_pos 	, --20	
        	        dIF_valor_mercado_neg 	, --21
                  	condicion_pacto		, --22
        		forma_pago		, --23
                  	tipo_instrumento	, --24
        	       	tipo_cliente		, --25
                  	tipo_emisor		, --26
                  	forma_pago_entregamos	, --27
                  	valor_futuro		, --28
                  	condicion_entrega	, --29
                  	tipo_operacion_or	, --30
                  	comquien		, --31
                  	instser			, --32
                  	documento		, --33
                  	Emisor			, --34
                  	tipo_bono		, --35
                  	clasIFicacion_cliente	, --36
                  	valor_final		, --37
                  	cartera_origen		, --38
                  	interes_positivo	, --39
                  	interes_negativo	, --40
                  	plazo			, --41
                  	cliente			, --42
                  	codcli			, --43
            	fecha_proceso		, --44
			capitalPeso		, --45
         	interesPeso		, --46
                  	ctacblecorresponsal	, --47
        	  	valor_cupon_peso          

	,	Utilidad_Avr_Patrimonio
	,	Perdida_Avr_Patrimonio
	,	Diferencia_Precio_Pos
	,	Diferencia_Precio_Neg
        	  	
        	  	)  --48
        	  	
 
	SELECT	id_sistema		, --01
		tipo_movimiento		, --02
		tipo_operacion		, --03
		operacion		, --04
           	correlativo		, --05
                codigo_instrumento	, --06
		moneda_instrumento	, --07
		(valor_compra)		, --08
		(valor_presente)	, --09
		(valor_venta)		, --10
		(utilidad)		, --11
		(perdida)		, --12
		(interes_papel)		, --13
		(interes_pacto)		, --14
		(valor_cupon)		, --15
		(nominal)		, --16
		(valor_comprahis)	, --17
		(dIF_ant_pacto_pos)	, --18
		(dIF_ant_pacto_neg)	, --19
		(dIF_valor_mercado_pos)	, --20
		(dIF_valor_mercado_neg)	, --21
		condicion_pacto		, --22
		forma_pago		, --23
		tipo_instrumento	, --24
		tipo_cliente		, --25
		tipo_emisor		, --26
		forma_pago_entregamos	, --27
		(valor_futuro)		, --28
		condicion_entrega	, --29
		tipo_operacion_or	, --30
		comquien		, --31
		''			, --32	 --instser,
		documento		, --33	--documento,
		0			, --34	--Emisor,
		tipo_bono		, --35
		clasIFicacion_cliente	, --36
		(valor_final)		, --37
		cartera_origen		, --38
		(interes_positivo)	, --39
		(interes_negativo)	, --40
		plazo			, --41
                cliente			, --42
                codcli			, --43
		fecha_proceso		, --44
		capitalPeso		, --45
interesPeso		, --46
                ctacblecorresponsal	, --47
		valor_cupon_peso	  --48	

	,	Utilidad_Avr_Patrimonio
	,	Perdida_Avr_Patrimonio
	,	Diferencia_Precio_Pos
	,	Diferencia_Precio_Neg
		
                	-- Numero de Operacion es IDENTITY
	from	BAC_CNT_CONTABILIZA


	INSERT INTO BAC_CNT_CONTABILIZA_HISTORICA
	SELECT	FechaContable	= ( SELECT acfecproc FROM TEXT_ARC_CTL_DRI with(nolock) )
		,	BAC_CNT_CONTABILIZA.*
	FROM	BAC_CNT_CONTABILIZA

	IF @@ERROR <> 0 
	BEGIN
		PRINT 'ERROR_PROC Falla Respaldando en Bac_Cnt_Contabiliza_Historica (Bonos Exterior).'
		RETURN 1
	END
	
	SET NOCOUNT OFF
	RETURN 0
END
GO
