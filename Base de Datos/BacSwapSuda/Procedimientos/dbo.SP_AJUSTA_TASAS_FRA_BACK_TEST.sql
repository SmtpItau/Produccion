USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AJUSTA_TASAS_FRA_BACK_TEST]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AJUSTA_TASAS_FRA_BACK_TEST]
   (   @Numero_Operacion   NUMERIC(9)   
   ,   @Fecha_Proc        DATETIME
   ,   @Fecha_Prox        DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FactorDescuento FLOAT
   SELECT  @FactorDescuento = 1.0

   DECLARE @iMensaje        VARCHAR(1000)
   SELECT  @iMensaje        = ''

   --> (0.0) Obtengo Fecha de Proceso
   DECLARE @dFechaProceso   DATETIME

   SELECT  @dFechaProceso   = @Fecha_Proc

   --> (0.1) Valores de Monedas
   SELECT vmcodigo , vmvalor INTO #MiValorMoneda 
   FROM BacParamSuda..VALOR_MONEDA 
   WHERE vmfecha = @dFechaProceso

      UNION
      SELECT 999 , 1.0
      UNION
      SELECT 13 , vmvalor                          
      FROM BacParamSuda..VALOR_MONEDA 
      WHERE vmfecha = @dFechaProceso 
      AND vmcodigo = 994

   --> (0.2) Crea Tabla Temporal para las Tasas por Moneda
   CREATE TABLE #TasasMonedas
   (   iTasa    FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpread  FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotCom FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotVen FLOAT   NOT NULL DEFAULT(0.0)
   )

   --> (0.2.0) Crea Tabla Temporal para la Tasa ICP
   CREATE TABLE #TasaICP
   (   iTasaICP FLOAT   NOT NULL DEFAULT(0.0)   )

   --> (0.2.1) Crea Tabla Para Almacenar los Resultados
   CREATE TABLE #Valores_Flujos
   (   TipoFlujo         INTEGER
   ,   NumeroFlujo       INTEGER
   ,   ValorRazonableMo  NUMERIC(21,4)
   ,   ValorRazonableMn  NUMERIC(21,4)
   ,   ValorRazonableMx  NUMERIC(21,4)
   ,   TasaAjustada      NUMERIC(21,4)
   ,   TasaSinAjustar    NUMERIC(21,4)
   ,   ResultadoC        FLOAT
   ,   ResultadoD        FLOAT
   ,   ResultadoE        FLOAT
   ,   ResultadoF        FLOAT
   ,   ResultadoG        FLOAT
   ,   ResultadoH        FLOAT
   ,   Macaulay          FLOAT
   ,   Modificada        FLOAT
   ,   Convexidad        FLOAT
   ,   Perioricidad      FLOAT
   ,   Variable          NUMERIC(1) -- 1: Variable 0: Fijo
   ,   FactorDescuento   FLOAT
   ,   FechaInicio       DATETIME
   ,   FechaVence        DATETIME 
   ,   InteresDevengado  FLOAT
   ,   InteresXDevengar  FLOAT
   ,   Flujo             FLOAT
   ,   NBInteres         FLOAT
   ,   NBAmortiza        FLOAT
   ,   NBIntDevengado    FLOAT
   ,   NBDiasCurva       FLOAT
   ,   NBDiasFacDes      FLOAT
   ,   NBBaseMoneda      INTEGER
   ,   NBTasaFlujo       FLOAT
   )
   --> (0.2.5) Obtiene el valor de tasa ICP nominal y reajustable MAP 20060928 CN°1

   --> Moneda Pesos
   TRUNCATE TABLE #TasaICP

   INSERT INTO #TasaICP
        EXECUTE SRV_CALCULO_TPCA  999  
                              ,   @Fecha_Proc
                              ,   @Fecha_Prox

   DECLARE @TNA   FLOAT
   SELECT  @TNA = iTasaICP 
     FROM  #TasaICP
   --> Moneda Pesos


   SELECT  '@TNA' = @TNA

   --> Moneda Unidada Fomento
   TRUNCATE TABLE #TasaICP

   INSERT INTO #TasaICP
        EXECUTE SRV_CALCULO_TPCA  998  
                              ,   @Fecha_Proc
                              ,   @Fecha_Prox

   DECLARE @TRA   FLOAT
   SELECT  @TRA   = iTasaICP 
   FROM    #TasaICP
   --> Moneda Unidada Fomento


   --> (0.3) Genera Cartera Temporal con Todos los Registros de la Cartera para la Operación
   SELECT *
   INTO   #CarteraSwap
   FROM   #CARTERA_TEMPORAL
   WHERE  Numero_Operacion = @Numero_Operacion

   CREATE NONCLUSTERED INDEX CARTERASWAP_001 ON #CARTERASWAP(numero_flujo,iTipoFlujo)

   --> (0.4) Se Define Tipo de Flujo, Para Recorrer La Cartera
   DECLARE @iTipoFlujo      INTEGER
   SET     @iTipoFlujo      = 1

   --> (0.5) Recorre la Cartera Por Tipo de Flujo
   WHILE   @iTipoFlujo <= 2
   BEGIN
      --> (1.0)    Defino el Tipo de la Tasa [Fija = 0; Variable = 1]
      --> (1.0.1)  Obtengo Moneda de la Pata y ContraMoneda
      DECLARE @TipoTasa        INTEGER
      DECLARE @Moneda          INTEGER
      DECLARE @ContraMoneda    INTEGER
      DECLARE @TipoSwap        INTEGER
      DECLARE @MonedaMx        INTEGER
      DECLARE @BaseMoneda      INTEGER
      DECLARE @iSwAjuste       INTEGER      --> [1 = ON] ; [0 = OFF]
      DECLARE @iValorMoneda    FLOAT
      DECLARE @iValorDolar     FLOAT
      DECLARE @RemanentePata   FLOAT
      DECLARE @fTasa           FLOAT
      DECLARE @TipoIndice      NUMERIC(3)
      DECLARE @FechaTermino    DATETIME
      DECLARE @cProducto       VARCHAR(5)

      SELECT  @TipoTasa        = CASE WHEN c.tipo_flujo = 1 THEN CASE WHEN c.compra_codigo_tasa = 0 THEN 0 ELSE 1 END
                                      ELSE                       CASE WHEN c.venta_codigo_tasa  = 0 THEN 0 ELSE 1 END
                                 END
      ,       @TipoIndice      = CASE WHEN c.Tipo_flujo = 1 THEN c.Compra_codigo_tasa ELSE c.Venta_codigo_tasa END 
      ,       @Moneda          = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda      ELSE c.venta_moneda      END

      ,       @ContraMoneda    = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda      ELSE v.venta_moneda      END
      ,       @BaseMoneda      = CASE WHEN c.tipo_flujo = 1 THEN c.compra_base        ELSE c.venta_base        END
      ,       @TipoSwap        = c.tipo_swap
      ,       @MonedaMx        = CASE WHEN mo.mnmx =  'C'   THEN 1
                                      WHEN mo.mnmx <> 'C'   THEN 0
                                 END
      ,       @iSwAjuste       = CASE WHEN mo.mnmx = 'C' AND cm.mnmx = 'C' THEN 1
                                      WHEN mo.mnmx = ''  AND cm.mnmx = ''  THEN 0
                                      ELSE                                      1
                                 END
      ,       @iValorMoneda    = ISNULL(vm.vmvalor,0)
      ,       @iValorDolar     = (SELECT do.vmvalor FROM #MiValorMoneda do WHERE do.vmcodigo = 994)
      ,       @FechaTermino    = c.Fecha_termino
       --> La fecha de pago de la compensa, generalmente es igual a la fecha efectiva
      ,       @RemanentePata   = DATEDIFF(DAY,@dFechaProceso,c.FechaLiquidacion )  
      ,       @cProducto       = CASE WHEN c.tipo_swap = 1 THEN 'ST'
                                      WHEN c.tipo_swap = 2 THEN 'SM'
                                      WHEN c.tipo_swap = 3 THEN 'FR'
                                      WHEN c.tipo_swap = 4 THEN 'SP'
                                 END
      FROM    #CarteraSwap                    c
              LEFT  JOIN #CarteraSwap         v  ON c.tipo_flujo <> v.tipo_flujo
              INNER JOIN BacParamSuda..MONEDA mo ON mo.mncodmon   = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
              INNER JOIN BacParamSuda..MONEDA cm ON cm.mncodmon   = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda ELSE v.venta_moneda  END
              LEFT  JOIN #MiValorMoneda       vm ON vm.vmcodigo   = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
      WHERE   c.tipo_flujo     = @iTipoFlujo

      DECLARE @dFechaVenceFlujo DATETIME

      --> La fecha de pago de la compensa, generalmente es igual a la fecha efectiva
      SELECT  @dFechaVenceFlujo = fechaLiquidacion  
      FROM    #CarteraSwap c 
      WHERE   c.tipo_flujo      = @iTipoFlujo

      SET     @fTasa = 0.0

      TRUNCATE TABLE #TasasMonedas

      INSERT INTO #TasasMonedas
           EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDA   @Moneda  
                                                ,     @RemanentePata 
                                                ,     'PCS' 
                                                ,     @cProducto
                                                ,     @TipoTasa
                                                ,     @BaseMoneda
                                                ,     0
                                                ,     'C'
                                                ,     @TipoIndice           --> No se habian Agregado.  Adrián 30-04-2008
                                                ,     'TIR'                 --> No se habian Agregado.  Adrián 30-04-2008
                                                ,     @Fecha_Proc
                                                ,     @Fecha_Prox

      SELECT  @fTasa = iTasa 
      FROM    #TasasMonedas

      IF @Moneda = 999 
         SET @fTasa = (@fTasa * 12.0)

      IF @iValorMoneda <= 0.0
      BEGIN
         SET    @iMensaje = 'Valor Moneda no Existe para Moneda ' + LTRIM(RTRIM(@Moneda))
         RAISERROR(@iMensaje,16,1,@iMensaje)
         RETURN
      END

      --> (1.1) Obtengo La Cantidad de Flujos A Recorrer
      DECLARE @iMinFlujo       INTEGER
      DECLARE @iMaxFlujo       INTEGER

      SET     @iMinFlujo       = 0
      SET     @iMaxFlujo       = 0

      SELECT  @iMinFlujo       = MIN(Numero_Flujo)
      ,       @iMaxFlujo       = MAX(Numero_Flujo)
      FROM    #CarteraSwap
      WHERE   Tipo_Flujo       = @iTipoFlujo

      --> (2.0) Recorre cada uno de los Flujos para la Pata que Corresponda
      DECLARE @Primero         INTEGER
      SET     @Primero         = 1

      WHILE @iMaxFlujo >= @iMinFlujo
      BEGIN

         --> (2.1) Recupero los Datos del Flujo
         DECLARE @nInteres       NUMERIC(21,4)
         ,       @nInteresDev    NUMERIC(21,4)
         ,       @nCapital       NUMERIC(21,4)
         ,       @dFecInicio     DATETIME
         ,       @dFecVcto       DATETIME
         ,       @iDias          NUMERIC(9)
         ,       @iDiasRem       NUMERIC(9)
	 ,       @iDiasFacDes    NUMERIC(9)
      -- ,       @fTasa          FLOAT
         ,       @fTasaAjust     FLOAT
         ,       @nAjuste        FLOAT
         ,       @nSaldo         NUMERIC(21,4)
         ,       @nAmortiza      NUMERIC(21,4)
         ,       @nFlujo         NUMERIC(21,4)
         ,       @Interes        NUMERIC(21,4)
         ,       @Capital        NUMERIC(21,4)
         ,       @Tasa           FLOAT
         ,       @Perioricidad   FLOAT
         ,       @Nocionales     NUMERIC(21,4)
         ,       @iMoneda        INTEGER 
         ,       @iTProyectada   FLOAT
         ,       @dFechaEfectiva DATETIME
         ,       @dMadurez       DATETIME
         ,       @TasaFlujo      FLOAT
         ,       @TipoBase       INTEGER

         SELECT  @Interes        = CASE WHEN @iTipoFlujo = 1 THEN compra_interes
                                        ELSE                      venta_interes
                                   END
         ,       @Capital        = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + CASE WHEN @TipoTasa = 1 THEN compra_saldo ELSE 0.0 END
                                        ELSE                      venta_amortiza  + CASE WHEN @TipoTasa = 1 THEN venta_saldo  ELSE 0.0 END
                                   END
         ,       @Tasa           = CASE WHEN @iTipoFlujo = 1 THEN compra_valor_tasa
                                        ELSE                      venta_valor_tasa
                                   END
         ,       @nInteres       = CASE WHEN @iTipoFlujo = 1 THEN compra_interes 
                                        ELSE                      venta_interes  
                                   END
         ,       @nAmortiza      = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza
                                        ELSE                      venta_amortiza
                                   END
         ,       @nSaldo         = CASE WHEN @iTipoFlujo = 1 THEN compra_saldo
                                        ELSE                      venta_saldo
                                   END
         ,       @nInteresDev    = CASE WHEN @iTipoFlujo = 1 THEN devengo_compra_acum
                                        ELSE                      devengo_venta_acum
                                   END
         ,       @nCapital       = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + compra_saldo
                                        ELSE                      venta_amortiza  + venta_saldo
                                   END
         ,       @dFecInicio     = Fecha_Inicio_Flujo
         ,       @dFecVcto       = Fecha_Vence_Flujo    
         ,       @iDias          = DATEDIFF(DAY,Fecha_Inicio_Flujo,Fecha_Vence_Flujo)
         ,       @iDiasRem       = DATEDIFF(DAY,@dFechaProceso,FechaLiquidacion) -- Solo para los FRA
         ,       @iDiasFacDes    = DATEDIFF(DAY,@dFechaProceso,FechaLiquidacion) -- Solo para los FRA
       --,       @fTasa          = 0.0
         ,       @nAjuste        = 0.0
         ,       @Perioricidad   = (65.0 / Dias)
	 ,       @TasaFlujo      = CASE WHEN @iTipoFlujo    = 1   THEN compra_valor_tasa
                                        ELSE                           venta_valor_tasa
                                   END
         ,       @Nocionales     = CASE WHEN Tipo_Flujo     = 1   THEN compra_capital
                                        ELSE                           venta_capital
                                   END
         ,       @iTProyectada   = CASE WHEN Tipo_Operacion  = 'T' AND Tipo_Flujo = 1 THEN CompraTasaProyectada
                                        WHEN Tipo_Operacion <> 'T' AND Tipo_Flujo = 1 THEN VentaTasaProyectada
                                        WHEN Tipo_Operacion  = 'T' AND Tipo_Flujo = 2 THEN VentaTasaProyectada
                                        WHEN Tipo_Operacion <> 'T' AND Tipo_Flujo = 2 THEN CompraTasaProyectada
                                   END
         ,       @TipoBase       = CASE WHEN Tipo_Flujo     = 1   THEN venta_base
                                        ELSE                           compra_base
                                   END
         ,       @dFechaEfectiva = FechaEfectiva
         ,       @dMadurez       = Madurez
         FROM    #CarteraSwap
                 LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ON Sistema = 'PCS' AND tabla = '1044' AND Codigo = CASE WHEN @iTipoFlujo = 1 THEN compra_codamo_interes ELSE venta_codamo_interes END
         WHERE   Tipo_Flujo      = @iTipoFlujo
         AND     Numero_Flujo    = @iMinFlujo

 	 IF @TipoIndice = 13
         BEGIN
         -- SELECT @iDiasRem  = 1
            SET @fTasa = @TasaFlujo
	 END

         --> Sin Ajuste.
         SET @fTasaAjust = @fTasa / 100.00 -- Se están dividiendo todas las tasas por 100.00

         --> (2.2.1) Cálculo Duracion y Convexidad
         DECLARE @FlujoCaja      FLOAT
         DECLARE @iResultadoC    FLOAT
         DECLARE @iResultadoD    FLOAT
         DECLARE @iResultadoE    FLOAT
         DECLARE @iResultadoF    FLOAT
         DECLARE @iResultadoG    FLOAT
         DECLARE @iResultadoH    FLOAT

         SET     @FlujoCaja   = @Interes   
         SET     @iResultadoC = @FlujoCaja              / POWER(1.0 + @fTasaAjust, @iDiasRem / 360.0 + 2.0)           
         SET     @iResultadoD = @iDiasRem  * @FlujoCaja / POWER(1.0 + @fTasaAjust, @iDiasRem / 360.0)           -- Numerador Duration
         SET     @iResultadoE = @iDiasRem  * (@iDiasRem + 360.0) * @FlujoCaja
         SET     @iResultadoF = @iResultadoE            / POWER(1.0 + @fTasaAjust, @iDiasRem / 360.0)           -- Numerador Convexidad
         SET     @iResultadoG = @FlujoCaja              / POWER(1.0 + @fTasaAjust, @iDiasRem / 360.0)           -- Denominador Convexidad y Duration
         SET     @iResultadoH = @fTasa
         --> ***************************************

         DECLARE @iTasaSinAjustar  NUMERIC(14,4)
         SET     @iTasaSinAjustar  = @fTasa

         SET     @nFlujo           = @nInteres -- + @nCapital
         SET     @FactorDescuento  = 1.0 / (1.0 + @fTasaAjust * @iDiasRem / 360.0)

         --> Genera Flujos de Interes a la Tasa y su Variación
         DECLARE @iValorRazonableMo NUMERIC(21,4)
         DECLARE @iValorRazonableMn NUMERIC(21,4)
         DECLARE @iValorRazonableMx NUMERIC(21,4)
         DECLARE @iTasaAjustada     NUMERIC(21,4)

         SET     @iValorRazonableMo = @FactorDescuento * @nFlujo 
         SET     @iValorRazonableMn = CONVERT(NUMERIC(21,0),ROUND(@iValorRazonableMo * @iValorMoneda,0))
         SET     @iValorRazonableMx = @iValorRazonableMn / @iValorDolar
         SET     @iTasaAjustada     = CONVERT(NUMERIC(21,4),@fTasaAjust * 100.00 ) -- Presentación o registro en Base de datos

         --> Inserta los Resultados para los flujos
         INSERT INTO #Valores_Flujos
         SELECT @iTipoFlujo
         ,      @iMinFlujo
         ,      @iValorRazonableMo
         ,      @iValorRazonableMn
         ,      @iValorRazonableMx
         ,      @iTasaAjustada
         ,      @iTasaSinAjustar
         ,      @iResultadoC
         ,      @iResultadoD
         ,      @iResultadoE
         ,      @iResultadoF
         ,      @iResultadoG
         ,      @iResultadoH
         ,      0.0
         ,      0.0
         ,      0.0
         ,      @Perioricidad
         ,      @TipoTasa
	 ,      @FactorDescuento
	 ,      @dFecInicio  
         ,      @dFecVcto    
	 ,      @nInteresDev
         ,      @nInteres
	 ,      @nFlujo
	 ,      @Interes         
	 ,      CASE WHEN @TipoTasa = 1 THEN @nCapital ELSE @nAmortiza END
	 ,      @nInteresDev    
	 ,      @RemanentePata
	 ,      @iDiasFacDes                    
         ,      @BaseMoneda
         ,      @TasaFlujo

         TRUNCATE TABLE #TasasMonedas

         SET    @iMinFlujo = @iMinFlujo + 1
         SET    @Primero = 0
      END

      SET @iTipoFlujo   = @iTipoFlujo + 1
   END     --> Fin (0.2)                        

   DROP TABLE #TasasMonedas

   --> Pata Activa
   --> Falta Dividir nuevamente por la perioricidad
   UPDATE #Valores_Flujos
   SET    Macaulay     = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0  FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo    = 1

   DECLARE @TasaVarAct FLOAT  -- Poner la tasa máxima para que tome la única que hay
   SET     @TasaVarAct = ISNULL((SELECT MAX(TasaAjustada) FROM #Valores_Flujos WHERE TipoFlujo = 1 AND Variable = 1),0)

   DECLARE @TasaVarPas FLOAT
   SET     @TasaVarPas = ISNULL((SELECT MAX(TasaAjustada) FROM #Valores_Flujos WHERE TipoFlujo = 2 AND Variable = 1),0)

   DECLARE @TasaFijAct FLOAT  -- Poner la tasa más lejana
   SET     @TasaFijAct = 0.0
   SELECT  @TasaFijAct = TasaAjustada FROM #Valores_Flujos WHERE TipoFlujo = 1 AND Variable = 0 ORDER BY NumeroFlujo 

   DECLARE @TasaFijPas FLOAT
   SET     @TasaFijPas = 0.0 
   SELECT  @TasaFijPas = TasaAjustada FROM #Valores_Flujos WHERE TipoFlujo = 2 AND Variable = 0 ORDER BY NumeroFlujo 

   UPDATE #Valores_Flujos   
   SET    Modificada   = (SELECT (SUM(ResultadoD) / SUM(ResultadoG) / 360.0) /  (1.0 + (@TasaVarAct + @TasaFijAct) /100.0 / MAX(Perioricidad))
                           FROM   #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo    = 1
   
   UPDATE #Valores_Flujos
   SET    Convexidad = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo  = 1

   --> Pata Pasiva
   UPDATE #Valores_Flujos
   SET    Macaulay   = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0          FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2

   UPDATE #Valores_Flujos
   SET    Modificada = (SELECT (SUM(ResultadoD) / SUM(ResultadoG)) / 360.0 /  (1.0 + (@TasaVarPas + @TasaFijPas) /100.0 / MAX(Perioricidad)) 
                         FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2
   
   UPDATE #Valores_Flujos
   SET    Convexidad = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2

   --> ************************************************
   --> SACAR COMENTARIOS UNA VEZ ALTERADAS LAS CARTERAS
   --> ************************************************
   --> Genera Actualización a la Cartera

   UPDATE #CARTERA_TEMPORAL
   SET    vRazAjustado_Mo    = 0.0
   ,      vRazAjustado_Mn    = 0.0
   ,      vRazAjustado_Do    = 0.0
   ,      vRazActivoAjus_Mo  = 0.0
   ,      vRazPasivoAjus_Mo  = 0.0
   ,      vRazActivoAjus_Mn  = 0.0
   ,      vRazPasivoAjus_Mn  = 0.0
   ,      vRazActivoAjus_Do  = 0.0
   ,      vRazPasivoAjus_Do  = 0.0
   ,      vTasaActivaAjusta  = 0.0
   ,      vTasaPasivaAjusta  = 0.0
   ,      vDurMacaulActivo   = 0.0
   ,      vDurMacaulPasivo   = 0.0
   ,      vDurModifiActivo   = 0.0
   ,      vDurModifiPasivo   = 0.0
   ,      vDurConvexActivo   = 0.0
   ,      vDurConvexPasivo   = 0.0
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE #CARTERA_TEMPORAL
   SET    vTasaActivaAjusta  = CASE WHEN TipoFlujo = 1 THEN TasaAjustada ELSE 0            END
   ,      vTasaPasivaAjusta  = CASE WHEN TipoFlujo = 1 THEN 0            ELSE TasaAjustada END
   FROM   #Valores_Flujos
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = TipoFlujo
   AND    Numero_flujo       = NumeroFlujo

   UPDATE #CARTERA_TEMPORAL
   SET    vRazActivoAjus_Mo  = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vRazActivoAjus_Mn  = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vRazActivoAjus_Do  = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = 1

   UPDATE #CARTERA_TEMPORAL
   SET    vRazPasivoAjus_Mo  = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vRazPasivoAjus_Mn  = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vRazPasivoAjus_Do  = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = 2

   UPDATE #CARTERA_TEMPORAL
   SET    vRazAjustado_Mo    = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE #CARTERA_TEMPORAL
   SET    vRazAjustado_Mn    = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE #CARTERA_TEMPORAL
   SET    vRazAjustado_Do    = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE #CARTERA_TEMPORAL
   SET    vDurMacaulActivo   = (SELECT DISTINCT Macaulay     FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurMacaulPasivo   = (SELECT DISTINCT Macaulay     FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vDurModifiActivo   = (SELECT DISTINCT Modificada   FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurModifiPasivo   = (SELECT DISTINCT Modificada   FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vDurConvexActivo   = (SELECT DISTINCT Convexidad   FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurConvexPasivo   = (SELECT DISTINCT Convexidad   FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   DROP TABLE #Valores_Flujos 

END
GO
