USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CTB_RENTA_FIJA_EXTRA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CTB_RENTA_FIJA_EXTRA] 
   (   @Fecha_Hoy   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON
   
   DECLARE @Fecha_Ant 			DATETIME
   DECLARE @Fecha_prox 			DATETIME
   DECLARE @Control_Error    	INTEGER
   DECLARE @Valor_Observado  	FLOAT
   DECLARE @Rut_Central      	NUMERIC(10)
   DECLARE @Habil            	CHAR(1)
   DECLARE @Fecha_Paso       	DATETIME
   DECLARE @VVISTA           	CHAR(4)
   DECLARE @rut_estado     		NUMERIC(10)
   DECLARE @RUT_CLIENTE     	NUMERIC(10)  
   DECLARE @RUT_CORPBNC			NUMERIC(10)
   DECLARE @Correla				NUMERIC(05)

   DECLARE @iRutAdmCorp         NUMERIC(10)
       SET @iRutAdmCorp         = 96513630

   SELECT  @Fecha_Ant	= acfecante
   ,	   @fecha_prox	= acfecprox
   FROM	   MDAC         with (nolock)

   SET     @Valor_Observado = isnull((SELECT ISNULL(vmvalor, 1.0) FROM VIEW_VALOR_MONEDA with (nolock) WHERE vmcodigo = 994 AND vmfecha = @Fecha_Hoy),1.0)
   SET     @Rut_Central     = isnull((SELECT ISNULL(folio, 0)     FROM GEN_FOLIOS        with (nolock) WHERE codigo   = 'RUTBCCH'),0)
   SET     @Rut_estado      = 97030000
   SET     @rut_Central     = 97029000
   SET     @RUT_CLIENTE     = (SELECT acrutprop FROM MDAC0823         with (nolock) )
   SET     @RUT_CORPBNC     = (SELECT rcrut     FROM VIEW_ENTIDAD with (nolock) )

   /*=======================================================================*/
   /* LIMPIA ARCHIVO DE CONTABILIZACION                                     */
   /*=======================================================================*/
   TRUNCATE TABLE BAC_CNT_ERRORES

   DELETE FROM BAC_CNT_CONTABILIZA 

   IF @@ERROR <> 0    
   BEGIN
      SET NOCOUNT OFF
      PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (RENTA FIJA).'
      RETURN 1
   END

   /*======================================================================================================*/
   -- Busca fecha de ultimo dia del mes en fin de mes no habil, cuANDo es primer dia del mes.
   /*======================================================================================================*/
   -------------------------------------------------------Tasa de Mercado---------------------------------------------------------
   DECLARE @feriado         NUMERIC (01)
   DECLARE @feriadoIniMes   NUMERIC (01)
   DECLARE @dfecfmes        DATETIME
   DECLARE @dfecImes        DATETIME
   DECLARE @indi            NUMERIC(01) 
   DECLARE @FechaTMAyer	    DATETIME
   DECLARE @FechaTMHoy	    DATETIME
   DECLARE @BorraTM	    INTEGER
   DECLARE @Mov_Rev	    INTEGER

   SET     @dfecfmes        = DATEADD(DAY, DATEPART(DAY, @Fecha_prox) * -1, @Fecha_prox)
   SET     @dfecImes        = DATEADD(DAY, DATEPART(DAY, @Fecha_Hoy)  * -1, DATEADD(DAY, 1, @Fecha_Hoy))

   EXECUTE SP_FERIADO @dfecfmes,6 , @feriado       OUTPUT
   EXECUTE SP_FERIADO @dfecImes,6 , @feriadoIniMes OUTPUT

   IF DATEPART(MONTH,@Fecha_Hoy) <> DATEPART(MONTH,@Fecha_Ant) 
   BEGIN
      SET @FechaTMAyer = DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8), @Fecha_Hoy, 112), 1, 6) + '01')
   END ELSE 
   BEGIN
      SET @FechaTMAyer = @Fecha_Ant
   END
   
   IF DATEPART(MONTH,@Fecha_Hoy) <> DATEPART(MONTH,@Fecha_Prox) 
   BEGIN
      SET @FechaTMHoy = DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8),@Fecha_Prox,112),1,6) + '01')
   END ELSE 
   BEGIN
      SET @FechaTMHoy = @Fecha_Hoy
   END


   --> INSERTA EN LA MDMO LAS TM DEL DIA
   SET @BorraTM	= 0   --> 1 = ELIMINA TASAS DE MERCADO DE LA MDMO
   SET @Mov_Rev	= 1   --> 1 = MOVIMIENTO DEL DIA

   EXECUTE DBO.Sp_ContabilizaSbif_EXTRA	@FechaTMHoy, @BorraTM, @Mov_Rev

   /*=======================================================================*/
   /* Busca si el sistema esta en una fecha no habil (Fin de mes feriado)  */
   /*=======================================================================*/

   SET @Fecha_Paso = @Fecha_Hoy

   EXECUTE SP_DIAHABIL @Fecha_Paso OUTPUT

   IF DATEDIFF(DAY, @Fecha_Hoy, @Fecha_Paso) <> 0 
   BEGIN
      SET @Habil = 'N'
   END ELSE 
   BEGIN
      SET @Habil = 'S'
   END
   DECLARE @FechaBusquedaValorizacion	    DATETIME
   DECLARE @FechaBusquedaValorizacionAyer   DATETIME

   IF DATEPART(MONTH,@fecha_hoy) <> DATEPART(MONTH,@Fecha_Prox)
   BEGIN
      SET @FechaBusquedaValorizacion = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@Fecha_Prox,112),1,6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL
   END ELSE 
   BEGIN
      SET @FechaBusquedaValorizacion = @fecha_hoy --FECHA HOY
   END

   IF DATEPART(MONTH,@Fecha_Ant) <> DATEPART(MONTH,@fecha_hoy) 
   BEGIN
      SET @FechaBusquedaValorizacionAyer = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@fecha_hoy,112),1,6) + '01') --FIN DE MES (ANTERIOR) HABIL O NO HABIL
   END ELSE 
   BEGIN
      SET @FechaBusquedaValorizacionAyer = @fecha_Ant
   END



   /*=======================================================================*/
   /* Llena Renta Fija operaciones                                         */
   /*=======================================================================*/
   INSERT INTO BAC_CNT_CONTABILIZA
   (	        id_sistema   			, -- 01
		tipo_movimiento   		, -- 02
		tipo_operacion   		, -- 03
		operacion                       , -- 04
		correlativo                     , -- 05
		codigo_instrumento    		, -- 06
		moneda_instrumento              , -- 07
		valor_compra                    , -- 08
		valor_presente           	, -- 09
		valor_venta                     , -- 10
		utilidad                        , -- 11
		perdida                         , -- 12
		interes_papel                   , -- 13
		reajuste_papel                  , -- 14
		interes_pacto                   , -- 15
		reajuste_pacto                  , -- 16
		valor_cupon                     , -- 17
		valor_comprahis                 , -- 18
		dif_ant_pacto_pos               , -- 19
		dif_ant_pacto_neg               , -- 20
		dif_valor_mercado_pos           , -- 21
		dif_valor_mercado_neg           , -- 22
		condicion_pacto                 , -- 23
		tipo_cliente        , -- 24
		forma_pago  			, -- 25
		tipo_emisor                     , -- 26
		nominalpesos                   , -- 27
		forma_pago_entregamos           , -- 28
		tipo_instrumento   		, -- 29
		condicion_entrega               , -- 30
		tipo_operacion_or               , -- 31
		instser				, -- 32
		documento			, -- 33
		emisor				, -- 34
		cartera_origen 			, -- 35
		valor_final			, -- 36
		clasificacion_cliente		, -- 37 -- aca
		interes_negativo		,
		reajuste_negativo		,
		plazo				,
		cliente				,
		codcli				,
		fecha_proceso  			,
		nominal				,
		valor_tasa_emision		,
		prima_total			,
		descuento_total			,
		prima_dia   			,
		descuento_dia			,
		valor_pte_emision		,	
		dif_par_pos           		,
		dif_par_neg                     ,
		Tipo_Cartera                    ,
		CondPactoCliente		,
		EstObj                          ,   
                Tipo_Bono
	)
 	SELECT	'BTR'                           , -- 01
                CASE WHEN a.motipoper = 'TM' THEN 'TMF' 
                     ELSE                         'MOV' 
                END                            , -- 02
  		CASE WHEN a.moinstser = 'ICAP' or  a.moinstser = 'ICOL'    THEN 'CP'
   	             WHEN a.motipoper = 'IC'   AND monumdocu <> monumdocuo THEN 'RIC'
                     WHEN a.motipoper = 'TM'   AND a.motipopero = 'CP'     THEN 'TMCP' 
		     WHEN a.motipoper = 'TM'   AND a.motipopero = 'VI'     THEN 'TMCP'--'TMVI' 
   		     ELSE a.motipoper
   		END   , -- 03
  		a.monumoper                     , -- 04
  		a.mocorrela   , -- 05
  		   CASE WHEN moinstser = 'ICAP' AND DATEDIFF(day,mofecemi,mofecven) > 365 THEN 'ICAP'
 			WHEN moinstser = 'ICOL' AND DATEDIFF(day,mofecemi,mofecven) > 365 THEN 'ICOL'
   			WHEN motipoper = 'IB'  THEN a.moinstser
   			WHEN motipoper = 'IC'  THEN ''
   			WHEN motipoper = 'VIC' THEN ''
   			WHEN motipoper = 'AIC' THEN ''
   		        ELSE b.inserie
   		   END   , -- 06
  		CASE a.motipoper
   			WHEN 'CP'  THEN CONVERT( CHAR(06), a.momonemi )
   			WHEN 'VP'  THEN CONVERT( CHAR(06), a.momonemi )
   			WHEN 'VIC' THEN CONVERT( CHAR(06), a.momonemi )
   			WHEN 'IC'  THEN CONVERT( CHAR(06), a.momonemi )
			WHEN 'TM'  THEN CONVERT( CHAR(06), a.momonemi )
   		        ELSE CONVERT( CHAR(06), a.momonpact )
   		END   , -- 07

  		CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0
  		     ELSE CASE a.motipoper WHEN 'IB' THEN a.movalinip 
		     			   ELSE CASE WHEN a.motipoper = 'CI' AND momonpact not in(999,998,997,994) THEN a.movalinip
						     ELSE a.movalcomp
						END 
		          END

   		END   , -- 08
           
  		CASE	WHEN a.motipoper = 'RC' THEN a.movpresen   --a.movalvenp
   			WHEN a.motipoper = 'RV' THEN a.movalvenp
   			WHEN a.motipoper = 'VI' THEN (a.movalcomp + a.mointeres + a.moreajuste)
                        WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN (a.movalcomp + a.mointeres + a.moreajuste)
                        WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movpresen -- a.movaltasemi

   		ELSE a.movpresen
   		END   , -- 09
  		CASE WHEN a.motipoper = 'RC' THEN a.movalinip ELSE a.movalven END   , -- 10
  		a.moutilidad   , -- 11
  		ABS(a.moperdida)   , -- 12

  		CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0
   		     ELSE mointeres
   		END   , -- 13
  		CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0   
   		     ELSE moreajuste
   		END   , -- 14
  		CASE WHEN (motipoper = 'VI'  AND morutcli = @rut_central) THEN 0 
   			WHEN motipoper = 'RC' THEN mointpac
   			WHEN motipoper = 'RV' THEN a.mointeresp --a.movalvenp-a.movalven --> Revisar. 09-09-2009
   		ELSE a.mointeres
   		END   , -- 15 (interes pacto)
  		CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0 
   			WHEN motipoper = 'RC' THEN moreapac
   			WHEN motipoper = 'RV' THEN moreapac
   		ELSE a.moreajuste
   		END   , -- 16 (reajuste pacto)
  		0.0    , -- 17
                CASE WHEN a.motipoper = 'VI' THEN a.movalcomp             
                     WHEN a.motipoper = 'RC' THEN a.movalcomp   
   		ELSE a.movalvenp
                END,   -- 18
  		a.moutilidad , -- 19 (Dif pacto pos)
  		a.moperdida , -- 20 (Dif Pacto neg  VBARRA 31/05/2000)
		CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb > 0 THEN ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob /100),0)END),a.modifsb)		
			WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb > 0 THEN (ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb) * -1)	
			WHEN a.motipoper = 'TM' AND a.modifsb = 0 THEN 0. 
			ELSE a.moutilidad END ,-- 21 (Valor Mercado pos) 
		CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb < 0 THEN (ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob /100),0) END ),a.modifsb) * -1)	
			WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb < 0 THEN ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),a.modifsb)
			ELSE a.moutilidad  END  , -- 22 (valor Mercado neg)

		'condPacto' = CASE WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli  = 97029000 THEN
			   CASE WHEN a.moforpagi  = 124 AND a.moforpagv  = 124 THEN '1'
                           	WHEN a.moforpagi  = 128 AND a.moforpagv  = 128 THEN '2'
                           	WHEN a.moforpagi  = 129 AND a.moforpagv  = 129 THEN '3'
                           	WHEN a.moforpagi  = 130 AND a.moforpagv  = 130 THEN '4'
                           	WHEN a.moforpagi  = 132 AND a.moforpagv  = 132 THEN '5'
                           	WHEN a.moforpagi  = 133 AND a.moforpagv  = 133 THEN '6'
                           	WHEN a.moforpagi  = 134 AND a.moforpagv  = 134 THEN '22'
                           	WHEN a.moforpagi  = 135 AND a.moforpagv  = 135 THEN '23'
                           	WHEN a.moforpagi  = 136 AND a.moforpagv  = 136 THEN '24'
                           	WHEN a.moforpagi  = 137 AND a.moforpagv  = 137 THEN '25'
                           	WHEN a.moforpagi  = 138 AND a.moforpagv  = 138 THEN '26'
                           	WHEN a.moforpagi  = 139 AND a.moforpagv  = 139 THEN '27'
                           	ELSE 						    '7'
			   END		 
			   WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli  = 1 THEN
			   CASE WHEN a.moforpagi  = 124 AND a.moforpagv  = 124 THEN '8'
                           	WHEN a.moforpagi  = 128 AND a.moforpagv  = 128 THEN '9'
                           	WHEN a.moforpagi  = 129 AND a.moforpagv  = 129 THEN '10'
                           	WHEN a.moforpagi  = 130 AND a.moforpagv  = 130 THEN '11'
                           	WHEN a.moforpagi  = 132 AND a.moforpagv  = 132 THEN '12'
                           	WHEN a.moforpagi  = 133 AND a.moforpagv  = 133 THEN '13'
                           	WHEN a.moforpagi  = 134 AND a.moforpagv  = 134 THEN '28'
                           	WHEN a.moforpagi  = 135 AND a.moforpagv  = 135 THEN '29'
                           	WHEN a.moforpagi  = 136 AND a.moforpagv  = 136 THEN '30'
                           	WHEN a.moforpagi  = 137 AND a.moforpagv  = 137 THEN '31'
                           	WHEN a.moforpagi  = 138 AND a.moforpagv  = 138 THEN '32'
                           	WHEN a.moforpagi  = 139 AND a.moforpagv  = 139 THEN '33'
                           	ELSE 						 '14'
			   END		 
			   WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN
		           CASE WHEN a.moforpagi  = 124 AND a.moforpagv  = 124 THEN '15'
                           	WHEN a.moforpagi  = 128 AND a.moforpagv  = 128 THEN '16'
                           	WHEN a.moforpagi  = 129 AND a.moforpagv  = 129 THEN '17'
                           	WHEN a.moforpagi  = 130 AND a.moforpagv  = 130 THEN '18'
                           	WHEN a.moforpagi  = 132 AND a.moforpagv  = 132 THEN '19'
                           	WHEN a.moforpagi  = 133 AND a.moforpagv  = 133 THEN '20'
                           	WHEN a.moforpagi  = 134 AND a.moforpagv  = 134 THEN '34'
                           	WHEN a.moforpagi  = 135 AND a.moforpagv  = 135 THEN '35'
   	                        WHEN a.moforpagi  = 136 AND a.moforpagv  = 136 THEN '36'
                           	WHEN a.moforpagi  = 137 AND a.moforpagv  = 137 THEN '37'
                           	WHEN a.moforpagi  = 138 AND a.moforpagv  = 138 THEN '38'
                           	WHEN a.moforpagi  = 139 AND a.moforpagv  = 139 THEN '39'
                           	ELSE 						    '21'
			   END                         
			   WHEN a.motipoper <> 'RC' AND a.motipoper <> 'VI' AND a.motipoper <> 'RCA' THEN A.mocondpacto
                 END,		--23

                CASE WHEN @RUT_CORPBNC = a.morutemi THEN '1' ELSE '2' END   ,--24
  		CASE WHEN motipoper = 'RC' OR motipoper = 'RV' THEN CONVERT( CHAR(06), moforpagv )
   		     ELSE                                                                  CONVERT(CHAR(06),a.moforpagi)
   		END   				, -- 25 (Forma de pago)

  		ISNULL( e.emgeneric, '' )       , -- 26 (Generico de emisor)
  		CASE WHEN motipoper ='RV' or motipoper ='CI' THEN a.monominalp --a.monominal
   		     ELSE a.monominalp
   		END   				, -- 27 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran
  		a.moforpagv        		, -- 28 --ZZZ
  		CASE WHEN motipoper <> 'IC' THEN a.motipobono
   			ELSE ( SELECT tipo_deposito
    			FROM GEN_CAPTACION
    			WHERE  numero_operacion  = monumoper
    			AND    correla_operacion = mocorrela )
   		END   				, -- 29 (Tipo Bono)
  		--> [Original SIN USO] 'condicion_entrega' = CASE WHEN a.motipoper = 'CP' THEN mocondpacto ELSE a.modcv END, -- 30
                'condicion_entrega' = CASE WHEN (a.moforpagi = 128 or a.moforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END
                                           WHEN (a.moforpagi = 129 or a.moforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END
                                           WHEN (a.moforpagi = 130 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END
                                           WHEN (a.moforpagi = 132 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END
                                           WHEN (a.moforpagi = 133 or a.moforpagv = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5  ELSE 16 END
                                           WHEN (a.moforpagi = 134 or a.moforpagv = 134) THEN CASE WHEN c.cltipcli = 1 THEN 6  ELSE 17 END
                                           WHEN (a.moforpagi = 135 or a.moforpagv = 135) THEN CASE WHEN c.cltipcli = 1 THEN 7  ELSE 18 END
                                           WHEN (a.moforpagi = 136 or a.moforpagv = 136) THEN CASE WHEN c.cltipcli = 1 THEN 8  ELSE 19 END
                                           WHEN (a.moforpagi = 137 or a.moforpagv = 137) THEN CASE WHEN c.cltipcli = 1 THEN 9  ELSE 20 END
                                           WHEN (a.moforpagi = 138 or a.moforpagv = 138) THEN CASE WHEN c.cltipcli = 1 THEN 10 ELSE 21 END
                                           WHEN (a.moforpagi = 139 or a.moforpagv = 139) THEN CASE WHEN c.cltipcli = 1 THEN 11 ELSE 22 END
                                           WHEN (a.moforpagi =   2 or a.moforpagv =   2) THEN 23
    WHEN (a.moforpagi =   3 or a.moforpagv =   3) THEN 24
                                           WHEN (a.moforpagi =   5 or a.moforpagv =   5) THEN 25
                                           WHEN (a.moforpagi =   6 or a.moforpagv =   6) THEN 26
                                           WHEN (a.moforpagi =   7 or a.moforpagv =   7) THEN 27
                                           WHEN (a.moforpagi =   8 or a.moforpagv =   8) THEN 28
                                           WHEN (a.moforpagi =  11 or a.moforpagv =  11) THEN 29
                                           WHEN (a.moforpagi =  12 or a.moforpagv =  12) THEN 30
                                           WHEN (a.moforpagi =  13 or a.moforpagv =  13) THEN 31
                                           WHEN (a.moforpagi =  14 or a.moforpagv =  14) THEN 32
                                           WHEN (a.moforpagi =  15 or a.moforpagv =  15) THEN 33
                                           WHEN (a.moforpagi =  16 or a.moforpagv =  16) THEN 34
                                           WHEN (a.moforpagi =  17 or a.moforpagv =  17) THEN 35
                                           WHEN (a.moforpagi =  19 or a.moforpagv =  19) THEN 36
                                           WHEN (a.moforpagi =  20 or a.moforpagv =  20) THEN 37
                                           WHEN (a.moforpagi = 100 or a.moforpagv = 100) THEN 38
                                           WHEN (a.moforpagi = 102 or a.moforpagv = 102) THEN 39
                                           WHEN (a.moforpagi = 103 or a.moforpagv = 103) THEN 40
                                           WHEN (a.moforpagi = 104 or a.moforpagv = 104) THEN 41
                                           WHEN (a.moforpagi = 105 or a.moforpagv = 105) THEN 42
                                           WHEN (a.moforpagi = 106 or a.moforpagv = 106) THEN 43
                                           WHEN (a.moforpagi = 118 or a.moforpagv = 118) THEN 44
                                           WHEN (a.moforpagi = 122 or a.moforpagv = 122) THEN 45
                                           WHEN (a.moforpagi = 123 or a.moforpagv = 123) THEN 46
                                           WHEN (a.moforpagi = 124 or a.moforpagv = 124) THEN 47
                                           WHEN (a.moforpagi = 125 or a.moforpagv = 125) THEN 48
                                           WHEN (a.moforpagi = 131 or a.moforpagv = 131) THEN 49
                                           WHEN (a.moforpagi = 140 or a.moforpagv = 140) THEN 50
                                           WHEN (a.moforpagi = 141 or a.moforpagv = 141) THEN 51
                                           WHEN (a.moforpagi = 142 or a.moforpagv = 142) THEN 52
                                           WHEN (a.moforpagi = 143 or a.moforpagv = 143) THEN 53
                                           ELSE                                               0
                                       END, -- 30

  		CASE WHEN SUBSTRING( a.motipopero, 1, 2 ) = 'CI' THEN '1'
   		ELSE '2'
   		END   				, -- 31
  		moinstser,                        -- 32
  		monumdocu,                        -- 33
  		CASE WHEN a.moinstser = 'ICAP' THEN CONVERT( VARCHAR(10), morutcli )
   		ELSE CONVERT( VARCHAR(10), morutemi )
   		END   ,   -- 34
  		motipopero,                       -- 35 
  		movalvenp,                        -- 36
		'clasificacion_cliente' = CASE	WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'
       						WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'
						WHEN motipoper <> 'IB'                           THEN '0'
						ELSE --- interbancarios ---
							CASE	WHEN morutcli  = 97029000                                          THEN '9'
								WHEN morutcli  = 97030000 AND moforpagi = 128 AND moforpagv = 128  THEN '10' 
								WHEN morutcli <> 97030000 AND moforpagi = 128 AND moforpagv = 128 THEN '11' 
								WHEN morutcli  = 97030000 AND moforpagi = 129 AND moforpagv = 129  THEN '12' 
								WHEN morutcli <> 97030000 AND moforpagi = 129 AND moforpagv = 129  THEN '13' 
								WHEN morutcli  = 97030000 AND moforpagi = 130 AND moforpagv = 130  THEN '14' 
								WHEN morutcli <> 97030000 AND moforpagi = 130 AND moforpagv = 130  THEN '15' 
								WHEN morutcli  = 97030000 AND moforpagi = 132 AND moforpagv = 132  THEN '16' 
								WHEN morutcli <> 97030000 AND moforpagi = 132 AND moforpagv = 132  THEN '17' 
								WHEN morutcli  = 97030000 AND moforpagi = 133 AND moforpagv = 133  THEN '18' 
								WHEN morutcli <> 97030000 AND moforpagi = 133 AND moforpagv = 133  THEN '19' 
								WHEN morutcli  = 97030000 AND moforpagi = 134 AND moforpagv = 134  THEN '20' 
								WHEN morutcli <> 97030000 AND moforpagi = 134 AND moforpagv = 134  THEN '21' 
								WHEN morutcli  = 97030000 AND moforpagi = 135 AND moforpagv = 135  THEN '22' 
								WHEN morutcli <> 97030000 AND moforpagi = 135 AND moforpagv = 135  THEN '23' 
								WHEN morutcli  = 97030000 AND moforpagi = 136 AND moforpagv = 136  THEN '24' 
								WHEN morutcli <> 97030000 AND moforpagi = 136 AND moforpagv = 136  THEN '25' 
								WHEN morutcli  = 97030000 AND moforpagi = 137 AND moforpagv = 137  THEN '26' 
								WHEN morutcli <> 97030000 AND moforpagi = 137 AND moforpagv = 137  THEN '27' 
								WHEN morutcli  = 97030000 AND moforpagi = 138 AND moforpagv = 138  THEN '28' 
								WHEN morutcli <> 97030000 AND moforpagi = 138 AND moforpagv = 138  THEN '29' 
								WHEN morutcli  = 97030000 AND moforpagi = 139 AND moforpagv = 139  THEN '30' 
								WHEN morutcli <> 97030000 AND moforpagi = 139 AND moforpagv = 139  THEN '31' 
								WHEN morutcli  = 97030000                                          THEN '1'
								WHEN morutcli <> 97030000                                          THEN '5'
								ELSE                                                                    '0'
							END
						END,   -- 37
		CASE WHEN mointeres < 0 THEN (mointeres *-1) ELSE 0 END,
  		CASE WHEN moreajuste < 0 THEN (moreajuste *-1) ELSE 0 END,
  		CASE WHEN motipoper = 'IB' THEN (CASE WHEN datediff(dd,mofecinip,mofecvenp) > 365 THEN 2 ELSE 1 END)
   		     ELSE datediff(dd,mofecinip,mofecvenp)
   		END,
  		morutcli,
  		mocodcli,
  		mofecpro,
  		ROUND(monominal,0),															
     		'valor_tasa_emision'  = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper='VP' THEN a.movaltasemi
                                             WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper='VP' THEN 0                                              
                                             WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper='CP' THEN a.movaltasemi ELSE a.movalcomp 
                                        END,
      		'prima_total'         = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,
      		'descuento_total'     = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc < 0 THEN (a.moprimadesc*-1) ELSE 0 END,
    		'prima_dia'           = 0,
      		'descuento_dia'       = 0,
		'valor_pte_emision'   = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') THEN a.movaltasemi ELSE 0 END,
		'dif_par_pos'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali > 0 THEN a.mocapitali ELSE 0 END	,
		'dif_par_neg'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali < 0 THEN (a.mocapitali*-1) ELSE 0 END
	,	'TIPO_CARTERA'		= 0		
	,	'CondPactoCliente'	= CASE	WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN '1'
						WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli  = 1 THEN '2'
						WHEN a.motipopero <> 'CI' AND a.morutcli  = 97029000 AND c.cltipcli  = 1 THEN '3'
						WHEN a.motipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'
						WHEN a.motipopero  = 'CI' AND c.cltipcli  = 1                            THEN '5'
						ELSE '0' END
	,	'EstadoObjeto'	=	CASE	WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' THEN (CASE WHEN ISNULL(VM.PorcjeCob,0)  <> 0 THEN 'CBTO' ELSE 'DCBTO' END )
						WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' THEN (CASE WHEN ISNULL(VMA.PorcjeCob,0) <> 0 THEN 'CBTO' ELSE 'DCBTO' END )
						WHEN a.motipoper <> 'TM' THEN '' END
        ,       'Tipo_Bono'     = CASE WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi  = @iRutAdmCorp THEN 1
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi  = @iRutAdmCorp THEN 2
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi  = @iRutAdmCorp THEN 3
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi  = @iRutAdmCorp THEN 4
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi  = @iRutAdmCorp THEN 5
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi <> @iRutAdmCorp THEN 6
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi <> @iRutAdmCorp THEN 7
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi <> @iRutAdmCorp THEN 8
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi <> @iRutAdmCorp THEN 9
                                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi <> @iRutAdmCorp THEN 10
                                       ELSE                                                                                     0   
                                   END 
	FROM	dbo.MDMO_EXTRA			a	LEFT JOIN VALORIZACION_MERCADO VM	ON	a.motipoper		= 'TM'
											AND	VM.fecha_valorizacion	= @FechaBusquedaValorizacion
											AND	VM.id_sistema		= 'BTR'
											AND	VM.rmnumoper		= a.monumoper
											AND	VM.rmnumdocu		= a.monumdocu
											AND	VM.rmcorrela		= a.mocorrela

						LEFT JOIN VALORIZACION_MERCADO VMA	ON	a.motipoper		= 'TM'
											AND	VMA.fecha_valorizacion	= @FechaBusquedaValorizacionAyer
											AND	VMA.id_sistema		= 'BTR'
											AND	VMA.rmnumoper		= a.monumoper
											AND	VMA.rmnumdocu		= a.monumdocu
											AND	VMA.rmcorrela		= a.mocorrela
						LEFT JOIN VIEW_EMISOR		e	ON	e.emrut			= a.morutemi
						LEFT JOIN VIEW_INSTRUMENTO	b	ON	b.incodigo		= a.mocodigo
	,	VIEW_CLIENTE		c
	,	MDAC			m
	WHERE	a.mofecpro	=  @fecha_hoy
	AND	a.mostatreg	<> 'A'
	AND	a.motipoper	NOT IN('RCA','RVA','CPP','FLI', 'VFM' )
	AND	(c.clrut	=  a.morutcli AND c.clcodigo = a.mocodcli )

	IF @@ERROR <> 0 BEGIN
		SET NOCOUNT OFF
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
		RETURN 1
	END



   SET NOCOUNT OFF

   RETURN 0

END

GO
