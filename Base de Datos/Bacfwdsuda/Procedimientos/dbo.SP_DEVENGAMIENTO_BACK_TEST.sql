USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGAMIENTO_BACK_TEST]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DEVENGAMIENTO_BACK_TEST]	(	@dFecPro		CHAR(08)		-- 1 Fecha de Proceso
						,	@dFecProAnt		CHAR(08)		-- 2 Fecha Proceso Anterior
						,	@dFecProxPro		CHAR(08)		-- 3 Proxima Fecha Habil
						,	@dFecUDMPro		CHAR(08)		-- 4 Ultimo D¡a Mes de Proceso
						,	@dFecUDMAnt		CHAR(08)		-- 5 Ultimo D¡a Mes de Proceso Anterior
						,	@cLastHabil		CHAR(2)			-- 6 Indica si es el Ultimo D¡a H bil
						,	@cFirstHabil		CHAR(2)			-- 7 Indica si es el Primer D¡a H bil
						,	@nValorUF_Ant		NUMERIC(12,04)		-- 8 Uf Dia Anterior
						,	@nValorUF_Pro		NUMERIC(12,04)		-- 9 Uf de Proceso
						,	@nValorUF_UDM		NUMERIC(12,04)		-- 10 Uf Fin de Mes
						,	@nValUsd_Pro		NUMERIC(12,4)		-- 11 Valor D¢lar Observado Proceso
						,	@nValUsd_Ant		NUMERIC(12,4)		-- 12 Valor D¢lar Observado Anterior
						,	@nvalusd_udma		NUMERIC(12,4)		-- 13 Valor D¢lar Observado Ultimo Día Mes Anterior
						,	@iEjecucionIniDia	INT		= 0
						)
AS
BEGIN 
   -- MAP 20070112 se debe resguardar esto con el valor al inicio
   SET NOCOUNT ON

   SELECT 'OK'
   RETURN

   IF CONVERT(CHAR(10), GETDATE(),108) < '12:00:00'
   BEGIN
      SELECT 'OK'
      RETURN
   END

   EXECUTE BACPARAMSUDA..SP_FECHA_HABIL_ANTERIOR @dFecPro , @dFecProAnt OUTPUT


/*
   DECLARE @iFound   INT
--> 1) INDICACION T-LOCK Agregar chequo de existencia de Tasa Bench-Mark para instrumentos extranjeros

   SELECT @iFound   = 0
   SELECT @iFound   = COUNT(1)
   FROM   MFCA
   WHERE  cacodpos1 = 10
   and    caestado  = ''
   and    cabroker  not in( select distinct instrumento from bench_marck
                             where fecha = case when @iEjecucionIniDia = 0 then @dFecPro else @dFecProAnt end)

   if @iFound > 0
   begin
      select -1 , 'Se deben ingresar las tasa Bench Marck antes de Devengar.'
      return -1
   end

   SELECT @iFound   = 0
   SELECT @iFound   = COUNT(1)
   FROM   MFCA       inner join bench_marck on fecha = case when @iEjecucionIniDia = 0 then @dFecPro else @dFecProAnt end
                            and cabroker = instrumento and tasa = 0
   WHERE  cacodpos1 = 10
   and    caestado  = ''

   if @iFound > 0
   begin
      select -1 , 'Se deben ingresar las tasa Bench Marck distinta de Cero.'
      return -1
   end


-----------------------------------------------------------------------------------------------------------
   SELECT @iFound   = 0
   SELECT @iFound   = COUNT(1)
   FROM   MFCA
   WHERE  cacodpos1 = 11
   and    caestado  = ''
   and    caserie  not in( select distinct instrumento from BENCH_MARCK_INVEX 
                            where fecha = case when @iEjecucionIniDia = 0 then @dFecPro else @dFecProAnt end)

   if @iFound > 0
   begin
      select -1 , 'Se deben ingresar las tasa Bench Marck INV.EXT antes de Devengar.'
      return -1
   end

   SELECT @iFound   = 0
   SELECT @iFound   = COUNT(1)
   FROM   MFCA       inner join BENCH_MARCK_INVEX on fecha = case when @iEjecucionIniDia = 0 then @dFecPro else @dFecProAnt end
                            and caserie = instrumento and tasa = 0

   WHERE  cacodpos1 = 11
   and    caestado  = ''

   if @iFound > 0
   begin
      select -1 , 'Se deben ingresar las tasa Bench Marck INV. EXT.  distinta de Cero.'
      return -1
   end


   SELECT @iFound      = -1
   SELECT @iFound      = 0
   FROM   BacparamSuda..VALOR_MONEDA_CONTABLE , BacFwdSuda..MFAC
   WHERE  Fecha        = CASE WHEN @iEjecucionIniDia = 1 THEN acfecante ELSE acfecproc END
   AND    Tipo_Cambio <> 0.0

   IF @iFound = -1
   BEGIN
      SELECT -1 , 'No Existen Valores de Monedas Contables a la Fecha de Proceso...'
      RETURN
   END

*/
   DECLARE @Tasa_uf05     FLOAT
   ,       @Tasa_uf10     FLOAT

   DECLARE @Valorizador   VARCHAR(50)
   ,       @nError        INT
   ,       @Mon_inst      NUMERIC(9)
   ,       @Mon_pago      NUMERIC(9)
   ,       @Fec_inic      DATETIME
   ,       @Fec_Vcto      DATETIME
   ,       @Mon_Nominal   NUMERIC(21,4)
   ,     @Mon_VpresPe   NUMERIC(21,0)
   ,       @Mon_VPresUm   NUMERIC(21,4)
   ,       @Mon_VMercado  NUMERIC(21,0)
   ,       @Tir_Forward   NUMERIC(21,4)
   ,       @Tir_Mercado   NUMERIC(21,4)

   ,       @ReajusteDia   NUMERIC(21,4)
   ,       @ReajusteAcum  NUMERIC(21,4)
   ,       @VariacionDia  NUMERIC(21,4)
   ,       @VariacionAcum NUMERIC(21,4)
   ,       @dFechaVctoIns DATETIME
   ,       @Seriedo       CHAR(1)
   ,       @Fec_Calc      DATETIME
   ,       @Cod_inst      NUMERIC(9)
   ,       @Ser_Inst      VARCHAR(20)
   ,       @Fec_Emis      DATETIME
   ,       @Tas_Emis      NUMERIC(21,4)
   ,       @Bas_Emis      NUMERIC(9)
   ,       @Mon_Emis      NUMERIC(9)
   ,       @Tas_Est       NUMERIC(21,4)
   ,       @Fec_UltDev    DATETIME
   ,       @fPvp          FLOAT
   ,       @fMt           FLOAT
   ,       @fMtum         FLOAT
   ,       @fMt_cien      FLOAT
   ,       @fVan          FLOAT
   ,       @fVpar         FLOAT
   ,       @nNumucup      INT
   ,       @dFecucup      DATETIME
   ,       @fIntucup      FLOAT
   ,       @fAmoucup      FLOAT
   ,       @fSalucup      FLOAT
   ,       @nNumpcup      INT
   ,       @dFecpcup      DATETIME
   ,       @fIntpcup      FLOAT
   ,       @fAmopcup      FLOAT
   ,       @fSalpcup      FLOAT
   ,       @fDurat        FLOAT
   ,       @fConvx        FLOAT
   ,       @fDurmo        FLOAT
   ,       @TipoOper      char(1)
   ,       @BenchMarck    CHAR(1)
   ,       @iCalculaVAyer INT

DECLARE @nNumOpe      		        NUMERIC(10,00) 	, -- N£mero de Operaci¢n
 	@nCarter   			NUMERIC(02,00) 	, -- Tipo de Cartera
 	@cTipOpe      			CHAR(01)       		, -- Tipo de Operaci¢n
 	@nCodMon      			NUMERIC(03,00) 	, -- Moneda Origen
 	@nMtoMex      			NUMERIC(21,04) 	, -- Monto Origen
	@nMtoClp_i 			NUMERIC(21,00)	, -- Pesos al Inicio Por los D¢lares
	@nCodCnv      			NUMERIC(03,00) 	, -- Moneda Conversi¢n
	@nMtoCnv      			NUMERIC(21,04) 	, -- Monto Conversi¢n
	@nMtoCnv_i 			NUMERIC(21,00)	, -- Pesos al Inicio Por moneda Cnv ($$-UF)
	@dFecIni      			DATETIME       		, -- Fecha Inicio
   	@dFecVto      			DATETIME       		, -- Fecha Vencimiento
	@dFecAux			DATETIME		, -- Fecha Auxiliar
	@dFecVctop			DATETIME		, -- Fecha Vcto.
	@nPlazoOpe     			NUMERIC(04,00) 	, -- Plazo Operaci¢n
	@nPlazoVto			NUMERIC(04,00)	, -- Plazo al Vencimiento
	@nPlazoVctop			NUMERIC(04,00)	, -- Plazo al Vencimiento
	@nPlazoCal			NUMERIC(04,00)	, -- Plazo Calculado hasta Hoy
	@nPlazoCal_a			NUMERIC(04,00)	, -- Plazo Calculado hasta Ayer
	@nDiaDev      			NUMERIC(04,00) 	, -- Dias de Devengamiento
	@nValorUF			NUMERIC(12,04)  	, -- Valor UF de Calculo
	@nValUsd_C			NUMERIC(12,04)	, -- Valor USD de C lculo
        @nMonRef      			NUMERIC(03,00)  	, -- Moneda Referencial	
	@nMtoDif			NUMERIC(21,00)	, -- Valor a Diferir
	@nDelUsd			NUMERIC(12,04)	, -- Variaci¢n del Tipo de Cambio
	@nDelUf			        NUMERIC(12,04)	, -- Variaci¢n de la UF
	@nDelUsd_a			NUMERIC(12,04)	, -- Variaci¢n del Tipo de Cambio Ayer
	@nDelUf_a			NUMERIC(12,04)	, -- Variaci¢n de la UF Ayer
	@nPerDif 			NUMERIC(21,00)	, -- P'rdida Diferida
	@nUtiDif 			NUMERIC(21,00)	, -- Utilidad Diferida
	@nPerDev 			NUMERIC(21,00)	, -- P'rdida Devengada
	@nUtiDev 			NUMERIC(21,00)	, -- Utilidad Devengada
	@nPerAcu 			NUMERIC(21,00)	, -- P'rdida Acumulada
	@nUtiAcu 			NUMERIC(21,00)	, -- Utilidad Acumulada
	@nPerAcu_a 			NUMERIC(21,00)	, -- P'rdida Acumulada Ayer
	@nUtiAcu_a 			NUMERIC(21,00)	, -- Utilidad Acumulada Ayer
	@nPerSal 			NUMERIC(21,00)	, -- Saldo por devengar de la P'rdida Diferida
	@nUtiSal 			NUMERIC(21,00)	, -- Saldo por devengar de la utilidad Diferida
	@nClp_Mex			NUMERIC(21,00)	, -- Pesos de la Moneda1 Hoy
	@nClp_Cnv			NUMERIC(21,00)	, -- Pesos de la Moneda2 Hoy
	@nCtaCamb_a 			NUMERIC(21,00)	, -- Valor de la Cuenta Cambio Ayer
	@nCtaCamb_c 			NUMERIC(21,00)	, -- Valor de la Cuenta Cambio Hoy
	@nReaUFDia 			NUMERIC(21,00)	, -- Reajustes de la UF Hoy
	@nReaTCDia 			NUMERIC(21,00)	, -- Reajustes de la T/C Hoy
	@nValMex_i			FLOAT		, -- Valor de la Moneda1 al Inicio
	@nValCnv_i			FLOAT		, -- Valor de la Moneda2 al Inicio
	@nPreFut			FLOAT		, -- Precio Futuro
	@nValorDia			NUMERIC(21,00)  , -- Valorizaci½n del D­a
	@nRevUsd			NUMERIC(21,00)  , -- Valorizaci½n Acumulada de los D½lares
	@nRevUF			        NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF
	@nRevUsd_a			NUMERIC(21,00)  , -- Valorizaci½n Acumulada de los D½lares Ayer
	@nRevUF_a			NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF Ayer
	@nRevTot			NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF + los D½lares
	@nRevTot_a			NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF + los D½lares ayer
	@nMtoComp			NUMERIC(21,04)  , -- Monto a Compensar
	@nMarktomarket			NUMERIC(21,04)  , -- Monto del Mark To Market
	@nPrecioMtm			NUMERIC(21,04)  , -- Precio Mark To Market
	@nmonto_mtm_usd 		NUMERIC(21,04)	, -- MTM Moneda USD
	@nmonto_mtm_cnv 		NUMERIC(21,04)	, -- MTM Moneda Conversión
	@nmonto_var_usd 		NUMERIC(21,04)	, -- VAR Moneda USD
	@nmonto_var_cnv 		NUMERIC(21,04)	, -- VAR Moneda CNV
	@ntasausd_mtm 		        FLOAT		, -- Tasa MTM USD
	@ntasacnv_mtm 		        FLOAT		, -- Tasa MTM CNV
	@ntasausd_var 			FLOAT		, -- Tasa VAR USD
	@ntasacnv_var 			FLOAT		,-- Tasa VAR CNV
	@nObserAyer			NUMERIC(21,10)	, -- Variable para dejar el observado de Ayer
	@nptofwdvcto			FLOAT		, -- Puntos Forward al Vencimiento
	@preciospot			FLOAT	       	, -- Calculo Precio Spot
	@valormtm_usd			FLOAT	       	, -- Valor MTM en USD
	@valorpte_usd			FLOAT		, -- Valor Presente USD
	@cfuerte                	CHAR ( 1 )      , -- Moneda fuerte o debil
        @preciofwd              FLOAT           , -- Paridad
        @ntipcamval            	FLOAT           , -- Paridad de valorizaci¢n
        @ntccierre              FLOAT           , -- Tipo de Cambio Cierre Arbitrajes
        @CodPais                INT         , -- Codigo pais CHILE segun tabla paises
        @ctipcli               	CHAR ( 1 )      , -- Tipo Cliente L=local  E=externo
	@cModal			        CHAR ( 1 )	, -- Modalidad de la Operación (C-Compensación, E-Entrega Física)
	@nmtoini1  			NUMERIC(21,4)	, -- Monto USD Inicial Oper. Posición-1446
	@nmtofin1  			NUMERIC(21,4)	, -- Monto USD Final Oper. Posición-1446
	@nmtoini2  			NUMERIC(21,4)	, -- Monto CNV Inicial Oper. Posición-1446	 
	@nmtofin2  			NUMERIC(21,4)	, -- Monto CNV Final Oper. Posición-1446
	@ntasausd  			FLOAT			, -- Tasa USD Posición-1446
	@ntasacnv			FLOAT			, -- Tasa CNV Posición-1446
	@nMtoDif_usd			NUMERIC(21,04)	, -- Valor a Diferir de los USD de Posición-1446
	@nMtoDif_cnv			NUMERIC(21,04)	,  -- Valor a Diferir de la Conversión de Posición-1446
	@ndevengo_Acu_usd_hoy 	        NUMERIC(21,04)	, 
	@ndevengo_Acu_cnv_hoy 	        NUMERIC(21,04)	,  
	@ndevengo_Acu_usd_ayer	        NUMERIC(21,04)	,  
	@ndevengo_Acu_cnv_ayer	        NUMERIC(21,04)	,  
	@clp_nMtoDif_usd 		NUMERIC(21,00)	,  
	@clp_nMtoDif_cnv 		NUMERIC(21,00)	,  
	@clp_ndevengo_usd 		NUMERIC(21,00)	,  
	@clp_ndevengo_cnv 		NUMERIC(21,00)	,  
	@clp_ndevengo_Acu_usd 	NUMERIC(21,00)	,  
	@clp_ndevengo_Acu_cnv 	NUMERIC(21,00)	,  
	@clp_nSaldo_diferido_usd 	NUMERIC(21,00)	,  
	@clp_nSaldo_diferido_cnv 	NUMERIC(21,00)	,
	@tc_calculo_mes_actual		NUMERIC(12,4)	,
	@tc_calculo_mes_anterior 	NUMERIC(21,4)	, -- 12,4
	@npremio		 	NUMERIC(24,4)	,
	@canticipo		 	CHAR(1)	,
	@vencimiento_original		DATETIME	,
	@nPlazoVtoanterior 	 	NUMERIC(4,0)	,
	@nefecto_cambiario_mon1	NUMERIC(21,00)	,
	@nefecto_cambiario_mon2	NUMERIC(21,00)	,
	@ndevengo_tasa_mon1		NUMERIC(21,00)	,
	@ndevengo_tasa_mon2		NUMERIC(21,00)	,
	@ncambio_tasa_mon1		NUMERIC(21,00)	,
	@ncambio_tasa_mon2		NUMERIC(21,00)	,
	@nresiduo			NUMERIC(21,00)	,
	@nmonto_mtm_mon1_ayer	NUMERIC(21,00)	,
	@nmonto_mtm_mon2_ayer	NUMERIC(21,00)	,
	@ndolar_estimado		NUMERIC(12,04)	,
	@Compensacion_estimada	NUMERIC(21,00)	,
	@nmonto_final 			NUMERIC(21,04)	,
	@precio_spot_inicial 		FLOAT		,
	@factor_moneda2 		FLOAT		,

	@factor_moneda1 		FLOAT		,
	@monto_factor 			FLOAT		,
	@monto_moneda2 		NUMERIC(21,4)	,
	@moneda2 			NUMERIC(3)	,
	@monto_pesos2 		NUMERIC(21,00)	,
	@valor_actual_cnv		NUMERIC(21,04)	,
	@devengo1			NUMERIC(21,00)	,
	@monto_acumulado_mon1 	NUMERIC(21,04)	,
	@monto_acumulado_mon2 	NUMERIC(21,04)	,
	@valor_ayer 	 		NUMERIC(21,00)	,
        	@PrimerDiaMes      		CHAR(8)		,
	@plazo_uso_moneda1		NUMERIC(05,00)	,
	@plazo_uso_moneda2		NUMERIC(05,00)	,
	@fecha				DATETIME	,
	@Valor_Obtenido		FLOAT		, --new Precio Proyectado
	@Resultado			FLOAT	  	, --new
	@ResultadoMTM		FLOAT		,  --RESULTADO MARKTOMARKET
	@CaTasaSinteticaM1		FLOAT		,	 
	@CaTasaSinteticaM2		FLOAT		,	 
	@CaPrecioSpotVentaM1		FLOAT		,	
	@CaPrecioSpotVentaM2		FLOAT		, 
	@CaPrecioSpotCompraM1	FLOAT		,
	@CaPrecioSpotCompraM2 	FLOAT		,
	@dFecEfectiva  			DATETIME       	,   -- Fecha Efectiva	JB 20050613
	@nPlazoVtoEfec			FLOAT		,   -- Fecha Vcto efectiva	JB 20050613	
        @ValorRazonableActivo           FLOAT           ,   -- MPNG20050825 TAG 002
        @ValorRazonablePasivo           FLOAT               -- MPNG20050825 TAG 002


	DECLARE @fTe_pcdus                   FLOAT
	,       @fTe_pcduf                   FLOAT
	,       @fTe_ptf                     FLOAT

	DECLARE @ValorMoneda_Hoy             FLOAT
	,       @ValorMoneda_Mañ             FLOAT

	SELECT @fTe_pcdus        = ISNULL(vmvalor,0.0)
	FROM   bacparamsuda..VALOR_MONEDA
	WHERE  vmcodigo          = 300 
	AND    vmfecha           = @dFecPro

	SELECT @fTe_pcduf        = ISNULL(vmvalor,0.0)
	FROM   bacparamsuda..VALOR_MONEDA
	WHERE  vmcodigo          = 301
	AND    vmfecha        = @dFecPro

	SELECT @fTe_ptf          = ISNULL(vmvalor,0.0)
	FROM   bacparamsuda..VALOR_MONEDA 
	WHERE  vmcodigo          = 302
	AND    vmfecha           = @dFecPro

	SELECT @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(8),@dfecpro,112),1,6) + '01'
	SELECT @nValUsd_c  = @nValUsd_Pro
	SELECT @nObserAyer = @nValUsd_Ant

	SELECT 	@CodPais    = acpais
	FROM 	MFAC

	-- Dólar Estimado, esto es para la proyección de los Vencimientos
	SELECT 	@ndolar_estimado	= tasa_compra 
	FROM	VIEW_TASA_FWD
	WHERE	codigo	= 2 
	AND	fecha	= @dFecProxPro

/*
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	--			 RECORDATORIO PARA VERIFICAR SI LO QUE ESTA DENTRO DE ESTE COMENTARIO SIRVE PARA RBT O NO			--
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------

	-- |------------------------------------
	-- | Limpia Resultados de Hoy 
	-- |------------------------------------

	UPDATE	RESULTADO	SET 	saldo_usd			= 0,
					saldo_uf 			= 0,
					variacion_tc			= 0,
					variacion_uf			= 0,
					devengo     			= 0,
					devengo_pesos			= 0,
					devengo_uf   			= 0,
					neto_dia     			= 0,
					acumulado_tc  			= 0,
					acumulado_uf  			= 0,
					acumulado_devengo 		= 0,
					acumulado_devengo_pesos 	= 0,
					acumulado_devengo_uf    	= 0,
					acumulado_neto          	= 0
	WHERE 	fecha = @dFecPro

	SELECT * INTO #temp_a FROM resultado WHERE @dFecProAnt = fecha 

	UPDATE 	a 
	SET 	a.acumulado_tc	 		= b.acumulado_tc		,
		a.acumulado_uf	 		= b.acumulado_uf		,
		a.acumulado_devengo 		= b.acumulado_devengo		,
		a.acumulado_devengo_pesos 	= b.acumulado_devengo_pesos	,
		a.acumulado_devengo_uf 	= b.acumulado_devengo_uf	,
		a.acumulado_neto 		= b.acumulado_neto 					
	FROM 	resultado 	a,
		#temp_a	b		
	WHERE  @dFecPro = a.fecha AND a.tipo = b.tipo 

	-- Para el Primer Día del Mes
	IF @cFirstHabil = 'SI'
		BEGIN
			UPDATE 	a 
			SET 	a.acumulado_tc	 		= 0	,
				a.acumulado_uf	 		= 0	,
				a.acumulado_devengo 		= 0	,
				a.acumulado_devengo_pesos 	= 0	,
				a.acumulado_devengo_uf 	= 0	,
				a.acumulado_neto 		= 0
			FROM 	resultado a
			WHERE	@dFecPro = a.fecha AND 
				a.tipo NOT LIKE '%NET%'

		END

	-- Para el Primer Día del Año
	IF SUBSTRING(@PrimerDiaMes,1,4) <> SUBSTRING(CONVERT(CHAR(8),@dFecProAnt,112),1,4)
		BEGIN
			UPDATE 	a 
			SET 	a.acumulado_tc	 		= 0	,
				a.acumulado_uf	 		= 0	,
				a.acumulado_devengo 		= 0	,
				a.acumulado_devengo_pesos 	= 0	,
				a.acumulado_devengo_uf 	= 0	,
				a.acumulado_neto 		= 0
			FROM 	resultado a
			WHERE	@dFecPro = a.fecha 
		END

	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
*/

BEGIN TRANSACTION

/*
|---------------------------------------------------------------------------|
| Declaraci¢n del Cursor						    |
|---------------------------------------------------------------------------|*/

	DECLARE Tmp_CurMFCA   SCROLL CURSOR FOR  
		SELECT	canumoper   		,--1
			cacodpos1   		,--2
			catipoper   		,--3
			cacodmon1   		,--4
			camtomon1 		,--5
			FLOOR( caequmon1 )	,--6
			capremon1   		,--7
			cacodmon2   		,--8
			camtomon2   		,--9
			FLOOR( caequmon2 )	,--10
			capremon2   		,--11
			cafecha     		,--12
			cafecvcto   		,--13
			catipcam    		,--14
			camdausd    		,--15
                        caprecal    		,--16
			catipmoda   		,--17
			camtomon1fin		,--18
			camtomon1ini		,--19
			camtomon2fin		,--20
			camtomon2ini		,--21
			catasausd		,--22
			catasacon		,--23
			tc_calculo_mes_actual	,--24
			tc_calculo_mes_anterior,--25
			capremio		,--26
			caantici		,--27
			cafecvenor		,--28
			cavalorayer		,--29
			cafecEfectiva		 --30
		FROM	BACFWDSUDA..MFCARES
		WHERE	CaFechaProceso	= @dFecPro
		AND	EXISTS(SELECT 1 FROM MFCA WHERE MFCA.canumoper = MFCARES.canumoper)
--		AND	cacodpos1	= 10
		ORDER 
		BY	canumoper

/*
|---------------------------------------------------------------------------|
| Apertura del Cursor.							    |
|---------------------------------------------------------------------------|*/
 OPEN Tmp_CurMFCA
/*
|---------------------------------------------------------------------------|
| Primer registro del CURSOR (lectura secuencial de la tabla MFCA)	    |
|---------------------------------------------------------------------------|*/

 FETCH FIRST FROM Tmp_CurMFCA
	       INTO 	@nNumOpe   	, --1
		    	@nCarter   	, --2   --
		    	@cTipOpe   	, --3
		    	@nCodMon   	, --4
		 	@nMtoMex 	, --5
		    	@nMtoClp_i 	, --6
		    	@nValMex_i 	, --7   --
		    	@nCodCnv   	, --8
		    	@nMtoCnv   	, --9
		    	@nMtoCnv_i 	, --10
		    	@nValCnv_i 	, --11  --
		    	@dFecIni   	, --12
		   	@dFecVto   	, --13
		    	@nPreFut   	, --14  --
		    	@nMonRef   	, --15
                	@ntccierre 	, --16  --
		    	@cModal    	, --17
		    	@nmtofin1  	, --18
		    	@nmtoini1  	, --19
		    	@nmtofin2  	, --20
		    	@nmtoini2  	, --21
		    	@ntasausd  	, --22  --
		    	@ntasacnv  	, --23  --
		    	@tc_calculo_mes_actual	 , --24
		    	@tc_calculo_mes_anterior , --25
		    	@npremio	, --26
		    	@canticipo	, --27
		    	@vencimiento_original  , --28
		    	@valor_ayer	, --29
			@dFecEfectiva	  --30
   /*
   |------------------------------------------------------------------------|
   | Carga Cursor					   		 ---|
   |------------------------------------------------------------------------|*/


    WHILE ( @@FETCH_STATUS = 0 )	
    BEGIN

	


	SELECT 	@nPlazoOpe		= 0
	,	@nPlazoVto 		= 0  
	,	@nPlazoCal 		= 0	
	,	@nPlazoCal_a 		= 0	
	,	@nDiaDev 		= 0		
	,	@nValorUF		= 0	
	,	@nMtoDif		= 0	
	,	@nDelUsd 		= 0	
	,	@nDelUf			= 0	
	,	@nDelUsd_a 		= 0	
	,	@nDelUf_a 		= 0	
	,	@nPerDif 		= 0	
	,	@nUtiDif 		= 0	
	,	@nPerDev 		= 0	
	,	@nUtiDev 		= 0	
	,	@nPerAcu 		= 0	
	,	@nUtiAcu 		= 0	
	,	@nPerAcu_a 		= 0	
	,	@nUtiAcu_a 		= 0	
	,	@nPerSal 		= 0		
	,	@nUtiSal 		= 0	
	,	@nClp_Mex 		= 0
	,	@nClp_Cnv 	         = 0	
	,	@nCtaCamb_a 	         = 0	
	,	@nCtaCamb_c 	         = 0	
	,	@nReaUFDia 	         = 0	
	,	@nReaTCDia 	         = 0	
	,	@nValorDia 	         = 0	
	,	@nMtoComp 	         = 0
	,	@nRevUsd 	         = 0
	,	@nRevUF 	         = 0
	,	@nRevUsd_a 	         = 0
	,	@nRevUF_a 	         = 0
	,	@nRevTot 	         = 0
	,	@nRevTot_a 	         = 0
	,	@nMarktomarket           = 0
	,	@nMtoDif_usd 	         = 0
	,	@nMtoDif_cnv 	         = 0
	,	@ndevengo_Acu_usd_hoy    = 0
	,	@ndevengo_Acu_cnv_hoy    = 0
	,	@ndevengo_Acu_usd_ayer   = 0
	,	@ndevengo_Acu_cnv_ayer   = 0
	,	@clp_nMtoDif_usd         = 0
	,	@clp_nMtoDif_cnv         = 0
	,	@clp_ndevengo_usd        = 0
	,	@clp_ndevengo_cnv        = 0
	,	@clp_ndevengo_Acu_usd    = 0
	,	@clp_ndevengo_Acu_cnv    = 0
	,	@clp_nSaldo_diferido_usd = 0
	,	@clp_nSaldo_diferido_cnv = 0
	,	@nmonto_mtm_usd          = 0
	,	@nmonto_mtm_cnv          = 0
	,	@nmonto_var_usd          = 0
	,	@nmonto_var_cnv          = 0
	,	@ntasausd_mtm            = 0
	,	@ntasacnv_mtm            = 0
	,	@ntasausd_var            = 0
	,	@ntasacnv_var            = 0
	,	@nPlazoVtoanterior       = 0
	,	@nefecto_cambiario_mon1	 = 0
	,	@nefecto_cambiario_mon2	 = 0
	,	@ndevengo_tasa_mon1      = 0
	,	@ndevengo_tasa_mon2      = 0
	,	@ncambio_tasa_mon1       = 0
	,	@ncambio_tasa_mon2       = 0
	,	@nresiduo                = 0
	,	@nmonto_mtm_mon1_ayer    = 0
	,	@nmonto_mtm_mon2_ayer    = 0
	,	@Compensacion_estimada   = 0
	,	@nmonto_final            = 0
	,	@precio_spot_inicial     = 0
	,	@factor_moneda2          = 0
	,	@factor_moneda1          = 0
	,	@monto_factor 	         = 0
	,	@ntipcamval              = 0
	,	@monto_pesos2            = 0
	,	@valor_actual_cnv        = 0
	,	@devengo1                = 0
	,	@monto_acumulado_mon1    = 0
	,	@monto_acumulado_mon2    = 0
	,	@plazo_uso_moneda1       = 0
	,	@plazo_uso_moneda2       = 0
	,	@nValUsd_Ant             = @nObserAyer --Vuelve a dejar el observado de ayer
	,	@monto_moneda2           = @nMtoCnv
	,	@moneda2                 = @nCodCnv
	,	@nPlazoVtoEfec           = 0



      SELECT @VariacionDia  = 0.0
      ,      @Mon_VpresPe = 0.0
      ,      @Mon_VMercado  = 0.0
      ,      @VariacionDia  = 0.0
      ,      @ReajusteDia   = 0.0
      ,      @VariacionAcum = 0.0
      ,      @ReajusteAcum  = 0.0
      ,      @fPvp          = 0.0
      ,      @fMt           = 0.0
      ,      @fMtum         = 0.0
      ,      @fMt_cien      = 0.0
      ,      @fVan          = 0.0
      ,      @fVpar         = 0.0
      ,      @nNumucup      = 0.0
      ,      @dFecucup      = 0.0
      ,      @fIntucup      = 0.0
      ,      @fAmoucup      = 0.0
      ,      @fSalucup      = 0.0
      ,      @nNumpcup      = 0
      ,     @dFecpcup      = ''
    ,      @fIntpcup      = 0.0
      ,      @fAmopcup      = 0.0
      ,   @fSalpcup      = 0.0
      ,      @fDurat        = 0.0
      ,      @fConvx        = 0.0
      ,      @fDurmo        = 0.0
      ,      @Fec_UltDev    = ''


	SELECT  @nPlazoOpe = DATEDIFF( dd, @dFecIni, @dFecVto )		--Dias de la Operaci¢n 

	-- MAP 20070816, desarrollo anticipo
	IF @nPlazoOpe = 0
        	SELECT @nPlazoOpe = 1


	/*----  Tipo  de Cliente  --------*/
	SELECT @cTipCli = (CASE clpais WHEN @CodPais THEN 'L' ELSE 'E' END)
	FROM	MFCARES
	,	VIEW_CLIENTE
	WHERE	CaFechaProceso	= @dFecPro
	AND	canumoper	= @nNumOpe 
	AND	clrut		= cacodigo 
	AND	clcodigo	= cacodcli

	/*----Plazo al Vencimiento--------*/
	IF @dFecVto < @dFecPro 
	   BEGIN
		SELECT @nPlazoVto = 0
		SELECT @nPlazoVtoEfec = 0

	   END 
	ELSE 
	   BEGIN
		SELECT @nPlazoVto 	   = DATEDIFF( dd , @dFecPro , @dFecVto )
		SELECT @nPlazoVtoEfec  = DATEDIFF( dd , @dFecPro ,@dFecEfectiva ) 
	END




	--Plazo Residual al Día Anterior
	SELECT @nPlazoVtoanterior = 0
	IF @dFecini < @dFecPro 
		SELECT @nPlazoVtoanterior = DATEDIFF( dd , @dFecProAnt , @dFecVto )

      /*
      |---------------------------------------------------------------------|
      | Plazo de Cálculo hasta Hoy 					    |
      |---------------------------------------------------------------------|*/
	IF @dFecPro = @dFecVto 
           BEGIN
             SELECT @nPlazoCal   = DATEDIFF( dd, @dFecIni, @dFecPro    )

	   END 


        ELSE 
           BEGIN

		IF @dFecVto < @dFecPro
		   BEGIN
			SELECT @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecVto )
		   END

		ELSE
                   BEGIN
 			SELECT @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecProxPro )

		   END

	       IF @cLastHabil = 'SI' AND @dFecVto <> @dFecPro 
		  BEGIN
		  	SELECT @nPlazoCal = DATEDIFF( dd , @dFecIni , ( @dFecUDMPro + 1 ) ) --SUDAMERICANO SUMA 1 Día en el Fin de Mes

       	          END

	   END

	IF @canticipo = 'A' 
			SELECT @nPlazoCal = DATEDIFF( dd, @dFecIni, @vencimiento_original )

	
	IF @dFecIni < @dFecPro
	        SELECT @nPlazoCal_a = DATEDIFF( dd, @dFecIni, @dFecPro )
	
	IF @cFirstHabil = 'SI'	AND @dFecIni < @dFecPro
	  	SELECT @nPlazoCal_a = DATEDIFF( dd , @dFecIni , ( @dFecUDMAnt + 1 ) ) --SUDAMERICANO SUMA 1 Día en el Fin de Mes



       /* FIN PLAZO CALCULO*/

      /*
      |---------------------------------------------------------------------|
      | Dias de Devengamiento						    |
      |---------------------------------------------------------------------|*/

	IF @dFecVto < @dFecPro 
	           BEGIN
			SELECT @dFecAux = @dFecVto
	           END 

	ELSE 
		BEGIN
			IF @canticipo = 'A' 
		           BEGIN
				SELECT @dFecAux = @vencimiento_original
		           END 

			ELSE
			   BEGIN

				SELECT @dFecAux = @dFecProxPro

		  	   END
		END

	SELECT @nDiaDev = DATEDIFF( dd ,  @dFecPro ,@dFecAux )		--Dias de Devengo en Período Normal

	IF @cFirstHabil = 'SI'  --Primer Día Hábil
	   BEGIN		
			
		IF @dFecIni < @dFecPro --Vigentes al Mes Anterior
		   BEGIN
				IF @dFecVto = @dFecPro 
				        SELECT @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecPro ) --SUDAMERICANO SUMA 1 Día en el Fin de Mes
				ELSE
				        SELECT @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecProxPro ) --SUDAMERICANO SUMA 1 Día en el Fin de Mes

	           END

	   END

	IF @cLastHabil = 'SI'
	   BEGIN		--Ultimo Día Hábil
		SELECT @nDiaDev = DATEDIFF( dd , @dFecPro , ( @dFecUDMPro + 1 ) )  --SUDAMERICANO SUMA 1 Día en el Fin de Mes
	   END
    
        IF @dFecVto <= @dFecPro AND @canticipo <> 'A' AND @cFirstHabil = 'NO'  
          BEGIN
                    SELECT @nDiaDev = 0 
	  END
       /* FIN DIAS DE DEVENGAMIENTO */

	
      /*
      |---------------------------------------------------------------------|
      | Valor UF a Utilizar en el Cálculo				    |
      | Lo General es que la UF de Cálculo Sea la Misma del día, sin Embargo|
      | a Fin de Mes se debe Utilizar la UF del Ultimo Día del Mes Excepto  |
      | Para Aquellas Operaciones que Vencen ese Día			    |
      |---------------------------------------------------------------------|*/
	SELECT @nValorUF = @nValorUF_Pro
	
	IF @cLastHabil = 'SI' 
	   BEGIN

		IF @dFecVto <> @dFecPro 
		   BEGIN
			SELECT @nValorUF = @nValorUF_UDM		
		END		

	   END
			
      /*
      |---------------------------------------------------------------------|
      |---------------------------------------------------------------------|
      |---------------------------------------------------------------------|
      |---------						   ---------|
      |---------						   ---------|
      |---------    Aqui Comienzan El Proceso de Devengamiento     ---------|
      |---------		y Valorizaci¢n			   ---------|
      |---------						   ---------|
      |---------------------------------------------------------------------|
      |---------------------------------------------------------------------|
      |---------------------------------------------------------------------|
      */

      /*
      |---------------------------------------------------------------------|
      | Cálculo de Devengo y Valorizaci¢n USD/UF                            |
      |---------------------------------------------------------------------|*/

	IF ( @nCarter IN ( 1 ,7 ) AND @nCodCnv = 998 )	--USD/UF
        BEGIN  			
            IF @cTipOpe = 'C' 
            BEGIN
	       SELECT @nMtoDif = @nMtoClp_i - @nMtoCnv_i
	       SELECT @nDelUsd = @nValUsd_c - @nValMex_i
	       SELECT @nDelUf  = @nValCnv_i - @nValorUF
	    END ELSE 
            BEGIN
	       SELECT @nMtoDif = @nMtoCnv_i - @nMtoClp_i 
	       SELECT @nDelUsd = @nValMex_i - @nValUsd_c
	       SELECT @nDelUf  = @nValorUF  - @nValCnv_i
	    END
            IF @nMtoDif < 0 
	    BEGIN
	       SELECT @nPerDif = @nMtoDif
            END ELSE 
	    BEGIN
	       SELECT @nUtiDif = @nMtoDif
            END

		SELECT @nPerDev = ROUND( ( @nPerDif / @nPlazoOpe ) * @nDiaDev  , 0 )
		SELECT @nUtiDev = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nDiaDev  , 0 )

		SELECT @nPerAcu = ROUND( ( @nPerDif / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @nUtiAcu = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nPlazoCal , 0 )

		SELECT @nPerSal = @nPerDif - @nPerAcu
		SELECT @nUtiSal = @nUtiDif - @nUtiAcu

		SELECT @nClp_Mex = ROUND( @nMtoMex * @nValUsd_c , 0 )
		SELECT @nClp_Cnv = ROUND( @nMtoCnv * @nValorUF , 0 )

		SELECT @nRevUsd = ROUND( @nMtoMex * @nDelUsd , 0 )
		SELECT @nRevUF  = ROUND( @nMtoCnv * @nDelUf  , 0 )
		SELECT @nRevTot = @nRevUsd + @nRevUF + @nUtiAcu + @nPerAcu

		IF @dFecIni < @dFecPro 
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( @nMtoMex * @nValUsd_Ant , 0 )
			SELECT @nCtaCamb_c = ROUND( @nMtoMex * @nValUsd_c   , 0 )
			SELECT @nReaUFDia  = ROUND( @nMtoCnv * ( @nValorUF - @nValorUF_Ant ) , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a

		   END 

		ELSE 
		   BEGIN                         
			SELECT @nCtaCamb_a = ROUND( @nMtoMex * @nValMex_i , 0 )
			SELECT @nCtaCamb_c = ROUND( @nMtoMex * @nValUsd_c , 0 )
			SELECT @nReaUFDia  = ROUND( @nMtoCnv * ( @nValorUF - @nValorUF_Pro ) , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a
		END

		IF @cTipOpe = 'C' 
		   BEGIN			
			SELECT @nCtaCamb_a = @nCtaCamb_a - @nUtiDev + ABS( @nPerDev )
		   END 
		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a + @nUtiDev - ABS( @nPerDev )
		   END

		SELECT @nCtaCamb_a = @nCtaCamb_a + @nReaUFDia

		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_c - @nCtaCamb_a
		   END 

		ELSE 
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_a - @nCtaCamb_c
		   END

		SELECT @nRevTot_a = @nValorDia+@valor_ayer

		IF @dFecVto <= @dFecpro --and @cModal = 'C' --Valor a Liquidar Real
		   BEGIN

			IF @cTipOpe = 'C' 
			   BEGIN
				SELECT @nMtoComp = ROUND( @nMtoMex * @nValUsd_c , 0 ) - ROUND( @nMtoCnv * @nValorUF , 0 )

			  END 

			ELSE 
			   BEGIN
				SELECT @nMtoComp = ROUND( @nMtoCnv * @nValorUF , 0 ) - ROUND( @nMtoMex * @nValUsd_c , 0 )

			END
		END

		IF @dFecVto = @dFecproxpro and @cModal = 'C' --Valor a Liquidar estimado
		   BEGIN

			IF @cTipOpe = 'C' 
			   BEGIN
				SELECT @Compensacion_estimada = ROUND( @nMtoMex * @ndolar_estimado , 0 ) - ROUND( @nMtoCnv * @nValorUF , 0 )
			   END

			ELSE
			   BEGIN
				SELECT @Compensacion_estimada = ROUND( @nMtoCnv * @nValorUF , 0 ) - ROUND( @nMtoMex * @ndolar_estimado , 0 )

 			END
		END		
	END


      /*
      |---------------------------------------------------------------------|
      | Calculo de Devengo y Valorizaci¢n USD/$$                            |
      |---------------------------------------------------------------------|*/

	IF  ((@nCarter =  1 OR @nCarter =  7 ) AND @nCodCnv = 999) --USD/UF
	 BEGIN  			
      
		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nMtoDif = @nMtoClp_i - @nMtoCnv_i
			SELECT @nDelUsd = @nValUsd_c - @nValMex_i
		   END 

		ELSE 
		   BEGIN

			SELECT @nMtoDif = @nMtoCnv_i - @nMtoClp_i 
			SELECT @nDelUsd = @nValMex_i - @nValUsd_c
		   END
		
		IF @nMtoDif < 0 
		   BEGIN
			SELECT @nPerDif = @nMtoDif

		   END 

		ELSE 
		   BEGIN
			SELECT @nUtiDif = @nMtoDif

	END
		SELECT @nPerDev = ROUND( ( @nPerDif / @nPlazoOpe ) * @nDiaDev  , 0 )
		SELECT @nUtiDev = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nDiaDev  , 0 )

		SELECT @nPerAcu = ROUND( ( @nPerDif / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @nUtiAcu = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @nPerSal = @nPerDif - @nPerAcu
		SELECT @nUtiSal = @nUtiDif - @nUtiAcu

		SELECT @nClp_Mex = ROUND( @nMtoMex * @nValUsd_c , 0 )
		SELECT @nClp_Cnv = @nMtoCnv_i
		SELECT @nRevUsd = ROUND( @nMtoMex * @nDelUsd , 0 )
		SELECT @nRevTot = @nRevUsd + @nUtiAcu + @nPerAcu

		IF @dFecIni < @dFecPro 
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( @nMtoMex * @nValUsd_Ant , 0 )
			SELECT @nCtaCamb_c = ROUND( @nMtoMex * @nValUsd_c , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a

		   END 

		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( @nMtoMex * @nValMex_i , 0 )
			SELECT @nCtaCamb_c = ROUND( @nMtoMex * @nValUsd_c , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a 
		END

		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a - @nUtiDev + ABS( @nPerDev )
		   END 
		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a + @nUtiDev - ABS( @nPerDev )
		END

		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_c - @nCtaCamb_a
		   END 
		ELSE 
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_a - @nCtaCamb_c
		   END

		SELECT @nRevTot_a = @nValorDia+@valor_ayer

		IF @dFecVto <= @dFecpro --and @cModal = 'C' -- Valor a Liquidar Real
		   BEGIN

			IF @cTipOpe = 'C' 
			   BEGIN
				SELECT @nMtoComp = ROUND( @nMtoMex * @nValUsd_c , 0 ) - @nMtoCnv_i
			   END 
			ELSE 
			   BEGIN
				SELECT @nMtoComp = @nMtoCnv_i - ROUND( @nMtoMex * @nValUsd_c , 0 )

			END

		END
		IF @dFecVto = @dFecproxpro and @cModal = 'C' --Valor a Liquidar estimado
		   BEGIN

			IF @cTipOpe = 'C' 
			   BEGIN
				SELECT @Compensacion_estimada = ROUND( @nMtoMex * @ndolar_estimado , 0 ) - @nMtoCnv_i

			   END 

			ELSE 
			   BEGIN
				SELECT @Compensacion_estimada = @nMtoCnv_i - ROUND( @nMtoMex * @ndolar_estimado , 0 )

			END

		END


	END

       -- declarar procesos de arbitrajes  
       -- cavalordia -> valor total del d¡a ,  uf usd + monto diferido 
       -- montomarktomarket  -> 
       -- caparval -> Precio ->parida para caculo      
       -- 
      /*
      |---------------------------------------------------------------------|
      | Cálculo de Devengo y Valorización MX-USD                            |
      |---------------------------------------------------------------------|*/

	IF @nCarter = 2 BEGIN  -- M/X-USD
 		IF @cTipOpe = 'C'
			SELECT @nmtodif = @nMtoClp_i - @nMtoCnv_i
		ELSE
			SELECT @nmtodif = @nMtoCnv_i - @nMtoClp_i

                SELECT @cfuerte = mnrefusd FROM VIEW_MONEDA WHERE mncodmon = @nCodMon
		
		IF @dFecVto > @dFecPro and @nCodCnv = 13 BEGIN -- Cálculo de BID-ASK
			EXECUTE Sp_BidAsk2	@ncodmon
					,	@dFecpro
					,	@cTipOpe
					,	@nPlazovto 
					,	@nPtofwdvcto	OUTPUT 
					,	@Preciospot	OUTPUT	
					,	@dFecProxPro

                        SELECT @preciofwd = ROUND( @preciospot +  @nptofwdvcto , 6 ) 

                        IF @cfuerte = 0 BEGIN --Mas Débil 
				EXECUTE Sp_Div 1.0 , @preciofwd  , @preciofwd OUTPUT 
				SELECT @preciofwd = ROUND(@preciofwd,10)
			END
                     
	 		SELECT @valormtm_usd = ROUND( @nMtoMex * @preciofwd    , 2 ) 
			SELECT @valorpte_usd = ROUND( @nMtoCnv - @valormtm_usd , 2 )

			IF @cTipOpe = 'C' BEGIN
				SELECT @valorpte_usd =  @valorpte_usd * -1
			END
                          
                     IF @cfuerte = 0 BEGIN --Mas Débil
				EXECUTE Sp_Div 1 , @preciofwd , @preciofwd OUTPUT 
			END
		
                        SELECT	@nValorDia  = ROUND(ISNULL(@valorpte_usd * @nValUsd_c, 0.0),0),
				@ntipcamval = ISNULL(@preciofwd,0.0)
		END
                
		IF @dFecVto <= @dFecpro and @cModal = 'C' BEGIN
               		SELECT @preciofwd = @ntccierre

		    IF @cfuerte = 0 BEGIN -- Mas Debil
				EXECUTE Sp_Div 1 , @ntccierre , @preciofwd OUTPUT 
			END

			IF @cTipOpe = 'C' BEGIN -- antes era esto DLS --> IF @cTipOpe = 'V' BEGIN
				SELECT @nMtoComp = ROUND(@nMtoMex * @PrecioFWD , 2) - @nMtoCnv
			END ELSE BEGIN
				SELECT @nMtoComp = @nMtoCnv - ROUND( @nMtoMex * @PrecioFWD , 2 )
			END

			IF @cTipCli = 'L' AND (@ncodcnv <> 999 and @ncodcnv<>998)
		       SELECT @nMtoComp = ROUND( @nMtoComp * @nValUsd_c, 0)
		END
	END



      /*
      |---------------------------------------------------------------------|
      | Calculo de Devengo y Valorizaci¢n UF/$$                             |
      |---------------------------------------------------------------------|
      */

	IF @nCarter = 3 --UF/$$
	   BEGIN  						

		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nMtoDif = @nMtoClp_i - @nMtoCnv_i
			SELECT @nDelUf  = @nValorUF - @nValMex_i

                        IF @dFecIni < @dFecPro
                           BEGIN
				SELECT @nDelUf_a  = @nValorUF_Ant - @nValMex_i
                           END

		   END 

		ELSE 
		   BEGIN
			SELECT @nMtoDif = @nMtoCnv_i - @nMtoClp_i 
			SELECT @nDelUf  = @nValMex_i - @nValorUF

                        IF @dFecIni < @dFecPro
                           BEGIN
				SELECT @nDelUf_a  = @nValMex_i - @nValorUF_Ant
                           END

		   END
		
		IF @nMtoDif < 0 
		   BEGIN
			SELECT @nPerDif = @nMtoDif

		   END 
		ELSE 
		   BEGIN
			SELECT @nUtiDif = @nMtoDif

		   END

		SELECT @nPerDev = ROUND( ( @nPerDif / @nPlazoOpe ) * @nDiaDev  , 0 )
		SELECT @nUtiDev = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nDiaDev  , 0 )

		SELECT @nPerAcu = ROUND( ( @nPerDif / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @nUtiAcu = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nPlazoCal , 0 )

		SELECT @nPerSal = @nPerDif - @nPerAcu
		SELECT @nUtiSal = @nUtiDif - @nUtiAcu

		SELECT @nClp_Mex = ROUND( @nMtoMex * @nValorUf , 0 )
		SELECT @nClp_Cnv = @nMtoCnv_i

		SELECT @nRevUF  = ROUND( @nMtoMex * @nDelUf  , 0 )
		SELECT @nRevTot = @nRevUF + @nUtiAcu + @nPerAcu

		SELECT @nRevUF_a= ROUND(@nMtoMex * @nDelUf_a , 0)

		IF @dFecIni < @dFecPro 
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( @nMtoMex * @nValorUF_Ant , 0 )
			SELECT @nCtaCamb_c = ROUND( @nMtoMex * @nValorUF , 0 )
			SELECT @nReaUFDia  = ROUND( @nMtoCnv * ( @nValorUF - @nValorUF_Ant ) , 0 )

		   END 

		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nValorUF_Pro
			SELECT @nCtaCamb_c = @nValorUF
			SELECT @nReaUFDia  = ROUND( @nMtoCnv * ( @nValorUF - @nValorUF_Pro ) , 0 )

		   END

		IF @cTipOpe = 'C' 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a - @nUtiDev + ABS( @nPerDev )
			SELECT @nValorDia = @nCtaCamb_c - @nCtaCamb_a

		   END 

		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a + @nUtiDev - ABS( @nPerDev )
			SELECT @nValorDia = @nCtaCamb_a - @nCtaCamb_c

		   END

		SELECT @nRevTot_a = @nValorDia + @valor_ayer

		IF @dFecVto <= @dFecpro 
		   BEGIN

			IF @cTipOpe = 'C' 
			   BEGIN
				SELECT @nMtoComp = ROUND( @nMtoMex * @nValorUF , 0 ) - @nMtoCnv

			   END 

			ELSE 
			   BEGIN
				SELECT @nMtoComp = @nMtoCnv - ROUND( @nMtoMex * @nValorUF , 0 )

			   END

		   END

	  END


      /*
      |---------------------------------------------------------------------|
      | Cálculo de Devengo y Valorizaci¢n SINTETICOS y HEDGE USD/$$ USD/UF  |
      |---------------------------------------------------------------------|*/

	IF ( @nCarter =  4 OR @nCarter = 5 OR @nCarter =  6 ) AND  ( @nCodCnv =   999 OR @nCodCnv =  998 ) BEGIN  			

		IF @cTipOpe = 'C' OR @cTipOpe = 'O'
		   BEGIN
			SELECT @nMtoDif_usd = ROUND( @nMtofin1 - @nMtoini1 , 4 )
			SELECT @nMtoDif_cnv = ROUND( @nMtoini2 - @nMtofin2 , 4 )
			SELECT @nDelUsd     = @nValUsd_c - @nValMex_i
			SELECT @nDelUf      = @nValCnv_i - @nValorUF

		   END 

		ELSE 
		   BEGIN
			SELECT @nMtoDif_usd = ROUND( @nMtoini1 - @nMtofin1 , 4 )
			SELECT @nMtoDif_cnv = ROUND( @nMtofin2 - @nMtoini2 , 4 )
			SELECT @nDelUsd     = @nValMex_i - @nValUsd_c
			SELECT @nDelUf      = @nValorUF  - @nValCnv_i

		END

		--Valor Actual de la Conversión
		IF @nCodCnv = 998 --UF
			BEGIN
				EXECUTE sp_div @nValMex_i , @nValCnv_i , @precio_spot_inicial OUTPUT

				SELECT @factor_moneda2 = 1 + ( @ntasacnv * @nPlazoOpe / 36000 )
				SELECT @factor_moneda1 = 1 + ( @ntasausd * @nPlazoOpe / 36000 )

				EXECUTE sp_div 	@nMtoini1 , @factor_moneda1 , @monto_factor OUTPUT

				SELECT @valor_actual_cnv = ROUND( ( @precio_spot_inicial * @monto_factor ) * @factor_moneda2 ,4 )

			END
		ELSE
			BEGIN
				SELECT @precio_spot_inicial = @nValmex_i
				SELECT @factor_moneda2 = 1 + ( @ntasacnv * @nPlazoOpe / 3000 )
				SELECT @factor_moneda1 = 1 + ( @ntasausd * @nPlazoOpe / 36000 )

				EXECUTE sp_div 	@nMtoini1 , @factor_moneda1 , @monto_factor OUTPUT

				SELECT @valor_actual_cnv = ROUND( ( @precio_spot_inicial * @monto_factor ) * @factor_moneda2  ,0 )

			END


		--Si es Distinto de UF deja 1 para Calcular los Pesos
		IF @nCodCnv <> 998
		   BEGIN
			   SELECT @nDelUf = 1
			   SELECT @nDelUf = 0
		   END

		--Diferido Acumulado en Unidad Monetaria
		SELECT @ndevengo_Acu_usd_hoy = ROUND( ( @nMtoDif_usd / @nPlazoOpe ) * @nPlazoCal , 4 )
		SELECT @ndevengo_Acu_cnv_hoy = ROUND( ( @nMtoDif_cnv / @nPlazoOpe ) * @nPlazoCal , 4 )

		SELECT @ndevengo_Acu_usd_ayer = ROUND( ( @nMtoDif_usd / @nPlazoOpe ) * ( @nPlazoCal - @nDiaDev ) , 4 )
		SELECT @ndevengo_Acu_cnv_ayer = ROUND( ( @nMtoDif_cnv / @nPlazoOpe ) * ( @nPlazoCal - @nDiaDev ) , 4 )

		--Cálculo de los Diferidos en Unidad Monetaria Convertidos a Pesos
		SELECT @clp_nMtoDif_usd = ROUND( @nMtoDif_usd * @nValUsd_c , 0 )
		SELECT @clp_nMtoDif_cnv = ROUND( @nMtoDif_cnv , 0 ) --Se Presume Pesos, por lo que se asigna el Mismo Valor
		
		--Sólo Si la Moneda es UF se Convierte a Pesos
		IF @nCodCnv = 998
			SELECT @clp_nMtoDif_cnv = ROUND( @nMtoDif_cnv * @nValorUF  , 0 )
		--

		IF @nCodCnv = 999 BEGIN
			SELECT @ndevengo_Acu_cnv_hoy = ROUND( ( @nMtoDif_cnv / @nPlazoOpe ) * @nPlazoCal , 0 )
			SELECT @ndevengo_Acu_cnv_ayer = ROUND( ( @nMtoDif_cnv / @nPlazoOpe ) * ( @nPlazoCal - @nDiaDev ) , 0 )
		END

		SELECT @clp_ndevengo_usd = ROUND( ( @clp_nMtoDif_usd / @nPlazoOpe ) * @nDiaDev , 0 )
		SELECT @clp_ndevengo_cnv = ROUND( ( @clp_nMtoDif_cnv / @nPlazoOpe ) * @nDiaDev , 0 )

		SELECT @clp_ndevengo_Acu_usd = ROUND( ( @clp_nMtoDif_usd / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @clp_ndevengo_Acu_cnv = ROUND( ( @clp_nMtoDif_cnv / @nPlazoOpe ) * @nPlazoCal , 0 )

		SELECT @clp_nSaldo_diferido_usd = @clp_nMtoDif_usd - @clp_ndevengo_Acu_usd 
		SELECT @clp_nSaldo_diferido_cnv = @clp_nMtoDif_cnv - @clp_ndevengo_Acu_cnv 

		SELECT @nRevUsd = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nDelUsd , 0 )
		SELECT @nRevUF  = ROUND( ( @nMtoini2 + ABS(@ndevengo_Acu_cnv_ayer) ) * @nDelUf  , 0 )
		SELECT @nRevTot = @nRevUsd + @nRevUF

		IF @dFecIni < @dFecPro
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nValUsd_Ant , 0 )
			SELECT @nCtaCamb_c = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nValUsd_c   , 0 )
			SELECT @nReaUFDia  = ROUND( ( @nMtoini2 + ABS(@ndevengo_Acu_cnv_ayer) ) * ( @nValorUF - @nValorUF_Ant ) , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a

		   END 

		ELSE 
		   BEGIN                     
			SELECT @nCtaCamb_a = ROUND( @nMtoini1 * @nValMex_i , 0 )  --USD Inicio
			SELECT @nCtaCamb_c = ROUND( @nMtoini1 * @nValUsd_c , 0 )
			SELECT @nReaUFDia  = ROUND( @nMtoini2 * ( @nValCnv_i - @nValorUF_Pro ) , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a

		END

		--Si es Distinto de UF deja 1 para Calcular los Pesos
		IF @nCodCnv <> 998
		   SELECT @nReaUFDia = 0
		--

		IF ( @clp_ndevengo_usd + @clp_ndevengo_cnv ) > 0
			BEGIN
				SELECT @nUtiDev = ( @clp_ndevengo_usd + @clp_ndevengo_cnv )
			END
		ELSE
				SELECT @nPerDev = ( @clp_ndevengo_usd + @clp_ndevengo_cnv )

		IF @cTipOpe = 'C' OR @cTipOpe = 'O' 
		   BEGIN			
			SELECT @nCtaCamb_a = @nCtaCamb_a - @nUtiDev + ABS( @nPerDev )

		   END 

		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a + @nUtiDev - ABS( @nPerDev )

		END
		
		SELECT @nUtiDev = 0
		SELECT @nPerDev = 0
		SELECT @nCtaCamb_a = @nCtaCamb_a + @nReaUFDia

		IF @cTipOpe IN ('C', 'O') BEGIN
			SELECT @nValorDia = @nCtaCamb_c - @nCtaCamb_a
		END 
		ELSE BEGIN
			SELECT @nValorDia = @nCtaCamb_a - @nCtaCamb_c
		END

		IF @dFecVto <= @dFecpro -- Cálculo al Vencimiento
		   BEGIN

  			IF @nCodCnv = 998
			   BEGIN
	     		   IF @cTipOpe = 'C' OR @cTipOpe = 'O'  
				   BEGIN
					SELECT @nMtoComp = ROUND( @nMtoFin1 * @nValUsd_c , 0 ) - ROUND( @nMtoFin2 * @nValorUF , 0 )
		
				   END 

			   ELSE 
			   	   BEGIN
					SELECT @nMtoComp = ROUND( @nMtoFin2 * @nValorUF , 0 ) - ROUND( @nMtoFin1 * @nValUsd_c , 0 )

			   	   END

			   END

			ELSE
			   BEGIN
			   IF @cTipOpe = 'C' OR @cTipOpe = 'O' 
				   BEGIN
					SELECT @nMtoComp = ROUND( @nMtoFin1 * @nValUsd_c , 0 ) - @nMtoFin2 
		
				   END 

			   ELSE 
			   	   BEGIN
					SELECT @nMtoComp = @nMtoFin2 - ROUND( @nMtoFin1 * @nValUsd_c , 0 )

			   END

			   END

		END

		IF @dFecVto <= @dFecproxpro --Cálculo de Vencimiento Estimado
		   BEGIN

  			IF @nCodCnv = 998
			   BEGIN
	     		   IF @cTipOpe = 'C' OR @cTipOpe = 'O' 
				   BEGIN
					SELECT @Compensacion_estimada = ROUND( @nMtoFin1 * @ndolar_estimado , 0 ) - ROUND( @nMtoFin2 * @nValorUF , 0 )
		
				   END 

			   ELSE 
			   	   BEGIN
					SELECT @Compensacion_estimada = ROUND( @nMtoFin2 * @nValorUF , 0 ) - ROUND( @nMtoFin1 * @ndolar_estimado , 0 )

			   	   END

			   END

			ELSE
			   BEGIN
			   IF @cTipOpe = 'C' OR @cTipOpe = 'O' 
				   BEGIN
					SELECT @Compensacion_estimada = ROUND( @nMtoFin1 * @ndolar_estimado , 0 ) - @nMtoFin2 
		
				   END 

			   ELSE 
			   	   BEGIN
					SELECT @Compensacion_estimada = @nMtoFin2 - ROUND( @nMtoFin1 * @ndolar_estimado , 0 )

			   	   END

			   END
		END
	END


      /*
      |---------------------------------------------------------------------|
      | Cálculo de Devengo y Valorizaci¢n 1446 y SINTETICOS USD/USD         |
      |---------------------------------------------------------------------|*/



	IF ( ( @nCarter =  4 OR @nCarter =  5 OR @nCarter =  6 )AND @nCodCnv = 13 )  
	   BEGIN  			

		IF @cTipOpe = 'C' OR @cTipOpe = 'O'
		   BEGIN
			SELECT @nMtoDif_usd = ROUND( @nMtofin1 - @nMtoini1 , 4 )
			SELECT @nDelUsd     = @nValUsd_c - @nValMex_i

		   END 

		ELSE 
		   BEGIN
			SELECT @nMtoDif_usd = ROUND( @nMtoini1 - @nMtofin1 , 4 )
			SELECT @nDelUsd     = @nValMex_i - @nValUsd_c

		END

		SELECT @nmonto_final = 0

		IF @nPlazoOpe > 60 --Se Asume como UF
			BEGIN
				EXECUTE sp_div @nValMex_i , @nValCnv_i , @precio_spot_inicial OUTPUT

				SELECT @factor_moneda2 = 1 + ( @ntasacnv * @nPlazoOpe / 36000 )
				SELECT @factor_moneda1 = 1 + ( @ntasausd * @nPlazoOpe / 36000 )

				EXECUTE sp_div 	@nMtofin1 , @factor_moneda1 , @monto_factor OUTPUT			

				SELECT @nmonto_final = ROUND( @precio_spot_inicial * @factor_moneda2 * @monto_factor ,4 )
				SELECT @moneda2 = 998
				SELECT @monto_moneda2 = @nmonto_final 
				SELECT @monto_pesos2 = @monto_moneda2 * @nvaloruf

			END
		ELSE
			BEGIN
				SELECT @precio_spot_inicial = @nValmex_i
				SELECT @factor_moneda2 = 1 + ( @ntasacnv * @nPlazoOpe / 3000 )
				SELECT @factor_moneda1 = 1 + ( @ntasausd * @nPlazoOpe / 36000 )

				EXECUTE sp_div 	@nMtofin1 , @factor_moneda1 , @monto_factor OUTPUT

				SELECT @nmonto_final = ROUND( @precio_spot_inicial * @factor_moneda2 * @monto_factor ,0 )
				SELECT @moneda2 = 999
				SELECT @monto_moneda2 = @nmonto_final
				SELECT @monto_pesos2 = @monto_moneda2 

			END

		--Diferido Acumulado en Unidad Monetaria
		SELECT @ndevengo_Acu_usd_hoy = ROUND( ( @nMtoDif_usd / @nPlazoOpe ) * @nPlazoCal , 4 )
		SELECT @ndevengo_Acu_usd_ayer = ROUND( ( @nMtoDif_usd / @nPlazoOpe ) * ( @nPlazoCal - @nDiaDev ) , 4 )

		--Cálculo de los Diferidos en Unidad Monetaria Convertidos a Pesos
		SELECT @clp_nMtoDif_usd = ROUND( @nMtoDif_usd * @nValUsd_c , 0 )
		
		SELECT @clp_ndevengo_usd = ROUND( ( @clp_nMtoDif_usd / @nPlazoOpe ) * @nDiaDev , 0 )
		SELECT @clp_ndevengo_Acu_usd = ROUND( ( @clp_nMtoDif_usd / @nPlazoOpe ) * @nPlazoCal , 0 )
		SELECT @clp_nSaldo_diferido_usd = @clp_nMtoDif_usd - @clp_ndevengo_Acu_usd 
		SELECT @nRevUsd = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nDelUsd , 0 )
		SELECT @nRevTot = @nRevUsd 

		IF @dFecIni < @dFecPro
		   BEGIN
			SELECT @nCtaCamb_a = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nValUsd_Ant , 0 )
			SELECT @nCtaCamb_c = ROUND( ( @nMtoini1 + ABS(@ndevengo_Acu_usd_ayer) ) * @nValUsd_c   , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a
		   END 
		ELSE 
		   BEGIN                     
			SELECT @nCtaCamb_a = ROUND( @nMtoini1 * @nValMex_i , 0 )  --USD Inicio
			SELECT @nCtaCamb_c = ROUND( @nMtoini1 * @nValUsd_c , 0 )
			SELECT @nReaTCDia  = @nCtaCamb_c - @nCtaCamb_a
		   END

		IF  @clp_ndevengo_usd > 0
			BEGIN
				SELECT @nUtiDev = @clp_ndevengo_usd 
			END
		ELSE
				SELECT @nPerDev = @clp_ndevengo_usd 

		IF @cTipOpe = 'C' OR @cTipOpe = 'O'
		   BEGIN			
			SELECT @nCtaCamb_a = @nCtaCamb_a - @nUtiDev + ABS( @nPerDev )
		   END 
		ELSE 
		   BEGIN
			SELECT @nCtaCamb_a = @nCtaCamb_a + @nUtiDev - ABS( @nPerDev )
		   END
		
		SELECT @nUtiDev = 0
		SELECT @nPerDev = 0

		IF @cTipOpe = 'C' OR @cTipOpe = 'O'
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_c - @nCtaCamb_a

		   END 

		ELSE 
		   BEGIN
			SELECT @nValorDia = @nCtaCamb_a - @nCtaCamb_c

		   END
		
		IF @dFecVto <= @dFecpro -- Cálculo al Vencimiento
		   BEGIN

	     		   IF @cTipOpe = 'C' 
				   BEGIN
					SELECT @nMtoComp = ROUND( @nMtoFin1 * @nValUsd_c , 0 ) - @monto_pesos2 
		
				   END 

			   ELSE 
			   	   BEGIN
					SELECT @nMtoComp = @monto_pesos2 - ROUND( @nMtoFin1 * @nValUsd_c , 0 )

			   	   END

		   END

		IF @dFecVto = @dFecproxpro --Cálculo de Vencimiento Estimado
		   BEGIN
	     		   IF @cTipOpe = 'C' 
				   BEGIN
					SELECT @Compensacion_estimada = ROUND( @nMtoFin1 * @ndolar_estimado , 0 ) - @monto_pesos2
		
			   END 

			   ELSE 
			   	   BEGIN
					SELECT @Compensacion_estimada = @monto_pesos2 - ROUND( @nMtoFin1 * @ndolar_estimado , 0 )

			   	   END

		  END
		
	END

      /*
   |---------------------------------------------------------------------|
      | Cálculo de vencimientos de los Cortes de Periodical Netting	    |
      |---------------------------------------------------------------------|*/

/*
	IF @ncarter = 7 
		BEGIN

			SELECT @fecha = @dFecPro

			IF @cLastHabil = 'SI'
				SELECT @fecha = @dFecUDMPro

			EXECUTE sp_interes_reajuste_periodical	@nnumope	,
								@dfecpro	,
								@ncodcnv	,
								@ctipope	,
								@nvaloruf	,
								@nvalusd_c	,
								@fecha

			EXECUTE sp_vcto_cortes_periodical 	@nnumope	,
								@dfecpro	,
								@nmtomex	,
								@ncodcnv	,
								@ctipope	,
								@nvaloruf	,
								@nvalusd_c


		END
*/
      /*
      |---------------------------------------------------------------------|
      | Cálculo de Valorización de Swap BCCH	                   	    |
      | Sólo se Efectua el Ultimo Día del Mes y Cuando Vencen los Contratos |
      |---------------------------------------------------------------------|*/


	IF @ncarter = 8 
		BEGIN
			IF @cLastHabil = 'SI' OR CONVERT(CHAR(8),@dFecVto,112) = CONVERT(CHAR(8),@dfecpro,112)
			   BEGIN
				SELECT @nClp_Cnv = ROUND( @nmtomex * @tc_calculo_mes_actual , 0 )
				SELECT @nClp_mex = ROUND( @nmtomex * @nValUsd_Pro , 0 )

				IF MONTH(@dfecini) <> MONTH(@dfecpro) AND YEAR(@dfecini) <> YEAR(@dfecpro)
					SELECT @ndelusd = @nvalusd_udma	- @tc_calculo_mes_anterior

				SELECT @nRevUsd = ROUND( @nmtomex * @ndelusd , 0 ) --variación del Mes Anterior
				SELECT @nReaTCDia = ROUND( @nmtomex * ( @nValUsd_Pro - @tc_calculo_mes_actual ) , 0 ) --Variación Actual
				SELECT @nrevTot = @nReaTCDia

				IF @nRevUsd < 0 
					SELECT 	@nRevUsd = 0 --Esto ya que se Informa sólo si es Utilidad

				IF @nReaTCDia < 0 
					SELECT @nReaTCDia =  0 --Esto ya que se Informa sólo si es Utilidad

				SELECT @nmtodif = @npremio
				IF @npremio < 0 
				   BEGIN
					SELECT @nPerDif = @npremio
				   END 
				ELSE 
				   BEGIN
					SELECT @nUtiDif = @npremio
	
				   END
				
				SELECT @nPerDev = ROUND( ( @nPerDif / @nPlazoOpe ) * @nDiaDev  , 0 )
				SELECT @nUtiDev = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nDiaDev  , 0 )

				SELECT @nPerAcu = ROUND( ( @nPerDif / @nPlazoOpe ) * @nPlazoCal , 0 )
				SELECT @nUtiAcu = ROUND( ( @nUtiDif / @nPlazoOpe ) * @nPlazoCal , 0 )

				SELECT @nPerSal = @nPerDif - @nPerAcu
				SELECT @nUtiSal = @nUtiDif - @nUtiAcu

			   END		
		END


      /*
      |---------------------------------------------------------------------|
      | Cálculo de Valorización de Opciones	                   	    |
      | Sólo se Efectua el Ultimo Día del Mes y Cuando Vencen los Contratos |
      |---------------------------------------------------------------------|*/

	IF @ncarter = 9
		BEGIN
			IF @cLastHabil = 'SI' OR CONVERT(CHAR(8),@dFecVto,112) = CONVERT(CHAR(8),@dfecpro,112)
			   BEGIN

				IF MONTH(@dfecini) <> MONTH(@dfecpro) AND YEAR(@dfecini) <> YEAR(@dfecpro)
				   BEGIN
					SELECT @ndelusd = ROUND( @nMtoCnv * @tc_calculo_mes_anterior / 100 , 2 )
					SELECT @nRevUsd = @ndelusd - @npremio
				   END

				SELECT @nReaTCDia = ROUND( ROUND( @nMtoCnv * @tc_calculo_mes_anterior / 100 , 2 ) - @npremio , 0 ) --Variación Actual

				IF @nRevUsd < 0 
					SELECT 	@nRevUsd = 0 --Esto ya que se Informa sólo si es Utilidad

				IF @nReaTCDia < 0 
					SELECT @nReaTCDia =  0 --Esto ya que se Informa sólo si es Utilidad

			   END
		END

	IF @nCarter = 10 BEGIN

/*
		-- Forward Bond Trades --
		SELECT  @Mon_inst      = cacodmon1
	        ,       @Mon_pago      = cacodmon2
		,       @Fec_inic      = cafecha
		,       @Fec_Vcto      = cafecvcto
		,       @Mon_Nominal   = camtomon1
		,       @Mon_VpresPe   = caequmon1
		,       @Mon_VPresUm   = camtomon2
		,       @Mon_VMercado  = caequusd2
		,       @Tir_Forward   = catipcam
		,       @Tir_Mercado   = capremon1 -- @Tasa_uf05
		,       @Seriedo    = caseriado
		,       @Ser_Inst      = caserie
		,       @Cod_inst      = cabroker
		,       @Fec_Calc      = @dFecPro
		,       @Tas_Est       = 0
		,       @Fec_UltDev    = fechaemision  
		,       @ReajusteAcum  = pesos_devengo_acum_cnv
		,       @VariacionAcum = pesos_devengo_acum_usd
		,       @ReajusteDia   = 0.0
		,       @VariacionDia  = 0
		,       @TipoOper      = catipoper
		,       @BenchMarck    = '*'
		,       @iCalculaVAyer = CASE WHEN cafecha = @dFecPro THEN 0 ELSE 1 END
		FROM    MFCARES
		WHERE	CaFechaProceso	= @dFecPro
		WHERE   canumoper      = @nNumOpe

		IF @Seriedo = 'S'
		BEGIN
			SELECT	@Tas_Emis       = setasemi 
			,	@Mon_Emis       = semonemi 
			,	@Bas_Emis       = sebasemi 
			,	@Fec_Emis       = sefecemi
			,	@dFechaVctoIns  = sefecven
			FROM   bacparamsuda..SERIE
			WHERE  semascara       = @Ser_Inst
		END ELSE 
		BEGIN
			
			SET ROWCOUNT 1
			SELECT @Tas_Emis          = nstasemi 
			,      @Mon_Emis          = nsmonemi 
			,      @Bas_Emis          = nsbasemi 
			,      @Fec_Emis          = nsfecemi
			,      @dFechaVctoIns     = nsfecven
                        FROM   bacparamsuda..NOSERIE
			WHERE  nsserie         = @Ser_Inst
			SET ROWCOUNT 0
		END

		IF EXISTS(SELECT 1 FROM BacParamSuda..INSTRUMENTO WHERE incodigo = @Cod_inst) BEGIN
			SELECT @Valorizador = 'bactradersuda..SP_' + LTRIM(RTRIM(inprog))
			FROM   BacParamSuda..INSTRUMENTO
			WHERE  incodigo     = @Cod_inst

			IF @Mon_Emis <> 999 BEGIN
				SELECT @Tas_Est = CASE WHEN @Cod_inst = 1 THEN @fTe_pcdus
	                                               WHEN @Cod_inst = 2 THEN @fTe_pcduf
                                                       WHEN @Cod_inst = 5 THEN @fTe_ptf
           					       ELSE               CONVERT(FLOAT,0)
       						  END
			END

			SELECT @ValorMoneda_Hoy = 0.0
			SELECT @ValorMoneda_Hoy = vmvalor
			FROM   VIEW_VALOR_MONEDA
			WHERE  vmcodigo         = @Mon_Emis
			AND    vmfecha          = @dFecPro

			SELECT @ValorMoneda_Mañ = 0.0
			SELECT @ValorMoneda_Mañ = vmvalor
			FROM   VIEW_VALOR_MONEDA
			WHERE  vmcodigo         = @Mon_Emis
			AND    vmfecha          = @dFecProxPro

			IF @Fec_inic <= @dFecPro
			BEGIN
				SELECT @ReajusteDia = isnull((@ValorMoneda_Hoy - @ValorMoneda_Mañ),0) * isnull(@Mon_VPresUm,0.0)
			END ELSE
		        BEGIN
				SELECT @ReajusteDia = 0.0
			END

			IF @Fec_UltDev = @Fec_Calc
			BEGIN
				SELECT @ReajusteAcum = ISNULL(@ReajusteAcum,0.0)
			END ELSE
		        BEGIN
				SELECT @ReajusteAcum = ISNULL(@ReajusteAcum + @ReajusteDia,0.0)
         		END
		END


               -- Definir Tasa Mercado para la valorización (benchmarck)  --
               DECLARE @nPlazo   INT
               SET     @nPlazo   = DATEDIFF(YEAR, @dFecPro,  @dFechaVctoIns)

               IF @Ser_Inst = 'BCU0500912'
                  SET @nPlazo   = 7

               SET    @Tir_Mercado = 0.0

               SELECT @Tir_Mercado = ISNULL(Tasa,0.0)
               ,      @BenchMarck  = ' ' 
               FROM   BENCH_MARCK
               WHERE  Instrumento  = @Cod_inst
               AND    Moneda       = @Mon_Emis
               AND    @nPlazo      BETWEEN Desde AND Hasta
               AND    Fecha        = @dFecProxPro

		IF @BenchMarck = '*' OR @Tir_Mercado IS NULL BEGIN
			SET @Tir_Mercado = 0.0
		END

		-- ******************************************* --
		EXECUTE @nError     = @Valorizador
				      2                   -- @iModcal
		,                     @Fec_Calc           -- @dFeccal
		,                     @Cod_inst           -- @iCodigo
		,                     @Ser_Inst           -- @cInstser
		,                     @Mon_Emis           -- @iMonemi
		,                     @Fec_Emis           -- @dFecemi
		,                     @Fec_Vcto           -- @dFecven
		,                     @Tas_Emis           -- @fTasemi
		,                     @Bas_Emis           -- @fBasemi
		,             @Tas_Est            -- @fTasest
		,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT
		,                     @Tir_Forward OUTPUT -- @fTir     OUTPUT
		,                     @fPvp        OUTPUT
		,                     @fMt         OUTPUT
		,                     @fMtum       OUTPUT
		,                     @fMt_cien    OUTPUT
		,                     @fVan        OUTPUT
		,                     @fVpar       OUTPUT
		,                     @nNumucup    OUTPUT
		,                     @dFecucup    OUTPUT
		,                     @fIntucup    OUTPUT
		,                     @fAmoucup    OUTPUT
		,		      @fSalucup    OUTPUT
		,                     @nNumpcup    OUTPUT
		,                     @dFecpcup    OUTPUT
		,                     @fIntpcup    OUTPUT
		,                     @fAmopcup    OUTPUT
		,                     @fSalpcup    OUTPUT
		,                     @fDurat      OUTPUT
		,                     @fConvx      OUTPUT
		, 		      @fDurmo      OUTPUT

		SET @Mon_VpresPe = ISNULL(@fMt,0)

		EXECUTE @nError     = @Valorizador
				      2                   -- @iModcal
		,                     @Fec_Calc           -- @dFeccal
		,                     @Cod_inst           -- @iCodigo
		,                     @Ser_Inst           -- @cInstser
		,                     @Mon_Emis           -- @iMonemi
		,                     @Fec_Emis           -- @dFecemi
		,                     @Fec_Vcto           -- @dFecven
		,                     @Tas_Emis           -- @fTasemi
		,                     @Bas_Emis           -- @fBasemi
		,                     @Tas_Est    -- @fTasest
		,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT
		,                     @Tir_Mercado OUTPUT -- @fTir     OUTPUT
		,                     @fPvp        OUTPUT
		,                     @fMt         OUTPUT
		,                     @fMtum       OUTPUT
		,                     @fMt_cien    OUTPUT
		,                     @fVan        OUTPUT
		,                     @fVpar       OUTPUT
		,                     @nNumucup    OUTPUT
		,                     @dFecucup    OUTPUT
		,                     @fIntucup    OUTPUT
		,                     @fAmoucup    OUTPUT
		,                     @fSalucup    OUTPUT
		,                     @nNumpcup    OUTPUT
		,                     @dFecpcup    OUTPUT
		,                     @fIntpcup    OUTPUT
		,                     @fAmopcup    OUTPUT
		,                     @fSalpcup    OUTPUT
		,                     @fDurat      OUTPUT
		,                     @fConvx      OUTPUT
		,                     @fDurmo      OUTPUT

		SET @Mon_VMercado = ISNULL(@fMt,0)
		SET @VariacionDia = ISNULL((@Mon_VpresPe - @Mon_VMercado),0)

		IF @TipoOper = 'C'
		BEGIN
		   SET @VariacionDia = ISNULL((@Mon_VMercado  - @Mon_VpresPe),0)
		END ELSE
		BEGIN
		   SET @VariacionDia = ISNULL((@Mon_VpresPe   - @Mon_VMercado),0)
		END

		IF @Fec_UltDev = @Fec_Calc
		BEGIN
                   SET @VariacionAcum = ISNULL(@VariacionAcum,0.0)
		END ELSE
		BEGIN
		   SET @VariacionAcum = ISNULL(@VariacionAcum + @VariacionDia,0.0)
		END

	        ----<< Actualiza Cartera
		UPDATE MFCARES
		SET    caplazoope	       = @nPlazoOpe
		,      caplazovto	       = @nPlazoVto
		,      caplazocal	       = @nPlazoCal
		,      cadiasdev	       = @nDiaDev
		,      cavalordia              = @VariacionDia
		,      diferido_cnv	       = @VariacionDia
		,      devengo_acum_usd_hoy    = @Mon_VpresPe
		,      devengo_acum_cnv_hoy    = @Mon_VMercado
		,      pesos_devengo_usd       = isnull(@VariacionDia,0.0)
		,      pesos_devengo_cnv       = isnull(@ReajusteDia,0.0)
		,      pesos_devengo_acum_usd  = isnull(@VariacionAcum,0.0)
		,      pesos_devengo_acum_cnv  = isnull(@ReajusteAcum,0.0)
		,      fechaemision            = @Fec_Calc
		,      tc_calculo_mes_actual   = @Tir_Mercado
		,      caequmon1 = @Mon_VpresPe
		, caequusd2               = @Mon_VMercado
		,      capremon1              = @Tir_Mercado
		WHERE	CaFechaProceso		= @dFecPro
		AND	canumoper		= @nNumOpe

*/


		EXECUTE SP_C08_ForwardBondTrades_Back_Test	@nNumOpe
							,	@iEjecucionIniDia
							,	@dFecPro
							,	@dFecProAnt
							,	@dFecProxPro


		SELECT @VariacionDia  = 0.0
		,      @Mon_VpresPe   = 0.0
		,      @Mon_VMercado  = 0.0
		,      @VariacionDia  = 0.0
		,      @ReajusteDia   = 0.0
		,      @VariacionAcum = 0.0
		,      @ReajusteAcum  = 0.0      
	END


	-- indicacion t-lock
       if  @nCarter = 11
	BEGIN

/*        	UPDATE MFCARES
		SET    caplazoope		= @nPlazoOpe
		,      caplazovto		= @nPlazoVto
		,      caplazocal		= @nPlazoCal
		,      cadiasdev		= @nDiaDev
		,      cavalordia		= @VariacionDia
		,      diferido_cnv		= @VariacionDia
		,      devengo_acum_usd_hoy	= @Mon_VpresPe
		,      devengo_acum_cnv_hoy	= @Mon_VMercado
		,      pesos_devengo_usd	= isnull(@VariacionDia,0.0)
		,      pesos_devengo_cnv	= isnull(@ReajusteDia,0.0)
		,      pesos_devengo_acum_usd	= isnull(@VariacionAcum,0.0)
		,      pesos_devengo_acum_cnv	= isnull(@ReajusteAcum,0.0)
		WHERE	CaFechaProceso	= @dFecPro
		AND	canumoper	= @nNumOpe
*/		

		EXECUTE SP_C08_TLOCK	@nNumOpe 
				,	@iEjecucionIniDia
				,	@dFecPro
				,	@dFecProAnt
				,	@dFecProxPro	

		SELECT @VariacionDia  = 0.0
		,      @Mon_VpresPe   = 0.0
		,      @Mon_VMercado  = 0.0
		,      @VariacionDia  = 0.0
		,      @ReajusteDia   = 0.0
		,      @VariacionAcum = 0.0
		,      @ReajusteAcum  = 0.0
	END

      /*
      |---------------------------------------------------------------------|
      | Grabar Registros de valorización 			  	    |		
      |	Seguros de Cambio	 					    |
      |	Seguros de Inflaci½n	 					    |
      |---------------------------------------------------------------------|*/

--	IF @nCarter = 1 OR @nCarter = 2 OR @nCarter = 3 OR @nCarter = 4 OR @nCarter = 5 OR @nCarter = 6 OR @nCarter = 7 OR @nCarter = 8 OR @nCarter = 9
	IF @nCarter IN ( 1, 2, 3, 4, 5, 6, 7, 8, 9)
	   BEGIN

		IF @nCarter = 7
		BEGIN
		      	SELECT @dFecVctop   = MIN(corfecvcto) FROM CORTES WHERE cornumoper = @nNumOpe AND corfecvcto >= @dFecPro
	      		SELECT @nPlazoVctop = DATEDIFF(DAY, @dFecPro, @dFecVctop)
			
			EXECUTE BacParamSuda..SP_FECHA_HABIL_ANTERIOR  @dFecVctop , @dFecEfectiva Output 
			
	      		SELECT @nPlazoVtoEfec = datediff(day, @dFecPro, @dFecEfectiva)
		END
		ELSE
		BEGIN
		   SELECT @dFecVctop   = @dFecVto
		   SELECT @nPlazoVctop = @nPlazoVto
		END
	 				
		----<< Calculo MTM
/*		IF @nCarter in ( 1 , 2 , 3 , 4 , 5 , 6 , 7  ) BEGIN -- MPNG20050825 TAG 001

			
			EXECUTE sp_marktomarket @nCarter				,	--1
                                              	@nPlazoVctop				,	--2
			                      	@nCodCnv	 			,	--3
					      	@nValorUF	 			,	--4
					      	@nMtoMex 	 			,	--5
					      	@dFecVctop				,	--6
					      	@cTipOpe	 			,	--7
					     	@nPreFut         			,	--8
			                   	@nCodMon 				,	--9
					      	@nNumOpe				,	--10
					      	@nMarkToMarket    	OUTPUT	        ,	--11
					      	@nPrecioMtm       	OUTPUT	        ,	--12
                                                @nmonto_mtm_usd  	OUTPUT	        ,	--13  
                 			        @nmonto_mtm_cnv   	OUTPUT	        ,	--14  --Valor Pasivo	
					      	@Valor_Obtenido         OUTPUT	        ,	--15  --Valor Obtenido
					      	@ResultadoMTM	        OUTPUT	        ,	--16
					      	@cModal		     		        ,      	--17 MODALIDAD DE PAGO
						@CaTasaSinteticaM1 	OUTPUT  	, 	--18
						@CaTasaSinteticaM2 	OUTPUT  	,	--19
						@CaPrecioSpotVentaM1	OUTPUT  	,	--20
						@CaPrecioSpotVentaM2 	OUTPUT  	,	--21
						@CaPrecioSpotCompraM1   OUTPUT  	,	--22
						@CaPrecioSpotCompraM2   OUTPUT   	,	--23	
                                                @ValorRazonableActivo   OUTPUT   	,	--24	MPNG20050825 TAG 002
                                   @ValorRazonablePasivo   OUTPUT   	,	--25	MPNG20050825 TAG 002
                                                @iEjecucionIniDia
		END 

						 ----<< Actualiza Cartera
						UPDATE  MFCARES  
						SET 	caplazoope                      = @nPlazoOpe		,
							caplazovto                      = @nPlazoVto		,
							caplazocal                      = @nPlazoCal		,				
							cadiasdev                       = @nDiaDev		,
							cadiftipcam 			= @nReaTCDia		, -- Diferencia
						   	cadifuf 			= @nReaUFDia		, -- Reajustes
							carevusd			= @nRevUsd		,  -- Inicio - Hoy
							carevuf				= @nRevUF		,  -- Inicio - Hoy
							carevTot			= @nrevTot		,
							carevusd_ayer			= @nRevUsd_a		,  -- Inicio - Ayer
							carevuf_ayer			= @nRevUF_a		,  -- Inicio - Ayer
							carevTot_ayer			= @nrevTot_a		, 
			                                cavalordia			= @nValorDia		,
							cactacambio_a			= @nctaCamb_a		,
							cactacambio_c			= @nctaCamb_c		,
					   		cautildiferir			= @nUtiDif 		,
							caperddiferir 			= @nPerDif		,
							cautildevenga 			= @nUtiDev		,  -- Utilida Diario
							caperddevenga 			= @nPerDev		,  -- perdida Diario
							cautilacum 			= @nUtiAcu		,  -- Acumulado 		 			
							caperdacum 			= @nPerAcu		,  -- Acumulado
							cautilacum_ayer			= @nUtiAcu_a		,  -- Acumulado AYER
							caperdacum_ayer			= @nPerAcu_a		,  -- Acumulado AYER
							cautilsaldo 			= @nUtiSal		,  -- Saldo					
							caperdsaldo 			= @nPerSal		,
							caclpmoneda1 			= @nClp_Mex 		,  -- Monto CLP Hoy 
							caclpmoneda2 			= @nClp_Cnv 		,  -- 
							cadelusd			= @nDelUsd		,
							cadeluf				= @ndelUf		,
							camtocomp      			= @nMtoComp     	,
							camarktomarket 			= ISNULL(@nMarktomarket,0) 	,
							capreciomtm			= ISNULL(@nPrecioMtm,0)		,
							catipcamval     		= @ntipcamval			,
							diferido_usd			= @nMtoDif_usd			,
							diferido_cnv			= @nMtoDif_cnv			,
							camtodiferir			= @nmtodif 			,
							devengo_acum_usd_hoy            = @ndevengo_Acu_usd_hoy 	,	
							devengo_acum_cnv_hoy 		= @ndevengo_Acu_cnv_hoy 	,
							devengo_acum_usd_ayer           = @ndevengo_Acu_usd_ayer	,	
							devengo_acum_cnv_ayer		= @ndevengo_Acu_cnv_ayer	,
							pesos_diferido_usd		= @clp_nMtoDif_usd 		,
							pesos_diferido_cnv		= @clp_nMtoDif_cnv 		,
							pesos_devengo_usd		= @clp_ndevengo_usd 		,
							pesos_devengo_cnv		= @clp_ndevengo_cnv 		,
							pesos_devengo_acum_usd	        = @clp_ndevengo_Acu_usd 	,
							pesos_devengo_acum_cnv	        = @clp_ndevengo_Acu_cnv 	,
							pesos_devengo_saldo_usd	        = @clp_nSaldo_diferido_usd 	,
							pesos_devengo_saldo_cnv   	= @clp_nSaldo_diferido_cnv 	,
							valor_actual_cnv		= @valor_actual_cnv		,
							mtm_hoy_moneda1		        = ISNULL(@nmonto_mtm_usd,0)	,
							mtm_hoy_moneda2		        = ISNULL(@nmonto_mtm_cnv,0)	,
							var_moneda1			= @nmonto_var_usd 		,
							var_moneda2			= @nmonto_var_cnv 		,
							tasa_mtm_moneda1		= @ntasausd_mtm 		,
							tasa_mtm_moneda2		= @ntasacnv_mtm		,
							tasa_var_moneda1		= @ntasausd_var 		,
							tasa_var_moneda2		= @ntasacnv_var 		,
							efecto_cambio_moneda1		= @nefecto_cambiario_mon1	,
							efecto_cambio_moneda2		= @nefecto_cambiario_mon2	,
							devengo_tasa_moneda1		= @ndevengo_tasa_mon1	,
							devengo_tasa_moneda2		= @ndevengo_tasa_mon2	,
							cambio_tasa_moneda1		= @ncambio_tasa_mon1 	,
							cambio_tasa_moneda2		= @ncambio_tasa_mon2 	,
							residuo				= @nresiduo 			,
							mtm_ayer_moneda1		= @nmonto_mtm_mon1_ayer 	,
							mtm_ayer_moneda2		= @nmonto_mtm_mon2_ayer 	,
							caplazo_uso_moneda1		= @plazo_uso_moneda1		,
							caplazo_uso_moneda2		= @plazo_uso_moneda2		
						WHERE   CaFechaProceso	= @dFecPro
						AND	canumoper	=  @nNumOpe
*/

		        --Fecha Efectiva	--JB 13062005     -*****************************************
		        --Plazo utilizado por el calculo de Descuento y o Capitalización

			EXECUTE sp_marktomarket_Back_Test	@nCarter				,	--1
								@nPlazoVtoEfec				,	--2	--JB 20050613
								@nCodCnv	 			,	--3
								@nValorUF	 			,	--4
								@nMtoMex 	 			,	--5
								@dFecVctop				,	--6
								@cTipOpe	 			,	--7
								@nPreFut         			,	--8
								@nCodMon          			,	--9
								@nNumOpe				,	--10
								@nMarkToMarket    	OUTPUT	        ,	--11
								@nPrecioMtm       	OUTPUT	        ,	--12
								@nmonto_mtm_usd  	OUTPUT	        ,	--13
								@nmonto_mtm_cnv   	OUTPUT	        ,	--14
								@Valor_Obtenido   	OUTPUT	        ,	--15 new
								@ResultadoMTM	        OUTPUT	        ,	--16
								@cModal		     		        ,      	--17 MODALIDAD DE PAGO
								@CaTasaSinteticaM1 	OUTPUT  	, 	--18
								@CaTasaSinteticaM2 	OUTPUT  	,	--19
								@CaPrecioSpotVentaM1	OUTPUT  	,	--20
								@CaPrecioSpotVentaM2 	OUTPUT  	,	--21
								@CaPrecioSpotCompraM1   OUTPUT  	,	--22
								@CaPrecioSpotCompraM2   OUTPUT   	,	--23		
								@ValorRazonableActivo   OUTPUT   	,	--24	MPNG20050825 TAG 002
								@ValorRazonablePasivo   OUTPUT   	,	--25	MPNG20050825 TAG 002
								0					,
								@dFecPro				,	
								@dFecProAnt				,	
								@dFecProxPro				


								
			UPDATE MFCARES
			SET	fRes_ObtenidoParPrx		= @ResultadoMTM 
			WHERE	CaFechaProceso	= @dFecPro
			AND	canumoper	= @nNumOpe



/*		SELECT @devengo1             = (@nPerDev + @nUtiDev)
		SELECT @monto_acumulado_mon1 = @nMtoini1 + ABS(@ndevengo_Acu_usd_hoy)	
		SELECT @monto_acumulado_mon2 = @nMtoini2 + ABS(@ndevengo_Acu_cnv_hoy)	

		EXECUTE	sp_llena_resultado	@ncarter				        ,
						@dfecpro					,
						@dFecProAnt					,
						@ncodmon					,
						@ncodcnv					,
						@nReaTCDia					,
						@nReaUFDia					,
						@devengo1					,
						@cTipOpe					,
						@dFecVto					,
						@nMtoMex					,
						@nmtocnv					,
						@clp_ndevengo_usd				,
						@clp_ndevengo_cnv				,
						@monto_acumulado_mon1			        ,
						@monto_acumulado_mon2			      ,
						@nNumOpe					,
						@nMtoComp					,
						@nValorDia					,
						@valor_ayer
*/

			IF @@error <> 0	BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 , 'Error: al actualizar el registro en la tabla de cartera.'
				CLOSE Tmp_CurMFCA
				DEALLOCATE Tmp_CurMFCA
				RETURN -1
			END
		END


	/*
      	|---------------------------------------------------------------------|
	| Siguiente registro del CURSOR lectura secuencial de la tabla MFCA   |
      	|---------------------------------------------------------------------|*/
       	FETCH NEXT FROM Tmp_CurMFCA
	       INTO 	@nNumOpe   	, --1
		    	@nCarter   	, --2   --
		    	@cTipOpe   	, --3
		    	@nCodMon   	, --4
		    	@nMtoMex   	, --5
		    	@nMtoClp_i 	, --6
		    	@nValMex_i 	, --7   --
		    	@nCodCnv   	, --8
		    	@nMtoCnv   	, --9
		    	@nMtoCnv_i 	, --10
		    	@nValCnv_i 	, --11  --
		    	@dFecIni   	, --12
		    	@dFecVto   	, --13
		    	@nPreFut   	, --14  --
		    	@nMonRef   	, --15
                	@ntccierre 	, --16  --
		    	@cModal    	, --17
		    	@nmtofin1  	, --18
		    	@nmtoini1  	, --19
		    	@nmtofin2  	, --20
		    	@nmtoini2  	, --21
		    	@ntasausd  	, --22  --
		    	@ntasacnv  	, --23  --
		    	@tc_calculo_mes_actual	 , --24
		    	@tc_calculo_mes_anterior , --25
		    	@npremio	, --26
		    	@canticipo	, --27
		    	@vencimiento_original  , --28
		    	@valor_ayer	, --29
			@dFecEfectiva	  --30


    END -- While

/*
|---------------------------------------------------------------------------|
| Cierra el CURSOR para abrierlo despues en el procedimiento almacenado.    |
|---------------------------------------------------------------------------|*/
 CLOSE Tmp_CurMFCA

/*
|---------------------------------------------------------------------------|
| Borra la estructura del cursor					    |
|---------------------------------------------------------------------------|*/
 DEALLOCATE Tmp_CurMFCA

/* UPDATE MFAC SET acsw_devenfwd = '1' ,acsw_fd ='0' ,acsw_contafwd = '0'

 IF @@error <> 0 
 BEGIN
	ROLLBACK TRANSACTION
	SELECT -1,
	'Error: al grabar flags de tabla de parametros'
	RETURN -1

 END
*/

 SET NOCOUNT OFF

 COMMIT TRANSACTION
 SELECT 'OK'
 
END







GO
