USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INTERFAZ_FD14]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_INTERFAZ_FD14]
   (   @FechaProc   DATETIME   )
AS
BEGIN

   --> Interfaz de Flujos de Derivados [FD14]
   SET NOCOUNT ON

   --> 1.0 --> Crea Estructura de Valores de Moneda Universal
   CREATE TABLE #TMP_VALOR_MONEDA
   (   vmcodigo   INT
   ,   vmvalor    FLOAT
   )
   CREATE INDEX #ix_TMP_VALOR_MONEDA ON #TMP_VALOR_MONEDA (vmcodigo)

   --> 2.0 --> Inserta los valores de moneda contable (Tipo Cambio Representación Contable)
   INSERT INTO #TMP_VALOR_MONEDA
   (   vmcodigo, vmvalor   )
   SELECT codigo_moneda, tipo_cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @FechaProc

   --> 3.0 --> Inserta los valores de moneda UF  (Valor de la Uf a la fecha de Proceso)
   INSERT INTO #TMP_VALOR_MONEDA SELECT vmcodigo, vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @FechaProc AND vmcodigo = 998
   --> 3.1 --> Inserta los valores de moneda CLP (Valor del Peso)
   INSERT INTO #TMP_VALOR_MONEDA SELECT 999 , 1.0
   --> 3.2 --> Inserta los valores de moneda USD (Valor del Dólar Americano)
   INSERT INTO #TMP_VALOR_MONEDA SELECT 13  , Tipo_Cambio 
                                    FROM BacparamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @FechaProc AND Codigo_Moneda = 994

   --> 4.0 --> Crea Estructura de salida Formal a la Generación de la Interfaz
   CREATE TABLE #FLUJOS_SUB
   (	tmp_numoper_fwd		NUMERIC(9)
   ,	tmp_nemotecnico		CHAR(12)
   ,	tmp_moneda		NUMERIC(3)
   ,	tmp_monto_fwd		NUMERIC(21,4)
   ,	tmp_fechavcto		CHAR(08)
   ,	tmp_tasa		NUMERIC(05,4)
   ,	tmp_numero_cupon	NUMERIC(5)
   ,	tmp_interes		NUMERIC(05,4)
   ,	tmp_monto_interes	NUMERIC(21,4)
   ,	tmp_amortizacion	FLOAT
   ,	tmp_monto_amortizacion	FLOAT
   ,	tmp_plazo		NUMERIC(9)
   ,	tmp_flujo		FLOAT
   ,	tmp_monto_flujo		FLOAT
   ,	tmp_indicador		CHAR(1)
   ,    tmp_marca           INT
   )
   --> 4.1 --> Crea Indices de control a la Estructura de Salida
   CREATE CLUSTERED    INDEX FLUJOS_SUB_001 ON #FLUJOS_SUB (tmp_nemotecnico, tmp_numero_cupon, tmp_indicador)
   CREATE NONCLUSTERED INDEX FLUJOS_SUB_002 ON #FLUJOS_SUB (tmp_numoper_fwd)

   --> 5.0 --> Lee la fecha de Proceso
   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT CONVERT(CHAR(8),acfecproc,112) FROM BacFwdSuda..MFAC with (nolock) )

   --> 6.0 --> Inicia la Lectura sobre la cartera del Día o Vigente
   IF @dFechaProceso = @FechaProc 
   BEGIN 

      INSERT INTO #FLUJOS_SUB
      SELECT 'tmp_numoper_fwd'        = car.canumoper
         ,   'tmp_nemotecnico'        = tds.tdmascara
         ,   'tmp_moneda'             = CASE WHEN car.caseriado = 'S' THEN (SELECT semonemi FROM BacParamSuda..SERIE WHERE seserie = tds.tdmascara)
				             ELSE 0
			                END
         ,   'tmp_monto_fwd'          =  car.camtomon1
         ,   'tmp_fechavcto'          = CONVERT(CHAR(08),tds.tdfecven,112)
         ,   'tmp_tasa'               =  car.catipcam
         ,   'tmp_numero_cupon'       = (tds.tdcupon)
         ,   'tmp_interes'            = (tds.tdinteres)
         ,   'tmp_monto_interes'      = (tds.tdinteres * car.camtomon1 / 100)
         ,   'tmp_amortizacion'       = (tds.tdamort)
         ,   'tmp_monto_amortizacion' = (tds.tdamort   * car.camtomon1 / 100)
         ,   'tmp_plazo'              = DATEDIFF(DAY, @FechaProc, tds.tdfecven)
         ,   'tmp_flujo'              = (tds.tdflujo   * car.camtomon1 / 100)
         ,   'tmp_monto_flujo'        = (car.camtomon1 * tds.tdinteres / 100) + CASE WHEN tds.tdamort = 0.0 THEN 0 ELSE car.camtomon1 END
         ,   'tmp_indicador'          = CASE WHEN car.catipoper = 'C' THEN 'A' ELSE 'P' END
         ,   'tmp_marca'              = 1
      FROM   BacFwdSuda..MFCA         car 
             LEFT JOIN BacParamSuda..TABLA_DESARROLLO tds ON tds.tdmascara = car.caserie   AND tds.tdfecven >= @FechaProc
             LEFT JOIN BacParamSuda..MONEDA           cnv ON cnv.mncodmon  = car.cacodmon2
      WHERE  car.cacodpos1	      = 10
	AND  car.cafecvcto            > @FechaProc


      INSERT INTO #FLUJOS_SUB
      SELECT 'tmp_numoper_fwd'        = canumoper
         ,   'tmp_nemotecnico'        = caserie
         ,   'tmp_moneda'             = cacodmon2
         ,   'tmp_monto_fwd'          = camtomon1
         ,   'tmp_fechavcto'          = CONVERT(CHAR(08),cafecvcto,112)
         ,   'tmp_tasa'               = catipcam
         ,   'tmp_numero_cupon'       = 1
         ,   'tmp_interes'            = 0.0 --> (tdinteres)
         ,   'tmp_monto_interes'      = 0.0 --> (tdinteres * camtomon1 / 100)
         ,   'tmp_amortizacion'       = 0.0 --> (tdamort)
         ,   'tmp_monto_amortizacion' = CASE WHEN catipoper = 'C' THEN ISNULL( valorrazonablepasivo ,0) 
                                             ELSE                      ISNULL( valorrazonableactivo ,0) 
                                        END
         ,   'tmp_plazo'              = DATEDIFF(DAY, @FechaProc, cafecvcto) --> DATEDIFF(DAY, @FechaProc, tdfecven)
         ,   'tmp_flujo'              = 0.0 --> (tdflujo * camtomon1 / 100)
         ,   'tmp_monto_flujo'        = CASE WHEN catipoper = 'C' THEN ISNULL( valorrazonablepasivo ,0) 
                                             ELSE                      ISNULL( valorrazonableactivo ,0) 
                                        END
         ,   'tmp_indicador'          = CASE WHEN catipoper = 'C' THEN 'P' ELSE 'A' END
         ,   'tmp_marca'              = 0
      FROM   BacFwdSuda..MFCA         car
             LEFT JOIN BacParamSuda..MONEDA cnv ON mncodmon = cacodmon2
      WHERE  cacodpos1	              = 10
	AND  car.cafecvcto            > @FechaProc

   END ELSE  --> 6.1 --> Inicia la Lectura sobre la cartera Historica.
   BEGIN

      INSERT INTO #FLUJOS_SUB
      SELECT 'tmp_numoper_fwd'        = canumoper
         ,   'tmp_nemotecnico'        = tdmascara
         ,   'tmp_moneda'             = CASE WHEN caseriado = 'S' THEN (SELECT semonemi FROM BacParamSuda..SERIE WHERE seserie = TDS.tdmascara)
				             ELSE 0
			                END
         ,   'tmp_monto_fwd'          = camtomon1
         ,   'tmp_fechavcto'          = CONVERT(CHAR(08),tdfecven,112)
         ,   'tmp_tasa'               = catipcam
         ,   'tmp_numero_cupon'       = tdcupon
         ,   'tmp_interes'            = tdinteres
         ,   'tmp_monto_interes'      = (tdinteres * camtomon1 / 100)
         ,   'tmp_amortizacion'       = tdamort
         ,   'tmp_monto_amortizacion' = (tdamort * camtomon1 / 100)
         ,   'tmp_plazo'              = DATEDIFF(DAY, @FechaProc, tdfecven)
         ,   'tmp_flujo'              = (tdflujo * camtomon1 / 100)
         ,   'tmp_monto_flujo'        = (camtomon1 * tdinteres /100) 
                                      + CASE WHEN tdamort   = 0.0 THEN 0   ELSE camtomon1 END
         ,   'tmp_indicador'          = CASE WHEN catipoper = 'C' THEN 'A' ELSE 'P'       END
         ,   'tmp_marca'              = 1
      FROM   BacFwdSuda..MFCARES      car 
             INNER JOIN BacParamSuda..TABLA_DESARROLLO tds ON tdmascara	= caserie AND tdfecven >= @FechaProc
      WHERE  cafechaproceso           = @FechaProc
      AND    cacodpos1	              = 10
      AND    car.cafecvcto            > @FechaProc

      INSERT INTO #FLUJOS_SUB
      SELECT 'tmp_numoper_fwd'        = canumoper
         ,   'tmp_nemotecnico'        = caserie
         ,   'tmp_moneda'             = cacodmon2
         ,   'tmp_monto_fwd'          = camtomon1
         ,   'tmp_fechavcto'          = CONVERT(CHAR(08),cafecvcto,112)
         ,   'tmp_tasa'               = catipcam
         ,   'tmp_numero_cupon'       = 1
         ,   'tmp_interes'            = 0.0 --> (tdinteres)
         ,   'tmp_monto_interes'      = 0.0 --> (tdinteres * camtomon1 / 100)
         ,   'tmp_amortizacion'       = 0.0 --> (tdamort)
         ,   'tmp_monto_amortizacion' = CASE WHEN catipoper = 'C' THEN ISNULL( valorrazonablepasivo ,0) 
                                             ELSE                      ISNULL( valorrazonableactivo ,0) 
                                        END
         ,   'tmp_plazo'              = DATEDIFF(DAY, @FechaProc, cafecvcto) --> DATEDIFF(DAY, @FechaProc, tdfecven)
         ,   'tmp_flujo'              = 0.0 --> (tdflujo * camtomon1 / 100)
         ,   'tmp_monto_flujo'        = CASE WHEN catipoper = 'C' THEN ISNULL( valorrazonablepasivo ,0) 
                                             ELSE                      ISNULL( valorrazonableactivo ,0) 
                                        END
         ,   'tmp_indicador'          = CASE WHEN catipoper = 'C' THEN 'P' ELSE 'A' END
         ,   'tmp_marca'              = 0
      FROM   BacFwdSuda..MFCARES      car
             LEFT JOIN BacParamSuda..MONEDA cnv ON mncodmon = cacodmon2
      WHERE  cafechaproceso           = @FechaProc
      AND    cacodpos1	              = 10
      AND    car.cafecvcto            > @FechaProc
   END

   --> 7.0 --> Lee la Cantidad de Registros a Retornar
   DECLARE @iCantidadRegistros        NUMERIC(21,0)
       SET @iCantidadRegistros        = (SELECT COUNT(1) FROM #FLUJOS_SUB)

   --> 8.0 --> Pasa a Moneda Local Peso, los Montos a Informar. Con el T/C Rep. Contable o con la UF del Día 
   --> Solamente los Registros Referentes a los Flujos de Tabla de Desarrollo.
   UPDATE #FLUJOS_SUB
      SET tmp_monto_flujo        = ROUND( tmp_monto_flujo        * ISNULL(vmvalor,1) ,0)
      ,   tmp_monto_amortizacion = ROUND( tmp_monto_amortizacion * ISNULL(vmvalor,1) ,0)
      ,   tmp_monto_interes      = ROUND( tmp_monto_interes      * ISNULL(vmvalor,1) ,0)
     FROM #TMP_VALOR_MONEDA
    WHERE tmp_marca              = 1 --> Solo los Registros de tabla de Desarrollo
      AND tmp_moneda             = vmcodigo

   --> 9.0 --> Retorno Final a la Interfaz de Flujos Forward FD14[]
       --> Se Retiro la Multiplicaciópn por los Valores de Moneda...
   SELECT 'CAMPO_001' = 'CL '
   ,	  'CAMPO_002' = CONVERT(CHAR(8),@FechaProc,112)
   ,	  'CAMPO_003' = 'FD14' + SPACE(10)
   ,	  'CAMPO_004' = '001'
   ,	  'CAMPO_005' = 'MD01' + SPACE(12)
   ,	  'CAMPO_006' = CONVERT(CHAR(20),tmp_numoper_fwd)
   ,	  'CAMPO_007' = tmp_fechavcto

   ,	  'CAMPO_008' = LTRIM(RTRIM( CONVERT(CHAR(18), CONVERT(NUMERIC(18), (ROUND(tmp_monto_flujo       ,0) ))) )) + '00'
   ,	  'CAMPO_009' = LTRIM(RTRIM( CONVERT(CHAR(18), CONVERT(NUMERIC(18), (ROUND(tmp_monto_amortizacion,0) ))) )) + '00'
   ,	  'CAMPO_010' = LTRIM(RTRIM( CONVERT(CHAR(18), CONVERT(NUMERIC(18), (ROUND(tmp_monto_interes     ,0) ))) )) + '00'

-->,	  'CAMPO_008' = LTRIM(RTRIM(CONVERT(CHAR(18),CONVERT(NUMERIC(18),(ROUND(tmp_monto_flujo        * ISNULL(vmvalor,1),0)))))) + '00'
-->,	  'CAMPO_009' = LTRIM(RTRIM(CONVERT(CHAR(18),CONVERT(NUMERIC(18),(ROUND(tmp_monto_amortizacion * ISNULL(vmvalor,1),0)))))) + '00'
-->,	  'CAMPO_010' = LTRIM(RTRIM(CONVERT(CHAR(18),CONVERT(NUMERIC(18),(ROUND(tmp_monto_interes      * ISNULL(vmvalor,1),0)))))) + '00'

   ,	  'CAMPO_011' = SPACE(3)
   ,	  'CAMPO_012' = SPACE(10)	
   ,	  'CAMPO_013' = tmp_indicador
   ,	  'CAMPO_014' = @iCantidadRegistros
   ,      'CAMPO_015' = tmp_moneda
   FROM	  #FLUJOS_SUB
          --> LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmcodigo = #FLUJOS_SUB.tmp_moneda AND vmfecha = @FechaProc
   ORDER BY tmp_numoper_fwd, tmp_indicador
	
END



GO
