USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_BACK_TEST]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULO_BACK_TEST]  
   (   @Fecha_Proc   DATETIME   )
AS    
BEGIN

   SET NOCOUNT ON

   DECLARE @Numero_Operacion  NUMERIC(7)
   ,       @Numero_Flujo      NUMERIC(3)
   ,       @Tipo_Flujo        NUMERIC(1)
   ,       @FlujoVigente      NUMERIC(1)
   ,       @FecIniFlujo       DATETIME
   ,       @FecVncFlujo       DATETIME
   ,       @Fecha_Prox        DATETIME

   --      Variables de calculo
   DECLARE @Interes           FLOAT
   ,       @ValorParMon       FLOAT
   ,       @Capital           FLOAT
   ,       @DiasBase          FLOAT
   ,       @BaseTasa          FLOAT
   ,       @CodigoTasa        NUMERIC(5)
   ,       @Fecha_UDM         DATETIME
   ,       @Plazo             FLOAT
   ,       @TasaMTM           FLOAT
   ,       @SpreadMTM         FLOAT
   ,       @Base              NUMERIC(3)
   ,       @Moneda            NUMERIC(3)
   ,       @MnNemo            CHAR(3)
   ,       @MnTipoPar         CHAR(1)
   ,       @MontoC08          FLOAT
   ,       @MontoC08USD       FLOAT
   ,       @MontoC08CLP       FLOAT 
   ,       @ValorDO_UDM       FLOAT
   ,       @PlazoDesc         FLOAT
   ,       @TasaDesc          FLOAT
   ,       @SpreadDesc        FLOAT
   ,       @FlujoDesc         FLOAT
   ,       @FlujoDescUSD      FLOAT
   ,       @FlujoDescCLP      FLOAT
   ,       @ValRazonable      FLOAT
   ,       @ValRazonableMO    FLOAT
   ,       @ValRazonableUSD   FLOAT
   ,       @ValRazonableCLP   FLOAT
   ,       @FecIniFlujoAnt    DATETIME
   ,       @PlazoAnt          FLOAT
   ,       @TasaPlazoAnt      FLOAT
   ,       @Amortiza          FLOAT
   ,       @Tipo_Swap         NUMERIC(3)
   ,       @iEstado           INT
   ,       @TasaCurva         FLOAT

   DECLARE @iRegistros        INTEGER
   ,       @iRegistro         INTEGER
   ,       @PeriodoInt        INTEGER
   ,       @PeriodoIntReal    INTEGER

    -- 20080320 Parar calcular el flujo vigente Swap ICP
   DECLARE @TasaICP           FLOAT
   DECLARE @PlazoDevengado    FLOAT
   DECLARE @PlazoPorDevengar  FLOAT
   DECLARE @TasaPlazo         FLOAT
   DECLARE @TipoIndice        INTEGER
   DECLARE @FinFlujo          DATETIME
   DECLARE @PlazoTIR          FLOAT
-- DECLARE @CantDiasAA        NUMERIC(3)  -- 20080319
   DECLARE @TipoInt           NUMERIC(1)
   DECLARE @EstadoFlujo       NUMERIC(5)
   DECLARE @Tir               FLOAT
   DECLARE @GlosaTasa         CHAR(30)
   DECLARE @FechaFijacionTasa DATETIME
   DECLARE @FinOperacion      DATETIME

   --Valorización Swap x Curva '0'
   DECLARE @Spread            FLOAT
   DECLARE @cProducto         CHAR(3)
   DECLARE @nTipoTasa         INTEGER
 
   EXECUTE BACTRADERSUDA..SP_BUSCA_FECHA_HABIL @Fecha_Proc , 1,  @Fecha_Prox OUTPUT  

      SET @PlazoAnt    = 0
      SET @Fecha_UDM   = @Fecha_Proc  
      SET @ValorDO_UDM = (SELECT Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = 994 AND fecha = @Fecha_UDM)
      SET @Fecha_UDM   = @Fecha_Proc    -- Se vuelve a dejar con los valores del día, revisar el tema para los EUR!!

   IF ISNULL(@ValorDO_UDM,0) = 0 
   BEGIN
      SELECT 'NO EXISTE VALOR DO ULTIMO DIA MES ANTERIOR' 
      RETURN(1)
   END    

   DECLARE @cMensajes   VARCHAR(100)
   DECLARE @Accion      VARCHAR(20) -- SE TUBO QUE DEFINIR.....DMV

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor  = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha    = @Fecha_UDM
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)

   CREATE NONCLUSTERED INDEX VALOR_TC_CONTABLE_001 ON #VALOR_TC_CONTABLE (vmcodigo)

   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha       = @Fecha_UDM
   AND    vmcodigo      IN(994,995,997,998,999)

   --> Tabla temporal para almacenar resultados de SP que retorna la tasa por plazo.                        
   CREATE TABLE #TasaMoneda
   (   Tasa             FLOAT NOT NULL DEFAULT(0.0)
   ,   Spreed           FLOAT NOT NULL DEFAULT(0.0)
   ,   SpotCompra       FLOAT NOT NULL DEFAULT(0.0)
   ,   SpotVenta        FLOAT NOT NULL DEFAULT(0.0)
   )

   --> Tabla temporal Obtiene operaciones sin tasa MTM, por flujo, plazo y moneda
   CREATE TABLE #OperacSNTasa 
   (   Numero_Operacion NUMERIC(7)
   ,   Numero_Flujo     NUMERIC(3)
   ,   Tipo_Flujo       NUMERIC(1)
   ,   Moneda           NUMERIC(3)
   ,   Plazo            FLOAT
   ,   Sistema          CHAR(3)
   ,   Producto         CHAR(5)
   ,   Tipo_Tasa        CHAR(5)
   ,   Base             NUMERIC(5)
   ,   Glosa            CHAR(100)
   )
   --> Tabla de paso para calculo de datos. 
   SELECT Numero_Operacion 
   ,      Numero_Flujo
   ,      Tipo_Flujo
   ,      Tipo_Swap
   ,      Fecha_Inicio_Flujo
   ,      Fecha_Vence_Flujo
   ,      Fecha_Inicio
   ,      fecha_fijacion_tasa

   ,      Compra_capital
   ,      Compra_Amortiza
   ,      Compra_Saldo 
   ,      Compra_Moneda
   ,      Compra_Interes   
   ,      Compra_Codigo_Tasa
   ,      Compra_Valor_tasa
   ,      Compra_Base
   ,      Compra_Spread

   ,      Venta_capital
   ,      Venta_Amortiza
   ,      Venta_Saldo 
   ,      Venta_Moneda
   ,      Venta_Interes
   ,      Venta_Codigo_Tasa
   ,      Venta_Valor_tasa
   ,      Venta_Base
   ,      Venta_Spread
   ,     'Plazo'                = CONVERT(NUMERIC(05,0),0.0) -->  CAST(0 AS NUMERIC(5))
   ,     'DiasBase'             = CONVERT(NUMERIC(05,0),0.0) -->  CAST(0 AS NUMERIC(5))
   ,     'TasaMTM'              = CONVERT(NUMERIC(12,8),0.0) -->  CAST(0 AS NUMERIC(12,8))
   ,     'MontoC08'             = CONVERT(NUMERIC(19,4),0.0) -->  CAST(0 AS NUMERIC(19,4))
   ,     'ValorParMon'          = CONVERT(NUMERIC(19,4),0.0) -->  CAST(0 AS NUMERIC(19,4))   
   ,     'MontoC08CLP'          = CONVERT(NUMERIC(19,0),0.0) -->  CAST(0 AS NUMERIC(19))
   ,     'Marca'                = ' '
   ,     'PeriodoInt'           = (12 / ISNULL(pa.meses,1) )
   ,     'PeriodoIntReal'       = pa.dias
   ,     'registrocorrelativo'  = IDENTITY(INT)
   ,     'Estado_Flujo'	  = Estado_Flujo
   INTO   #Cartera
   FROM   CARTERARES      
          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION pa ON pa.sistema = 'PCS' AND pa.tabla = 1044 AND codigo = (venta_codamo_interes + compra_codamo_interes)
   WHERE  Fecha_Proceso      = @Fecha_Proc
   ORDER BY Numero_Operacion, Numero_Flujo, Tipo_Flujo

   CREATE NONCLUSTERED INDEX #CARTERA_001 ON #CARTERA (Numero_Operacion ,Numero_Flujo ,Tipo_Flujo )
   CREATE CLUSTERED    INDEX #CARTERA_002 ON #CARTERA (marca,registrocorrelativo)

   SELECT * 
   INTO   #CARTERA_TEMPORAL
   FROM   CARTERARES
   WHERE  Fecha_Proceso   = @Fecha_Proc
   
   CREATE CLUSTERED    INDEX CAR_TEMPO_001 ON #CARTERA_TEMPORAL (numero_operacion ,numero_flujo, tipo_flujo)

   SELECT  @iRegistros       = MAX(registrocorrelativo)
   ,       @iRegistro        = MIN(registrocorrelativo)
   FROM    #Cartera

   WHILE @iRegistros >= @iRegistro 
   BEGIN

      SELECT @Numero_Operacion   = Numero_Operacion 
      ,      @Numero_Flujo       = Numero_Flujo
      ,      @Tipo_Flujo         = Tipo_Flujo
      ,      @FecIniFlujo        = Fecha_Inicio_Flujo  
      ,      @FecVncFlujo        = Fecha_Vence_Flujo  
      ,      @FlujoVigente       = CASE WHEN @Fecha_Proc BETWEEN Fecha_inicio_Flujo AND Fecha_Vence_Flujo THEN 1 ELSE 0 END
      ,      @Capital            = CASE WHEN Tipo_Flujo = 1 THEN Compra_Saldo + Compra_Amortiza 
                                        ELSE                     Venta_Saldo  + Venta_Amortiza
                                   END 
      ,      @Moneda             = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda      ELSE Venta_Moneda      END  
      ,      @Base               = CASE WHEN Tipo_Flujo = 1 THEN Compra_Base        ELSE Venta_Base        END    
      ,      @CodigoTasa         = CASE WHEN Tipo_Flujo = 1 THEN Compra_Codigo_Tasa ELSE Venta_Codigo_Tasa END     
      ,      @TasaMTM            = CASE WHEN Tipo_Flujo = 1 THEN Compra_Valor_Tasa  ELSE Venta_Valor_Tasa  END         
      ,      @MontoC08           = CASE WHEN Tipo_Flujo = 1 THEN Compra_Interes     ELSE Venta_Interes     END     
      ,      @PeriodoInt         = CONVERT(INTEGER,ROUND(PeriodoInt,0))
      ,      @PeriodoIntReal     = CONVERT(INTEGER,ROUND(PeriodoIntReal,0))
      ,      @Amortiza           = Compra_Amortiza + Venta_Amortiza
      ,      @Tipo_Swap          = Tipo_Swap
      ,      @FechaFijacionTasa  = fecha_fijacion_tasa
      ,      @Spread             = CASE WHEN Tipo_Flujo = 1 THEN Compra_Spread     ELSE Venta_Spread     END
      ,      @EstadoFlujo        = Estado_Flujo
      FROM   #Cartera
      WHERE  Marca              <> '-'
      AND    registrocorrelativo = @iRegistro

      IF @@ROWCOUNT = 0 
         BREAK

        SELECT @GlosaTasa = tbglosa  
          FROM BacParamSuda..TABLA_GENERAL_DETALLE  
         WHERE tbcateg    = 1042
           AND tbcodigo1  = @CodigoTasa
                          
         IF @Tipo_Swap = 3  -- Gatillar recualculo de Flujo 
         BEGIN
		EXECUTE CALCULO_TASA_PROYECTADA_FRA_BACK_TEST  @Numero_Operacion
                                                            ,  -1            -- TIPO TASA
                                                            ,  @Fecha_Proc
                                                            ,  @Fecha_Prox                           
               
		-- Volver a rescatar la información
	        SELECT @MontoC08           = CASE WHEN Tipo_Flujo = 1 THEN Compra_Interes ELSE Venta_Interes END
		FROM   #Cartera
		WHERE  Marca              <> '-'
		AND    registrocorrelativo = @iRegistro
         END

        SET   @nTipoTasa   = CASE WHEN @CodigoTasa = 0 THEN 0 ELSE 1 END
        SET   @BaseTasa    = 360

        -->  20080319 Se retoma la base de la operación.  
        SELECT @BaseTasa   = CASE WHEN Base = 'A' THEN 365 ELSE Base END   
        FROM   BASE
        WHERE  codigo      = @Base

        SET   @cProducto   = CASE WHEN @Tipo_SWAP = 1 THEN 'ST'
                                  WHEN @Tipo_SWAP = 2 THEN 'SM'
                                  WHEN @Tipo_SWAP = 3 THEN 'FR'
                                  WHEN @Tipo_SWAP = 4 THEN 'SP'
                             END

        SELECT @FinFlujo        = CASE WHEN compra_codigo_tasa = 0 THEN fecha_termino ELSE fecha_vence_flujo END
          ,    @FinOperacion    = fecha_termino
          FROM #CARTERA_TEMPORAL
         WHERE Numero_Operacion = @Numero_Operacion
           AND Estado_Flujo     = 1
           AND Tipo_Flujo       = @Tipo_Flujo

         SET @PlazoTIR = DATEDIFF(DD, @Fecha_Proc, CASE WHEN @nTipoTasa =1 THEN @FinFlujo ELSE @FinOperacion END) -- 05/03/2008
         SET @TipoInt = 2 --CASE WHEN  @PlazoTIR <= @CantDiasAA THEN 1 ELSE  2 END  -- 20080319

         DELETE FROM #TasaMoneda  

         INSERT INTO #TasaMoneda
         EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA  @Moneda  
                                                ,  @PlazoTIR
                                                ,  'PCS'
                                                ,  @cProducto
                                                ,  @nTipoTasa
                                                ,  @Tipo_Flujo
                                                ,  @Base
                                                ,  'C'
                                                ,  @CodigoTasa
                                                ,  'TIR'
                                                ,  @Fecha_Prox
                                                ,  @Fecha_Prox


            -- Rescata valor de tasa y redondeo a 8 decimales 
            SELECT @Tir = ROUND(Tasa,8)
            FROM   #TasaMoneda

            IF @Tir = 0.0
            BEGIN
               INSERT INTO #OperacSNTasa 
                   VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoTIR,'PCS', @cProducto, @nTipoTasa, @Base, ' al rescatar Tasa con valor "cero" para TIR con Indice ' + @GlosaTasa) 
            END

        SET @Plazo    = DATEDIFF(DAY,@Fecha_Proc ,@FecVncFlujo)  -- TAG MPNG 20051109

/*	20080319 Recuperar Dias base como estaba antes,
        según la convención de operación
        con esto se obtiene una tasa Forward en
        la base de la operación y no hay que transformarla

        SET @DiasBase = DATEDIFF(DAY,@FecIniFlujo,@FecVncFlujo) --> Dias normales 
*/  

         -->Dias segun base para bases con meses de 30 dias.            
         IF @Base IN (4,5)  -- 30/360 30/365
         BEGIN
            EXECUTE BacBonosExtSuda..SVC_FMU_DIF_D30  @FecIniFlujo, @FecVncFlujo, @DiasBase OUTPUT  
         END ELSE
         BEGIN
            SELECT @DiasBase = DATEDIFF(DAY,@FecIniFlujo,@FecVncFlujo) --> Dias normales 
         END

         --> 20080320   
         SET @TasaICP  = @TasaMTM -- Recordar que esta variable registra la tasa del flujo vigente 

         --> Obtiene tasa para flujos variables futuros, para flujo en curso o FRA (tipo=3) mantiene los intereses.	   
         IF (@CodigoTasa <> 0 AND @FechaFijacionTasa > @Fecha_Proc  AND @Tipo_SWAP <> 3 AND @Tipo_SWAP <> 4)
             -- 20080320 todos los flujos ICP serán recalculados
         --> OR (@CodigoTasa <> 0 AND @EstadoFlujo <> 1 AND @Tipo_SWAP =4)    
             OR (@Tipo_SWAP   = 4 AND @CodigoTasa  <> 0 )	

         BEGIN
            --> Busca tasa MTM segun plazo y moneda            
            -- *
            SET @nTipoTasa   = CASE WHEN @CodigoTasa = 0 THEN 0 ELSE 1 END
   
            DELETE #TasaMoneda  

            INSERT INTO #TasaMoneda
                   EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA  @Moneda  
                                                         ,   @Plazo
                                                         ,   'PCS'
                                                         ,   @cProducto
                                                         ,   @nTipoTasa
                                                         ,   @Tipo_Flujo
                                                         ,   @Base
                                                         ,   'C'
                                                         ,   @CodigoTasa
                                                         ,   'CERO'
                                                         ,   @Fecha_Prox
                                                         ,   @Fecha_Prox


            -- Rescata valor de tasa y redondeo a 8 decimales 
            SELECT @TasaMTM   = ROUND(Tasa,8),
                   @SpreadMTM = Spreed
              FROM #TasaMoneda  

            IF @TasaMTM  = 0.0
            BEGIN
                INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @Plazo,'PCS', @cProducto, @nTipoTasa, @Base, ' al rescatar Tasa con valor "cero" para Curva con Indice ' + @GlosaTasa) 

            END

            SET @FecIniFlujoAnt  = ''

            SELECT @FecIniFlujoAnt  =  Fecha_vence_Flujo    -- TAG MPNG 20051109 
              FROM #cartera  
            WHERE Numero_Operacion  =  @Numero_Operacion 
              AND Tipo_Flujo        =  @Tipo_Flujo  
              AND Numero_Flujo      = (@Numero_Flujo - 1)    
            ORDER BY
                  Numero_Operacion,
                  Tipo_Flujo,
                  Numero_Flujo

             IF @@ROWCOUNT = 0
                SET @PlazoAnt = DATEDIFF(DAY, @Fecha_Proc, @FecIniFlujo ) 
             ELSE
                SET @PlazoAnt = DATEDIFF(DAY, @Fecha_Proc, @FecIniFlujoAnt ) 


             -- 20080320 comenzó a devengar un promedio de cámara
             -- por tanto se debe calcular el flujo vigente
             
             IF  @PlazoAnt < 0 	  -- Esto solo se dará para ICP Vigente, es señal de devengo
             BEGIN

                SET @PlazoDevengado   = datediff( Day, @FecIniFlujo, @Fecha_Proc )  -- plazo devengado
                SET @PlazoPorDevengar = @Plazo 
                SET @TasaPlazo        = @TasaMTM 

                SET @TasaMTM          = (      ( 1.0 + @TasaICP / 100.0 * @PlazoDevengado / @BaseTasa ) * 
                                          power( 1.0 + @TasaPlazo / 100.0 ,  @PlazoPorDevengar / 360.0 ) 
                                           - 1.0 
                                        ) * 360.0 / @DiasBase
             END ELSE
             BEGIN

               -->Busca tasa MTM segun plazo Ant y moneda
               DELETE #TasaMoneda 

               -- Utilizar un procedimiento que recapitalice la tasa
               INSERT INTO #TasaMoneda
                      EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA  @Moneda  
                                                            ,   @PlazoAnt
                                                            ,   'PCS'
                                                            ,   @cProducto
                                                            ,   @nTipoTasa
                                                            ,   @Tipo_Flujo
                                                            ,   @Base
                                                            ,   'C'
                                                            ,   @CodigoTasa
                                                            ,   'CERO'
                                                            ,   @Fecha_Prox
                                                            ,   @Fecha_Prox

               SELECT @TasaPlazoAnt = ROUND( Tasa, 8 )
                 FROM #TasaMoneda

               IF @TasaPlazoAnt  = 0.0 
               BEGIN
                   INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoAnt,'PCS', @cProducto, @nTipoTasa, @Base, ' al rescatar Tasa con valor [cero] para Curva con Indice ' + @GlosaTasa) 

               END

               --Valorización Swap x Curva '0'

               /*
	       20080319 Calculo de tasa Forward , los factores de capitalización encapsulan la convensión de tasas, luego
	       se puede inferir la tasa forward de la siguiente manera: ( 1 + Tasa2/100 )^(p2/360) = ( 1 + Tasa1/100 )^(p1/360)*( 1 + TasaForward/100 * Convensión(pl2-pl1)/BaseOperacion )
	       */

               SELECT @TasaMTM = (POWER((1 + @TasaMTM/100.0),(@Plazo/@BaseTasa))/POWER((1 + @TasaPlazoAnt/100.0),(@PlazoAnt/@BaseTasa))-1) * 
	       (@BaseTasa/@DiasBase)

             END        

            --Valorización Swap x Curva '0'         

            -- Ojo volver a multiplicar por 100
            SET @TasaMTM = @TasaMTM * 100.0

            -- Suma Spread a tasa FRA
            SET @TasaMTM = @TasaMTM + @Spread


            -->Calculo de intereses. 
            SET @MontoC08 = (@Capital * (@TasaMTM + @SpreadMTM) /100.0) * (@DiasBase/@BaseTasa) 

            -->Redondeo a 4 decimales. 
            SET @MontoC08   = ROUND(@MontoC08, 4)

        END         -- FIN flujos variables

         --Rescata valor de tasa de descuento con plazo de descuento para flujo pagamos
         -->plazo de descuento 
         SELECT @PlazoDesc = DATEDIFF(DAY,@Fecha_Proc ,@FecVncFlujo)

         -->     Nuevo Codigo Agregado por Adrián Fecha 30-04-2008
         DECLARE @ContraMoneda  INTEGER
             SET @ContraMoneda  = (SELECT MAX( compra_moneda + venta_moneda )
                                     FROM #cartera 
                                    WHERE Numero_Operacion = @Numero_Operacion
                                      AND tipo_Flujo       = CASE WHEN @Tipo_Flujo = 1 THEN 2 ELSE 1 END)

         SET @Accion = 'Descont' 
         IF  @Moneda = 13 AND (@ContraMoneda = 998 OR @ContraMoneda = 999)
             SET @Accion = 'DescMxMn'
         -->     Nuevo Codigo Agregado por Adrián Fecha 30-04-2008


         --> Obtiene tasa de descuento segun plazo de dias corridos.    
         DELETE #TasaMoneda 

         INSERT INTO #TasaMoneda 
         EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA   @Moneda  
                                                ,   @PlazoDesc
                                                ,   'PCS'
                                                ,   @cProducto 
                                                ,   @nTipoTasa
                                                ,   @Tipo_Flujo
                                                ,   @Base 
                                                ,   'C' 
                                                ,   @CodigoTasa
                                                ,   'CERO'
                                                ,   @Fecha_Prox
                                                ,   @Fecha_Prox

         SELECT @TasaDesc   = ROUND(Tasa,8)
         ,      @SpreadDesc = Spreed
         FROM   #TasaMoneda

         IF @TasaDesc  = 0.0 
            INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoDesc, 'PCS', @cProducto , @nTipoTasa, @Base, ' al rescatar Tasa con valor "cero" para Curva con Indice ' + @GlosaTasa) 

         --> Calculo de descuentos de interes con plazo de dias corridos.
         --> 05-Ago-2005 Se incluye el monto amortizar como parte del valor razonable.
/*
        IF @PlazoDesc <= @CantDiasAA  --Valorización Swap x Curva '0'
        BEGIN
            SET @FlujoDesc = (@MontoC08 + @Amortiza) / (1 + ((@TasaDesc + @SpreadDesc) /100.0) * (@PlazoDesc/@BaseTasa))
            SELECT '1','@FlujoDesc' = @FlujoDesc

        END ELSE
        BEGIN
*/-- 20080319
	-- 20080319 Calculo del descuento debe ser siempre calculado con interes compuesto, solo utilizar esta formula
            SET @FlujoDesc =  (@MontoC08 + @Amortiza) / power( 1 + (@TasaDesc + @SpreadDesc) /100.0 , @PlazoDesc/@BaseTasa ) --Valorización Swap x Curva '0'
--        END

         --  descontar DIVIDIDO por ( 1 + Tasa/100 * Plazo/360)
         --> Redondeo a 4 decimales. 
         SELECT @FlujoDesc = ROUND(@FlujoDesc , 4) 
         -- FIN calculo de descuentos.

         --Conversion a pesos.   
         IF @Moneda = 999
         BEGIN 
            SELECT @MontoC08CLP  =  ROUND(@MontoC08,0) 
            SELECT @FlujoDescCLP =  ROUND(@FlujoDesc,0) 
            SELECT @MontoC08USD  =  ROUND(@MontoC08  / @ValorDO_UDM,4)                
            SELECT @FlujoDescUSD =  ROUND(@FlujoDesc / @ValorDO_UDM,4)                
         END ELSE
         BEGIN
            -->Obtiene Tipo de paridad de moneda y nemo.
            IF @Moneda NOT IN(998,994,13)
            BEGIN
               SELECT @MnNemo    = mnnemo 
               FROM   BacParamSuda..MONEDA
               WHERE  mncodmon   = @Moneda

               IF NOT EXISTS(SELECT 1 FROM #VALOR_TC_CONTABLE WHERE vmcodigo = @Moneda AND vmvalor <> 0)
               BEGIN
                  SET @cMensajes = '¡ NO EXISTEN VALORES PARA LA MONEDA ' + @MnNemo + ' A LA FECHA !.' 
                  RAISERROR (@cMensajes ,16,6,'ERROR.')
                  RETURN
               END ELSE
               BEGIN
                  SELECT @ValorParMon = ISNULL((SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13)
                                             / (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = @Moneda),0.0)
               END

               IF @ValorParMon = 0.0
               BEGIN
                  SELECT 'NO SE PUDO DETERMINAR PARIDAD BCCH PARA EL ' + @MnNemo
                  BREAK       
               END

               --> A Usd
               SELECT @MontoC08USD  = ROUND(@MontoC08     / @ValorParMon, 4)  
               SELECT @FlujoDescUSD = ROUND(@FlujoDesc    / @ValorParMon, 4) 

               SELECT @MontoC08CLP  = ROUND(@MontoC08     / @ValorParMon, 4)  
               SELECT @FlujoDescCLP = ROUND(@FlujoDesc    / @ValorParMon, 4) 

               --> A CLP
               SELECT @MontoC08CLP  = ROUND(@MontoC08CLP  * @ValorDO_UDM, 0)  
               SELECT @FlujoDescCLP = ROUND(@FlujoDescCLP * @ValorDO_UDM, 0)   
            END ELSE
            BEGIN

               SELECT @ValorParMon = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = @Moneda

               IF @ValorParMon = 0.0
               BEGIN
                  SET @cMensajes = 'NO SE PUDO DETERMINAR VALOR PARA LA MONEDA ' + @MnNemo 
                  RAISERROR(@cMensajes,16,6,'ERROR.')   
                  RETURN
               END

               SELECT @MontoC08CLP  = ROUND( @MontoC08     * @ValorParMon, 0)  
               SELECT @FlujoDescCLP = ROUND( @FlujoDesc    * @ValorParMon, 0)  
               SELECT @MontoC08USD  = ROUND( @MontoC08CLP  / @ValorDO_UDM, 4)  
               SELECT @FlujoDescUSD = ROUND( @FlujoDescCLP / @ValorDO_UDM, 4) 
            END
         END
                 
         -->Actualizando marca en cartera temporal
/*         UPDATE #Cartera 
         SET    Marca            = '-'
         WHERE  Numero_Operacion = @Numero_Operacion
         AND    Numero_Flujo     = @Numero_Flujo
         AND    Tipo_Flujo       = @Tipo_Flujo
*/
         UPDATE #Cartera 
         SET    Marca            = '-'
         WHERE  registrocorrelativo = @iRegistro


         UPDATE #CARTERA_TEMPORAL
         SET    Tasa_Compra_Curva   = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@TasaMTM,8)                ELSE 0 END
         ,      Tasa_Venta_Curva    = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@TasaMTM,8)                ELSE 0 END
         ,      Activo_MO_C08       = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08,4)               ELSE 0 END
         ,      Activo_USD_C08      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08USD,4)            ELSE 0 END
         ,      Activo_CLP_C08      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08CLP,0)            ELSE 0 END
         ,      Pasivo_MO_C08       = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08,4)               ELSE 0 END
         ,      Pasivo_USD_C08      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08USD,4)            ELSE 0 END
         ,      Pasivo_CLP_C08      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08CLP,0)            ELSE 0 END
         ,      Tasa_Compra_CurvaVR = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@TasaDesc + @SpreadDesc,8) ELSE 0 END
         ,      Tasa_Venta_CurvaVR  = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@TasaDesc + @SpreadDesc,8) ELSE 0 END
         ,      Activo_FlujoMO      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDesc,4)              ELSE 0 END
         ,      Activo_FlujoUSD     = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDescUSD,4)           ELSE 0 END
         ,      Activo_FlujoCLP     = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDescCLP,0)           ELSE 0 END
         ,      Pasivo_FlujoMO      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDesc,4)              ELSE 0 END 
         ,      Pasivo_FlujoUSD     = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDescUSD,4)           ELSE 0 END
         ,      Pasivo_FlujoCLP     = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDescCLP,0)           ELSE 0 END
         ,      Valor_RazonableMO   = 0
         ,      Valor_RazonableUSD  = 0
         ,      Valor_RazonableCLP  = 0
         WHERE  Numero_Operacion    = @Numero_Operacion
         AND    Numero_Flujo        = @Numero_Flujo
         AND    Tipo_Flujo          = @Tipo_Flujo

         SET @iRegistro = @iRegistro + 1
      END

      --> Calculando valor razonable
      UPDATE #CARTERA_TEMPORAL
      SET    Valor_RazonableMO  = Activo_FlujoMO  - Pasivo_FlujoMO
      ,      Valor_RazonableUSD = Activo_FlujoUSD - Pasivo_FlujoUSD
      ,      Valor_RazonableCLP = Activo_FlujoCLP - Pasivo_FlujoCLP

      SELECT 'NumeroOperacion'   = Numero_Operacion,
             'ValorRazonableMO'  = SUM(Valor_RazonableMO),
             'ValorRazonableUSD' = SUM(Valor_RazonableUSD),
             'ValorRazonableCLP' = SUM(Valor_RazonableCLP)
        INTO #TMP_CARTERA_TEMPORAL
        FROM #CARTERA_TEMPORAL Ctr
       GROUP BY Numero_Operacion

      UPDATE CARTERARES
      SET    Valor_RazonableMOParPrx     = ValorRazonableMO
      ,      Valor_RazonableUSDParPrx    = ValorRazonableUSD
      ,      Valor_RazonableCLPParPrx    = ValorRazonableCLP
      FROM   #TMP_CARTERA_TEMPORAL
      WHERE  Fecha_Proceso               = @Fecha_Proc
        AND  CARTERARES.Numero_Operacion = NumeroOperacion

END
GO
