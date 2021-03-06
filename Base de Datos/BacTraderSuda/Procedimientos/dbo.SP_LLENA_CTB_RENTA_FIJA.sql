USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CTB_RENTA_FIJA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CTB_RENTA_FIJA]
	(	@Fecha_Hoy	DATETIME	)
AS
BEGIN
      
	SET NOCOUNT ON      
	
		-->		Lee el Sw de Configuracion de Garantias
	DECLARE @iActivaCicloGarantias	INT
	SELECT	@iActivaCicloGarantias	= BacTraderSuda.dbo.Fx_Sw_Garantias(4)
	-->		Si @iActivaCicloGarantias = 0 ; esta Apagado	Garantias
	-->		Si @iActivaCicloGarantias = 1 ; esta Encendido	Garantias


	DECLARE @Fecha_Ant DATETIME      
	DECLARE @Fecha_prox DATETIME      
	DECLARE @Control_Error INTEGER      
	DECLARE @Valor_Observado FLOAT      
	DECLARE @Rut_Central NUMERIC(10)      
	DECLARE @Habil CHAR(1)      
	DECLARE @Fecha_Paso DATETIME      
	DECLARE @VVISTA CHAR(4)      
	DECLARE @rut_estado NUMERIC(10)      
	DECLARE @RUT_CLIENTE NUMERIC(10)        
	DECLARE @RUT_CORPBNC NUMERIC(10)      
	DECLARE @Correla NUMERIC(05)      
	
	DECLARE @iRutAdmCorp NUMERIC(10)      
	SET @iRutAdmCorp = 96513630      
	
   SELECT  @Fecha_Ant = acfecante      
   ,    @fecha_prox = acfecprox      
   FROM    MDAC         with (nolock)      
	
   SET     @Valor_Observado = isnull((SELECT ISNULL(vmvalor, 1.0) FROM VIEW_VALOR_MONEDA with (nolock) WHERE vmcodigo = 994 AND vmfecha = @Fecha_Hoy),1.0)      
   SET     @Rut_Central     = isnull((SELECT ISNULL(folio, 0)     FROM GEN_FOLIOS        with (nolock) WHERE codigo   = 'RUTBCCH'),0)      
	SET @Rut_estado = 97030000      
	SET @rut_Central = 97029000      
   SET     @RUT_CLIENTE     = (SELECT acrutprop FROM MDAC         with (nolock) )      
   SET     @RUT_CORPBNC     = (SELECT rcrut     FROM VIEW_ENTIDAD with (nolock) )      
	
	/*=======================================================================*/ 
	/* LIMPIA ARCHIVO DE CONTABILIZACION                                     */ 
	/*=======================================================================*/ 
	TRUNCATE TABLE BAC_CNT_ERRORES      
	
	DELETE FROM BAC_CNT_CONTABILIZA
	
	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF
	    RAISERROR('¡ Err. Falla Borrando Archivo Contabiliza Renta Fija Nacional.... ! ',16,6,'ERROR.')
	    PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (RENTA FIJA).'
	    RETURN 1
	END 

	DELETE	FROM	BAC_CNT_CONTABILIZA_HISTORICA
			WHERE	FechaContable	= (	select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
	
	if @@error <> 0
		begin
			RAISERROR('¡ Err. Falla Borrando Archivo Contabiliza Renta Fija Nacional Historico.... ! ',16,6,'ERROR.')
			RETURN 1
		end
	
	/*======================================================================================================*/ 
	-- Busca fecha de ultimo dia del mes en fin de mes no habil, cuANDo es primer dia del mes.      
	/*======================================================================================================*/ 
	-------------------------------------------------------Tasa de Mercado---------------------------------------------------------      
	DECLARE @feriado NUMERIC(01)      
	DECLARE @feriadoIniMes NUMERIC(01)      
	DECLARE @dfecfmes DATETIME      
	DECLARE @dfecImes DATETIME      
	DECLARE @indi NUMERIC(01)       
	DECLARE @FechaTMAyer DATETIME      
	DECLARE @FechaTMHoy DATETIME      
	DECLARE @BorraTM INTEGER      
	DECLARE @Mov_Rev INTEGER      
	
	SET @dfecfmes = DATEADD(DAY, DATEPART(DAY, @Fecha_prox) * -1, @Fecha_prox)      
   SET     @dfecImes        = DATEADD(DAY, DATEPART(DAY, @Fecha_Hoy)  * -1, DATEADD(DAY, 1, @Fecha_Hoy))      
	
	EXECUTE SP_FERIADO @dfecfmes,6 , @feriado OUTPUT 
	EXECUTE SP_FERIADO @dfecImes,6 , @feriadoIniMes OUTPUT      
	
	IF DATEPART(MONTH, @Fecha_Hoy) <> DATEPART(MONTH, @Fecha_Ant)
	BEGIN
      SET @FechaTMAyer = DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8), @Fecha_Hoy, 112), 1, 6) + '01')      
   END ELSE       
	BEGIN
	    SET @FechaTMAyer = @Fecha_Ant
	END      
	
	IF DATEPART(MONTH, @Fecha_Hoy) <> DATEPART(MONTH, @Fecha_Prox)
	BEGIN
      SET @FechaTMHoy = DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8),@Fecha_Prox,112),1,6) + '01')      
   END ELSE       
	BEGIN
	    SET @FechaTMHoy = @Fecha_Hoy
	END 
	
	--> INSERTA EN LA MDMO LA REVERSA DE LAS TM DEL DIA ANTERIOR      
	SET @BorraTM = 1 -->  1 = ELIMINA TASAS DE MERCADO DE LA MDMO      
	SET @Mov_Rev = -1 --> -1 = REVERSA      
	
	EXECUTE SP_CONTABILIZASBIF @FechaTMAyer, @BorraTM, @Mov_Rev 
	
	--> INSERTA EN LA MDMO LAS TM DEL DIA      
	SET @BorraTM = 0 --> 1 = ELIMINA TASAS DE MERCADO DE LA MDMO      
	SET @Mov_Rev = 1 --> 1 = MOVIMIENTO DEL DIA      
	
	EXECUTE SP_CONTABILIZASBIF @FechaTMHoy, @BorraTM, @Mov_Rev 
	
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
	
	/***********************************************************************************************************
	 +++VBF 12/09/2018  SE REVALIDA CAMPO DE CONDICION PARA ANULACION DE OPERACIONES PM Y CN
	 ***********************************************************************************************************/ 
		UPDATE mdmopm 
		   SET mocondpacto = CASE WHEN mofecpro <= m.acfecante  thEN 'X' ELSE 'H' END  
		  FROM MDMOPM a, 
		       MDAC   m      
		 WHERE  a.mostatreg = 'A'
		   AND a.motipoper IN ('CP', 'VP')
		   AND a.Fecha_PagoMañana = acfecproc
		   AND a.SorteoLCHR = 'N'
		   AND a.PagoMañana = 'S'
	/*********************************************************************************************************
	 ---VBF 12/09/2018  SE REVALIDA CAMPO DE CONDICION PARA ANULACION DE OPERACIONES PM Y CN   
	 *********************************************************************************************************/ 


	/*=======================================================================*/ 
	/* Clasifica las operaciones de pactos y tipos de BONOS para Renta Fija */ 
	/*=======================================================================*/ 
	
	EXECUTE @Control_Error = SP_ACTUALIZA_MDMO      
	
	IF @Control_Error <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RETURN 1
	END 

	if @iActivaCicloGarantias = 1	--> Activa el Ciclo de Garantias
	begin
		SET @Control_Error = 0
		EXECUTE @Control_Error = dbo.SP_LLENA_CONTABILIZA_GARANTIAS @Fecha_Hoy
		
		if @Control_Error <> 0
		begin
			set nocount off

			if @Control_Error = -1
				print 'Error en limpiar  registros de movimientos de garatias.'
			if @Control_Error = -2
				print 'Error en Insertar registros de movimientos de garatias.'
			if @Control_Error = -3
				print 'Error en Insertar registros para revalorizacion de garatias.'
			if @Control_Error = -4
				print 'Error en Insertar registros para alzamientos por intercambio'
			if @Control_Error = -5
				print 'Error en Insertar registros para alzamientos de vencimientos naturales'

			return -1
		end
	end							--> Activa el Ciclo de Garantias
	
	
	/*=======================================================================*/ 
	/* Clasifica las operaciones de pactos y tipos de BONOS para Renta Fija */ 
	/*=======================================================================*/ 
	
	EXECUTE @Control_Error = SP_ACTUALIZA_MDRS @Fecha_Hoy, @fecha_prox      
	
	IF @Control_Error <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RETURN 1
	END      
	
	
	SELECT * 
	       INTO #TMP_MDRS
	FROM   MDRS
	WHERE  rsfecha >= @Fecha_Hoy
	       AND rsfecha < @fecha_prox 
	
	/***************************************************************************************************************/ 
	/******************************* ACTUALIZA PORCENTAJE COBERTURA VALORIZACION MERCADO ***************************/ 
	/***************************************************************************************************************/      
	
	DECLARE @FechaBusquedaValorizacion DATETIME      
	DECLARE @FechaBusquedaValorizacionAyer DATETIME      
	
	IF DATEPART(MONTH, @fecha_hoy) <> DATEPART(MONTH, @Fecha_Prox)
	BEGIN
	    SET @FechaBusquedaValorizacion = DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8), @Fecha_Prox, 112), 1, 6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL
   END ELSE       
	BEGIN
	    SET @FechaBusquedaValorizacion = @fecha_hoy --FECHA HOY
	END      
	
	IF DATEPART(MONTH, @Fecha_Ant) <> DATEPART(MONTH, @fecha_hoy)
	BEGIN
	    SET @FechaBusquedaValorizacionAyer = DATEADD(DAY, -1,SUBSTRING(CONVERT(CHAR(8), @fecha_hoy, 112), 1, 6) + '01') --FIN DE MES (ANTERIOR) HABIL O NO HABIL
   END ELSE       
	BEGIN
	    SET @FechaBusquedaValorizacionAyer = @fecha_Ant
	END      
	
	UPDATE VALORIZACION_MERCADO
	SET    PorcjeCob = (nMontoCubrir * 100) / valor_nominal
   FROM   VALORIZACION_MERCADO A      
   ,   DETALLE_COBERTURAS B      
	WHERE  A.fecha_valorizacion = @FechaBusquedaValorizacion
	       AND A.id_sistema = 'BTR'
	       AND B.cSistema = A.id_sistema
	       AND B.nDocumento = A.rmnumdocu
	       AND B.nCorrelativo = A.rmcorrela
	       AND A.rmnumoper = B.nDocumento 
	
	/*=======================================================================*/ 
	/* Llena Renta Fija operaciones                                         */ 
	/*=======================================================================*/      
	INSERT INTO BAC_CNT_CONTABILIZA
   (    id_sistema      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06  
	    moneda_instrumento,	-- 07    
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    valor_comprahis,	-- 18      
	    dif_ant_pacto_pos,	-- 19      
	    dif_ant_pacto_neg,	-- 20      
	    dif_valor_mercado_pos,	-- 21      
	    dif_valor_mercado_neg,	-- 22      
	    condicion_pacto,	-- 23      
	    tipo_cliente,	-- 24      
	    forma_pago,	-- 25      
	    tipo_emisor,	-- 26      
	    nominalpesos,	-- 27      
	    forma_pago_entregamos,	-- 28      
	    tipo_instrumento,	-- 29      
	    condicion_entrega,	-- 30      
	    tipo_operacion_or,	-- 31      
	    instser,	-- 32      
	    documento,	-- 33      
	    emisor,	-- 34      
	    cartera_origen,	-- 35      
	    valor_final,	-- 36      
	    clasificacion_cliente,	-- 37 -- aca      
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    Tipo_Cartera,
	    CondPactoCliente,
	    EstObj,
	    Tipo_Bono,

		Utilidad_Avr_Patrimonio		,		--> Ventas AFS
		Perdida_Avr_Patrimonio		,		--> Ventas AFS
		Diferencia_Precio_Pos		,		--> Ventas AFS
		Diferencia_Precio_Neg				--> Ventas AFS
	  )
	SELECT 'BTR',	-- 01      
		   CASE WHEN a.motipoper = 'TM' THEN 'TMF'       
	            ELSE 'MOV'
	       END,	-- 02      
		   CASE WHEN a.moinstser = 'ICAP' or  a.moinstser = 'ICOL'  THEN 'CP'      
	            WHEN a.motipoper = 'IC' AND monumdocu <> monumdocuo THEN 'RIC'
	            WHEN a.motipoper = 'TM' AND a.motipopero = 'CP'		THEN 'TMCP'
	            WHEN a.motipoper = 'TM' AND a.motipopero = 'VI'		THEN 'TMCP'--'TMVI'
	            ELSE a.motipoper
	       END,	-- 03      
	       a.monumoper,	-- 04      
	       a.mocorrela,	-- 05      
		   CASE WHEN moinstser = 'ICAP' AND DATEDIFF(day,mofecemi,mofecven) > 365 THEN 'ICAP'      
				WHEN moinstser = 'ICOL' AND DATEDIFF(day,mofecemi,mofecven) > 365 THEN 'ICOL'      
	            WHEN motipoper = 'IB' THEN a.moinstser
	            WHEN motipoper = 'IC' THEN ''
	            WHEN motipoper = 'RIC' THEN ''
	            WHEN motipoper = 'VIC' THEN ''
	            WHEN motipoper = 'AIC' THEN ''
	            ELSE b.inserie
	       END,	-- 06      
	       CASE a.motipoper
	            WHEN 'CP' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'VP' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'VIC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'IC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'RIC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'TM' THEN CONVERT(CHAR(06), a.momonemi)
	            ELSE CONVERT(CHAR(06), a.momonpact)
	       END,	-- 07      
	       
    CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0      
         ELSE CASE a.motipoper WHEN 'IB' THEN a.movalinip 
           ELSE CASE WHEN a.motipoper = 'CI' AND momonpact not in(999,998,997,994) THEN a.movalinip      
	                                ELSE a.movalcomp
	                           END
	                 END
      
	       END,	-- 08      
	       
    CASE WHEN a.motipoper = 'RC' THEN a.movpresen   --a.movalvenp      
	            WHEN a.motipoper = 'RV' THEN a.movalvenp
	            WHEN a.motipoper = 'VI' THEN (a.movalcomp + a.mointeres + a.moreajuste)
                WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN (a.movalcomp + a.mointeres + a.moreajuste)      
                WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movpresen -- a.movaltasemi      
	            ELSE a.movpresen
	       END,	-- 09      
	       
		CASE	WHEN a.motipoper = 'RC' THEN a.movalinip 
				ELSE a.movalven 
				END   , -- 10
	       a.moutilidad,	-- 11      
	       ABS(a.moperdida),	-- 12      
	       
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0      
	            ELSE mointeres
	       END,	-- 13      
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0         
	            ELSE moreajuste
	       END,	-- 14      
    CASE WHEN (motipoper = 'VI'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN mointpac
	            WHEN motipoper = 'RV' THEN a.mointeresp --a.movalvenp-a.movalven --> Revisar. 09-09-2009
	            ELSE a.mointeres
	 END,	-- 15 (interes pacto)      
    CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN moreapac
	            WHEN motipoper = 'RV' THEN moreapac
	            ELSE a.moreajuste
	       END,	-- 16 (reajuste pacto)      
	       0.0,	-- 17      
                CASE WHEN a.motipoper = 'VI' THEN a.movalcomp                   
	            WHEN a.motipoper = 'RC' THEN a.movalcomp
	            ELSE a.movalvenp
	       END,	-- 18      
	       a.moutilidad,	-- 19 (Dif pacto pos)      
	       a.moperdida,	-- 20 (Dif Pacto neg  VBARRA 31/05/2000)      
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb > 0 THEN ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0) = 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END ),a.modifsb) 
                  WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb > 0 THEN (ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.modifsb = 0 THEN 0.
	            ELSE a.moutilidad END,	-- 21 (Valor Mercado pos)       
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb < 0 THEN (ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb < 0 THEN ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb)
 	            ELSE a.moutilidad END,	-- 22 (valor Mercado neg)      
	       
	       'condPacto' = CASE  WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli = 97029000 THEN 
                   CASE WHEN a.moforpagi = 124 AND a.moforpagv = 124 THEN '1'
	                             WHEN a.moforpagi  = 128 AND a.moforpagv = 128 THEN '2'
                                     WHEN a.moforpagi  = 129 AND a.moforpagv = 129 THEN '3'
                                     WHEN a.moforpagi  = 130 AND a.moforpagv = 130 THEN '4'
	            WHEN a.moforpagi  = 132 AND a.moforpagv = 132 THEN '5'
    WHEN a.moforpagi = 133 AND a.moforpagv = 133 THEN '6'
	                             WHEN a.moforpagi  = 134 AND a.moforpagv = 134 THEN '22'
	                             WHEN a.moforpagi  = 135 AND a.moforpagv = 135 THEN '23'
	                             WHEN a.moforpagi  = 136 AND a.moforpagv = 136 THEN '24'
	                             WHEN a.moforpagi = 137 AND a.moforpagv = 137 THEN '25'
	                             WHEN a.moforpagi = 138 AND a.moforpagv  = 138 THEN '26'
                                     WHEN a.moforpagi = 139 AND a.moforpagv = 139 THEN '27'
	                             ELSE '7'
	           END
                   WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli = 1 THEN 
                   CASE WHEN a.moforpagi = 124 AND a.moforpagv = 124 THEN '8'
	                                WHEN a.moforpagi = 128 AND a.moforpagv  = 128 THEN '9'
	                                WHEN a.moforpagi = 129 AND a.moforpagv = 129 THEN '10'
	    WHEN a.moforpagi = 130 AND a.moforpagv = 130 THEN '11'
	                                WHEN a.moforpagi = 132 AND a.moforpagv = 132 THEN '12'
	                                WHEN a.moforpagi = 133 AND a.moforpagv = 133 THEN '13'
	                                WHEN a.moforpagi = 134 AND a.moforpagv = 134 THEN '28'
	                                WHEN a.moforpagi = 135 AND a.moforpagv = 135 THEN '29'
	                                WHEN a.moforpagi = 136 AND a.moforpagv = 136 THEN '30'
	                                WHEN a.moforpagi = 137 AND a.moforpagv = 137 THEN '31'
	                                WHEN a.moforpagi = 138 AND a.moforpagv = 138 THEN '32'
	                                WHEN a.moforpagi = 139 AND a.moforpagv = 139 THEN '33'
	                                           ELSE '14'
	                                      END
      WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN      
             CASE WHEN a.moforpagi  = 124 AND a.moforpagv  = 124 THEN '15'      
	                                             WHEN a.moforpagi = 128 AND a.moforpagv  = 128 THEN '16'
	                                             WHEN a.moforpagi = 129 AND a.moforpagv  = 129 THEN '17'
	                                             WHEN a.moforpagi = 130 AND a.moforpagv  = 130 THEN '18'
	                                             WHEN a.moforpagi = 132 AND a.moforpagv  = 132 THEN '19'
	                                             WHEN a.moforpagi = 133 AND a.moforpagv  = 133 THEN '20'
						     WHEN a.moforpagi = 134 AND a.moforpagv  = 134 THEN '34'
	                                             WHEN a.moforpagi = 135 AND a.moforpagv  = 135 THEN '35'
	                                             WHEN a.moforpagi = 136 AND a.moforpagv  = 136 THEN '36'
	                                             WHEN a.moforpagi = 137 AND a.moforpagv  = 137 THEN '37'
	                                             WHEN a.moforpagi = 138 AND a.moforpagv  = 138 THEN '38'
	                                             WHEN a.moforpagi = 139 AND a.moforpagv  = 139 THEN '39'
	                                             ELSE '21'
	                                        END
      WHEN a.motipoper <> 'RC' AND a.motipoper <> 'VI' AND a.motipoper <> 'RCA' THEN A.mocondpacto      
	                     END,	--23      
	       
                CASE WHEN @RUT_CORPBNC = a.morutemi THEN '1' ELSE '2' END   ,--24      
    CASE WHEN motipoper = 'RC' OR motipoper = 'RV' THEN CONVERT( CHAR(06), moforpagv )      
	            ELSE CONVERT(CHAR(06), a.moforpagi)
	       END,	-- 25 (Forma de pago)      
	       
	       ISNULL(e.emgeneric, ''),	-- 26 (Generico de emisor)      
    CASE WHEN motipoper ='RV' or motipoper ='CI' THEN a.monominalp --a.monominal      
	            ELSE a.monominalp
	       END,	-- 27 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran      
	       a.moforpagv,	-- 28 --ZZZ      
    CASE WHEN motipoper <> 'IC' AND motipoper <> 'RIC' THEN a.motipobono      
      ELSE ( SELECT tipo_deposito      
	                     FROM   GEN_CAPTACION
	                     WHERE  numero_operacion = monumoper
       AND    correla_operacion = mocorrela )      
	       END,	-- 29 (Tipo Bono)
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
	                                  ELSE 0
	                             END,	-- 30      
	       
    CASE WHEN SUBSTRING( a.motipopero, 1, 2 ) = 'CI' THEN '1'      
	            ELSE '2'
	       END,	-- 31    
	       moinstser,	-- 32      
	       monumdocu,	-- 33      
    CASE WHEN a.moinstser = 'ICAP' THEN CONVERT( VARCHAR(10), morutcli )      
	            ELSE CONVERT(VARCHAR(10), morutemi)
	       END,	-- 34      
	       motipopero,	-- 35       
	       movalvenp,	-- 36      
  'clasificacion_cliente' = CASE WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'      
             WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'      
	                                      WHEN motipoper <> 'IB' THEN '0'
	                                      ELSE --- interbancarios ---      
       CASE WHEN morutcli  = 97029000                                          THEN '9'      
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
	                                                ELSE '0'
	                                           END
	                                 END,	-- 37      
  CASE WHEN mointeres < 0 THEN (mointeres *-1) ELSE 0 END,      
    CASE WHEN moreajuste < 0 THEN (moreajuste *-1) ELSE 0 END,      
    CASE WHEN motipoper = 'IB' THEN (CASE WHEN datediff(dd,mofecinip,mofecvenp) > 365 THEN 2 ELSE 1 END)      
          ELSE datediff(dd,mofecinip,mofecvenp)      
	       END,
	       morutcli,
	       mocodcli,
	       mofecpro,
	       ROUND(monominal, 0),
	       'valor_tasa_emision' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'VP' THEN a.movaltasemi
	              WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper= 'VP' THEN 0
	                                   WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'CP' THEN a.movaltasemi ELSE a.movalcomp
	                              END,
	       'prima_total' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,
	       'descuento_total' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc < 0 THEN (a.moprimadesc * -1) ELSE 0 END,
	       'prima_dia' = 0,
	       'descuento_dia' = 0,
	       'valor_pte_emision' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') THEN  a.movaltasemi ELSE 0 END,
	       'dif_par_pos' = CASE  WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo =  20 AND a.motipoper = 'VP' AND a.mocapitali > 0 THEN a.mocapitali ELSE 0 END,
  'dif_par_neg'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali < 0 THEN (a.mocapitali*-1) ELSE 0 END      
 , 'TIPO_CARTERA'  = 0        
 , 'CondPactoCliente' = CASE WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN '1'      
      WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli  = 1 THEN '2'      
      WHEN a.motipopero <> 'CI' AND a.morutcli  = 97029000 AND c.cltipcli  = 1 THEN '3'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli  = 1                            THEN '5'      
      ELSE '0' END      
 , 'EstadoObjeto' = CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' THEN (CASE WHEN ISNULL(VM.PorcjeCob,0)  <> 0 THEN 'CBTO' ELSE 'DCBTO' END )      
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
	                          ELSE 0
	                     END
	
	,	Utilidad_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) >= 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Perdida_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) < 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	
	/*
	,	Utilidad_Avr_Patrimonio		= case when a.Resultado_Dif_Mercado >= 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 
										
	,	Perdida_Avr_Patrimonio		= case when a.Resultado_Dif_Mercado < 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 

	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	*/
	
 FROM	MDMO   a LEFT JOIN VALORIZACION_MERCADO VM ON a.motipoper  = 'TM'      
				AND VM.tipo_operacion		<> 'CG'
	            AND VM.fecha_valorizacion	= @FechaBusquedaValorizacion
	            AND VM.id_sistema			= 'BTR'
	            AND VM.rmnumoper			= a.monumoper
	            AND VM.rmnumdocu			= a.monumdocu
	            AND VM.rmcorrela			= a.mocorrela
      
		LEFT JOIN VALORIZACION_MERCADO VMA ON a.motipoper  = 'TM'      
				AND VMA.tipo_operacion		<> 'CG'
	            AND VMA.fecha_valorizacion	= @FechaBusquedaValorizacionAyer
	            AND VMA.id_sistema			= 'BTR'
	            AND VMA.rmnumoper			= a.monumoper
	            AND VMA.rmnumdocu			= a.monumdocu
	            AND VMA.rmcorrela			= a.mocorrela

		LEFT JOIN VIEW_EMISOR  e ON e.emrut   = a.morutemi      
		LEFT JOIN VIEW_INSTRUMENTO b ON b.incodigo  = a.mocodigo      
	,	VIEW_CLIENTE  c      
	,	MDAC   m      
	WHERE	a.mofecpro		 = @fecha_hoy
	AND		a.mostatreg		<> 'A'
	AND		a.motipoper		NOT IN ('RCA', 'RVA', 'CPP', 'FLI', 'VFM', 'IC','RIC' )
	and		a.motipopero	<> 'CG'
	AND	(	c.clrut = a.morutcli AND c.clcodigo = a.mocodcli)
	AND		NOT EXISTS( SELECT 1 FROM MDMOPM f WHERE f.monumoper  = a.monumoper
												AND  f.monumdocu  = a.monumdocu
												AND  f.mocorrela  = a.mocorrela
												AND  f.monumdocuo = a.monumdocuo
												AND  f.mocorrelao = a.mocorrelao
												AND  f.mostatreg <> 'A')
	AND		 NOT EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.monumoper
												AND  l.LCGP_CORRELATIVO  = a.mocorrela
												)
	IF @@ERROR <> 0 
	BEGIN
		SET NOCOUNT OFF 
		RAISERROR('¡ Err. Falla Agregando Movimientos Renta Fija Archivo Contabiliza.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END

	
	/*=======================================================================*/ 
	/* inicio	:	valorizacion mercado cartera garantias					 */ 
	/*=======================================================================*/      

	INSERT INTO BAC_CNT_CONTABILIZA
   (    id_sistema      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03   
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06  
	    moneda_instrumento,	-- 07    
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    valor_comprahis,	-- 18      
	    dif_ant_pacto_pos,	-- 19      
	    dif_ant_pacto_neg,	-- 20      
	    dif_valor_mercado_pos,	-- 21      
	    dif_valor_mercado_neg,	-- 22      
	    condicion_pacto,	-- 23      
	    tipo_cliente,	-- 24      
	    forma_pago,	-- 25      
	    tipo_emisor,	-- 26      
	    nominalpesos,	-- 27      
	    forma_pago_entregamos,	-- 28      
	    tipo_instrumento,	-- 29      
	    condicion_entrega,	-- 30      
	    tipo_operacion_or,	-- 31      
	    instser,	-- 32      
	    documento,	-- 33      
	    emisor,	-- 34      
	    cartera_origen,	-- 35      
	    valor_final,	-- 36      
	    clasificacion_cliente,	-- 37 -- aca      
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    Tipo_Cartera,
	    CondPactoCliente,
	    EstObj,
	    Tipo_Bono,

		Utilidad_Avr_Patrimonio		,		--> Ventas AFS
		Perdida_Avr_Patrimonio		,		--> Ventas AFS
		Diferencia_Precio_Pos		,		--> Ventas AFS
		Diferencia_Precio_Neg				--> Ventas AFS
	  )
	SELECT	'BTR'																			-- 01      
		,	CASE	WHEN a.motipoper	= 'TM'			THEN	'TMF' 
					ELSE										'MOV' 
				END																			-- 02
		,	CASE	WHEN a.moinstser	= 'ICAP'
					or	 a.moinstser	= 'ICOL'		THEN	'CP'
					WHEN a.motipoper	=	'IC'
					AND	 a.monumdocu	<> a.monumdocuo	THEN	'RIC'
					WHEN a.motipoper	= 'TM' 
					AND	 a.motipopero	= 'CP'			THEN	'TMCP'
					WHEN a.motipoper	= 'TM' 
					AND	 a.motipopero	= 'VI'			THEN	'TMCP'	--'TMVI'
					
					WHEN a.motipoper	= 'TM' 
					AND	 a.motipopero	= 'CG'			THEN	'TMCP'	--'TMVI'

					ELSE a.motipoper
				END																			-- 03
		,	a.monumoper																		-- 04      
		,	a.mocorrela																		-- 05      
		,	CASE	WHEN moinstser		= 'ICAP'
					AND  DATEDIFF(day,mofecemi,mofecven) > 365	THEN 'ICAP'
					WHEN moinstser		= 'ICOL' 
					AND  DATEDIFF(day,mofecemi,mofecven) > 365	THEN 'ICOL'
					WHEN motipoper		= 'IB'					THEN a.moinstser
					WHEN motipoper		= 'IC'					THEN ''
					WHEN motipoper		= 'RIC'					THEN ''
					WHEN motipoper		= 'VIC'					THEN ''
					WHEN motipoper		= 'AIC'					THEN ''
					ELSE b.inserie
				END																			-- 06
		,	CASE a.motipoper
	            WHEN 'CP' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'VP' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'VIC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'IC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'RIC' THEN CONVERT(CHAR(06), a.momonemi)
	            WHEN 'TM' THEN CONVERT(CHAR(06), a.momonemi)
	            ELSE CONVERT(CHAR(06), a.momonpact)
	       END,	-- 07      
	       
    CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0      
         ELSE CASE a.motipoper WHEN 'IB' THEN a.movalinip   
             ELSE CASE WHEN a.motipoper = 'CI' AND momonpact not in(999,998,997,994) THEN a.movalinip      
	                                ELSE a.movalcomp
	                           END
	                 END
      
	       END,	-- 08      
	       
    CASE WHEN a.motipoper = 'RC' THEN a.movpresen   --a.movalvenp      
	            WHEN a.motipoper = 'RV' THEN a.movalvenp
	            WHEN a.motipoper = 'VI' THEN (a.movalcomp + a.mointeres + a.moreajuste)
                WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN (a.movalcomp + a.mointeres + a.moreajuste)      
              WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movpresen -- a.movaltasemi      
      
	            ELSE a.movpresen
	       END,	-- 09      
	       
		CASE	WHEN a.motipoper = 'RC' THEN a.movalinip 
				ELSE a.movalven 
				END   , -- 10
	       a.moutilidad,	-- 11      
	       ABS(a.moperdida),	-- 12      
	       
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0      
	            ELSE mointeres
	       END,	-- 13      
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0         
	            ELSE moreajuste
	       END,	-- 14      
    CASE WHEN (motipoper = 'VI'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN mointpac
	            WHEN motipoper = 'RV' THEN a.mointeresp --a.movalvenp-a.movalven --> Revisar. 09-09-2009
	            ELSE a.mointeres
	 END,	-- 15 (interes pacto)      
    CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN moreapac
	            WHEN motipoper = 'RV' THEN moreapac
	            ELSE a.moreajuste
	       END,	-- 16 (reajuste pacto)      
	       0.0,	-- 17      
                CASE WHEN a.motipoper = 'VI' THEN a.movalcomp                   
	            WHEN a.motipoper = 'RC' THEN a.movalcomp
	            ELSE a.movalvenp
	       END,	-- 18      
	       a.moutilidad,	-- 19 (Dif pacto pos)      
	       a.moperdida,	-- 20 (Dif Pacto neg  VBARRA 31/05/2000)      
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb > 0 THEN ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0) = 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END ),a.modifsb) 
                  WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb > 0 THEN (ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.modifsb = 0 THEN 0.
	            ELSE a.moutilidad END,	-- 21 (Valor Mercado pos)       
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb < 0 THEN (ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb < 0 THEN ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb)
 	            ELSE a.moutilidad END,	-- 22 (valor Mercado neg)      
	       
	       'condPacto' = CASE  WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli = 97029000 THEN 
                   CASE WHEN a.moforpagi = 124 AND a.moforpagv = 124 THEN '1'
	                             WHEN a.moforpagi  = 128 AND a.moforpagv = 128 THEN '2'
                                     WHEN a.moforpagi  = 129 AND a.moforpagv = 129 THEN '3'
                                     WHEN a.moforpagi  = 130 AND a.moforpagv = 130 THEN '4'
	            WHEN a.moforpagi  = 132 AND a.moforpagv = 132 THEN '5'
                             WHEN a.moforpagi  = 133 AND a.moforpagv = 133 THEN '6'
	                             WHEN a.moforpagi  = 134 AND a.moforpagv = 134 THEN '22'
	                             WHEN a.moforpagi  = 135 AND a.moforpagv = 135 THEN '23'
	                             WHEN a.moforpagi  = 136 AND a.moforpagv = 136 THEN '24'
	                             WHEN a.moforpagi = 137 AND a.moforpagv = 137 THEN '25'
	                             WHEN a.moforpagi = 138 AND a.moforpagv  = 138 THEN '26'
                                     WHEN a.moforpagi = 139 AND a.moforpagv = 139 THEN '27'
	                   ELSE '7'
	           END
                   WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli = 1 THEN 
                   CASE WHEN a.moforpagi = 124 AND a.moforpagv = 124 THEN '8'
	                                WHEN a.moforpagi = 128 AND a.moforpagv  = 128 THEN '9'
	                                WHEN a.moforpagi = 129 AND a.moforpagv = 129 THEN '10'
	    WHEN a.moforpagi = 130 AND a.moforpagv = 130 THEN '11'
	                                WHEN a.moforpagi = 132 AND a.moforpagv = 132 THEN '12'
	                                WHEN a.moforpagi = 133 AND a.moforpagv = 133 THEN '13'
	                                WHEN a.moforpagi = 134 AND a.moforpagv = 134 THEN '28'
	                                WHEN a.moforpagi = 135 AND a.moforpagv = 135 THEN '29'
	                                WHEN a.moforpagi = 136 AND a.moforpagv = 136 THEN '30'
	                                WHEN a.moforpagi = 137 AND a.moforpagv = 137 THEN '31'
	                                WHEN a.moforpagi = 138 AND a.moforpagv = 138 THEN '32'
	                                WHEN a.moforpagi = 139 AND a.moforpagv = 139 THEN '33'
	                                           ELSE '14'
	                                      END
      WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN      
             CASE WHEN a.moforpagi  = 124 AND a.moforpagv  = 124 THEN '15'      
	                                             WHEN a.moforpagi = 128 AND a.moforpagv  = 128 THEN '16'
	                                             WHEN a.moforpagi = 129 AND a.moforpagv  = 129 THEN '17'
	                                             WHEN a.moforpagi = 130 AND a.moforpagv  = 130 THEN '18'
	                                             WHEN a.moforpagi = 132 AND a.moforpagv  = 132 THEN '19'
	                                             WHEN a.moforpagi = 133 AND a.moforpagv  = 133 THEN '20'
						     WHEN a.moforpagi = 134 AND a.moforpagv  = 134 THEN '34'
	                                             WHEN a.moforpagi = 135 AND a.moforpagv  = 135 THEN '35'
	                                             WHEN a.moforpagi = 136 AND a.moforpagv  = 136 THEN '36'
	                                             WHEN a.moforpagi = 137 AND a.moforpagv  = 137 THEN '37'
	                                             WHEN a.moforpagi = 138 AND a.moforpagv  = 138 THEN '38'
	                                             WHEN a.moforpagi = 139 AND a.moforpagv  = 139 THEN '39'
	                                             ELSE '21'
	                                        END
      WHEN a.motipoper <> 'RC' AND a.motipoper <> 'VI' AND a.motipoper <> 'RCA' THEN A.mocondpacto      
	                     END,	--23      
	       
                CASE WHEN @RUT_CORPBNC = a.morutemi THEN '1' ELSE '2' END   ,--24      
    CASE WHEN motipoper = 'RC' OR motipoper = 'RV' THEN CONVERT( CHAR(06), moforpagv )      
	            ELSE CONVERT(CHAR(06), a.moforpagi)
	       END,	-- 25 (Forma de pago)      
	       
	       ISNULL(e.emgeneric, ''),	-- 26 (Generico de emisor)      
    CASE WHEN motipoper ='RV' or motipoper ='CI' THEN a.monominalp --a.monominal      
	            ELSE a.monominalp
	       END,	-- 27 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran      
	       a.moforpagv,	-- 28 --ZZZ      
    CASE WHEN motipoper <> 'IC' AND motipoper <> 'RIC' THEN a.motipobono      
      ELSE ( SELECT tipo_deposito      
	                     FROM   GEN_CAPTACION
	                     WHERE  numero_operacion = monumoper
       AND    correla_operacion = mocorrela )      
	       END,	-- 29 (Tipo Bono)
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
	                                  ELSE 0
	                             END,	-- 30      
	       
    CASE WHEN SUBSTRING( a.motipopero, 1, 2 ) = 'CI' THEN '1'      
	            ELSE '2'
	       END,	-- 31    
	       moinstser,	-- 32      
	       monumdocu,	-- 33      
    CASE WHEN a.moinstser = 'ICAP' THEN CONVERT( VARCHAR(10), morutcli )      
	            ELSE CONVERT(VARCHAR(10), morutemi)
	       END,	-- 34      
	       motipopero,	-- 35       
	       movalvenp,	-- 36      
  'clasificacion_cliente' = CASE WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'      
             WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'      
	                                      WHEN motipoper <> 'IB' THEN '0'
	                                      ELSE --- interbancarios ---      
       CASE WHEN morutcli  = 97029000                                          THEN '9'      
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
	                                                ELSE '0'
	                                           END
	                                 END,	-- 37      
  CASE WHEN mointeres < 0 THEN (mointeres *-1) ELSE 0 END,     
    CASE WHEN moreajuste < 0 THEN (moreajuste *-1) ELSE 0 END,      
    CASE WHEN motipoper = 'IB' THEN (CASE WHEN datediff(dd,mofecinip,mofecvenp) > 365 THEN 2 ELSE 1 END)      
          ELSE datediff(dd,mofecinip,mofecvenp)      
	       END,
	       morutcli,
	       mocodcli,
	       mofecpro,
	       ROUND(monominal, 0),
	       'valor_tasa_emision' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'VP' THEN a.movaltasemi
	                                   WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper= 'VP' THEN 0
	                                   WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'CP' THEN a.movaltasemi ELSE a.movalcomp
	                              END,
	       'prima_total' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,
	       'descuento_total' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc < 0 THEN (a.moprimadesc * -1) ELSE 0 END,
	       'prima_dia' = 0,
	       'descuento_dia' = 0,
	       'valor_pte_emision' = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') THEN  a.movaltasemi ELSE 0 END,
	       'dif_par_pos' = CASE  WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo =  20 AND a.motipoper = 'VP' AND a.mocapitali > 0 THEN a.mocapitali ELSE 0 END,
  'dif_par_neg'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali < 0 THEN (a.mocapitali*-1) ELSE 0 END      
 , 'TIPO_CARTERA'  = 0        
 , 'CondPactoCliente' = CASE WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN '1'      
      WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli  = 1 THEN '2'      
      WHEN a.motipopero <> 'CI' AND a.morutcli  = 97029000 AND c.cltipcli  = 1 THEN '3'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli  = 1                            THEN '5'      
      ELSE '0' END      
 , 'EstadoObjeto' = CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' THEN (CASE WHEN ISNULL(VM.PorcjeCob,0)  <> 0 THEN 'CBTO' ELSE 'DCBTO' END )      
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
	                          ELSE 0
	                     END
	          
	,	Utilidad_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) >= 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Perdida_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) < 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	
 FROM	MDMO   a 
		INNER JOIN VIEW_CLIENTE				c  ON c.clrut			= a.morutcli 
										AND c.clcodigo				= a.mocodcli

		LEFT  JOIN VALORIZACION_MERCADO		VM ON a.motipoper		= 'TM'
										AND VM.tipo_operacion		= 'CG'
										AND VM.fecha_valorizacion	= @FechaBusquedaValorizacion
										AND VM.id_sistema			= 'BTR'
										AND VM.rmnumoper			= a.monumoper
										AND VM.rmnumdocu			= a.monumdocu
										AND VM.rmcorrela			= a.mocorrela
		LEFT  JOIN VALORIZACION_MERCADO		VMA ON a.motipoper		= 'TM'  
										AND VMA.tipo_operacion		= 'CG'
										AND VMA.fecha_valorizacion	= @FechaBusquedaValorizacionAyer
										AND VMA.id_sistema			= 'BTR'
										AND VMA.rmnumoper			= a.monumoper
										AND VMA.rmnumdocu			= a.monumdocu
										AND VMA.rmcorrela			= a.mocorrela
		LEFT  JOIN VIEW_EMISOR		e ON e.emrut   = a.morutemi      
		LEFT  JOIN VIEW_INSTRUMENTO b ON b.incodigo  = a.mocodigo      
	
	,	MDAC   m      
	WHERE   a.mofecpro = @fecha_hoy
	AND		a.mostatreg		<> 'A'
	AND		a.motipoper		NOT IN ('RCA', 'RVA', 'CPP', 'FLI', 'VFM', 'IC','RIC')
	AND		a.motipopero	=	'CG'
	
	AND		NOT EXISTS( SELECT 1 FROM MDMOPM f WHERE f.monumoper  = a.monumoper
												AND  f.monumdocu  = a.monumdocu
												AND  f.mocorrela  = a.mocorrela
												AND  f.monumdocuo = a.monumdocuo
												AND  f.mocorrelao = a.mocorrelao
												AND  f.mostatreg <> 'A')
	AND		 NOT EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.monumoper
												AND  l.LCGP_CORRELATIVO  = a.mocorrela
												)
	IF @@ERROR <> 0 
	BEGIN
		SET NOCOUNT OFF 
		RAISERROR('¡ Err. Falla Agregando Movimientos Renta Fija Archivo Contabiliza.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END

	/*=======================================================================*/ 
	/* fin		:	valorizacion mercado cartera garantias					 */ 
	/*=======================================================================*/      

	

	/*=======================================================================*/ 
	/* Llena Renta Fija operaciones Pago Mañana                              */ 
	/*=======================================================================*/      
	
	INSERT INTO bac_cnt_contabiliza
  ( id_sistema      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    valor_comprahis,	-- 18      
	    dif_ant_pacto_pos,	-- 19      
	    dif_ant_pacto_neg,	-- 20 
	    dif_valor_mercado_pos,	-- 21      
	    dif_valor_mercado_neg,	-- 22      
	    condicion_pacto,	-- 23      
	    tipo_cliente,	-- 24      
	    forma_pago,	-- 25      
	    tipo_emisor,	-- 26      
	    nominalpesos,	-- 27      
	    forma_pago_entregamos,	-- 28      
	    tipo_instrumento,	-- 29      
	  condicion_entrega,	-- 30      
	    tipo_operacion_or,	-- 31      
	    instser,	-- 32      
	    documento,	-- 33      
	    emisor,	-- 34      
	    cartera_origen,	-- 35      
	    valor_final,	-- 36      
	    clasificacion_cliente,	-- 37 -- aca      
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    Tipo_Cartera,
	    CondPactoCliente,
	    monto_pagomañana,
	    Tipo_Bono,
	    comquien,

		Utilidad_Avr_Patrimonio		,	--> Ventas AFS
		Perdida_Avr_Patrimonio		,	--> Ventas AFS
		Diferencia_Precio_Pos		,	--> Ventas AFS
		Diferencia_Precio_Neg			--> Ventas AFS
	  )
	SELECT 'BTR',	-- 01      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN 'REV' ELSE 'MOV' END   , -- 02      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN 'R' + LTRIM(RTRIM(a.motipoper)) + 'M' ELSE a.motipoper END  , -- 03      
	       a.monumoper,	-- 04      
	       a.mocorrela,	-- 05      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy AND a.motipoper ='CP' THEN '' ELSE b.inserie END          , -- 06      
   CASE a.motipoper WHEN 'CP'  THEN CONVERT( CHAR(06), a.momonemi )      
	            WHEN 'VP' THEN CONVERT(CHAR(06), a.momonemi)
	       END,	-- 07      
	       
	       a.movalcomp,	-- 08      
	       
	       /*CASE WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN a.movalant  --> vb+- 07/05/2009  (a.movalcomp + a.mointeres + a.moreajuste)      
	       WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movalant  --> a.movpresen -- a.movaltasemi      
	       ELSE                                                                            a.movalant  --> a.movpresen       
	       END, -- 09 */ 
	       a.momtocce,	-- 09       
	CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN  movalven ELSE (((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc)  END , --VB+- 07/05/2009  Se incorpora MONTO PARA Cuadrar segun documento aprobado por usuario      
	           	-- VB+-07/05/2009 a.movalven           , -- 10      
	       a.moutilidad,	-- 11      
   CASE WHEN a.moperdida < 0 THEN (a.moperdida * -1)       
    ELSE a.moperdida END        , -- 12      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN mointermesvi  ELSE mointeres END  , -- 13      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN moreajumesvi  ELSE moreajuste END , -- 14      
	       
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN MOINTERESP    ELSE mointeres END  , -- 15      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN moreajustp    ELSE moreajuste END , -- 16      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN MOVPRESENP    ELSE 0.0 END  , -- 17      
	       a.movalvenp,	-- 18      
	       a.moutilidad,	-- 19 (Dif pacto pos)      
	       a.moperdida,	-- 20 (Dif Pacto neg  VBARRA 31/05/2000)      
	       a.moutilidad,	-- 21 (Valor Mercado pos)       
	       a.moutilidad,	-- 22 (valor Mercado neg)      
	       'condPacto' = A.mocondpacto,	-- 23      
                 CASE WHEN @RUT_CORPBNC = a.morutemi THEN '1' ELSE '2' END       , -- 24      
   CASE WHEN a.Fecha_PagoMañana = @Fecha_Hoy THEN a.moforpagi ELSE 140 END   , -- 25 (Forma de pago)      
	       ISNULL(e.emgeneric, ''),	-- 26 (Generico de emisor)      
	       a.monominalp,	-- 27 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran      
	       a.moforpagv,	-- 28       
	       a.motipobono,	-- 29 (Tipo Bono)      
	       
	       --> CASE WHEN a.motipoper = 'CP' THEN mocondpacto ELSE a.modcv END   , -- 30      
        --> CASE WHEN a.motipoper = 'CP' THEN mocondpacto ELSE a.modcv END   , -- 30        
/*  +++ VBF 03/07/2018 se agrega valor para t+2
                         'condicion_entrega' = CASE WHEN (a.Fecha_PagoMañana > @Fecha_Hoy)        
											THEN CASE WHEN c.cltipcli = 1 THEN 54 ELSE 55 END --> 50     
	--- VBF 03/07/2018 se agrega valor para t+2 
  */
                'condicion_entrega' = CASE WHEN (a.Fecha_PagoMañana > @Fecha_prox)        
											THEN CASE WHEN c.cltipcli = 1 THEN 60 ELSE 61 END --> 50     
											WHEN (a.Fecha_PagoMañana = @Fecha_prox)        
											THEN CASE WHEN c.cltipcli = 1 THEN 54 ELSE 55 END --> 50     
                      WHEN (a.moforpagi = 128 or a.moforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
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
						WHEN (a.moforpagi = 150 or a.moforpagv = 150) THEN 62 -->vb03/07/2019        
										   
	                                  ELSE 0
	               END,	--> 30      
	       
	       '2',	-- 31      
	       moinstser,	-- 32      
	       monumdocu,	-- 33      
	       CONVERT(VARCHAR(10), morutemi),	-- 34      
	       motipopero,	-- 35       
	       movalvenp,	-- 36      
   'clasificacion_cliente' = CASE WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'      
       WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'      
	                                      WHEN motipoper <> 'IB' THEN '0'
	                                 END,	-- 37      
	       
   CASE WHEN mointeres < 0 then (mointeres *-1) else 0 end     , -- 38      
   CASE WHEN moreajuste < 0 then (moreajuste *-1) else 0 end    , -- 39      
	       DATEDIFF(dd, mofecinip, mofecvenp),	-- 40      
	       morutcli,	-- 41      
	       mocodcli,	-- 42      
	       mofecpro,	-- 43      
	       ROUND(monominal, 0),	-- 44      
   'valor_tasa_emision'  = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' THEN a.movaltasemi      
       WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper='VP' THEN 0                 
       WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper='CP' THEN a.movaltasemi ELSE a.movalcomp       
	                              END,	-- 45      
   'prima_total'         = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,      
   'descuento_total'     = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc < 0 THEN (a.moprimadesc*-1) ELSE 0 END,      
	       'prima_dia' = 0,	-- 46      
	       'descuento_dia' = 0,	-- 47      
   'valor_pte_emision'   = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') THEN a.movaltasemi ELSE 0 END,      
   'dif_par_pos'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali > 0 THEN a.mocapitali ELSE 0 END,      
   'dif_par_neg'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali < 0 THEN (a.mocapitali*-1) ELSE 0 END,      
   'Tipo_Cartera'        = CASE WHEN a.mocodigo =  15 and e.emtipo  = 2  and a.codigo_carterasuper = 'T' then 3        
       WHEN a.mocodigo =  15 and e.emtipo  = 2  and a.codigo_carterasuper = 'P' then 4         
       WHEN a.mocodigo =  15 and e.emtipo <> 2  and a.codigo_carterasuper = 'T' then 5         
       WHEN a.mocodigo =  15 and e.emtipo <> 2  and a.codigo_carterasuper = 'P' then 6       
       WHEN a.mocodigo <> 15                 and a.codigo_carterasuper = 'T' then 1       
	                             ELSE 2
	                        END,	-- 48      
   'CondPactoCliente' = CASE WHEN a.morutcli  <> 97029000 AND c.cltipcli <> 1 THEN '1'      
       WHEN a.morutcli  <> 97029000 AND c.cltipcli  = 1 THEN '2'      
       WHEN a.morutcli   = 97029000 AND c.cltipcli  = 1 THEN '3'      
       ELSE '0' END        -- 49      
   ,                   CASE a.motipoper WHEN 'CP' THEN a.movalcomp ELSE (((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc)    END     -- vb 50       
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
	                          ELSE 0
	                     END 
	       
	       -->  Se agrego para la Reversa de la contabilidad PM, Forma de Pago segun Criterios.-       
                        ,       'comquien'        = CASE WHEN (a.Fecha_PagoMañana = @Fecha_Hoy) THEN CASE WHEN c.cltipcli = 1 THEN '1' ELSE '2' END      
	                         ELSE '0'
	                    END
	
	,	Utilidad_Avr_Patrimonio		= case when a.Fecha_PagoMañana = @Fecha_Hoy then
											case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.momtocce))) >= 0 then 
													 ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.momtocce))))
													else 0
												end
											else
											case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- ((((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc) - a.momtocce))) >= 0 then 
													 ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- ((((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc) - a.momtocce))))
													else 0
												end
										end
										
										
	,	Perdida_Avr_Patrimonio		= case when a.Fecha_PagoMañana = @Fecha_Hoy then
											case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.momtocce))) < 0 then 
													 ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.momtocce))))
													else 0
												end
											else
											case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- ((((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc) - a.momtocce))) < 0 then 
													 ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- ((((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc) - a.momtocce))))
													else 0
												end
										end
											
	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	
	
	/*
	,	Utilidad_Avr_Patrimonio		= case	when a.Fecha_PagoMañana = @Fecha_Hoy then case when a.Resultado_Dif_Mercado >= 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 
											else 0.0
										end
										
	,	Perdida_Avr_Patrimonio		= case	when a.Fecha_PagoMañana = @Fecha_Hoy then case when a.Resultado_Dif_Mercado < 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 
											else 0.0
										end

	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	*/

	FROM   --  REQ. 7619      
                 MDMOPM a RIGHT OUTER JOIN VIEW_EMISOR e ON e.emrut = a.morutemi       
                          RIGHT OUTER JOIN VIEW_INSTRUMENTO b ON b.incodigo = a.mocodigo      
	                --   , VIEW_INSTRUMENTO   b      
   , VIEW_CLIENTE c      
	       --  REQ. 7619
	       --   , VIEW_EMISOR  e      
   , MDAC   m 
	WHERE	a.mostatreg <> 'A'
	AND		a.motipoper IN ('CP', 'VP')
	AND	(	a.mofecpro = @fecha_hoy OR a.Fecha_PagoMañana = @fecha_hoy)
	AND		a.SorteoLCHR = 'N'
	AND		a.PagoMañana = 'S'
	AND (	c.clrut =  a.morutcli AND c.clcodigo =  a.mocodcli)
		--  REQ. 7619
	    --   AND e.emrut  =* a.morutemi
	    --   AND b.incodigo =* a.mocodigo
	AND		a.mocondpacto <> 'X'      
	
   IF @@ERROR <> 0 
   BEGIN      
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Agregando Movimientos Renta Fija Pago Mañana Archivo Contabiliza.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA PAGO MAÑANA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END      

	UPDATE BAC_CNT_CONTABILIZA
	SET    reajuste_papel = CASE	WHEN (valor_venta + valor_cupon) - (Monto_PagoMañana + interes_papel) < 0 THEN 0      
									WHEN (valor_venta + valor_cupon) - (Monto_PagoMañana + interes_papel) = 1 THEN 0
									ELSE (valor_venta + valor_cupon) -(Monto_PagoMañana + interes_papel)
								END      
	,      interes_papel  = CASE	WHEN CONVERT(INTEGER, moneda_instrumento) <> 999 THEN interes_papel
									ELSE interes_papel + (valor_venta + valor_cupon) - (Monto_PagoMañana + interes_papel) 
								END
	WHERE  tipo_operacion = 'RVPM'      
	
	UPDATE BAC_CNT_CONTABILIZA
	SET    reajuste_papel = (valor_venta + valor_cupon) -(Monto_PagoMañana + interes_papel)
	WHERE  id_sistema = 'BTR'
	       AND tipo_movimiento = 'REV'
	       AND tipo_operacion = 'RVPM'
	       AND moneda_instrumento = 998 
	
	
	--- *********  CONTABILIDAD OPERACIONES PM ANULADAS AL DIA FECHA DE CUMPLIEMIENTO PM **************************      
	
	
	
	INSERT INTO bac_cnt_contabiliza
  ( id_sistema      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03   
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    valor_comprahis,	-- 18      
	    dif_ant_pacto_pos,	-- 19      
	    dif_ant_pacto_neg,	-- 20      
	    dif_valor_mercado_pos,	-- 21      
	    dif_valor_mercado_neg,	-- 22      
	    condicion_pacto,	-- 23      
	    tipo_cliente,	-- 24      
	    forma_pago,	-- 25      
	    tipo_emisor,	-- 26      
	    nominalpesos,	-- 27      
	    forma_pago_entregamos,	-- 28      
	    tipo_instrumento,	-- 29      
	    condicion_entrega,	-- 30      
	    tipo_operacion_or,	-- 31      
	    instser,	-- 32      
	    documento,	-- 33      
	    emisor,	-- 34      
	    cartera_origen,	-- 35      
	    valor_final,	-- 36      
	    clasificacion_cliente,	-- 37 -- aca      
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    Tipo_Cartera,
	    CondPactoCliente,
	    monto_pagomañana,
	    Tipo_Bono,

		Utilidad_Avr_Patrimonio		,	--> Ventas AFS
		Perdida_Avr_Patrimonio		,	--> Ventas AFS
		Diferencia_Precio_Pos		,	--> Ventas AFS
		Diferencia_Precio_Neg			--> Ventas AFS
	  )
	SELECT 'BTR',	-- 01      
	       'MOV',	-- 02      
	       a.motipoper,	-- 03      
	       a.monumoper,	-- 04      
	       a.mocorrela,	-- 05      
	       b.inserie,	-- 06      
   CASE a.motipoper WHEN 'CP'  THEN CONVERT( CHAR(06), a.momonemi )      
	            WHEN 'VP' THEN CONVERT(CHAR(06), a.momonemi)
	       END,	-- 07      
	       
	       a.movalcomp * -1,	-- 08      
	       /* +-VB08/05/2009 CASE WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN (a.movalcomp + a.mointeres + a.moreajuste)*-1      
	       WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movpresen *-1 -- a.movaltasemi      
	       ELSE a.movalant *-1 a.movpresen *-1      
	       END              
	       */ 
	       a.momtocce * -1,	--9    
   ((((a.momtocce - ABS(a.moperdida))+a.moutilidad)+a.moprimadesc) )*-1 , --VB+- 09/06/2009  Se incorpora MONTO PARA Cuadrar segun documento aprobado por usuario      
	              	--   ((((a.momtocce - a.moperdida)+a.moutilidad)+a.moprimadesc))*-1  , --VB+- 07/05/2009  Se incorpora MONTO PARA Cuadrar segun documento aprobado por usuario      
	       
	       -- +-VB08/05/2009 a.movalven *-1          , -- 10      
	       a.moutilidad * -1,	-- 11      
   abs(a.moperdida)* -1                                                                      , -- 12 MAP 20070206 *-1      
	       mointeres,	-- 13      
	       moreajuste,	-- 14      
	       a.mointeres,	-- 15 (interes pacto)      
	       a.moreajuste,	-- 16 (reajuste pacto)      
	       0.0,	-- 17      
	       a.movalvenp * -1,	-- 18      
	       a.moutilidad * -1,	-- 19 (Dif pacto pos)      
   abs( a.moperdida) *-1          , -- 20 (Dif Pacto neg  VBARRA 31/05/2000) MAP 20070206 *-1      
	       a.moutilidad * -1,	-- 21 (Valor Mercado pos)       
	       a.moutilidad * -1,	-- 22 (valor Mercado neg)      
	       'condPacto' = A.mocondpacto,	-- 23      
                 CASE WHEN @RUT_CORPBNC = a.morutemi then '1' ELSE '2' end       , -- 24      
	       140,	-- 25 (Forma de pago)      
	       ISNULL(e.emgeneric, ''),	-- 26 (Generico de emisor)      
	       a.monominalp,	-- 27 antes monominalp fue cambiado para la contabilidad de CI, RV, por valor nominal, MQuilodran      
	       a.moforpagv,	-- 28       
	       a.motipobono,	-- 29 (Tipo Bono)      
	       
	       -->   CASE WHEN a.motipoper = 'CP' THEN mocondpacto ELSE a.modcv END   , -- 30      
                'condicion_entrega' = CASE WHEN c.cltipcli = 1 THEN 54 ELSE 55 END --> 50      
	       
	       /* CASE WHEN (a.moforpagi = 128 or a.moforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
	       WHEN (a.moforpagi = 129 or a.moforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END      
	       WHEN (a.moforpagi = 130 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END      
	       WHEN (a.moforpagi = 132 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END      
	       WHEN (a.moforpagi = 133 or a.moforpagv = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5  ELSE 16 END      
	       WHEN (a.moforpagi = 134 or a.moforpagv = 134) THEN CASE WHEN c.cltipcli = 1 THEN 6  ELSE 17 END      
	       WHEN (a.moforpagi = 135 or a.moforpagv = 135) THEN CASE WHEN c.cltipcli = 1 THEN 7  ELSE 18 END      
	       WHEN (a.moforpagi = 136 or a.moforpagv = 136) THEN CASE WHEN c.cltipcli = 1 THEN 8 ELSE 19 END      
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
	       --   WHEN (a.moforpagi = 140 or a.moforpagv = 140) THEN 50      
	       WHEN (a.moforpagi = 141 or a.moforpagv = 141) THEN 51      
	       WHEN (a.moforpagi = 142 or a.moforpagv = 142) THEN 52      
	       WHEN (a.moforpagi = 143 or a.moforpagv = 143) THEN 53      
	       ELSE                                      0      
	       END */,	--> 30      
	       
	       '2',	-- 31      
	       moinstser,	-- 32      
	       monumdocu,	-- 33      
	       CONVERT(VARCHAR(10), morutemi),	-- 34      
	       motipopero,	-- 35       
	       movalvenp,	-- 36      
   'clasificacion_cliente' = CASE WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'      
       WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'      
	                                      WHEN motipoper <> 'IB' THEN '0'
	                                 END,	-- 37      
	       
   CASE WHEN mointeres < 0 then (mointeres *-1) else 0 end     , -- 38      
   CASE WHEN moreajuste < 0 then (moreajuste *-1) else 0 end    , -- 39      
	       DATEDIFF(dd, mofecinip, mofecvenp),	-- 40      
	       morutcli,	-- 41      
	       mocodcli,	-- 42      
	       mofecpro,	-- 43      
	       ROUND(monominal, 0),	-- 44      
   'valor_tasa_emision'  = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' THEN a.movaltasemi *-1      
       WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper='VP' THEN 0                                                    
       WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper='CP' THEN a.movaltasemi *-1 ELSE a.movalcomp *-1      
	                              END,	-- 45
	                                  	--   'prima_total'         = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,
	                            	--   'descuento_total'     = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') AND a.moprimadesc < 0 THEN (a.moprimadesc*-1) ELSE 0 END,      
	       
   'prima_total'         = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') and a.moprimadesc > 0 THEN a.moprimadesc *-1 ELSE 0 END,  -- MAP 20070605      
   'descuento_total'     = CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP')  AND a.moprimadesc < 0 THEN a.moprimadesc  ELSE 0 END,    -- MAP 20070605      
	       'prima_dia' = 0,	-- 46      
	       'descuento_dia' = 0,	-- 47      
   'valor_pte_emision'   = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN('CP','VP') THEN a.movaltasemi ELSE 0 END,      
   'dif_par_pos'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP'  THEN a.mocapitali *-1 ELSE 0 END,      
   'dif_par_neg'         = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP'  THEN a.mocapitali ELSE 0 END, -- REVISAR PARA QUE SE USA ESTE CAMPO....-???      
   'Tipo_Cartera'        = CASE WHEN a.mocodigo =  15 and e.emtipo  = 2  and a.codigo_carterasuper = 'T' then 3        
       WHEN a.mocodigo =  15 and e.emtipo  = 2  and a.codigo_carterasuper = 'P' then 4         
       WHEN a.mocodigo =  15 and e.emtipo <> 2  and a.codigo_carterasuper = 'T' then 5         
       WHEN a.mocodigo =  15 and e.emtipo <> 2  and a.codigo_carterasuper = 'P' then 6         
       WHEN a.mocodigo <> 15    and a.codigo_carterasuper = 'T' then 1       
	                             ELSE 2
	                        END,	-- 48      
   'CondPactoCliente' = CASE WHEN a.morutcli  <> 97029000 AND c.cltipcli <> 1 THEN '1'      
       WHEN a.morutcli  <> 97029000 AND c.cltipcli  = 1 THEN '2'      
       WHEN a.morutcli   = 97029000 AND c.cltipcli  = 1 THEN '3'      
       ELSE '0' END        -- 49      
   , CASE a.motipoper WHEN 'CP' THEN a.movalcomp *-1 ELSE a.movalven *-1 END     -- 50      
      
                        ,       'Tipo_Bono'     = CASE	WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi  = @iRutAdmCorp THEN 1      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi  = @iRutAdmCorp THEN 2      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi  = @iRutAdmCorp THEN 3      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi  = @iRutAdmCorp THEN 4      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi  = @iRutAdmCorp THEN 5      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi <> @iRutAdmCorp THEN 6      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi <> @iRutAdmCorp THEN 7      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi <> @iRutAdmCorp THEN 8      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi <> @iRutAdmCorp THEN 9      
														WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi <> @iRutAdmCorp THEN 10      
														ELSE 0
													END

	,	Utilidad_Avr_Patrimonio		= case when a.Fecha_PagoMañana = @Fecha_Hoy then
											case when a.Resultado_Dif_Mercado >= 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 
										end *-1
										
	,	Perdida_Avr_Patrimonio		= case when a.Fecha_PagoMañana = @Fecha_Hoy then
											case when a.Resultado_Dif_Mercado < 0 then abs(a.Resultado_Dif_Mercado) else 0.0 end 
										end *-1

	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	*-1 --> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	*-1 --> Ventas AFS

	FROM   --  REQ. 7619      
      MDMOPM a RIGHT OUTER JOIN VIEW_EMISOR e      ON e.emrut = a.morutemi      
                          RIGHT OUTER JOIN VIEW_INSTRUMENTO b ON b.incodigo = a.mocodigo       
	                --   , VIEW_INSTRUMENTO b      
   , VIEW_CLIENTE  c      
	       --  REQ. 7619
	       --   , VIEW_EMISOR  e      
   , MDAC   m      
	WHERE  a.mostatreg = 'A'
	       AND a.motipoper IN ('CP', 'VP')
	       AND a.Fecha_PagoMañana = @fecha_hoy
	       AND a.SorteoLCHR = 'N'
	       AND a.PagoMañana = 'S'
   AND (c.clrut =  a.morutcli       
   AND c.clcodigo =  a.mocodcli )      
	           --  REQ. 7619
	           --   AND e.emrut  =* a.morutemi
	           --   AND b.incodigo =* a.mocodigo
	       AND mocondpacto = 'X'      
	
   IF @@ERROR <> 0 
   BEGIN      
		SET NOCOUNT OFF 
		RAISERROR('¡ Err. Falla Agregando Movimientos Renta Fija Anulacion Pago Mañana Archivo Contabiliza.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA PAGO MAÑANA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END 

	
	--- *********  FIN PEDAZO CONTABILIDAD OPERACIONES PM ANULADAS AL DIA FECHA DE CUMPLIEMIENTO PM **************************      
	
	
	/*=======================================================================*/ 
	/* Llena Renta Fija Operaciones solo anticipos de pacto ReCompras        */ 
	/* Anticipadas                                                           */ 
	/*=======================================================================*/      
	INSERT INTO bac_cnt_contabiliza
 ( id_sistema                      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 07.5      
	    valor_venta,	-- 08 (Valor Venta)      
	    valor_presente,	-- 09 (Valor Final)      
	    interes_pacto,	-- 10 (Interes del pacto)      
	    reajuste_pacto,	-- 11 (Reajuste Pacto)      
	    valor_comprahis,	-- 12 (Valor Final del Pacto)      
	    dif_ant_pacto_pos,	-- 13 (Utilidad Anticipo)      
	    dif_ant_pacto_neg,	-- 14 (Perdidad Anticipo)      
	    tipo_instrumento,	-- 15 (Tipo de Bonos)      
	    condicion_pacto,	-- 16 (Condicion original del Pacto)      
	    interes_papel,	-- 17 (Interes Devengado del Papel)      
	    reajuste_papel,	-- 18 (Reajuste Devengado del Papel)      
	    tipo_operacion_or,	-- 19      
	    forma_pago,	-- 20      
	    tipo_cliente,	-- 21 (Operacion de compra Original)      
	    forma_pago_entregamos,	--22      
	    instser,
	    documento,
	    emisor,
	    cartera_origen,

	    valor_final,

	    utilidad,
	    perdida,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    CondPactoCliente,
	    condicion_entrega
	  )
	SELECT 'BTR',	-- 01      
	       'MOV',	-- 02      
	       'RCA',	-- 03      
	       a.monumoper,	-- 04      
	       a.mocorrela,	-- 05      
	       b.inserie,	-- 06      
	       CONVERT(CHAR(06), a.momonpact),	-- 07      
	       a.movalcomp,	-- 07.5      
	       a.movalinip,	-- 08      
	       a.movpresen,	-- 09      
	       a.mointpac,	-- 10      
	       a.moreapac,	-- 11      
	       a.movalant,	-- 12      
	       a.moutilidad,	-- 13      
	       a.moperdida,	-- 14      
	       a.motipobono,	-- 15      
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
         ELSE           '7'      
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
	                                           ELSE '14'
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
	                                             ELSE '21'
	                                        END
        WHEN a.motipoper <> 'RC' AND a.motipoper <> 'VI' AND a.motipoper <> 'RCA' THEN A.mocondpacto      
	                     END,	--a.mocondpacto       , -- 16      
	       a.mointeres,	-- 17      
	       a.moreajuste,	-- 18      
	       a.motipopero,	-- 19      
	       CONVERT(CHAR(06), a.moforpagv),	-- 20      
    (CASE WHEN a.motipoletra = 'V' THEN '3'       
	                WHEN a.motipoletra = 'F' THEN '4'
	                WHEN a.motipoletra = 'E' THEN '2'
	                WHEN a.motipoletra = 'O' THEN '1'
      ELSE '0' END)    ,--21      
	       moforpagv,	-- 22   
	       moinstser,
	       monumdocu,
	       CONVERT(VARCHAR(10), morutemi),
	       motipopero,
	       case when momonpact = 13 then movalvenp else movalven end,
	       moutilidad,
	      moperdida,
	       mofecpro,
  round(monominal,0)  ,      
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
  0.0      
       , 'CondPactoCliente' = CASE WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli <> 1 THEN '1'      
      WHEN a.motipopero <> 'CI' AND a.morutcli <> 97029000 AND c.cltipcli  = 1 THEN '2'      
      WHEN a.motipopero <> 'CI' AND a.morutcli  = 97029000 AND c.cltipcli  = 1 THEN '3'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'      
      WHEN a.motipopero  = 'CI' AND c.cltipcli  = 1                            THEN '5'      
      ELSE '0' END,      
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
	                                  ELSE 0
	                             END
 FROM MDMO a      
 , VIEW_INSTRUMENTO b      
 , VIEW_CLIENTE  c      
	WHERE  a.motipoper = 'RCA'
	       AND b.incodigo = a.mocodigo
	       AND a.mostatreg <> 'A'
	       AND a.mofecpro = @fecha_hoy
	       AND c.clrut = a.morutcli
	       AND c.clcodigo = a.mocodcli 
		   AND		 NOT EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.monumoper
												AND  l.LCGP_CORRELATIVO  = a.mocorrela
												)
	/*=======================================================================*/ 
	/* Llena Renta Fija operaciones solo anticipos de pacto ReVentas         */ 
	/* anticipadas															 */ 
	/*=======================================================================*/      
	
	
  INSERT INTO bac_cnt_contabiliza (      
	    id_sistema,	-- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08 (Valor Compra)      -->   movalinip      
	    valor_presente,	-- 09 (Valor Final)      
	    interes_pacto,	-- 10 (Interes del pacto)      
	    reajuste_pacto,	-- 11 (Reajuste Pacto)      
	    dif_ant_pacto_pos,	-- 12 (Utilidad Anticipo)      
	    dif_ant_pacto_neg,	-- 13 (Perdidad Anticipo)      
	    tipo_instrumento,	-- 14 (Tipo de Bonos)      
	    condicion_pacto,	-- 15 (Condicion original del Pacto)      
	    forma_pago,	-- 16      
	    tipo_cliente,	-- 17      
	    forma_pago_entregamos,	-- 18      
	    instser,	-- 19      
	    documento,
	    emisor,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    condicion_entrega,
	    valor_final,
	    valor_venta
	  )
	SELECT 'BTR',	-- 01      
	       'MOV',	-- 02      
	       'RVA',	-- 03      
	       a.monumoper,	-- 04      
	       a.mocorrela,	-- 05      
	       b.inserie,	-- 06      
	       CONVERT(CHAR(06), a.momonpact),	-- 07      
	       a.movalinip,	-- 08      
	       a.movalant,	-- 09      
    CASE WHEN a.momonpact = 13 THEN CONVERT(NUMERIC(21,4),ROUND((a.movalven - a.movalinip), 4))      
	            ELSE a.mointpac
	       END,	-- 10      
	       a.moreapac,	-- 11      
			dif_ant_pacto_pos = CASE WHEN (a.movpresen - a.movalinip) >= 0 THEN ABS((a.movpresen - a.movalinip)) ELSE 0 END,      
                dif_ant_pacto_neg = CASE WHEN (a.movpresen - a.movalinip) <  0 THEN ABS((a.movpresen - a.movalinip)) ELSE 0 END,      
	 a.motipobono,	-- 141      
	  '1',	--a.mocondpacto                 , -- 15      
	       CONVERT(CHAR(06), a.moforpagv),	-- 16      
         (CASE WHEN a.motipoletra = 'V' THEN '3'       
	                WHEN a.motipoletra = 'F' THEN '4'
	                WHEN a.motipoletra = 'E' THEN '2'
	                WHEN a.motipoletra = 'O' THEN '1'
     ELSE '0' END)    ,--17        
	       moforpagv,	--18      
	       a.moinstser,
	       monumdocu,
	       CONVERT(VARCHAR(10), morutemi),
	       mofecpro,
	       ROUND(monominal, 0),
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
	       0.0,
                'condicion_entrega' = CASE WHEN (a.moforpagi = 128 or a.moforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
                                           WHEN (a.moforpagi = 129 or a.moforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END      
                                           WHEN (a.moforpagi = 130 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END      
                                           WHEN (a.moforpagi = 132 or a.moforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END      
                                           WHEN (a.moforpagi = 133 or a.moforpagv = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5 ELSE 16 END      
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
	                                  ELSE 0
	         END,
	       valor_final = CONVERT(NUMERIC(21, 4), ROUND(a.movalven, 4)),
	       valor_venta = CONVERT(NUMERIC(21, 4), ROUND(a.movpresen, 0))
                      
	FROM   MDMO a
                INNER JOIN BacParamSuda..CLIENTE     c ON a.morutcli = c.clrut AND a.mocodcli = c.clcodigo      
          INNER JOIN BacParamSuda..INSTRUMENTO b ON a.mocodigo = b.incodigo      
	WHERE  a.mofecpro = @fecha_hoy -- '20050705'
	       AND a.mostatreg <> 'A'
	       AND a.motipoper = 'RVA' 
	
	
	/*=======================================================================*/ 
	/* Llena Renta Fija Devengo                                    */ 
	/*=======================================================================*/      
	INSERT INTO bac_cnt_contabiliza
 ( id_sistema                      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    nominalpesos,	-- 18      
	    valor_comprahis,	-- 19      
	    dif_ant_pacto_pos,	-- 20      
	    dif_ant_pacto_neg,	-- 21      
	    dif_valor_mercado_pos,	-- 22      
	    dif_valor_mercado_neg,	-- 23      
	    condicion_pacto,	-- 24      
	    forma_pago,	-- 25      
	    forma_pago_entregamos,	-- 25.5      
	    tipo_instrumento,	-- 26      
	    tipo_cliente,	-- 27      
	    tipo_emisor,	-- 28      
	    valor_futuro,	-- 29      
	    comquien,	-- 30      
	    instser,	-- 31      
	    documento,	-- 32      
	    emisor,	-- 33      
	    clasificacion_cliente,	-- 34            
	    valor_final,
	    cartera_origen,
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    Interes_Reajuste,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    CondPactoCliente,
	    condicion_entrega
	  )
	SELECT	'BTR',	-- 01      
			'DEV',	-- 02 (VB+- 21/03/2000 Se cambia definici¢n de tipo de operacion)      
			(CASE	WHEN rscartera = '111' AND rstipoper = 'DEV'                              THEN 'DVCP'      
					WHEN rscartera = '130' AND rstipoper = 'DEV' AND rsrutcli <> @Rut_Central THEN 'DVCP'      
					WHEN rscartera = '111' AND rstipoper = 'VC'                               THEN 'DVVC'      
					WHEN rscartera = '121' AND rstipoper = 'VC'  AND b.inserie = 'ICAP'       THEN 'VICA' --AND rsrutcli <> @Rut_Central      
					WHEN rscartera = '121' AND rstipoper = 'VC'  AND b.inserie = 'ICOL'       THEN 'VICO'      
					WHEN rscartera = '130' AND rstipoper = 'VC'  AND b.inserie = 'ICAP'       THEN 'VICA' --'VCAB'      
					WHEN rscartera = '130' AND rstipoper = 'VC'  AND b.inserie = 'ICOL'       THEN 'VICO'   -- VB+- 02/01/2001      
					WHEN rscartera = '121' AND rstipoper = 'DEV' AND b.inserie = 'ICAP'       THEN 'DICA' --AND rsrutcli <> @Rut_Central      
					WHEN rscartera = '121' AND rstipoper = 'DEV' AND b.inserie = 'ICOL'       THEN 'DICO'      
					WHEN rscartera = '130' AND rstipoper = 'DEV' AND b.inserie = 'ICAP'       THEN 'DICA'--'DCAB      
					WHEN rscartera = '130' AND rstipoper = 'DEV' AND b.inserie = 'ICOL'       THEN 'DICO'      
					WHEN rscartera = '112' AND rstipoper = 'DEV'							  THEN 'DVCI'      
					WHEN rscartera = '114' AND rstipoper = 'DEV'							  THEN 'DVCP' -- 'DVIT' MAP 20060111      
					WHEN rscartera = '114' AND rstipoper = 'VC'								  THEN 'DVVC'      
					WHEN rscartera = '115' AND rstipoper = 'DEV'							  THEN 'DVVI'      
					WHEN rscartera = '150' AND rstipoper = 'DEV'                              THEN 'DIC'      
					WHEN rscartera = '159' AND rstipoper = 'DEV'                              THEN 'DVCP'      
					WHEN rscartera = '159' AND rstipoper = 'VC'                               THEN 'DVVC'      
					ELSE 'DEV' 
			END)                   , -- 03      
	       a.rsnumoper,	-- 04 rsnumoper      
	       a.rscorrela,	-- 05      
			(CASE	WHEN rscartera = '111'                            THEN ISNULL( b.inserie, '' )      
	                WHEN rscartera = '112' THEN ISNULL(b.inserie, '')
	                WHEN rscartera = '114' THEN ISNULL(b.inserie, '')
	                WHEN rscartera = '115' THEN ISNULL(b.inserie, '')
					WHEN rscartera = '121' AND DATEDIFF(day,rsfecinip,rsfecvtop)>365 THEN ISNULL( RTRIM(LTRIM(b.inserie)), '' )      
					WHEN rscartera = '121' THEN ISNULL(b.inserie, '') 
					WHEN rscartera = '130' THEN ISNULL(b.inserie, '')
					WHEN rscartera = '159' THEN ISNULL(b.inserie, '')
					ELSE '' 
			END)                                      , -- 06      
			(CASE	WHEN rscartera = 115 or rscartera = 112 or rscartera = 121 THEN CONVERT( CHAR(06), a.rsmonpact )      
					ELSE CONVERT(CHAR(06), a.rsmonemi) 
  END)                            , -- 07 monpact      
  CASE WHEN rstipoper = 'VC' THEN rscupamo      
	            ELSE rsvalcomp
	       END,	-- 08      
	       ISNULL(a.rsinteres, 0) + ISNULL(a.rsreajuste, 0),	-- 09      
  CASE WHEN rstipoper = 'VC' AND rscartera = '111' THEN rsflujo       
	            ELSE ISNULL(a.rsvppresenx, 0)
	       END,	-- 10      
	       0.0,	-- 11      
	       0.0,	-- 12      
       CASE WHEN rstipopero = 'RC' AND rsrutcli = @rut_central THEN 0       
	            WHEN rstipoper = 'VC' THEN rscupint
	            ELSE ISNULL(a.rsinteres, 0)
	       END,	-- 13      
      CASE WHEN (rstipopero = 'RC' AND rsrutcli = @rut_central) THEN 0       
	            WHEN rstipoper = 'VC' THEN rscuprea
	            ELSE ISNULL(a.rsreajuste, 0)
	       END,	-- 14      
     CASE WHEN rstipoper = 'VC' THEN rscupint      
	            ELSE ISNULL(a.rsinteres, 0)
	       END,	-- 15      
       CASE WHEN rstipoper = 'VC' THEN rscuprea      
	            ELSE ISNULL(a.rsreajuste, 0)
	       END,	-- 16      
       CASE WHEN rstipoper = 'VC' THEN rsflujo      
	            ELSE ISNULL(a.rsvppresenx, 0)
	       END,	-- 17      
	       0.0,	-- 18      
	       ISNULL(a.rsvppresen, 0),	-- 19 (Val.Compra Historico)      
	       0.0,	-- 20 (Dif Pacto pos)      
	       0.0,	-- 21 (Dif pacto neg)      
	       0.0,	-- 22 (Valor Mercado pos)      
	       0.0,	-- 23 (Valor Mercado neg)      
	      rscondpacto,	-- 24 (Condicion pacto)       
		CASE	WHEN rscartera = '111' AND rstipoper = 'VC'                        THEN CONVERT( CHAR(06), rsforpagv )
				WHEN rscartera = '121' AND rstipoper = 'VC' AND b.inserie = 'ICAP' THEN CONVERT( CHAR(06), rsforpagv )      
				WHEN rscartera = '121' AND rstipoper = 'VC' AND b.inserie = 'ICOL' THEN CONVERT( CHAR(06), rsforpagv )      
				WHEN rscartera = '130' AND rstipoper = 'VC' AND b.inserie = 'ICAP' THEN CONVERT( CHAR(06), rsforpagv )      
				WHEN rscartera = '130' AND rstipoper = 'VC' AND b.inserie = 'ICOL' THEN CONVERT( CHAR(06), rsforpagv )
				WHEN rscartera = '159' AND rstipoper = 'VC'                        THEN CONVERT( CHAR(06), rsforpagv )      
				ELSE rsforpagi
			END,	-- 25 (Forma de pago)      
	       rsforpagv,	-- 25.5      
	       rstipobono,	-- 26 (Tipo instrumento) ISNULL( h.motipobono, '' )      
       CASE WHEN rstipoletra = 'V' THEN '3'       
	            WHEN rstipoletra = 'F' THEN '4'
	            WHEN rstipoletra = 'E' THEN '2'
	            WHEN rstipoletra = 'O' THEN '1'
	            ELSE '0'
	       END,	-- 27                     --- select * from view_emisor where emrut = 97037000      
	       '',	-- 28 (Generico de emisor)      
	       ISNULL(a.rsvppresenx, 0),	-- 29 (Valor Futuro para vencimiento de interbancarios)      
       CASE WHEN rsrutemis = 97037000 THEN '1'       
	            ELSE '2'
	       END,	-- 30 97029000      
	       rsinstser,	-- 31      
	       rsnumdocu,	-- 32      
   CASE WHEN rscartera = '121'  THEN CONVERT( VARCHAR(10), rsrutcli )   
	            ELSE CONVERT(VARCHAR(10), rsrutemis)
	       END,	-- 33      
    CASE WHEN rscodigo =  20  AND rsrutemis  = @RUT_CLIENTE             THEN '1'      
	            WHEN rscodigo = 20 AND rsrutemis <> @RUT_CLIENTE THEN '2'
	            WHEN rstipopero <> 'IB' THEN '0'
	            WHEN rstipopero = 'IB' AND rstipoper = 'VC' THEN rscondpacto -- <<Marca>> --
				WHEN rstipopero  = 'IB'                                           THEN      
                   CASE WHEN rsrutcli  = @rut_central                                         THEN '9'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '10'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '11'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '12'    
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '13'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '14'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '15'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '16'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '17'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '18'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '19'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '20'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '21'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '22'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '23'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '24'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '25'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '26'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '27'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '28'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '29'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '30'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '31'      
						WHEN rsrutcli  = @rut_estado                                          THEN '1'      
						WHEN rsrutcli <> @rut_estado                                         THEN '5'																								     
	                                             ELSE '0'
	                                        END
           ELSE CASE WHEN rsrutcli  = @rut_central                                         THEN '9'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '10'       
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '11'       
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '12'       
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '13'       
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '14'       
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '15'       
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '16'       
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '17'       
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '18'       
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '19'       
						-- Aca se Agregaron las formas de Pago DVP/COMPENSACION
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '20'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '21'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '22'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 135 AND rsforpagv = 135 THEN '23'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '24'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '25'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '26'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '27'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '28'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '29'      
					WHEN rsrutcli  = @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '30'      
					WHEN rsrutcli <> @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '31'      
					WHEN rsrutcli = @rut_estado THEN '1'
					WHEN rsrutcli <> @rut_estado THEN '5'
	                      ELSE '0'
	                 END
	       END,	-- 34      
  CASE WHEN rstipoper = 'VC' THEN rsflujo      
	            ELSE ISNULL(a.rsinteres, 0)
	       END,
	       rstipopero,
	       (CASE WHEN rsinteres < 0 THEN (rsinteres * -1) ELSE 0 END),
	       (CASE WHEN rsreajuste < 0 THEN (rsreajuste * -1) ELSE 0 END),
    (CASE WHEN rstipoper = 'IB' THEN (CASE WHEN datediff(dd,rsfecinip,rsfecvtop) > 365 THEN 2 ELSE 1 END) ELSE datediff(dd,rsfecinip,rsfecvtop) END) ,      
	       rsrutcli,
	       rscodcli,
	       rsfecha,
  ((CASE WHEN rstipopero = 'RC'  AND rsrutcli = @rut_central THEN 0       
	                   WHEN rstipoper = 'VC' THEN rscupint 
	                   ELSE ISNULL(a.rsinteres, 0) 
						END) + (CASE WHEN (rstipopero = 'RC'  AND rsrutcli = @rut_central) THEN 0       
	                    WHEN rstipoper = 'VC' THEN rscuprea
	                    ELSE ISNULL(a.rsreajuste, 0)
			END )),      
	       rsnominal,
	       0,
	       0,
	       0,
         CASE WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 20 AND rstipoper = 'DEV' AND a.prima_descuento_dia > 0 THEN a.prima_descuento_dia ELSE 0 END,      
         CASE WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 20 AND rstipoper = 'DEV' AND a.prima_descuento_dia < 0 THEN (a.prima_descuento_dia*-1) ELSE 0 END,      
	       0,
	       0,
	       0,
  'CondPactoCliente' =		CASE WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> 97029000 AND c.cltipcli <> 1 THEN '1'      
								  WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> 97029000 AND c.cltipcli  = 1 THEN '2'      
								  WHEN a.rstipopero <> 'CI' AND a.rsrutcli  = 97029000 AND c.cltipcli  = 1 THEN '3'      
								  WHEN a.rstipopero  = 'CI' AND a.rsrutcli  = 97029000                     THEN '3' --> No Estaba      
								  WHEN a.rstipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'      
								  WHEN a.rstipopero  = 'CI' AND c.cltipcli  = 1          THEN '5'      
	                                 ELSE '0'
	                            END,
        'condicion_entrega' = CASE WHEN (a.rsforpagi = 128 or a.rsforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
									WHEN (a.rsforpagi = 129 or a.rsforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END      
									WHEN (a.rsforpagi = 130 or a.rsforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END      
									WHEN (a.rsforpagi = 132 or a.rsforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END      
									WHEN (a.rsforpagi = 133 or a.rsforpagv = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5  ELSE 16 END  
									WHEN (a.rsforpagi = 134 or a.rsforpagv = 134) THEN CASE WHEN c.cltipcli = 1 THEN 6  ELSE 17 END      
									WHEN (a.rsforpagi = 135 or a.rsforpagv = 135) THEN CASE WHEN c.cltipcli = 1 THEN 7  ELSE 18 END      
									WHEN (a.rsforpagi = 136 or a.rsforpagv = 136) THEN CASE WHEN c.cltipcli = 1 THEN 8  ELSE 19 END      
									WHEN (a.rsforpagi = 137 or a.rsforpagv = 137) THEN CASE WHEN c.cltipcli = 1 THEN 9  ELSE 20 END      
									WHEN (a.rsforpagi = 138 or a.rsforpagv = 138) THEN CASE WHEN c.cltipcli = 1 THEN 10 ELSE 21 END      
									WHEN (a.rsforpagi = 139 or a.rsforpagv = 139) THEN CASE WHEN c.cltipcli = 1 THEN 11 ELSE 22 END      
									WHEN (a.rsforpagi =   2 or a.rsforpagv =   2) THEN 23      
									WHEN (a.rsforpagi =   3 or a.rsforpagv =   3) THEN 24      
									WHEN (a.rsforpagi =   5 or a.rsforpagv =   5) THEN 25      
									WHEN (a.rsforpagi =   6 or a.rsforpagv =   6) THEN 26      
									WHEN (a.rsforpagi =   7 or a.rsforpagv =   7) THEN 27      
									WHEN (a.rsforpagi =   8 or a.rsforpagv =   8) THEN 28      
									WHEN (a.rsforpagi =  11 or a.rsforpagv =  11) THEN 29      
									WHEN (a.rsforpagi =  12 or a.rsforpagv =  12) THEN 30      
									WHEN (a.rsforpagi =  13 or a.rsforpagv =  13) THEN 31      
									WHEN (a.rsforpagi =  14 or a.rsforpagv =  14) THEN 32      
									WHEN (a.rsforpagi =  15 or a.rsforpagv =  15) THEN 33      
									WHEN (a.rsforpagi =  16 or a.rsforpagv =  16) THEN 34      
									WHEN (a.rsforpagi =  17 or a.rsforpagv =  17) THEN 35      
									WHEN (a.rsforpagi =  19 or a.rsforpagv =  19) THEN 36      
									WHEN (a.rsforpagi =  20 or a.rsforpagv =  20) THEN 37      
									WHEN (a.rsforpagi = 100 or a.rsforpagv = 100) THEN 38      
									WHEN (a.rsforpagi = 102 or a.rsforpagv = 102) THEN 39      
									WHEN (a.rsforpagi = 103 or a.rsforpagv = 103) THEN 40      
									WHEN (a.rsforpagi = 104 or a.rsforpagv = 104) THEN 41      
									WHEN (a.rsforpagi = 105 or a.rsforpagv = 105) THEN 42      
									WHEN (a.rsforpagi = 106 or a.rsforpagv = 106) THEN 43 
									WHEN (a.rsforpagi = 118 or a.rsforpagv = 118) THEN 44      
									WHEN (a.rsforpagi = 122 or a.rsforpagv = 122) THEN 45      
									WHEN (a.rsforpagi = 123 or a.rsforpagv = 123) THEN 46      
									WHEN (a.rsforpagi = 124 or a.rsforpagv = 124) THEN 47      
									WHEN (a.rsforpagi = 125 or a.rsforpagv = 125) THEN 48      
									WHEN (a.rsforpagi = 131 or a.rsforpagv = 131) THEN 49      
									WHEN (a.rsforpagi = 140 or a.rsforpagv = 140) THEN 50      
									WHEN (a.rsforpagi = 141 or a.rsforpagv = 141) THEN 51      
									WHEN (a.rsforpagi = 142 or a.rsforpagv = 142) THEN 52      
									WHEN (a.rsforpagi = 143 or a.rsforpagv = 143) THEN 53      
	                                  ELSE 0
	                             END
	FROM   #TMP_MDRS a
			INNER JOIN BacParamSuda..INSTRUMENTO b ON b.incodigo = a.rscodigo      
			INNER JOIN BacParamSuda..CLIENTE     c ON c.clrut    = a.rsrutcli AND c.clcodigo = a.rscodcli      
      ,     MDAC      
	WHERE  rsfecha >= @Fecha_Hoy
	AND rsfecha < @fecha_prox
	AND rscartera <> '211'
	AND rscodigo <> 98
	AND rstipoper NOT IN ('DVP', 'VCP') 
	AND		 NOT EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.rsnumoper
												AND  l.LCGP_CORRELATIVO  = a.rscorrela
												)
	-- cambiado Hoy 18 04 2005      
	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Actualización Archivo de Devengamiento en Renta Fija Contabiliza.... ! ',16,6,'ERROR.')
        PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA  ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END 

	/*=======================================================================*/ 
	/* Llena Renta Fija Movimientos LCGP VI (VILCG / RCLCG)                  */ 
	/*=======================================================================*/      
	INSERT INTO BAC_CNT_CONTABILIZA
   (    id_sistema      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06  
	    moneda_instrumento,	-- 07    
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    valor_comprahis,	-- 18      
	    dif_ant_pacto_pos,	-- 19      
	    dif_ant_pacto_neg,	-- 20      
	    dif_valor_mercado_pos,	-- 21      
	    dif_valor_mercado_neg,	-- 22      
	    condicion_pacto,	-- 23      
	    tipo_cliente,	-- 24      
	    forma_pago,	-- 25      
	    tipo_emisor,	-- 26      
	    nominalpesos,	-- 27      
	    forma_pago_entregamos,	-- 28      
	    tipo_instrumento,	-- 29      
	    condicion_entrega,	-- 30      
	    tipo_operacion_or,	-- 31      
	    instser,	-- 32      
	    documento,	-- 33      
	    emisor,	-- 34      
	    cartera_origen,	-- 35      
	    valor_final,	-- 36      
	    clasificacion_cliente,	-- 37 -- aca      
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    Tipo_Cartera,
	    CondPactoCliente,
	    EstObj,
	    Tipo_Bono,

		Utilidad_Avr_Patrimonio		,		--> Ventas AFS
		Perdida_Avr_Patrimonio		,		--> Ventas AFS
		Diferencia_Precio_Pos		,		--> Ventas AFS
		Diferencia_Precio_Neg				--> Ventas AFS
	  )
	SELECT 'BTR',													-- 01      
		   'MOV',													-- 02      
			CASE WHEN a.motipoper = 'RC' THEN 'RCLCG'   
	             WHEN a.motipoper = 'VI' THEN 'VILCG'
                ELSE a.motipoper
	       END,														-- 03      
	       a.monumoper,												-- 04      
	       a.mocorrela,												-- 05      
		   b.inserie,												-- 06      
--	       case when CONVERT(CHAR(06), a.momonpact)=0 then 998 else CONVERT(CHAR(06), a.momonpact) end,							-- 07      
	       CONVERT(CHAR(06), a.momonpact),							-- 07      
			0      ,												-- 08      
    CASE WHEN a.motipoper = 'RC' THEN a.movpresen   --a.movalvenp      
	            WHEN a.motipoper = 'RV' THEN a.movalvenp
	            WHEN a.motipoper = 'VI' THEN (a.movalcomp + a.mointeres + a.moreajuste)
                WHEN a.motipoper = 'VP' AND a.morutemi <> @RUT_CORPBNC AND b.incodigo = 20 THEN (a.movalcomp + a.mointeres + a.moreajuste)      
                WHEN a.motipoper = 'VP' AND a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 THEN a.movpresen -- a.movaltasemi      
	            ELSE a.movpresen
	       END,	-- 09      
	       
		CASE	WHEN a.motipoper = 'RC' THEN a.movalinip 
				ELSE a.movalven 
				END   , -- 10
	       a.moutilidad,	-- 11      
	       ABS(a.moperdida),	-- 12      
	       
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0      
	            ELSE mointeres
	       END,	-- 13      
    CASE WHEN  (motipoper = 'VI'  AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0         
	            ELSE moreajuste
	       END,	-- 14      
    CASE WHEN (motipoper = 'VI'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN mointpac
	            WHEN motipoper = 'RV' THEN a.mointeresp --a.movalvenp-a.movalven --> Revisar. 09-09-2009
	            ELSE a.mointeres
	 END,	-- 15 (interes pacto)      
    CASE WHEN (motipoper = 'VI' AND morutcli = @rut_central) or ( motipoper = 'RC'  AND morutcli = @rut_central) THEN 0       
	            WHEN motipoper = 'RC' THEN moreapac
	            WHEN motipoper = 'RV' THEN moreapac
	            ELSE a.moreajuste
	       END,	-- 16 (reajuste pacto)      
	       0.0,	-- 17      
                CASE WHEN a.motipoper = 'VI' THEN a.movalcomp                   
	            WHEN a.motipoper = 'RC' THEN a.movalcomp
	            ELSE a.movalvenp
	       END,	-- 18      
	       a.moutilidad,	-- 19 (Dif pacto pos)      
	       a.moperdida,	-- 20 (Dif Pacto neg  VBARRA 31/05/2000)      
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb > 0 THEN ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0) = 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END ),a.modifsb) 
                  WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb > 0 THEN (ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.modifsb = 0 THEN 0.
	            ELSE a.moutilidad END,	-- 21 (Valor Mercado pos)       
	       CASE WHEN a.motipoper = 'TM' AND a.mostatreg = ' ' AND a.modifsb < 0 THEN (ISNULL((VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob / 100), 0) END),a.modifsb) * -1)
	            WHEN a.motipoper = 'TM' AND a.mostatreg = 'R' AND a.modifsb < 0 THEN ISNULL((VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob / 100), 0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob / 100), 0) END),a.modifsb)
 	            ELSE a.moutilidad END,	-- 22 (valor Mercado neg)      
	       
	       'condPacto' = CASE  WHEN (a.motipoper = 'RC' OR a.motipoper = 'VI' OR a.motipoper = 'RCA') AND a.morutcli = @rut_central THEN 
								CASE WHEN a.moforpagi = 124 AND a.moforpagv = 124 THEN '1'
									 WHEN a.moforpagi  = 128 AND a.moforpagv = 128 THEN '2'
                                     WHEN a.moforpagi  = 129 AND a.moforpagv = 129 THEN '3'
                                     WHEN a.moforpagi  = 130 AND a.moforpagv = 130 THEN '4'
									 WHEN a.moforpagi  = 132 AND a.moforpagv = 132 THEN '5'
									 WHEN a.moforpagi = 133 AND a.moforpagv = 133 THEN '6'
									 WHEN a.moforpagi  = 134 AND a.moforpagv = 134 THEN '22'
									 WHEN a.moforpagi  = 135 AND a.moforpagv = 135 THEN '23'
									 WHEN a.moforpagi  = 136 AND a.moforpagv = 136 THEN '24'
									 WHEN a.moforpagi = 137 AND a.moforpagv = 137 THEN '25'
									 WHEN a.moforpagi = 138 AND a.moforpagv  = 138 THEN '26'
									 WHEN a.moforpagi = 139 AND a.moforpagv = 139 THEN '27'
	                             ELSE '7'
								END
							ELSE '7'	--+++FMO 20190218 por problemas de null en este campo
                          END,	--23      
            CASE WHEN @RUT_CORPBNC = a.morutemi THEN '1' ELSE '2' END   ,--24      
			CASE WHEN motipoper = 'RC' OR motipoper = 'RV' THEN CONVERT( CHAR(06), moforpagv )      
	            ELSE CONVERT(CHAR(06), a.moforpagi)
	       END,	-- 25 (Forma de pago)      
	       
	       ISNULL(e.emgeneric, ''),	-- 26 (Generico de emisor)      
		   a.monominalp,	-- 27   
	       a.moforpagv,	-- 28 --ZZZ      
    CASE WHEN motipoper <> 'IC' AND motipoper <> 'RIC' THEN a.motipobono      
      ELSE ( SELECT tipo_deposito      
	                     FROM   GEN_CAPTACION
	                     WHERE  numero_operacion = monumoper
       AND    correla_operacion = mocorrela )      
	END,	-- 29 (Tipo Bono)
	'condicion_entrega' =  CASE WHEN (a.moforpagi = 128 or a.moforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
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
	                                  ELSE 0
	                             END,	-- 30      
    
	             '2'
	       ,	-- 31    
	       moinstser,	-- 32      
	       monumdocu,	-- 33      
           CONVERT(VARCHAR(10), morutemi)	       ,	-- 34      
	       motipopero,	-- 35       
	       movalvenp,	-- 36      
		  'clasificacion_cliente' = CASE WHEN mocodigo = 20 AND morutemi =  @RUT_CLIENTE  THEN '1'      
										 WHEN mocodigo = 20 AND morutemi <> @RUT_CLIENTE  THEN '2'      
	                                     WHEN motipoper <> 'IB' THEN '0'
	                                 ELSE --- interbancarios ---      
										CASE WHEN morutcli  = @rut_Central                                          THEN '9'      
                                                ELSE '0'
	                                         END
	                                 END,	-- 37      
	CASE WHEN mointeres < 0 THEN (mointeres *-1) ELSE 0 END,      
    CASE WHEN moreajuste < 0 THEN (moreajuste *-1) ELSE 0 END,      
    CASE WHEN motipoper = 'IB' THEN (CASE WHEN datediff(dd,mofecinip,mofecvenp) > 365 THEN 2 ELSE 1 END)      
          ELSE datediff(dd,mofecinip,mofecvenp)      
	       END,
	       morutcli,
	       mocodcli,
	       mofecpro,
	       ROUND(monominal, 0),
	       'valor_tasa_emision' = CASE	WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'VP' THEN a.movaltasemi
										WHEN a.morutemi <> @RUT_CORPBNC AND a.motipoper= 'VP' THEN 0
										WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper = 'CP' THEN a.movaltasemi ELSE a.movalcomp
	                              END,
	       'prima_total'		= CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc > 0 THEN a.moprimadesc ELSE 0 END,
	       'descuento_total'	= CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') AND a.moprimadesc < 0 THEN (a.moprimadesc * -1) ELSE 0 END,
	       'prima_dia'			= 0,
	       'descuento_dia'		= 0,
	       'valor_pte_emision'	= CASE WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper IN ('CP', 'VP') THEN  a.movaltasemi ELSE 0 END,
	       'dif_par_pos'		= CASE  WHEN a.morutemi = @RUT_CORPBNC AND b.incodigo =  20 AND a.motipoper = 'VP' AND a.mocapitali > 0 THEN a.mocapitali ELSE 0 END,
		   'dif_par_neg'        = CASE WHEN a.morutemi =  @RUT_CORPBNC AND b.incodigo = 20 AND a.motipoper ='VP' AND a.mocapitali < 0 THEN (a.mocapitali*-1) ELSE 0 END      
		, 'TIPO_CARTERA'  = 0        
		, 'CondPactoCliente' = '3'      
		, 'EstadoObjeto' = '' 
        , 'Tipo_Bono'			=  0
		,	Utilidad_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) >= 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Perdida_Avr_Patrimonio		= case	when (a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))) < 0 then 
												ABS((a.Resultado_Dif_Mercado + abs((a.Resultado_Dif_Precio + a.Resultado_Dif_Mercado)- (a.movalven - a.movpresen))))
											else 0
										end
	,	Diferencia_Precio_Pos		= case when a.Resultado_Dif_Precio	>= 0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
	,	Diferencia_Precio_Neg		= case when a.Resultado_Dif_Precio	<  0 then abs(a.Resultado_Dif_Precio)	else 0 end	--> Ventas AFS
FROM 	MDMO   a  
		LEFT JOIN VALORIZACION_MERCADO VM ON a.motipoper  = 'TM'      
				AND VM.tipo_operacion		<> 'CG'
	            AND VM.fecha_valorizacion	= @FechaBusquedaValorizacion
	            AND VM.id_sistema			= 'BTR'
	            AND VM.rmnumoper			= a.monumoper
	            AND VM.rmnumdocu			= a.monumdocu
	            AND VM.rmcorrela			= a.mocorrela
		LEFT JOIN VALORIZACION_MERCADO VMA ON a.motipoper  = 'TM'      
				AND VMA.tipo_operacion		<> 'CG'
	            AND VMA.fecha_valorizacion	= @FechaBusquedaValorizacionAyer
	            AND VMA.id_sistema			= 'BTR'
	            AND VMA.rmnumoper			= a.monumoper
	            AND VMA.rmnumdocu			= a.monumdocu
	            AND VMA.rmcorrela			= a.mocorrela

		LEFT JOIN VIEW_EMISOR  e ON e.emrut   = a.morutemi      
		LEFT JOIN VIEW_INSTRUMENTO b ON b.incodigo  = a.mocodigo      
	,	VIEW_CLIENTE  c      
	,	MDAC   m      
	
	WHERE	a.mofecpro		 = @fecha_hoy
	AND		a.mostatreg		<> 'A'
	AND		a.motipoper		NOT IN ('RCA', 'RVA', 'CPP', 'FLI', 'VFM', 'IC','RIC' )
	and		a.motipopero	<> 'CG'
	AND		(c.clrut = a.morutcli AND c.clcodigo = a.mocodcli)
	AND		 EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.monumoper
												AND  l.LCGP_CORRELATIVO  = a.mocorrela
												)
	and motipoper<>'TM'

	IF @@ERROR <> 0 
	BEGIN
		SET NOCOUNT OFF 
		RAISERROR('¡ Err. Falla Agregando Movimientos Renta Fija Archivo Contabiliza.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA (LCGP) CONTABILIZA.'      
	    RETURN 1
	END
	/*=======================================================================*/ 
	/* Llena Renta Fija Devengo  LCGP VI (DVVIL)                                  */ 
	/*=======================================================================*/      
	INSERT INTO bac_cnt_contabiliza
	  ( id_sistema                      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08      
	    valor_presente,	-- 09      
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    nominalpesos,	-- 18      
	    valor_comprahis,	-- 19      
	    dif_ant_pacto_pos,	-- 20      
	    dif_ant_pacto_neg,	-- 21      
	    dif_valor_mercado_pos,	-- 22      
	    dif_valor_mercado_neg,	-- 23      
	    condicion_pacto,	-- 24      
	    forma_pago,	-- 25      
	    forma_pago_entregamos,	-- 25.5      
	    tipo_instrumento,	-- 26      
	    tipo_cliente,	-- 27      
	    tipo_emisor,	-- 28      
	    valor_futuro,	-- 29      
	    comquien,	-- 30      
	    instser,	-- 31      
	    documento,	-- 32      
	    emisor,	-- 33      
	    clasificacion_cliente,	-- 34            
	    valor_final,
	    cartera_origen,
	    interes_negativo,
	    reajuste_negativo,
	    plazo,
	    cliente,
	    codcli,
	    fecha_proceso,
	    Interes_Reajuste,
	    nominal,
	    valor_tasa_emision,
	    prima_total,
	    descuento_total,
	    prima_dia,
	    descuento_dia,
	    valor_pte_emision,
	    dif_par_pos,
	    dif_par_neg,
	    CondPactoCliente,
	    condicion_entrega
	  )
	SELECT	'BTR',										-- 01      
			'DEV',										-- 02 
			'DVCP', /*Cambio VBarra */ -->'DVVIL',									-- 03      
			a.rsnumoper,								-- 04 
			a.rscorrela,								-- 05      
			ISNULL(b.inserie, ''), -- 06      
			--> /*Cambio VBarra */ CONVERT( CHAR(06), a.rsmonpact )      , -- 07 monpact      
			CONVERT( CHAR(06), a.rsmonemi )      , 
			rsvalcomp,	-- 08      
	        ISNULL(a.rsinteres, 0) + ISNULL(a.rsreajuste, 0),	-- 09      
			ISNULL(a.rsvppresenx, 0)	       ,	-- 10      
	       0.0,	-- 11      
	       0.0,	-- 12      
       CASE WHEN rstipopero = 'RC' AND rsrutcli = @rut_central THEN 0       
	            WHEN rstipoper = 'VC' THEN rscupint
	            ELSE ISNULL(a.rsinteres, 0)
	       END,	-- 13      
       CASE WHEN (rstipopero = 'RC' AND rsrutcli = @rut_central) THEN 0       
	            WHEN rstipoper = 'VC' THEN rscuprea
	            ELSE ISNULL(a.rsreajuste, 0)
	       END,	-- 14      
       CASE WHEN rstipoper = 'VC' THEN rscupint      
	            ELSE ISNULL(a.rsinteres, 0)
	       END,	-- 15      
       CASE WHEN rstipoper = 'VC' THEN rscuprea      
	            ELSE ISNULL(a.rsreajuste, 0)
	       END,	-- 16      
       CASE WHEN rstipoper = 'VC' THEN rsflujo      
	            ELSE ISNULL(a.rsvppresenx, 0)
	       END,	-- 17      
	       0.0,	-- 18      
	       ISNULL(a.rsvppresen, 0),	-- 19 (Val.Compra Historico)      
	       0.0,	-- 20 (Dif Pacto pos)      
	       0.0,	-- 21 (Dif pacto neg)      
	       0.0,	-- 22 (Valor Mercado pos)      
	       0.0,	-- 23 (Valor Mercado neg)      
	      rscondpacto,	-- 24 (Condicion pacto)       
		  rsforpagi,	-- 25 (Forma de pago)      
	       rsforpagv,	-- 25.5      
	       rstipobono,	-- 26 (Tipo instrumento) ISNULL( h.motipobono, '' )      
			'0',	-- 27                     --- select * from view_emisor where emrut = 97037000      
	       '',	-- 28 (Generico de emisor)      
	       ISNULL(a.rsvppresenx, 0),	-- 29 (Valor Futuro para vencimiento de interbancarios)      
			'2',	-- 30 @rut_central      
	       rsinstser,	-- 31      
	       rsnumdocu,	-- 32      
		CONVERT(VARCHAR(10), rsrutemis),	-- 33      
		CASE	WHEN rscodigo =  20  AND rsrutemis  = @RUT_CLIENTE             THEN '1'      
	            WHEN rscodigo = 20 AND rsrutemis <> @RUT_CLIENTE THEN '2'
	            WHEN rstipopero <> 'IB' THEN '0'
	            WHEN rstipopero = 'IB' AND rstipoper = 'VC' THEN rscondpacto -- <<Marca>> --
				WHEN rstipopero  = 'IB'                                           THEN      
				CASE    WHEN rsrutcli  = @rut_central                                         THEN '9'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '10'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '11'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '12'    
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '13'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '14'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '15'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '16'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '17'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '18'       
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '19'       
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '20'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '21'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '22'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '23'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '24'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '25'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '26'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '27'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '28'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '29'      
						WHEN rsrutcli  = @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '30'      
						WHEN rsrutcli <> @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '31'      
						WHEN rsrutcli  = @rut_estado                                          THEN '1'      
						WHEN rsrutcli <> @rut_estado                                         THEN '5'      
																	 ELSE '0'
	                                        END
           ELSE CASE WHEN rsrutcli  = @rut_central                                         THEN '9'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '10'       
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 128 AND rsforpagv = 128  THEN '11'       
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '12'       
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 129 AND rsforpagv = 129  THEN '13'       
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '14'       
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 130 AND rsforpagv = 130  THEN '15'       
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '16'       
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 132 AND rsforpagv = 132  THEN '17'       
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '18'       
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 133 AND rsforpagv = 133  THEN '19'       
	                           -- Aca se Agregaron las formas de Pago DVP/COMPENSACION
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '20'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 134 AND rsforpagv = 134  THEN '21'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 135 AND rsforpagv = 135  THEN '22'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 135 AND rsforpagv = 135 THEN '23'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '24'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 136 AND rsforpagv = 136  THEN '25'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '26'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 137 AND rsforpagv = 137  THEN '27'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '28'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 138 AND rsforpagv = 138  THEN '29'      
     WHEN rsrutcli  = @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '30'      
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 139 AND rsforpagv = 139  THEN '31'      
	                      WHEN rsrutcli = @rut_estado THEN '1'
	                      WHEN rsrutcli <> @rut_estado THEN '5'
	                      ELSE '0'
	                 END
	       END,	-- 34      
  CASE WHEN rstipoper = 'VC' THEN rsflujo      
	            ELSE ISNULL(a.rsinteres, 0)
	       END,
	       rstipopero,
	       (CASE WHEN rsinteres < 0 THEN (rsinteres * -1) ELSE 0 END),
	       (CASE WHEN rsreajuste < 0 THEN (rsreajuste * -1) ELSE 0 END),
    (CASE WHEN rstipoper = 'IB' THEN (CASE WHEN datediff(dd,rsfecinip,rsfecvtop) > 365 THEN 2 ELSE 1 END) ELSE datediff(dd,rsfecinip,rsfecvtop) END) ,      
	       rsrutcli,
	       rscodcli,
	       rsfecha,
  ((CASE WHEN rstipopero = 'RC'  AND rsrutcli = @rut_central THEN 0       
	                   WHEN rstipoper = 'VC' THEN rscupint 
	                   ELSE ISNULL(a.rsinteres, 0) 
          END) + (CASE WHEN (rstipopero = 'RC'  AND rsrutcli = @rut_central) THEN 0       
	                    WHEN rstipoper = 'VC' THEN rscuprea
	                    ELSE ISNULL(a.rsreajuste, 0)
     END )),      
	       rsnominal,
	       0,
	       0,
	       0,
         CASE WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 20 AND rstipoper = 'DEV' AND a.prima_descuento_dia > 0 THEN a.prima_descuento_dia ELSE 0 END,      
         CASE WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 20 AND rstipoper = 'DEV' AND a.prima_descuento_dia < 0 THEN (a.prima_descuento_dia*-1) ELSE 0 END,      
	       0,
	       0,
	       0,
  'CondPactoCliente' = CASE WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> @rut_central AND c.cltipcli <> 1 THEN '1'      
      WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> @rut_central AND c.cltipcli  = 1 THEN '2'      
      WHEN a.rstipopero <> 'CI' AND a.rsrutcli  = @rut_central AND c.cltipcli  = 1 THEN '3'      
      WHEN a.rstipopero  = 'CI' AND a.rsrutcli  = @rut_central                     THEN '3' --> No Estaba      
      WHEN a.rstipopero  = 'CI' AND c.cltipcli <> 1                            THEN '4'      
      WHEN a.rstipopero  = 'CI' AND c.cltipcli  = 1          THEN '5'      
	                                 ELSE '0'
	                            END,
        'condicion_entrega' = CASE	WHEN (a.rsforpagi = 128 or a.rsforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END      
									WHEN (a.rsforpagi = 129 or a.rsforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END      
									WHEN (a.rsforpagi = 130 or a.rsforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END      
									WHEN (a.rsforpagi = 132 or a.rsforpagv = 130) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END      
									WHEN (a.rsforpagi = 133 or a.rsforpagv = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5  ELSE 16 END  
									WHEN (a.rsforpagi = 134 or a.rsforpagv = 134) THEN CASE WHEN c.cltipcli = 1 THEN 6  ELSE 17 END      
									WHEN (a.rsforpagi = 135 or a.rsforpagv = 135) THEN CASE WHEN c.cltipcli = 1 THEN 7  ELSE 18 END      
									WHEN (a.rsforpagi = 136 or a.rsforpagv = 136) THEN CASE WHEN c.cltipcli = 1 THEN 8  ELSE 19 END      
									WHEN (a.rsforpagi = 137 or a.rsforpagv = 137) THEN CASE WHEN c.cltipcli = 1 THEN 9  ELSE 20 END      
									WHEN (a.rsforpagi = 138 or a.rsforpagv = 138) THEN CASE WHEN c.cltipcli = 1 THEN 10 ELSE 21 END      
									WHEN (a.rsforpagi = 139 or a.rsforpagv = 139) THEN CASE WHEN c.cltipcli = 1 THEN 11 ELSE 22 END      
									WHEN (a.rsforpagi =   2 or a.rsforpagv =   2) THEN 23      
									WHEN (a.rsforpagi =   3 or a.rsforpagv =   3) THEN 24      
									WHEN (a.rsforpagi =   5 or a.rsforpagv =   5) THEN 25      
									WHEN (a.rsforpagi =   6 or a.rsforpagv =   6) THEN 26      
									WHEN (a.rsforpagi =   7 or a.rsforpagv =   7) THEN 27      
									WHEN (a.rsforpagi =   8 or a.rsforpagv =   8) THEN 28      
									WHEN (a.rsforpagi =  11 or a.rsforpagv =  11) THEN 29      
									WHEN (a.rsforpagi =  12 or a.rsforpagv =  12) THEN 30      
									WHEN (a.rsforpagi =  13 or a.rsforpagv =  13) THEN 31      
									WHEN (a.rsforpagi =  14 or a.rsforpagv =  14) THEN 32      
									WHEN (a.rsforpagi =  15 or a.rsforpagv =  15) THEN 33      
									WHEN (a.rsforpagi =  16 or a.rsforpagv =  16) THEN 34      
									WHEN (a.rsforpagi =  17 or a.rsforpagv =  17) THEN 35      
									WHEN (a.rsforpagi =  19 or a.rsforpagv =  19) THEN 36      
									WHEN (a.rsforpagi =  20 or a.rsforpagv =  20) THEN 37      
									WHEN (a.rsforpagi = 100 or a.rsforpagv = 100) THEN 38      
									WHEN (a.rsforpagi = 102 or a.rsforpagv = 102) THEN 39      
									WHEN (a.rsforpagi = 103 or a.rsforpagv = 103) THEN 40      
									WHEN (a.rsforpagi = 104 or a.rsforpagv = 104) THEN 41      
									WHEN (a.rsforpagi = 105 or a.rsforpagv = 105) THEN 42      
									WHEN (a.rsforpagi = 106 or a.rsforpagv = 106) THEN 43 
									WHEN (a.rsforpagi = 118 or a.rsforpagv = 118) THEN 44      
									WHEN (a.rsforpagi = 122 or a.rsforpagv = 122) THEN 45      
									WHEN (a.rsforpagi = 123 or a.rsforpagv = 123) THEN 46      
									WHEN (a.rsforpagi = 124 or a.rsforpagv = 124) THEN 47      
									WHEN (a.rsforpagi = 125 or a.rsforpagv = 125) THEN 48      
									WHEN (a.rsforpagi = 131 or a.rsforpagv = 131) THEN 49      
									WHEN (a.rsforpagi = 140 or a.rsforpagv = 140) THEN 50      
									WHEN (a.rsforpagi = 141 or a.rsforpagv = 141) THEN 51      
									WHEN (a.rsforpagi = 142 or a.rsforpagv = 142) THEN 52      
									WHEN (a.rsforpagi = 143 or a.rsforpagv = 143) THEN 53      
	                                  ELSE 0
	                             END
	FROM   #TMP_MDRS a
			INNER JOIN BacParamSuda..INSTRUMENTO b ON b.incodigo = a.rscodigo      
			INNER JOIN BacParamSuda..CLIENTE     c ON c.clrut    = a.rsrutcli AND c.clcodigo = a.rscodcli      
      ,     MDAC      
	WHERE  rsfecha >= @Fecha_Hoy
	AND rsfecha < @fecha_prox
	AND rscartera <> '211'
	AND rscodigo <> 98
	AND rstipoper NOT IN ('DVP', 'VCP') 
	AND		  EXISTS( SELECT 1 FROM lcgp_vi l WHERE l.LCGP_OPERACION  = a.rsnumoper
												AND  l.LCGP_CORRELATIVO  = a.rscorrela
												)
	
	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Actualización Archivo de Devengamiento en Renta Fija Contabiliza.... ! ',16,6,'ERROR.')
        PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA (LCGP) ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END 







	--      UPDATE BAC_CNT_CONTABILIZA SET moneda_instrumento = 999 WHERE codigo_instrumento = 'FMUTUO'      
      DELETE BAC_CNT_CONTABILIZA WHERE codigo_instrumento = 'FMUTUO' AND tipo_movimiento = 'DEV'      
	




	----------------------------------------------------------------------------------------------------
	-- <VENCIMIENTO FDOS MUTUOS>------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------      
	
	/*=======================================================================*/ 
	/* Llena Renta Fija Vencimientos Fondos Mutuos     */ 
	/*=======================================================================*/      
	INSERT INTO BAC_CNT_CONTABILIZA
 ( id_sistema                      , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_compra,	-- 08 --> Valor Inicial      
	    valor_presente,	-- 09       
	    valor_venta,	-- 10      
	    utilidad,	-- 11      
	    perdida,	-- 12      
	    interes_papel,	-- 13      
	    reajuste_papel,	-- 14      
	    interes_pacto,	-- 15      
	    reajuste_pacto,	-- 16      
	    valor_cupon,	-- 17      
	    nominalpesos,	-- 18      
	    valor_comprahis,	-- 19      
	    dif_ant_pacto_pos,	-- 20      
	    dif_ant_pacto_neg,	-- 21      
	    dif_valor_mercado_pos,	-- 22      
	    dif_valor_mercado_neg,	-- 23      
	    condicion_pacto,	-- 24      
	    forma_pago,	-- 25      
	    forma_pago_entregamos,	-- 25.5      
	    tipo_instrumento,	-- 26      
	    tipo_cliente,	-- 27      
	    tipo_emisor,	-- 28      
	    valor_futuro,	-- 29      
	    comquien,	-- 30  
	    instser,	-- 31      
	    documento,	-- 32      
	    emisor,	-- 33      
	    clasificacion_cliente,	-- 34            
	    valor_final,	--       
	    cartera_origen,	--       
	    interes_negativo,	--     
	    reajuste_negativo,	--       
	    plazo,	--       
	    cliente,	--       
	    codcli,	--       
	    fecha_proceso,	--       
	    Interes_Reajuste,	--       
	    nominal,	--       
	    valor_tasa_emision,	--       
	    prima_total,	--       
	    descuento_total,	--       
	    prima_dia,	--           
	    descuento_dia,	--       
	    valor_pte_emision,	--       
	    dif_par_pos,	--       
	    dif_par_neg,	--       
	    CondPactoCliente,	--       
	    Tipo_Bono --
	  )
	SELECT 'BTR' -- 01      
        ,       'DEV'                                  -- 02 tipo de movimiento      
        ,       'DVVC'           -- 03 tipo de operacion      
        ,       a.monumoper                            -- 04 rsnumoper      
        ,       a.mocorrela                            -- 05      
        ,       ISNULL( b.inserie, '' )         -- 06      
        ,       CONVERT( CHAR(06), a.momonemi )        -- 07 monpact      
        , a.movalcomp                                      --> 08 vPresente Inicial      
        ,   0           -- 09 ISNULL( a.rsinteres, 0 ) + ISNULL( a.rsreajuste, 0)      
        ,       a.movpresen            -- 10 valor de vencimiento      
        ,       CASE WHEN (a.movpresen - a.movalcomp) > 0 THEN ABS((a.movpresen - a.movalcomp)) ELSE 0 END --> 11 Utilidad  
        ,       CASE WHEN (a.movpresen - a.movalcomp) < 0 THEN ABS((a.movpresen - a.movalcomp)) ELSE 0 END --> 12 Perdida      
,       0.0           -- 13 interes del cupon      
        ,       0.0           -- 14 reajustes del cupon      
        ,       0.0           -- 15 interes del cupon      
  ,       0.0           -- 16 reajustes del cupon      
        ,       a.movpresen                                 --> 17 valor de vencimiento --> vPresente final      
  ,       0.0                                    -- 18      
        ,       ISNULL(a.movalcomp, 0)                 -- 19 (Val.Compra Historico)      
        ,       0.0                                    -- 20 (Dif Pacto pos)      
        ,       0.0                                    -- 21 (Dif pacto neg)      
        ,       0.0                                    -- 22 (Valor Mercado pos)      
        ,       0.0                                    -- 23 (Valor Mercado neg)      
        ,       a.mocondpacto                -- 24 (Condicion pacto)      
        ,       CONVERT(CHAR(06), moforpagv)        -- 25 (Forma de pago)      
        ,    a.moforpagv                      -- 25.5      
        ,       a.motipobono                           -- 26 (Tipo instrumento) ISNULL( h.motipobono, '' )      
        ,       '0'           -- 27       
        ,       ''                                     -- 28 (Generico de emisor)      
        ,       ISNULL(a.movalcomp, 0)                 -- 29 (Valor Futuro para vencimiento de interbancarios)      
        ,       '2'                                    -- 30 97029000      
       ,       a.moinstser             -- 31      
,       a.monumdocu                            -- 32      
        ,       CONVERT(VARCHAR(10), morutemi)         -- 33      
        ,       '0'           -- 34      
        ,       a.movpresen            -- 35 valor de vencimiento      
        ,       a.motipopero      
        ,       0.0      
        ,       0.0      
        ,       0      
        ,       a.morutcli      
        ,       a.mocodcli      
        ,       a.mofecpro      
        ,       0.0      
        ,       a.monominal      
        ,       0      
        ,       0      
     ,       0      
        ,       0      
        ,       0      
        ,       0      
        ,       0    
        ,       0         
        ,    'CondPactoCliente' = '0'      
        ,       'Tipo_Bono'        = CASE WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi  = @iRutAdmCorp THEN 1      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi  = @iRutAdmCorp THEN 2      
                       WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi  = @iRutAdmCorp THEN 3      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi  = @iRutAdmCorp THEN 4      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi  = @iRutAdmCorp THEN 5      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'T' AND a.morutemi <> @iRutAdmCorp THEN 6      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'P' AND a.morutemi <> @iRutAdmCorp THEN 7      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'A' AND a.morutemi <> @iRutAdmCorp THEN 8      
                  WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'C' AND a.morutemi <> @iRutAdmCorp THEN 9      
                                          WHEN a.mocodigo = 98 AND a.codigo_carterasuper = 'R' AND a.morutemi <> @iRutAdmCorp THEN 10      
	                          ELSE 0
	                     END
	FROM   MDMO a
               INNER JOIN BacParamSuda..INSTRUMENTO b ON b.incodigo = a.mocodigo   
               INNER JOIN BacParamSuda..CLIENTE     c ON c.clrut    = a.morutcli AND c.clcodigo = a.mocodcli      
         ,     MDAC      
	WHERE  mofecpro = @Fecha_Hoy
	       AND mocodigo = 98
	       AND motipoper = 'VFM' 
	
	-- cambiado Hoy 18 04 2005      
	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Actualización Archivo de Cuotas FFMM en Renta Fija Contabiliza.... ! ',16,6,'ERROR.')
        PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END 


	----------------------------------------------------------------------------------------------------
	-- </VENCIMIENTO FDOS MUTUOS>-----------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------      
	
	
	/*=======================================================================*/ 
	/* REVERSA LBTR 48-24                                          */ 
	/*=======================================================================*/      

--      INSERT INTO bac_cnt_contabiliza      
--      (   id_sistema,          -- 01      
--          tipo_movimiento,     -- 02      
--          tipo_operacion,      -- 03      
--          operacion,           -- 04      
--          correlativo,         -- 05      
--          codigo_instrumento,  -- 06      
--          moneda_instrumento,  -- 07      
--          valor_futuro,        -- 08      
--          valor_compra,        -- 09 VGS Reversa Recibimos       
--          forma_pago,      
--          condicion_entrega      
--      )      
--      SELECT 'BTR'                           , -- 01      
--             'REV'                           , -- 02      
--             'RLB'    , -- 03      
--     numero_operacion                , -- 04      
--             1                               , -- 05      
--             ''                        , -- 06      
--             '999'                           , -- 07      
--             CASE WHEN Tipo_Movimiento = 'C' THEN monto_operacion ELSE 0 END,                  -- 08 VGS      
--             CASE WHEN Tipo_Movimiento = 'A' THEN monto_operacion ELSE 0 END,                  -- 08 VGS      
--             forma_pago,      
--                'condicion_entrega' = CASE WHEN (forma_pago = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1  ELSE 12 END    
--                                           WHEN (forma_pago = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2  ELSE 13 END      
--                                           WHEN (forma_pago = 130) THEN CASE WHEN c.cltipcli = 1 THEN 3  ELSE 14 END      
--         WHEN (forma_pago = 132) THEN CASE WHEN c.cltipcli = 1 THEN 4  ELSE 15 END      
--                                           WHEN (forma_pago = 133) THEN CASE WHEN c.cltipcli = 1 THEN 5  ELSE 16 END      
--                                           WHEN (forma_pago = 134) THEN CASE WHEN c.cltipcli = 1 THEN 6  ELSE 17 END      
--                                           WHEN (forma_pago = 135) THEN CASE WHEN c.cltipcli = 1 THEN 7  ELSE 18 END      
--                                           WHEN (forma_pago = 136) THEN CASE WHEN c.cltipcli = 1 THEN 8  ELSE 19 END      
--                                           WHEN (forma_pago = 137) THEN CASE WHEN c.cltipcli = 1 THEN 9  ELSE 20 END      
--                                           WHEN (forma_pago = 138) THEN CASE WHEN c.cltipcli = 1 THEN 10 ELSE 21 END      
--                                           WHEN (forma_pago = 139) THEN CASE WHEN c.cltipcli = 1 THEN 11 ELSE 22 END      
--                                 WHEN (forma_pago =   2) THEN 23      
--                                           WHEN (forma_pago =   3) THEN 24      
--                                           WHEN (forma_pago =   5) THEN 25      
--                                           WHEN (forma_pago =   6) THEN 26      
--                     WHEN (forma_pago =   7) THEN 27    
--                       WHEN (forma_pago =   8) THEN 28      
--           WHEN (forma_pago =  11) THEN 29      
--                                           WHEN (forma_pago =  12) THEN 30      
--                           WHEN (forma_pago =  13) THEN 31      
--                                           WHEN (forma_pago =  14) THEN 32    
--                                           WHEN (forma_pago =  15) THEN 33      
--                    WHEN (forma_pago =  16) THEN 34      
--                                           WHEN (forma_pago =  17) THEN 35      
--                      WHEN (forma_pago =  19) THEN 36      
--                                       WHEN (forma_pago =  20) THEN 37      
--                                           WHEN (forma_pago = 100) THEN 38      
--                                           WHEN (forma_pago = 102) THEN 39      
--                                           WHEN (forma_pago = 103) THEN 40      
--WHEN (forma_pago = 104) THEN 41      
--                                           WHEN (forma_pago = 105) THEN 42      
--                                           WHEN (forma_pago = 106) THEN 43      
--                                           WHEN (forma_pago = 118) THEN 44      
--                                           WHEN (forma_pago = 122) THEN 45      
--                                           WHEN (forma_pago = 123) THEN 46      
--                                           WHEN (forma_pago = 124) THEN 47      
-- WHEN (forma_pago = 125) THEN 48      
--                                           WHEN (forma_pago = 131) THEN 49      
--                                           WHEN (forma_pago = 140) THEN 50      
--                                           WHEN (forma_pago = 141) THEN 51      
--                                           WHEN (forma_pago = 142) THEN 52      
--                                           ELSE                         0      
--                END      
--FROM   BACPARAMSUDA..MDLBTR        
--             LEFT JOIN BacParamSuda..CLIENTE c ON c.clrut = rut_cliente AND c.clcodigo = codigo_cliente      
--      WHERE fecha_vencimiento  = @Fecha_Hoy      
--      AND   fecha_vencimiento <> fecha      
--      AND   Sistema            = 'BTR'      
-- AND   Estado_envio      <> 'A'      
--      
--      
--  IF @@ERROR <> 0       
--      BEGIN      
--         SET NOCOUNT OFF      
--         PRINT 'ERROR_PROC FALLA AGREGANDO REVERSO LBTR ARCHIVO CONTABILIZA.'      
--         RETURN 1      
--      END      

	/************************************************************
	* Code para SADP - Operaciones caen por SADP
	************************************************************/

	SELECT 'BTR' as id_sistema,	-- 01      
	       'REV' as tipo_movimiento,	-- 02      
	       'RLB' as tipo_operacion,	-- 03      
		   sdo.iOPE_Operacion as operacion,
		   1 as correlativo ,
		   '' as codigo_instrumento,
		   '999' as moneda_instrumento, 
		     CASE when sto.idTipoMovimiento = 1 THEN  sob.fDETOPE_MontoPago
		     ELSE 0 END as valor_futuro,   
		     CASE when sto.idTipoMovimiento = 2 THEN  sob.fDETOPE_MontoPago
		     ELSE 0 END as valor_compra,   
	       iForPagoOrig as forma_pago,
	       'condicion_entrega' = CASE 
	                                  WHEN ( iForPagoOrig = 128) THEN CASE 
	                                                                    WHEN c.cltipcli 
	     = 1 THEN 
	                                                                         1
	                                                                    ELSE 12
	                                              END
	                                  WHEN (iForPagoOrig = 129) THEN CASE 
	           WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                 2
	                                                                    ELSE 13
	                                                               END
	                                  WHEN (iForPagoOrig = 130) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         3
	                                                                    ELSE 14
	                                                               END
	                                  WHEN (iForPagoOrig = 132) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         4
	                                                                    ELSE 15
	                                                               END
	                                  WHEN (iForPagoOrig = 133) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         5
	                                                                    ELSE 16
	                                                               END
	                                  WHEN (iForPagoOrig = 134) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         6
	                                                                    ELSE 17
	                                                               END
	                                  WHEN (iForPagoOrig = 135) THEN CASE 
	                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         7
	                       ELSE 18
	                                   END
	            WHEN (iForPagoOrig = 136) THEN CASE 
	                                  WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                 8
	                                                                    ELSE 19
	                                                               END
	                                  WHEN (iForPagoOrig = 137) THEN CASE 
	                                                                    WHEN c.cltipcli 
	       = 1 THEN 
	                                                                         9
	                                                                    ELSE 20
	                                                               END
	                                  WHEN (iForPagoOrig = 138) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                     = 1 THEN 
	                                                                         10
	                                                                    ELSE 21
	                                                               END
	                        WHEN (iForPagoOrig = 139) THEN CASE 
	          WHEN c.cltipcli 
	                = 1 THEN 
	                                                                         11
	                                                                    ELSE 22
	                                                               END
	                                  WHEN (iForPagoOrig = 2) THEN 23
	                                  WHEN (iForPagoOrig = 3) THEN 24
	                                  WHEN (iForPagoOrig = 5) THEN 25
	                                  WHEN (iForPagoOrig = 6) THEN 26
	                                  WHEN (iForPagoOrig = 7) THEN 27
	                                  WHEN (iForPagoOrig = 8) THEN 28
	                                  WHEN (iForPagoOrig = 11) THEN 29
	                                  WHEN (iForPagoOrig = 12) THEN 30
	                                  WHEN (iForPagoOrig = 13) THEN 31
	                                  WHEN (iForPagoOrig = 14) THEN 32
	                                  WHEN (iForPagoOrig = 15) THEN 33
	                                  WHEN (iForPagoOrig = 16) THEN 34
	                                  WHEN (iForPagoOrig = 17) THEN 35
	                                  WHEN (iForPagoOrig = 19) THEN 36
	                                  WHEN (iForPagoOrig = 20) THEN 37
	                                  WHEN (iForPagoOrig = 100) THEN 38
	                                  WHEN (iForPagoOrig = 102) THEN 39
	                                  WHEN (iForPagoOrig = 103) THEN 40
	                                  WHEN (iForPagoOrig = 104) THEN 41
	                                  WHEN (iForPagoOrig = 105) THEN 42
	                                  WHEN (iForPagoOrig = 106) THEN 43
	                                  WHEN (iForPagoOrig = 118) THEN 44
	                                  WHEN (iForPagoOrig = 122) THEN 45
	                                  WHEN (iForPagoOrig = 123) THEN 46
	                                  WHEN (iForPagoOrig = 124) THEN 47
	                                  WHEN (iForPagoOrig = 125) THEN 48
	                                  WHEN (iForPagoOrig = 131) THEN 49
	                                  WHEN (iForPagoOrig = 140) THEN 50
	                                  WHEN (iForPagoOrig = 141) THEN 51
	                                  WHEN (iForPagoOrig = 142) THEN 52
	                                  ELSE 0
	                             END
	INTO #TMP_BTR
	FROM db_SADP_Filiales.dbo.SADP_OperacionesBANCO sob WITH(NOLOCK)
	INNER JOIN  	db_sadp_filiales.dbo.SADP_DetOperaciones sdo WITH(NOLOCK) 
	   ON sdo.idEntidad = sob.idEntidad
	   AND sdo.idModulo = sob.idModulo
	   AND sdo.idTipoOperacion = sob.idTipoOperacion
	   AND sdo.iOPE_Operacion =  CASE when sob.bAgrupada=1 THEN sob.iRegistro ELSE sob.iOPE_Operacion END
	INNER JOIN db_SADP_Filiales.dbo.sadp_operaciones so 
	   ON so.idEntidad = sdo.idEntidad
	   AND so.idModulo = sdo.idModulo
	   AND so.idTipoOperacion = sdo.idTipoOperacion
	   AND so.iOPE_Operacion =  sdo.iOPE_Operacion
	INNER JOIN db_SADP_Filiales.dbo.SADP_TipoOperaciones sto 
	 ON sto.identidad= sdo.idEntidad
	 AND sto.idmodulo = sdo.idmodulo 
	 AND sto.idTipoOperacion = sdo.idTipoOperacion
	INNER JOIN bacparamsuda.dbo.CLIENTE c
	 ON c.Clrut = so.iOPE_RutCliente 
	 and c.Clcodigo= iOPE_CodCliente
	WHERE  sob.dDETOPE_FechaLiquidacion = @Fecha_Hoy
	       AND sob.dDETOPE_FechaLiquidacion <> sob.dOPE_Fecha
	       AND sob.idEntidad = 1 
		   AND sob.idModulo = 3		-- RFIJA
		   AND sdo.idFormaPago <> 5	-- Administrativa
		   AND sdo.idEstado = 4		-- Enviada

	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Agregando Reversa LBTR en Archivo Contabilizacion Renta Fija Nacional.... ! ',16,6,'ERROR.')
	    PRINT 'ERROR_PROC FALLA AGREGANDO REVERSO LBTR ARCHIVO CONTABILIZA' 
	    RETURN 1
	END 


	-- Operaciones caen por SADP VB6
	INSERT INTO #TMP_BTR
	SELECT 'BTR',	-- 01      
	       'REV',	-- 02      
	       'RLB',	-- 03      
	       numero_operacion,	-- 04      
	       1,	-- 05      
	       '',	-- 06      
	       '999',	-- 07      
	       CASE 
	            WHEN Tipo_Movimiento = 'C' THEN monto_operacion
	            ELSE 0
	       END,	-- 08 VGS      
	       CASE 
	            WHEN Tipo_Movimiento = 'A' THEN monto_operacion
	            ELSE 0
	       END,	-- 08 VGS      
	       forma_pago,
	       'condicion_entrega' = CASE 
	                                  WHEN (forma_pago = 128) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         1
	                                                                    ELSE 12
	                                                               END
	                                  WHEN (forma_pago = 129) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         2
	                                                                    ELSE 13
	                                                               END
	                                  WHEN (forma_pago = 130) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         3
	                                                                    ELSE 14
	                                                               END
	                                  WHEN (forma_pago = 132) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         4
	                                                                    ELSE 15
	                                                      END
	                                  WHEN (forma_pago = 133) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	  5
	                                    ELSE 16
	                                         END
	                                  WHEN (forma_pago = 134) THEN CASE 
	                  WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         6
	                                                                    ELSE 17
	                                                               END
	                                  WHEN (forma_pago = 135) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         7
	                                                                    ELSE 18
	       END
	                                  WHEN (forma_pago = 136) THEN CASE 
	                                                                    WHEN c.cltipcli 
	            = 1 THEN 
	                                                                         8
	                                                                    ELSE 19
	                                                            END
	           WHEN (forma_pago = 137) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         9
	                                                                    ELSE 20
	                                                               END
	                                  WHEN (forma_pago = 138) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         10
	                                                                    ELSE 21
	                                                               END
	                                  WHEN (forma_pago = 139) THEN CASE 
	                                                                    WHEN c.cltipcli 
	                                                                         = 1 THEN 
	                                                                         11
	                                                                    ELSE 22
	                                                               END
	                                  WHEN (forma_pago = 2) THEN 23
	                                  WHEN (forma_pago = 3) THEN 24
	                                  WHEN (forma_pago = 5) THEN 25
	                                  WHEN (forma_pago = 6) THEN 26
	                                  WHEN (forma_pago = 7) THEN 27
	                                  WHEN (forma_pago = 8) THEN 28
	                                  WHEN (forma_pago = 11) THEN 29
	                                  WHEN (forma_pago = 12) THEN 30
	                                  WHEN (forma_pago = 13) THEN 31
	                                  WHEN (forma_pago = 14) THEN 32
	                                  WHEN (forma_pago = 15) THEN 33
	         WHEN (forma_pago = 16) THEN 34
	                                  WHEN (forma_pago = 17) THEN 35
	                                  WHEN (forma_pago = 19) THEN 36
	                                  WHEN (forma_pago = 20) THEN 37
	                                  WHEN (forma_pago = 100) THEN 38
	                                  WHEN (forma_pago = 102) THEN 39
	                                  WHEN (forma_pago = 103) THEN 40
	                                  WHEN (forma_pago = 104) THEN 41
	                      WHEN (forma_pago = 105) THEN 42
	                                  WHEN (forma_pago = 106) THEN 43
	                                  WHEN (forma_pago = 118) THEN 44
	        WHEN (forma_pago = 122) THEN 45
	                                  WHEN (forma_pago = 123) THEN 46
	                                  WHEN (forma_pago = 124) THEN 47
	                                  WHEN (forma_pago = 125) THEN 48
	                                  WHEN (forma_pago = 131) THEN 49
	                                  WHEN (forma_pago = 140) THEN 50
	                                  WHEN (forma_pago = 141) THEN 51
	                                  WHEN (forma_pago = 142) THEN 52
	                                  ELSE 0
	                             END
	FROM   BACPARAMSUDA..MDLBTR
             LEFT JOIN BacParamSuda..CLIENTE c ON c.clrut = rut_cliente AND c.clcodigo = codigo_cliente      
	WHERE  fecha_vencimiento = @Fecha_Hoy
	       AND fecha_vencimiento <> fecha
	       AND Sistema = 'BTR'
	     AND Estado_envio <> 'A'      
		   AND numero_operacion NOT IN (SELECT operacion FROM #TMP_BTR) -- Omitir Oper. SADP
	
	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Agregando Reversa LBTR (2) en Archivo Contabilizacion Renta Fija Nacional.... ! ',16,6,'ERROR.')
	    RETURN 1
	END 
	
	INSERT INTO bac_cnt_contabiliza
	  (
	    id_sistema,	-- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_futuro,	-- 08      
	    valor_compra,	-- 09 
	    forma_pago,
	    condicion_entrega
	  )
	SELECT * FROM #TMP_BTR

	IF @@ERROR <> 0
	BEGIN
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Agregando Reversa LBTR (3) en Archivo Contabilizacion Renta Fija Nacional.... ! ',16,6,'ERROR.')
	    PRINT 'ERROR_PROC FALLA AGREGANDO REVERSO LBTR ARCHIVO CONTABILIZA.' 
	    RETURN 1
	END 

/************************************************************
 * FIN Code para SADP
************************************************************/


	--> GENERA UN CORRELATIVO UNICO PARA CADA OPERACION, DEBIDO A QUE PUEDEN HABER OPERACIONES
	--> CON UN MISMO NUMERO, PERO DE DISTINTOS SISTEMAS       
	SET @Correla = 0      
	
	UPDATE BAC_CNT_CONTABILIZA
         SET Correlativo    = @Correla      
           , @Correla  = @Correla + 1      
	WHERE  Tipo_Operacion = 'RLB' 
	
	/*=======================================================================*/ 
	/* FLI ABONOS                                                  */ 
	/*=======================================================================*/      
	INSERT INTO bac_cnt_contabiliza
      (   id_sistema                       , -- 01      
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_presente -- 08
	  )
	SELECT 'BTR',	-- 01      
	       'MOV',	-- 02      
	       'AFL',	-- 03      
	       monumoper,	-- 04      
	       1,	-- 05      
	       '',	-- 06      
	       '',	-- 07      
	       SUM(movpresen) -- 08
	FROM   MDMO
             LEFT JOIN BacParamSuda..CLIENTE c ON c.clrut = morutcli and c.clcodigo = mocodcli      
	WHERE motipoper = 'FLI'
	       AND mostatreg <> 'A'
      GROUP BY monumoper      
	
	/*=======================================================================*/ 
	/* FLI CARGOS             */ 
	/*=======================================================================*/      
	
	INSERT INTO bac_cnt_contabiliza
 ( id_sistema                      , -- 01    
	    tipo_movimiento,	-- 02      
	    tipo_operacion,	-- 03      
	    operacion,	-- 04      
	    correlativo,	-- 05      
	    codigo_instrumento,	-- 06      
	    moneda_instrumento,	-- 07      
	    valor_presente -- 08
	  )
	SELECT 'BTR',	-- 01      
	       'MOV',	-- 02      
	       'CFL',	-- 03      
	       PANUMOPER,	-- 04 
	       1,	-- 05      
	       '',	-- 06      
	       '',	-- 07      
	       SUM(PAVPRESEN) --08
	FROM   PAGOS_FLI
	WHERE  PAFECPRO = @Fecha_Hoy
	       AND PAPTIPOPAGO = 'S'
 GROUP       
 BY PANUMOPER      
	
	IF @@ERROR <> 0 
	BEGIN      
	    SET NOCOUNT OFF 
	    RAISERROR('¡ Err. Falla Agregando Pagos Fli en Archivo Contabilizacion Renta Fija Nacional.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END 
	
	
	--->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	-- INCIO PROCESO DE GARANTIAS
	--->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      
	DECLARE @ValMercado_Gar_Ayer FLOAT       
	DECLARE @ValMercado_Gar_HOY FLOAT       
	
	SET @ValMercado_Gar_Ayer = 0 ;      
	
	SET @ValMercado_Gar_HOY = 0 ;      
	
 SET @ValMercado_Gar_Ayer  = (SELECT sum(valorpresentehoy) FROM bacparamsuda.dbo.tbl_ValMercado_Garantia  WHERE fechaValoriza = @Fecha_Ant ) ;       
  SET @ValMercado_Gar_HOY   = (SELECT sum(valorpresentehoy) FROM bacparamsuda.dbo.tbl_ValMercado_Garantia  WHERE fechaValoriza = @Fecha_Hoy ) ;      
	
	
	SET @ValMercado_Gar_Ayer = ISNULL(@ValMercado_Gar_Ayer, 0)      
	SET @ValMercado_Gar_HOY = ISNULL(@ValMercado_Gar_HOY, 0)      
	
 If @ValMercado_Gar_Ayer  <>0  and  @ValMercado_Gar_HOY   <> 0      
	BEGIN
	    INSERT INTO bac_cnt_contabiliza
 ( id_sistema                            
 , tipo_movimiento                       
 , tipo_operacion          
 , operacion               
 , correlativo                   
 , codigo_instrumento            
      
 , moneda_instrumento            
 , valor_compra        
 , valor_presente              
	      )
	    VALUES
 ( 'BTR'       
 , 'GAR'        
 , 'CONS'       
 , 1       
 , 1       
 , ''        
 , ''       
 , @ValMercado_Gar_Ayer        
  , @ValMercado_Gar_HOY        
	      )      

	IF @@ERROR <> 0 
	BEGIN      
		SET NOCOUNT OFF 
		RAISERROR('¡ Err. Falla Agregando Garantias Constituidas en Archivo Contabilizacion Renta Fija Nacional.... ! ',16,6,'ERROR.')
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'      
	    RETURN 1
	END
END


	
	SET @ValMercado_Gar_Ayer = 0 ;      
	
	SET @ValMercado_Gar_HOY = 0 ;      
	
	
 SET @ValMercado_Gar_Ayer = ( SELECT  SUM( ((nominal/cpnominal)*valor_mercado) ) AS ValorMercadoAyer      
	        FROM   bacparamsuda.dbo.tbl_Garantias_Otorgadas_detalle det
	               INNER       
	        JOIN bacparamsuda.dbo.tbl_Garantias_Otorgadas car
	                    ON  car.folio = det.folio
	               INNER       
	        JOIN bactradersuda.dbo.valorizacion_mercado
	                    ON  fecha_valorizacion = @Fecha_Ant
	                    AND rmnumdocu = Numdocu
	                    AND rmcorrela = Correlativo
	               INNER       
	        JOIN bactradersuda.dbo.mdcp
	                    ON  cpnumdocu = Numdocu
	                    AND cpcorrela = Correlativo
          WHERE car.Fecha <= @Fecha_Ant) ;      
	
 SET @ValMercado_Gar_HOY  = ( SELECT  SUM( ((nominal/cpnominal)*valor_mercado)) AS ValorMercadoHoy      
	        FROM   bacparamsuda.dbo.tbl_Garantias_Otorgadas_detalle det
	               INNER       
	        JOIN bacparamsuda.dbo.tbl_Garantias_Otorgadas car
	                    ON  car.folio = det.folio
	               INNER       
	        JOIN bactradersuda.dbo.valorizacion_mercado
	                    ON  fecha_valorizacion = @Fecha_hoy
	                    AND rmnumdocu = Numdocu
	                    AND rmcorrela = Correlativo
	 INNER       
	        JOIN bactradersuda.dbo.mdcp
	          ON  cpnumdocu = Numdocu
	                    AND cpcorrela = Correlativo
          WHERE car.Fecha <= @Fecha_Hoy) ;     
	
	
	SET @ValMercado_Gar_Ayer = ISNULL(@ValMercado_Gar_Ayer, 0)      
	SET @ValMercado_Gar_HOY = ISNULL(@ValMercado_Gar_HOY, 0)      
	
 If @ValMercado_Gar_Ayer  <>0  and  @ValMercado_Gar_HOY   <> 0      
	BEGIN
      
	    INSERT INTO bac_cnt_contabiliza
 ( id_sistema                            
 , tipo_movimiento                       
 , tipo_operacion          
 , operacion               
 , correlativo                   
 , codigo_instrumento            
 , moneda_instrumento            
 , valor_compra        
 , valor_presente              
	      )
	    VALUES
 ( 'BTR'       
 , 'GAR'        
 , 'OTOR'       
 , 1       
 , 1       
 , ''        
 , ''       
 , @ValMercado_Gar_Ayer        
, @ValMercado_Gar_HOY        
	      )
	END 
	--->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	-->>  Fin carga de Datos para garantias
	--->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      
	
	/****************************************************************************************************************/ 
	/********************************** ACTUALIZA STATUS DE OBJETOS CUBIERTOS ***************************************/ 
	/****************************************************************************************************************/      
	INSERT INTO BAC_CNT_CONTABILIZA
	SELECT A.id_sistema      
	 , A.tipo_movimiento      
	 , A.tipo_operacion      
	 , A.operacion      
	 , A.correlativo      
	 , A.codigo_instrumento      
	 , A.moneda_instrumento      
	 , A.valor_compra      
	 , A.valor_presente      
	 , A.valor_venta      
	 , A.utilidad      
	 , A.perdida      
	 , A.interes_papel      
	 , A.reajuste_papel      
	 , A.interes_pacto      
	 , A.reajuste_pacto      
	 , A.valor_cupon      
	 , A.nominalpesos      
	 , A.valor_comprahis      
	 , A.dif_ant_pacto_pos      
	 , A.dif_ant_pacto_neg      
	 , CASE WHEN B.motipoper = 'TM' AND B.mostatreg = ' ' AND B.modifsb > 0 THEN ISNULL(VM.diferencia_mercado  -(VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob /100),0)END),B.modifsb)        
	   WHEN B.motipoper = 'TM' AND B.mostatreg = 'R' AND B.modifsb > 0 THEN (ISNULL(VMA.diferencia_mercado  -(VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),B.modifsb) * -1)       
					WHEN B.motipoper = 'TM' AND B.modifsb = 0 THEN 0.
					ELSE B.moutilidad
			   END --> 21 (Valor Mercado pos)       
	 , CASE WHEN B.motipoper = 'TM' AND B.mostatreg = ' ' AND B.modifsb < 0 THEN (ISNULL(VM.diferencia_mercado  -(VM.diferencia_mercado * CASE WHEN ISNULL((VM.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VM.PorcjeCob /100),0) END ),B.modifsb) * -1)       
	   WHEN B.motipoper = 'TM' AND B.mostatreg = 'R' AND B.modifsb < 0 THEN ISNULL(VMA.diferencia_mercado  -(VMA.diferencia_mercado * CASE WHEN ISNULL((VMA.PorcjeCob /100),0)= 0 THEN 1 ELSE ISNULL((VMA.PorcjeCob /100),0) END),B.modifsb)      
					ELSE B.moutilidad
			   END --> 22 (valor Mercado neg)      
	 , A.condicion_pacto      
	 , A.forma_pago      
	 , A.tipo_instrumento      
	 , A.tipo_cliente      
	 , A.tipo_emisor      
	 , A.forma_pago_entregamos      
	 , A.valor_futuro      
	 , A.condicion_entrega      
	 , A.tipo_operacion_or      
	 , A.comquien      
	 , A.instser      
	 , A.documento      
	 , A.Emisor      
	 , A.tipo_bono      
	 , A.clasificacion_cliente      
	 , A.valor_final      
	 , A.cartera_origen      
	 , A.interes_positivo      
	 , A.interes_negativo      
	 , A.reajuste_positivo      
	 , A.reajuste_negativo      
	 , A.plazo      
	 , A.cliente      
	 , A.codcli      
	 , A.fecha_proceso      
	 , A.Interes_Reajuste      
	 , A.Nominal      
	 , A.valor_tasa_emision      
	 , A.prima_total      
	 , A.descuento_total 
	 , A.prima_dia    
	 , A.descuento_dia      
	 , A.valor_pte_emision      
	 , A.dif_par_pos      
	 , A.dif_par_neg     
	 , A.Tipo_cartera      
	 , A.CondPactoCliente      
	 , 'DCBTO' --DESCUBIERTO      
	 , 0      -- REQ.7619

	,		Utilidad_Avr_Patrimonio  = 0
	,		Perdida_Avr_Patrimonio	 = 0
	,		Diferencia_Precio_Pos	 = 0
	,		Diferencia_Precio_Neg	 = 0
	FROM	MDMO   B 
			LEFT JOIN VALORIZACION_MERCADO VM ON B.motipoper  = 'TM'	AND VM.fecha_valorizacion = @FechaBusquedaValorizacion
																		AND VM.id_sistema = 'BTR'
																		AND VM.rmnumoper = B.monumoper
																		AND VM.rmnumdocu = B.monumdocu
																		AND VM.rmcorrela = B.mocorrela
      
			LEFT JOIN VALORIZACION_MERCADO VMA ON B.motipoper  = 'TM'   AND VMA.fecha_valorizacion = @FechaBusquedaValorizacionAyer
																		AND VMA.id_sistema = 'BTR'
																		AND VMA.rmnumoper = B.monumoper
																		AND VMA.rmnumdocu = B.monumdocu
																		AND VMA.rmcorrela  = B.mocorrela      
		,	BAC_CNT_CONTABILIZA A         
	WHERE	A.EstObj = 'CBTO'
	AND		B.motipoper = 'TM'
	AND		B.monumdocu = A.documento
	AND		B.mocorrela = A.correlativo
	AND		B.monumoper = A.operacion 
	
	/*==============================================================================================*/ 
	/*================  D E V E N G A M I E N T O     D E    O P E R A C I O N E S  ================*/ 
	/*================                        P A G O      M A Ñ A N A              ================*/ 
	/*==============================================================================================*/      
	INSERT INTO BAC_CNT_CONTABILIZA
      (   id_sistema      
      ,   tipo_movimiento      
      ,   tipo_operacion      
      ,   operacion      
      ,   correlativo      
      ,   codigo_instrumento      
      ,  moneda_instrumento      
      ,   valor_compra      
      ,   valor_presente      
      ,   valor_venta      
      ,   utilidad      
      ,   perdida      
      ,   interes_papel      
      ,   reajuste_papel      
      ,   interes_pacto      
      ,   reajuste_pacto      
      ,   valor_cupon      
      ,   nominalpesos      
      ,   valor_comprahis      
      ,   dif_ant_pacto_pos      
      ,   dif_ant_pacto_neg      
      ,   dif_valor_mercado_pos      
      ,   dif_valor_mercado_neg      
      ,   condicion_pacto      
      ,   forma_pago      
      ,   forma_pago_entregamos      
      ,   tipo_instrumento      
      ,   tipo_cliente      
      ,   tipo_emisor      
      ,   valor_futuro      
      ,   comquien      
      ,   instser      
      ,   documento      
 ,   emisor      
      ,   clasificacion_cliente      
      ,   valor_final      
      ,   cartera_origen      
      ,   interes_negativo      
      , reajuste_negativo      
    ,   plazo      
  ,   cliente      
      ,   codcli      
      ,   fecha_proceso      
      ,   Interes_Reajuste      
      ,   nominal      
      ,   valor_tasa_emision      
      ,   prima_total      
      ,   descuento_total      
      ,   prima_dia      
      ,   descuento_dia      
      ,   valor_pte_emision      
      ,   dif_par_pos      
      ,   dif_par_neg      
      ,   CondPactoCliente      
      ,   condicion_entrega      
	  )
      SELECT       
      
          'id_sistema'            = 'BTR'      
      ,   'tipo_movimiento'       = 'DEV'      
      ,   'tipo_operacion'        = CASE WHEN rscartera = '111' AND rstipoper = 'DVP' THEN 'DVCP'      
                                         WHEN rscartera = '111' AND rstipoper = 'VCP' THEN 'DVVC'      
                      END      
      ,   'operacion'             = a.rsnumoper      
      ,   'correlativo'          = a.rscorrela     
      ,   'codigo_instrumento'    = CASE WHEN rscartera = '111' THEN ISNULL(b.inserie, '') ELSE '' END      
      ,   'moneda_instrumento'    = CONVERT(CHAR(06), a.rsmonemi)      
      ,   'valor_compra'          = CASE WHEN rstipoper = 'VCP' THEN rscupamo ELSE rsvalcomp END      
      ,   'valor_presente'        = ISNULL(a.rsinteres, 0) + ISNULL(a.rsreajuste, 0)      
     ,   'valor_venta'           = CASE WHEN rstipoper = 'VCP' AND rscartera = '111' THEN rsflujo ELSE ISNULL(a.rsvppresenx, 0) END      
      ,   'utilidad'              = 0.0      
      ,   'perdida'               = 0.0      
      ,   'interes_papel' = CASE WHEN rstipoper = 'VCP' THEN rscupint ELSE ISNULL(a.rsinteres,  0) END      
     ,   'reajuste_papel'        = CASE WHEN rstipoper = 'VCP' THEN rscuprea ELSE ISNULL(a.rsreajuste, 0) END      
     ,   'interes_pacto'         = CASE WHEN rstipoper = 'VCP' THEN rscupint ELSE ISNULL(a.rsinteres,  0) END      
      ,   'reajuste_pacto'        = CASE WHEN rstipoper = 'VCP' THEN rscuprea ELSE ISNULL(a.rsreajuste, 0) END      
      ,   'valor_cupon'           = CASE WHEN rstipoper = 'VCP' THEN rsflujo  ELSE ISNULL(a.rsvppresenx,0) END      
      ,   'nominalpesos'          = 0.0      
      ,   'valor_comprahis'       = ISNULL(a.rsvppresen, 0)      
      ,   'dif_ant_pacto_pos'     = 0.0      
      ,   'dif_ant_pacto_neg'     = 0.0      
      ,   'dif_valor_mercado_pos' = 0.0      
      ,   'dif_valor_mercado_neg' = 0.0      
      ,   'condicion_pacto'      = rscondpacto      
      ,   'forma_pago'            = CASE WHEN rscartera = '111' AND rstipoper = 'VCP' THEN CONVERT(CHAR(06), rsforpagv)       
	                           ELSE CONVERT(CHAR(06), rsforpagi)
 END      
      ,   'forma_pago_entregamos' = rsforpagv      
      ,   'tipo_instrumento'      = rstipobono      
      ,   'tipo_cliente'          = CASE WHEN rstipoletra = 'V' THEN '3'      
	                             WHEN rstipoletra = 'F' THEN '4'
	                             WHEN rstipoletra = 'E' THEN '2'
	                             WHEN rstipoletra = 'O' THEN '1'
	                             ELSE '0'
                                    END      
      ,   'tipo_emisor'           = ''      
      ,   'valor_futuro'          = ISNULL(a.rsvppresenx,0)      
      ,   'comquien'              = CASE WHEN rsrutemis = 97037000 THEN '1' ELSE '2' END      
      ,   'instser'               = rsinstser      
      ,   'documento'             = rsnumdocu      
      ,   'emisor'                = CONVERT(VARCHAR(10),rsrutemis)      
      ,   'clasificacion_cliente' = CASE WHEN rscodigo = 20 AND rsrutemis  = @RUT_CLIENTE THEN '1'      
	                                      WHEN rscodigo = 20 AND rsrutemis <> @RUT_CLIENTE THEN '2'
                            ELSE CASE WHEN rsrutcli  = @rut_central                                        THEN '9'      
	                                                WHEN rsrutcli = @rut_estado AND rsforpagi = 128 AND rsforpagv = 128 THEN '10'
	                                                WHEN rsrutcli <> @rut_estado AND rsforpagi = 128 AND rsforpagv = 128 THEN '11'
	                                                WHEN rsrutcli = @rut_estado AND rsforpagi = 129 AND rsforpagv = 129 THEN '12'
	                                                WHEN rsrutcli <> @rut_estado AND rsforpagi = 129 AND rsforpagv = 129 THEN '13'
	                                                WHEN rsrutcli = @rut_estado AND rsforpagi = 130 AND rsforpagv = 130 THEN '14'
	                                                WHEN rsrutcli <> @rut_estado AND rsforpagi = 130 AND rsforpagv = 130 THEN '15'
	                                                WHEN rsrutcli = @rut_estado AND rsforpagi = 132 AND rsforpagv = 132 THEN '16'
     WHEN rsrutcli <> @rut_estado AND rsforpagi = 132 AND rsforpagv = 132 THEN '17'       
                                          WHEN rsrutcli  = @rut_estado AND rsforpagi = 133 AND rsforpagv = 133 THEN '18'       
   WHEN rsrutcli <> @rut_estado AND rsforpagi = 133 AND rsforpagv = 133 THEN '19'       
                                              WHEN rsrutcli  = @rut_estado AND rsforpagi = 134 AND rsforpagv = 134 THEN '20'      
                                                   WHEN rsrutcli <> @rut_estado AND rsforpagi = 134 AND rsforpagv = 134 THEN '21'      
                                                   WHEN rsrutcli  = @rut_estado AND rsforpagi = 135 AND rsforpagv = 135 THEN '22'      
      WHEN rsrutcli <> @rut_estado AND rsforpagi = 135 AND rsforpagv = 135 THEN '23'      
                                                   WHEN rsrutcli  = @rut_estado AND rsforpagi = 136 AND rsforpagv = 136 THEN '24'      
                                                 WHEN rsrutcli <> @rut_estado AND rsforpagi = 136 AND rsforpagv = 136 THEN '25'      
                                                   WHEN rsrutcli  = @rut_estado AND rsforpagi = 137 AND rsforpagv = 137 THEN '26'      
                                                   WHEN rsrutcli <> @rut_estado AND rsforpagi = 137 AND rsforpagv = 137 THEN '27'      
                                                   WHEN rsrutcli  = @rut_estado AND rsforpagi = 138 AND rsforpagv = 138 THEN '28'      
 WHEN rsrutcli <> @rut_estado AND rsforpagi = 138 AND rsforpagv = 138 THEN '29'      
 WHEN rsrutcli  = @rut_estado AND rsforpagi = 139 AND rsforpagv = 139 THEN '30'      
                                     WHEN rsrutcli <> @rut_estado AND rsforpagi = 139 AND rsforpagv = 139 THEN '31'      
	                         WHEN rsrutcli = @rut_estado THEN '1'
	                                                WHEN rsrutcli <> @rut_estado THEN '5'
	                                                ELSE '0'
	                                           END
	                                 END,
	       'valor_final' = CASE WHEN rstipoper = 'VCP' THEN rsflujo ELSE ISNULL(a.rsinteres, 0) END,
	       'cartera_origen' = rstipopero,
	       'interes_negativo' = CASE WHEN rsinteres < 0 THEN (rsinteres * -1) ELSE 0 END,
	       'reajuste_negativo' = CASE WHEN rsreajuste < 0 THEN (rsreajuste * -1) ELSE 0 END,
	       'plazo' = DATEDIFF(DAY, rsfecinip, rsfecvtop),
	       'cliente' = rsrutcli,
	       'codcli' = rscodcli,
	       'fecha_proceso' = rsfecha,
	       'Interes_Reajuste' = CASE 
	                                 WHEN rstipoper = 'VCP' THEN rscupint
	                                 ELSE ISNULL(a.rsinteres, 0)
	                            END 
	       + CASE 
	              WHEN rstipoper = 'VCP' THEN rscuprea
	              ELSE ISNULL(a.rsreajuste, 0)
	         END,
	       'nominal' = rsnominal,
	     'valor_tasa_emision' = 0,
	       'prima_total' = 0,
	       'descuento_total' = 0,
	       'prima_dia' = CASE 
	                          WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 20 
	                               AND rstipoper = 'DVP' AND a.prima_descuento_dia 
	                               > 0 THEN a.prima_descuento_dia
	                          ELSE 0
	                     END,
	       'descuento_dia' = CASE 
	                              WHEN rsrutemis = @RUT_CORPBNC AND rscodigo = 
	             20 AND rstipoper = 'DVP' AND a.prima_descuento_dia 
	                                   < 0 THEN (a.prima_descuento_dia * -1)
	                              ELSE 0
	                         END,
	       'valor_pte_emision' = 0,
	       'dif_par_pos' = 0,
	       'dif_par_neg' = 0,
	       'CondPactoCliente' = CASE 
	                                 WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> 
	                                      97029000 AND c.cltipcli <> 1 THEN '1'
	                                 WHEN a.rstipopero <> 'CI' AND a.rsrutcli <> 
	                          97029000 AND c.cltipcli = 1 THEN '2'
	                                 WHEN a.rstipopero <> 'CI' AND a.rsrutcli = 
	                                      97029000 AND c.cltipcli = 1 THEN '3'
	     WHEN a.rstipopero = 'CI' AND a.rsrutcli = 
	                         97029000 THEN '3'
	                                 WHEN a.rstipopero = 'CI' AND c.cltipcli <> 
	                                      1 THEN '4'
	                                 WHEN a.rstipopero = 'CI' AND c.cltipcli = 1 THEN 
	                                      '5'
	                                 ELSE '0'
	                            END,
	       'condicion_entrega' = CASE 
	                                  WHEN (a.rsforpagi = 128 OR a.rsforpagv = 128) THEN CASE WHEN c.cltipcli = 1 THEN 1 ELSE 12 END
	                                  WHEN (a.rsforpagi = 129 OR a.rsforpagv = 129) THEN CASE WHEN c.cltipcli = 1 THEN 2 ELSE 13 END
	                                  WHEN (a.rsforpagi = 130 OR a.rsforpagv = 130) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                           = 
	                                                                                               1 THEN 
	                                               3
	                                                                                          ELSE 
	                                                                                               14
	                                                   END
	                                  WHEN (a.rsforpagi = 132 OR a.rsforpagv = 130) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	                                                                                               4
	                                                                                          ELSE 
	                                                                                               15
	                                                                                     END
	                                  WHEN (a.rsforpagi = 133 OR a.rsforpagv = 133) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	                                                                                               5
	                                                                                          ELSE 
	                                16
	                                                                                     END
	                                  WHEN (a.rsforpagi = 134 OR a.rsforpagv = 134) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	           6
	                                                                                          ELSE 
	                                                 17
	                                                                                     END
	                        WHEN (a.rsforpagi = 135 OR a.rsforpagv = 135) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	                                                              7
	                                                                                          ELSE 
	                 18
	                                                                                     END
	                                  WHEN (a.rsforpagi = 136 OR a.rsforpagv = 136) THEN CASE 
	                 WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	                                                                              8
	         ELSE 
	                                                                                               19
	                                                                                     END
	                                  WHEN (a.rsforpagi = 137 OR a.rsforpagv = 137) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                   1 THEN 
	                                                                                               9
	                                                                                          ELSE 
	                                                                                               20
	                                                                                     END
	                                  WHEN (a.rsforpagi = 138 OR a.rsforpagv = 138) THEN CASE 
	                                                                                          WHEN 
	                                                                                               c.cltipcli 
	                                                                                               = 
	                                                                                               1 THEN 
	                                                                                               10
	                                                                      ELSE 
	                                                                                               21
	                                                                                     END
	                                  WHEN (a.rsforpagi = 139 OR a.rsforpagv = 139) THEN CASE WHEN c.cltipcli = 1 THEN 11 ELSE 22 END
	                                  WHEN (a.rsforpagi = 2 OR a.rsforpagv = 2) THEN 23
	                                  WHEN (a.rsforpagi = 3 OR a.rsforpagv = 3) THEN 24
	                                  WHEN (a.rsforpagi = 5 OR a.rsforpagv = 5) THEN 25
	                             WHEN (a.rsforpagi = 6 OR a.rsforpagv = 6) THEN 26
	                                  WHEN (a.rsforpagi = 7 OR a.rsforpagv = 7) THEN 27
	                                  WHEN (a.rsforpagi = 8 OR a.rsforpagv = 8) THEN 28
	                WHEN (a.rsforpagi = 11 OR a.rsforpagv = 11) THEN 29
	                                  WHEN (a.rsforpagi = 12 OR a.rsforpagv = 12) THEN 30
	                    WHEN (a.rsforpagi = 13 OR a.rsforpagv = 13) THEN 31
	                     WHEN (a.rsforpagi = 14 OR a.rsforpagv = 14) THEN 32
	                                  WHEN (a.rsforpagi = 15 OR a.rsforpagv = 15) THEN 33
	                                  WHEN (a.rsforpagi = 16 OR a.rsforpagv = 16) THEN 34
	                                  WHEN (a.rsforpagi = 17 OR a.rsforpagv = 17) THEN 35
	                                  WHEN (a.rsforpagi = 19 OR a.rsforpagv = 19) THEN 36
	                                  WHEN (a.rsforpagi = 20 OR a.rsforpagv = 20) THEN 37
	                                  WHEN (a.rsforpagi = 100 OR a.rsforpagv = 100) THEN 38
	                                  WHEN (a.rsforpagi = 102 OR a.rsforpagv = 102) THEN 39
	                                  WHEN (a.rsforpagi = 103 OR a.rsforpagv = 103) THEN 40
	                                  WHEN (a.rsforpagi = 104 OR a.rsforpagv = 104) THEN 41
	                                  WHEN (a.rsforpagi = 105 OR a.rsforpagv = 105) THEN 42
	 WHEN (a.rsforpagi = 106 OR a.rsforpagv = 106) THEN 43
	                                  WHEN (a.rsforpagi = 118 OR a.rsforpagv = 118) THEN 44
	                                  WHEN (a.rsforpagi = 122 OR a.rsforpagv = 122) THEN 45
	                                  WHEN (a.rsforpagi = 123 OR a.rsforpagv = 123) THEN 46
	                                  WHEN (a.rsforpagi = 124 OR a.rsforpagv = 124) THEN 47
	                                  WHEN (a.rsforpagi = 125 OR a.rsforpagv = 125) THEN 48
	                                  WHEN (a.rsforpagi = 131 OR a.rsforpagv = 131) THEN 49
	                                  WHEN (a.rsforpagi = 140 OR a.rsforpagv = 140) THEN 50
	                                  WHEN (a.rsforpagi = 141 OR a.rsforpagv = 141) THEN 51
	                                  WHEN (a.rsforpagi = 142 OR a.rsforpagv = 142) THEN 52
	                                  WHEN (a.rsforpagi = 143 OR a.rsforpagv = 143) THEN 53
	                                  ELSE 0
	                             END
	FROM   #TMP_MDRS a
           INNER JOIN BacParamSuda..CLIENTE     c ON c.clrut    = a.rsrutcli AND c.clcodigo = a.rscodcli      
           INNER JOIN BacParamSuda..INSTRUMENTO b ON b.incodigo = a.rscodigo      
      ,    MDAC      
	WHERE  rsfecha >= @Fecha_Hoy
	       AND rsfecha < @fecha_prox
	       AND rstipoper  IN ('DVP', 'VCP')
	       AND rscartera <> '211'
	       AND rscodigo <> 98 
	
	
	/****************************************************************************************************************/ 
	/***************************** ACTUALIZACION CODIGO TIPO_CARTERA (BAC_CNT_CONTABILIZA ***************************/ 
	/****************************************************************************************************************/      
	CREATE TABLE #TEMPORAL
      (   id_sistema    CHAR(03)       
      ,   tipo_movimiento  CHAR(05)      
      ,   tipo_operacion   CHAR(05)      
      , operacion    NUMERIC(10,0)      
      ,   documento    NUMERIC(10,0)      
      ,   correlativo    NUMERIC(3,0)      
      ,  estadocobertura  CHAR(05)      
      ,   CodClas    CHAR(10)      
      ,   Estado    CHAR(01)      
	)      
	
	INSERT INTO #TEMPORAL
      SELECT id_sistema       
      ,      tipo_movimiento       
      ,		 tipo_operacion      
      ,      operacion          
      ,      documento      
      ,      correlativo      
      ,      EstObj      
      ,      ''      
      ,      'N'      
	FROM   BAC_CNT_CONTABILIZA      
	
	DECLARE @IdSistema CHAR(03)      
	DECLARE @Tipo_Movimiento CHAR(05)      
	DECLARE @Tipo_Operacion CHAR(05)      
	DECLARE @NumOpe NUMERIC(10, 0)      
	DECLARE @NumDocu NUMERIC(10, 0)      
	DECLARE @NumCorre NUMERIC(03)      
	DECLARE @EstadoCobertura CHAR(05)      
	DECLARE @CodClas CHAR(10)      
	DECLARE @Estado CHAR(01)      
	
	WHILE 1 = 1
	BEGIN
	    SET @CodClas = '*'   
	    SET ROWCOUNT 1      
         SELECT @IdSistema        = id_sistema       
     ,      @Tipo_Movimiento  = tipo_movimiento      
         ,      @Tipo_Operacion   = tipo_operacion      
         ,      @NumOpe           = operacion      
         ,      @NumDocu          = documento      
         ,      @NumCorre         = correlativo      
         ,      @EstadoCobertura  = estadocobertura      
         ,      @CodClas          = CodClas      
	   FROM   #TEMPORAL
	    WHERE  Estado = 'N'      
	    
	    SET ROWCOUNT 0      
	    
	    IF @CodClas = '*'
	        BREAK 
	    
	    
	    EXECUTE @CodClas = BacParamSuda..SP_CON_CLASIFICACION_CARTERA @IdSistema 
	    , @Tipo_Movimiento 
	    , @Tipo_Operacion 
	    , @NumOpe 
	    , @NumDocu 
	    , @NumCorre 
	    , @EstadoCobertura      
	    SET NOCOUNT ON      
	    
	    UPDATE #TEMPORAL
            SET CodClas  = @CodClas      
             ,   Estado  = 'S'      
	    WHERE  id_sistema           = @IdSistema
	           AND tipo_movimiento  = @Tipo_Movimiento
	           AND tipo_operacion   = @Tipo_Operacion
	           AND operacion        = @NumOpe
	           AND documento        = @NumDocu
	           AND correlativo      = @NumCorre
	           AND estadocobertura  = @EstadoCobertura
	END      
	
	UPDATE BAC_CNT_CONTABILIZA
	SET    TIPO_CARTERA = CodClas
	FROM   #TEMPORAL A
	WHERE  BAC_CNT_CONTABILIZA.id_sistema = A.id_sistema
	       AND BAC_CNT_CONTABILIZA.tipo_movimiento = A.tipo_movimiento
	       AND BAC_CNT_CONTABILIZA.tipo_operacion = A.tipo_operacion
	       AND BAC_CNT_CONTABILIZA.operacion = A.operacion
	       AND BAC_CNT_CONTABILIZA.documento = A.documento
	       AND BAC_CNT_CONTABILIZA.correlativo = A.correlativo
	       AND BAC_CNT_CONTABILIZA.EstObj = A.EstadoCobertura 
	
	-- INSERTA TABLA DE PASO PARA LA CONTABILIDAD (BAC_CNT_CONTABILIZA_RESUMEN)
	-- ***********************************************************************************      
	TRUNCATE TABLE BAC_CNT_CONTABILIZA_RESUMEN 
	
	-- Volver a centralizar la contabilidad -- DMV      
	INSERT INTO BAC_CNT_CONTABILIZA_RESUMEN
	SELECT id_sistema,
	       tipo_movimiento,
	       tipo_operacion,
	       0,
	       codigo_instrumento,
	       moneda_instrumento,
	       SUM(valor_compra),
	       SUM(valor_presente),
	       SUM(valor_venta),
	       SUM(utilidad),
	       SUM(perdida),
	       SUM(interes_papel),
	       SUM(reajuste_papel),
	       SUM(interes_pacto),
	       SUM(reajuste_pacto),
	       SUM(valor_cupon),
	       SUM(nominalpesos),
	       SUM(valor_comprahis),
	       SUM(dif_ant_pacto_pos),
	       SUM(dif_ant_pacto_neg),
	       SUM(dif_valor_mercado_pos),
	       SUM(dif_valor_mercado_neg),
	       condicion_pacto,
	       forma_pago,
	       tipo_instrumento,
	       tipo_cliente,
	       tipo_emisor,
	       forma_pago_entregamos,
	       SUM(valor_futuro),
	       condicion_entrega,
	       tipo_operacion_or,
	       comquien,
	       '',
	       0,
	       0,
	       tipo_bono,
	       clasificacion_cliente,
	       SUM(valor_final),
	       cartera_origen,
	       SUM(interes_positivo),
	       SUM(interes_negativo),
	       SUM(reajuste_positivo),
	       SUM(reajuste_negativo),
	       plazo,
	       0,
	       0,
	       fecha_proceso,
	       SUM(interes_reajuste),
	       SUM(nominal),
	       SUM(valor_tasa_emision),
	       SUM(prima_total),
	       SUM(descuento_total),
	       SUM(prima_dia),
	       SUM(descuento_dia),
	       SUM(valor_pte_emision),
	       SUM(dif_par_pos),
	       SUM(dif_par_neg),
	       Tipo_Cartera,
	       CondPactoCliente,
	       SUM(monto_pagomañana),

			SUM(Utilidad_Avr_Patrimonio),		--> Ventas AFS
			SUM(Perdida_Avr_Patrimonio),		--> Ventas AFS
			SUM(Diferencia_Precio_Pos),			--> Ventas AFS
			SUM(Diferencia_Precio_Neg)			--> Ventas AFS
	FROM   BAC_CNT_CONTABILIZA
	WHERE  LEFT(instser, 3) <> 'DPX'
	       AND tipo_movimiento <> 'TMF'
 GROUP       
 BY id_sistema,      
	       tipo_movimiento,
	       tipo_operacion,
	       codigo_instrumento,
	       moneda_instrumento,
	       condicion_pacto,
	       forma_pago,
	       tipo_instrumento,
	       tipo_cliente,
	       tipo_emisor,
	       forma_pago_entregamos,
	       condicion_entrega,
	       tipo_operacion_or,
	       comquien,
	       tipo_bono,
	       clasificacion_cliente,
	       cartera_origen,
	       plazo,
	       fecha_proceso,
	       Tipo_Cartera,
	       CondPactoCliente      
	
	INSERT INTO BAC_CNT_CONTABILIZA_RESUMEN
	SELECT id_sistema,
	       tipo_movimiento,
	       tipo_operacion,
	       correlativo,
	       codigo_instrumento,
	       moneda_instrumento,
	       valor_compra,
	       valor_presente,
	       valor_venta,
	       utilidad,
	       perdida,
	       interes_papel,
	       reajuste_papel,
	       interes_pacto,
	       reajuste_pacto,
	       valor_cupon,
	       nominalpesos,
	       valor_comprahis,
	       dif_ant_pacto_pos,
	       dif_ant_pacto_neg,
	       dif_valor_mercado_pos,
	       dif_valor_mercado_neg,
	       condicion_pacto,
	       forma_pago,
	       tipo_instrumento,
	       tipo_cliente,
	       tipo_emisor,
	       forma_pago_entregamos,
	       valor_futuro,
	       condicion_entrega,
	       tipo_operacion_or,
	       comquien,
	       instser,
	       documento,
	       Emisor,
	       tipo_bono,
	       clasificacion_cliente,
	       valor_final,
	       cartera_origen,
	       interes_positivo,
	       interes_negativo,
	       reajuste_positivo,
	       reajuste_negativo,
	       plazo,
	       cliente,
	       codcli,
	       fecha_proceso,
	       interes_reajuste,
	       nominal,
	       valor_tasa_emision,
	       prima_total,
	       descuento_total,
	       prima_dia,
	       descuento_dia,
	       valor_pte_emision,
	       dif_par_pos,
	       dif_par_neg,
	       Tipo_Cartera,
	       CondPactoCliente,
	       monto_pagomañana,

	       	Utilidad_Avr_Patrimonio,	--> Ventas AFS
			Perdida_Avr_Patrimonio,		--> Ventas AFS
			Diferencia_Precio_Pos,		--> Ventas AFS
			Diferencia_Precio_Neg		--> Ventas AFS

	FROM   BAC_CNT_CONTABILIZA
	WHERE  LEFT(instser, 3) = 'DPX'
	       OR  tipo_movimiento = 'TMF'       


	INSERT	INTO	BAC_CNT_CONTABILIZA_HISTORICA
	SELECT	FechaContable		= (	select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
		,	BAC_CNT_CONTABILIZA.*
	FROM	BAC_CNT_CONTABILIZA

	if @@error <> 0 
	begin
		RAISERROR('¡ Err. Falla al Realizar el Respaldo Contabilización del Día.... ! ',16,6,'ERROR.')
		return 1
	end

	SET NOCOUNT OFF 
	
	RETURN 0
END
GO
