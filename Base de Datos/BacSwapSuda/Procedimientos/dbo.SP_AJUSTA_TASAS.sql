USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AJUSTA_TASAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AJUSTA_TASAS]
   (   @Numero_Operacion   NUMERIC(9)   
   ,   @SwithEjecucion     INTEGER    = 0 --> 0 = Normal ; 1 = Inicio de Día
   )
AS
BEGIN
	/******************************************
	* Tocado por funcionalidad de Anticipo
	* Cambios marcado con MAP 20071029
	* Se descartan los flujos para liquidar 
	* el anticipo
	*******************************************/

   SET NOCOUNT ON

   --> (0.0) Obtengo Fecha de Proceso
   DECLARE @dFechaProc      DATETIME
   DECLARE @dFechaAnt       DATETIME

   SELECT  @dFechaProc      = fechaproc
   ,       @dFechaAnt       = fechaant
   FROM    SWAPGENERAL
   WHERE   entidad          = '01' 
   AND     codigo           = 'PCS'

   DECLARE @dFechaProceso   DATETIME
   SET     @dFechaProceso   = @dFechaProc

   DECLARE @Spread          FLOAT
   SET     @Spread          = 0.0

   DECLARE @FactorDescuento FLOAT
   SET     @FactorDescuento = 0.0

   DECLARE @iMensaje        VARCHAR(1000)
   SET     @iMensaje        = ''

   DECLARE @iFound          INTEGER
   SET     @iFound          = -1

   SELECT  @iFound          = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE   Fecha            = CASE WHEN @SwithEjecucion = 0 THEN @dFechaProc ELSE @dFechaAnt END
   AND     Tipo_Cambio     <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN
   END

   --> (0.1) Valores de Monedas
   SELECT vmcodigo , vmvalor INTO #MiValorMoneda FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProceso
      UNION
   SELECT 999      , 1.0
      UNION
   SELECT 13       , vmvalor                     FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProceso AND vmcodigo = 994

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo     = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor      = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE  Fecha        = CASE WHEN @SwithEjecucion = 0 THEN @dFechaProc ELSE @dFechaAnt END
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
   AND    Tipo_Cambio  <> 0

   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   #MiValorMoneda
--   WHERE  vmcodigo  IN(994,995,997,998,999)
    WHERE  vmcodigo  IN(995,997,998,999)  -- Cargaba valores distintos para el 994-13


   --> (0.2) Crea Tabla Temporal para las Tasas por Moneda
   CREATE TABLE #TasasMonedas
   (   iTasa    FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpread  FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotCom FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotVen FLOAT   NOT NULL DEFAULT(0.0)
   )
   --> (0.2.0) Crea Tabla Temporal para la Tasa ICP
   CREATE TABLE #TasaICP
   (   iTasaICP    FLOAT   NOT NULL DEFAULT(0.0) )

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

   --> (0.2.5) Obtiene el valor de tasa ICP nominal y reajustable
   DECLARE @TNA          FLOAT
   DECLARE @TRA          FLOAT

   TRUNCATE TABLE #TasaICP
   INSERT INTO #TasaICP  EXECUTE SRV_CALCULO_TPCA 999  
      SELECT @TNA = iTasaICP FROM #TasaICP

   TRUNCATE TABLE #TasaICP
   INSERT INTO #TasaICP  EXECUTE SRV_CALCULO_TPCA 998  
      SELECT @TRA = iTasaICP FROM #TasaICP


   --> (0.3) Genera Cartera Temporal con Todos los Registros de la Cartera para la Operación
   SELECT *
   INTO   #CarteraSwap
   FROM   CARTERA 
   WHERE  Numero_Operacion =  @Numero_Operacion 
   and    estado           <> 'N'	-- MAP 20071029

    IF (SELECT COUNT(1) FROM #CARTERASWAP) = 0 -- ANTICIPO TOTAL, NO VLORICE
        RETURN

   --> (0.4) Se Define Tipo de Flujo, Para Recorrer La Cartera
   DECLARE @iTipoFlujo      INTEGER
   SET     @iTipoFlujo      = 1

   --> Define para Almacenar el Tipo de La Curva (TM, MC)
   DECLARE @TipoCurvaMon       VARCHAR(5)
       SET @TipoCurvaMon       = ''

   --> (0.5) Recorre la Cartera Por Tipo de Flujo
   WHILE   @iTipoFlujo <= 2                              
   BEGIN

      --> (1.0)    Defino el Tipo de la Tasa [Fija = 0; Variable = 1] 
      --> (1.0.1)  Obtengo Moneda de la Pata y ContaMoneda
      DECLARE @TipoTasa        INTEGER
      DECLARE @Moneda          INTEGER
      DECLARE @ContraMoneda    INTEGER
      DECLARE @TipoSwap        INTEGER
      DECLARE @MonedaMx        INTEGER
      DECLARE @BaseMoneda      INTEGER
      DECLARE @iSwAjuste       INTEGER --> [1 = ON] ; [0 = OFF]
      DECLARE @iValorMoneda    FLOAT
      DECLARE @iValorDolar     FLOAT
      DECLARE @RemanentePata   FLOAT
      DECLARE @fTasa           FLOAT
      DECLARE @TipoIndice      NUMERIC(3)
      DECLARE @FechaTermino    DATETIME
      DECLARE @TasaFlujo       FLOAT
      DECLARE @cProducto       VARCHAR(5)

      SELECT  @TipoTasa        = CASE WHEN c.tipo_flujo = 1 THEN CASE WHEN c.compra_codigo_tasa = 0 THEN 0 ELSE 1 END
                                      ELSE                       CASE WHEN c.venta_codigo_tasa  = 0 THEN 0 ELSE 1 END
                                 END
      ,       @TipoIndice      = CASE WHEN c.Tipo_flujo = 1 THEN c.Compra_codigo_tasa ELSE c.Venta_codigo_tasa  END 
      ,       @Moneda          = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda      ELSE c.venta_moneda       END

      ,       @ContraMoneda    = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda      ELSE v.venta_moneda       END
      ,       @BaseMoneda      = CASE WHEN c.tipo_flujo = 1 THEN c.compra_base        ELSE c.venta_base         END
      ,       @TipoSwap        = c.tipo_swap
      ,       @MonedaMx        = CASE WHEN mo.mnmx = 'C' THEN 1 ELSE 0 END
      ,       @iSwAjuste       = CASE WHEN mo.mnmx = 'C' AND cm.mnmx = 'C' THEN 1
                                      WHEN mo.mnmx = ''  AND cm.mnmx = ''  THEN 0
                                      ELSE 1
                                 END
      ,       @iValorMoneda    = ISNULL(vm.vmvalor,0)
      ,       @iValorDolar     = (SELECT do.vmvalor FROM #VALOR_TC_CONTABLE do WHERE do.vmcodigo = 13) -- =994 MAP 20071226 
      ,       @FechaTermino    = c.Fecha_termino                                
      ,       @RemanentePata   = DATEDIFF(DAY,@dFechaProceso,c.Fecha_Termino)
      ,       @Spread          = CASE WHEN @Spread = 0 and @iTipoFlujo = 1 THEN c.compra_spread  
                                      WHEN @Spread = 0 and @iTipoFlujo = 2 THEN c.venta_spread  
                                      ELSE                                      @Spread 
                                 END
      ,       @cProducto       = CASE WHEN c.tipo_swap = 1 THEN 'ST'
                                      WHEN c.tipo_swap = 2 THEN 'SM'
                                      WHEN c.tipo_swap = 3 THEN 'FR'
                                      WHEN c.tipo_swap = 4 THEN 'SP'
                                 END
      FROM    #CarteraSwap           c
             LEFT  JOIN #CarteraSwap v          ON c.tipo_flujo <> v.tipo_flujo
             INNER JOIN BacParamSuda..MONEDA mo ON mo.mncodmon = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
             INNER JOIN BacParamSuda..MONEDA cm ON cm.mncodmon = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda ELSE v.venta_moneda  END
             LEFT  JOIN #VALOR_TC_CONTABLE   vm ON vm.vmcodigo = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
      WHERE  c.tipo_flujo      = @iTipoFlujo

      -- Spread se aplica solame en flujos variables select * from #CarteraSwap
      SET    @Spread    = 0             -- CBB 18122007
      SELECT @Spread    = Compra_spread -- CASE WHEN compra_codigo_tasa <> 0 THEN Compra_spread
                                        --      ELSE                              0
                                        -- END
      FROM   #CarteraSwap
      WHERE  tipo_flujo = 1

      IF @Spread = 0
      BEGIN                               -- CBB 18122007
         SELECT @Spread    = Venta_spread -- CASE WHEN venta_codigo_tasa <> 0 THEN Venta_spread
                                          --      ELSE                             0
                                          -- END
         FROM 	#CarteraSwap
         WHERE  tipo_flujo = 2	
      END

      DECLARE @dFechaVctoFlujo   DATETIME

      SELECT  @dFechaVctoFlujo   = fecha_vence_flujo
      FROM    #CarteraSwap       c 
      WHERE   c.tipo_flujo       = @iTipoFlujo
      /*AND  ((@dFechaProceso    >  Fecha_inicio_flujo AND @dFechaProceso <= Fecha_vence_flujo AND numero_flujo <> 1)
          OR  (@dFechaProceso    >= Fecha_cierre       AND @dFechaProceso <= Fecha_vence_flujo AND numero_flujo  = 1)
            )*/
      AND     c.Estado_Flujo     = 1
      AND     c.Estado          <> 'N' -- MAP 20071226 Evita distorción de anticipo

      IF @TipoTasa = 1 -- Pata Variable implica tomar el plazo remanente del flujo vigente
         SET @RemanentePata = DATEDIFF(DAY, @dFechaProceso, @dFechaVctoFlujo)

      SET @Ftasa = 0.0

      TRUNCATE TABLE #TasasMonedas

      INSERT INTO #TasasMonedas 
         EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA @Moneda, @RemanentePata, 'PCS', @cProducto, @TipoTasa, @iTipoFlujo, @BaseMoneda, 'C', @TipoIndice, 'CERO'  

      SELECT @fTasa = iTasa
      FROM   #TasasMonedas

      --> 
      EXECUTE dbo.SP_RETORNATIPOORIGEN_PCS 'PCS', @cProducto, @Moneda, @TipoTasa, @BaseMoneda, @TipoIndice, @RemanentePata, @dFechaProc, @fTasa, @iTipoFlujo, @TipoCurvaMon OUTPUT  
      UPDATE CARTERA SET OrigenCurva = @TipoCurvaMon 
       WHERE numero_operacion = @Numero_Operacion AND tipo_flujo = @iTipoFlujo
      --> 

      IF @Moneda = 999 
         SET @fTasa = @fTasa --> * 12.0

      IF @iValorMoneda <= 0.0
      BEGIN
         SET       @iMensaje = 'Valor Moneda no Existe para Moneda ' + ltrim(rtrim(@Moneda))
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
      and     Estado          <> 'N' -- MAP 20071229

      --> (1.2) Si La Tasa es Variable, Solo se debe Recalcular el Flujo Vigente y el que vence
      IF @TipoTasa = 1
         SET @iMaxFlujo = @iMinFlujo

      DECLARE @Primero           NUMERIC
      SET     @Primero           = 1

      --> (2.0) Recorre cada uno de los Flujos para la Pata que Corresponda
      WHILE @iMaxFlujo >= @iMinFlujo
      BEGIN
         --> (2.1) Recupero los Datos del Flujo
         DECLARE @nInteres       NUMERIC(21,4)
         DECLARE @nInteresDev    NUMERIC(21,4)
         DECLARE @nCapital       NUMERIC(21,4)
         DECLARE @dFecInicio     DATETIME
         DECLARE @dFecVcto       DATETIME
         DECLARE @iDias          NUMERIC(9)
         DECLARE @iDiasRem       NUMERIC(9)
         DECLARE @iDiasFacDes    NUMERIC(9)
         DECLARE @fTasaAjust     FLOAT
         DECLARE @nAjuste        FLOAT
         DECLARE @nSaldo         NUMERIC(21,4)
         DECLARE @nAmortiza      NUMERIC(21,4)
         DECLARE @nFlujo         NUMERIC(21,4)
         DECLARE @Interes        NUMERIC(21,4)
         DECLARE @Capital        NUMERIC(21,4)
         DECLARE @Tasa           FLOAT
         DECLARE @Perioricidad   FLOAT

         SELECT  @Interes       = CASE WHEN @iTipoFlujo = 1 THEN compra_interes
                                       ELSE                      venta_interes
                                  END
         ,       @Capital       = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + CASE WHEN @TipoTasa = 1 THEN compra_saldo ELSE 0.0 END
                                       ELSE                      venta_amortiza  + CASE WHEN @TipoTasa = 1 THEN venta_saldo  ELSE 0.0 END
                                  END
         ,       @Tasa          = CASE WHEN @iTipoFlujo = 1 THEN compra_valor_tasa
                                       ELSE                      venta_valor_tasa
                                  END
         ,       @nInteres      = CASE WHEN @iTipoFlujo = 1 THEN compra_interes - devengo_compra_acum
                                       ELSE                      venta_interes  - devengo_venta_acum
                                  END
         ,       @nAmortiza     = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza
                                       ELSE                      venta_amortiza
                                  END
         ,       @nSaldo        = CASE WHEN @iTipoFlujo = 1 THEN compra_saldo
                                       ELSE                      venta_saldo
                                  END
         ,       @nInteresDev   = CASE WHEN @iTipoFlujo = 1 THEN devengo_compra_acum
                                       ELSE                      devengo_venta_acum
                                  END
         ,       @nCapital      = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + compra_saldo
                                       ELSE                      venta_amortiza + venta_saldo
                                  END
         ,       @dFecInicio    = Fecha_Inicio_Flujo
         ,       @dFecVcto      = Fecha_Vence_Flujo         
         ,       @iDias         = DATEDIFF(DAY,Fecha_Inicio_Flujo,Fecha_Vence_Flujo)
         ,       @iDiasRem      = DATEDIFF(DAY,@dFechaProceso,Fecha_Vence_Flujo)
	 ,       @iDiasFacDes   = CASE WHEN @Primero = 1 THEN DATEDIFF(DAY,@dFechaProceso    ,Fecha_vence_flujo)
                                       ELSE                   DATEDIFF(DAY,Fecha_Inicio_flujo,Fecha_vence_flujo)
                                  END
         ,       @nAjuste       = 0.0
         ,       @Perioricidad  = (365.0 / ISNULL(Dias,1))
	 ,       @TasaFlujo     = CASE WHEN @iTipoFlujo = 1 THEN compra_valor_tasa  
                                       ELSE                      venta_valor_tasa
                                  END
         FROM    #CarteraSwap 
                 LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ON Sistema = 'PCS' AND tabla = '1044' AND Codigo = CASE WHEN @iTipoFlujo = 1 THEN compra_codamo_interes ELSE venta_codamo_interes END
         WHERE   Tipo_Flujo   = @iTipoFlujo
         AND     Numero_Flujo = @iMinFlujo

 	 IF @TipoIndice = 13 
            SET @fTasa = @TasaFlujo 

 	 IF @TipoSwap = 1   -- MAP20070404 Swap de Tasas IRS
         BEGIN
            IF @tipoIndice <> 0  and @tipoIndice <> 13 
            BEGIN	    -- MAP20070404 Solo si la Pata es con tasa Variable 
               SET    @fTasa  = 0
               SELECT @fTasa  = Tasa 
               FROM   BacParamSuda..MONEDA_TASA
               WHERE  sistema = 'PCS'
               AND    periodo = 1 
               AND    CodMon  = @Moneda
               AND    CodTasa = @TipoIndice
               AND    Fecha   = CASE WHEN @SwithEjecucion = 0 THEN @dFechaProc ELSE @dFechaAnt END

               IF @fTasa <> 0 AND (@tipoIndice = 15 OR @tipoIndice = 10 OR @tipoIndice = 9 OR @tipoIndice = 8)
                  SET @fTasa  = @fTasa -- + @Spread CBB 

               IF @fTasa = 0
               BEGIN
                  RAISERROR('¡ NO EXISTEN VALORES DE TASAS A LA FECHA DE HOY. ! ',16,6,'ERROR.')
                  RETURN
               END
	    END
         END

         --> (2.3) Determino Valor de Ajuste por Periodicidad e Interes
         IF @iSwAjuste = 1
         BEGIN
            IF (@Moneda <> 999 AND @Moneda <> 998)
            BEGIN
               SELECT @nAjuste       = CASE WHEN @iTipoFlujo = 1 THEN ISNULL(Ajuste_Activo,0.0) ELSE ISNULL(Ajuste_Pasivo,0.0) END
               FROM   PERIODICIDAD_TASAS
               WHERE  Tipo_Tasa      = @TipoTasa
               AND   (@iDias         BETWEEN Desde AND Hasta)

               SET    @fTasaAjust    = @fTasa / 100.0 + @nAjuste / 10000.0

               SELECT @nAjuste       = CASE WHEN @iTipoFlujo = 1 THEN ISNULL(Ajuste_Activo,0.0) ELSE ISNULL(Ajuste_Pasivo,0.0) END
               FROM   CONVENCION_AJUSTE_INTERES
               WHERE  Tipo_Tasa      = @TipoTasa
               AND    Base           = @BaseMoneda

               SET    @fTasaAjust    = @fTasaAjust + @nAjuste / 10000.0 + @Spread / 100.0
            END

            --> (2.3.1) Ajuste Especial para los Pesos.
            IF @Moneda = 999
            BEGIN
               SELECT @nAjuste       = ISNULL(Ajuste_Pasivo,0.0)
               FROM   PERIODICIDAD_TASAS   
               WHERE  Tipo_Tasa      = 3
               SELECT @fTasaAjust    = @fTasa / 100.0 + @nAjuste/10000.0 + @Spread / 100.0 -- CBB
            END

            --> (2.3.1) Ajuste Especial para las U.F. 35. ptb
            IF @Moneda = 998
            BEGIN
               SELECT @nAjuste     = ISNULL(Ajuste_Pasivo,0.0)
               FROM   PERIODICIDAD_TASAS
               WHERE  Tipo_Tasa      = 4
               SELECT @fTasaAjust    = @fTasa / 100.0 + @nAjuste/10000.0  + @Spread / 100.0 -- CBB
            END

         END ELSE
         BEGIN
            --> Sin Ajuste.
            SET       @fTasaAjust    = @fTasa / 100.00  + @Spread / 100.0 -- CBB 
         END

         --> (2.2.1) Cálculo Duracion y Convexidad
         DECLARE @FlujoCaja     FLOAT
         DECLARE @iResultadoC   FLOAT
         DECLARE @iResultadoD   FLOAT
         DECLARE @iResultadoE   FLOAT
         DECLARE @iResultadoF   FLOAT
         DECLARE @iResultadoG   FLOAT
         DECLARE @iResultadoH   FLOAT

         SET     @FlujoCaja     = @Interes     + @Capital
         SET     @iResultadoC   = @FlujoCaja   / POWER(1.0   + @fTasaAjust, @iDiasRem  / 360.0 + 2.0)
         SET     @iResultadoD   = @iDiasRem    *  @FlujoCaja / POWER(1.0  + @fTasaAjust,@iDiasRem/360.0)
         SET     @iResultadoE   = @iDiasRem    * (@iDiasRem  +  360.0)    * @FlujoCaja
         SET     @iResultadoF   = @iResultadoE / POWER(1.0   + @fTasaAjust, @iDiasRem  / 360.0)
         SET     @iResultadoG   = @FlujoCaja   / POWER(1.0   + @fTasaAjust, @iDiasRem  / 360.0)
         SET     @iResultadoH   = @fTasa

         DECLARE @iTasaSinAjustar NUMERIC(14,4)
         SET     @iTasaSinAjustar = @fTasa

         --> Compone el Flujo Dependiendo de la Tasa y la Fecha de Vcto.
         IF @TipoTasa <> 0
         BEGIN
            IF @dFecVcto = @dFechaProceso
            BEGIN
               IF @FechaTermino = @dFechaProceso
               BEGIN
                  SET @nFlujo = @nInteres  + @nCapital
               END ELSE 
               BEGIN
                  SET @iMaxFlujo = @iMaxFlujo + 1
                  SET @nFlujo    = @nInteres  + @nAmortiza
               END
            END ELSE
            BEGIN
               SET @nFlujo = @nInteres + @nCapital 
            END
         END ELSE
         BEGIN
            IF @dFecVcto = @FechaTermino
            BEGIN
               SET @nFlujo = @nInteres + @nCapital
            END ELSE
            BEGIN
               SET @nFlujo = @nInteres + @nAmortiza
            END
         END

         SET    @FactorDescuento = 0.0	
         SET    @FactorDescuento = ISNULL((SELECT FactorDescuento FROM #Valores_Flujos AS V WHERE V.Tipoflujo = @iTipoFlujo and V.NumeroFlujo = (@iMinFlujo - 1)),1)
				 / ( 1.0 + @fTasaAjust * @iDiasFacDes / 360.0 )

         --> Genera Flujos de Interes a la Tasa y su Variación
         DECLARE @iValorRazonableMo NUMERIC(21,4)
         DECLARE @iValorRazonableMn NUMERIC(21,4)
         DECLARE @iValorRazonableMx NUMERIC(21,4)
         DECLARE @iTasaAjustada     NUMERIC(21,4)

         SET  @iValorRazonableMo = @FactorDescuento * @nFlujo + @nInteresDev
         SET  @iValorRazonableMn = CONVERT(NUMERIC(21,0),ROUND(@iValorRazonableMo * @iValorMoneda,0))
         SET  @iValorRazonableMx = @iValorRazonableMn / @iValorDolar
         SET  @iTasaAjustada     = CONVERT(NUMERIC(21,4),@fTasaAjust * 100.00 ) -- Presentación o registro en Base de datos

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
	 ,      @RemanentePata                 -- <== Calcular según la convención
	 ,      @iDiasFacDes                    
         ,      @BaseMoneda
         ,      @TasaFlujo

         TRUNCATE TABLE #TasasMonedas

         SET @iMinFlujo = @iMinFlujo + 1
         SET @Primero = 0
      END
      SET @iTipoFlujo   = @iTipoFlujo + 1
   END     --> Fin (0.2)

   DROP TABLE #TasasMonedas

   --> Pata Activa
   UPDATE #Valores_Flujos
   SET    Macaulay      = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0  FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo     = 1

   DECLARE @TasaVarAct  FLOAT
   SET     @TasaVarAct  = ISNULL((SELECT MAX(TasaAjustada) FROM #Valores_Flujos WHERE TipoFlujo = 1 AND Variable = 1),0)

   DECLARE @TasaVarPas  FLOAT
   SET     @TasaVarPas  = ISNULL((SELECT MAX(TasaAjustada) FROM #Valores_Flujos WHERE TipoFlujo = 2 AND Variable = 1),0)

   DECLARE @TasaFijAct  FLOAT
   SET     @TasaFijAct  = 0.0
   SELECT  @TasaFijAct  = TasaAjustada FROM #Valores_Flujos WHERE TipoFlujo = 1 AND Variable = 0 ORDER BY NumeroFlujo

   DECLARE @TasaFijPas  FLOAT
   SET     @TasaFijPas  = 0.0 
   SELECT  @TasaFijPas  = TasaAjustada FROM #Valores_Flujos WHERE TipoFlujo = 2 AND Variable = 0 ORDER BY NumeroFlujo

   UPDATE #Valores_Flujos
   SET    Modificada    = (SELECT (SUM(ResultadoD) / SUM(ResultadoG) / 360.0) / (1.0 + (@TasaVarAct + @TasaFijAct) / 100.0/ MAX(Perioricidad)) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo     = 1
   
   UPDATE #Valores_Flujos
   SET    Convexidad    = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo     = 1

   --> Pata Pasiva
   UPDATE #Valores_Flujos
   SET    Macaulay      = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0   FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo     = 2

   UPDATE #Valores_Flujos
   SET    Modificada    = (SELECT (SUM(ResultadoD) / SUM(ResultadoG)) / 360.0 / (1.0 + (@TasaVarPas + @TasaFijPas) / 100.0 / MAX(Perioricidad) ) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo     = 2
   
   UPDATE #Valores_Flujos
   SET    Convexidad    = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo     = 2

   UPDATE CARTERA
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
  
   UPDATE CARTERA
   SET    vTasaActivaAjusta  = CASE WHEN TipoFlujo = 1 THEN        TasaAjustada ELSE 0 END
   ,      vTasaPasivaAjusta  = CASE WHEN TipoFlujo = 1 THEN 0 ELSE TasaAjustada        END
   FROM   #Valores_Flujos
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = TipoFlujo
   AND    Numero_flujo       = NumeroFlujo

   UPDATE CARTERA
   SET    vRazActivoAjus_Mo  = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vRazActivoAjus_Mn  = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vRazActivoAjus_Do  = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = 1

   UPDATE CARTERA
   SET    vRazPasivoAjus_Mo  = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vRazPasivoAjus_Mn  = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vRazPasivoAjus_Do  = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion
   AND    Tipo_Flujo         = 2

   UPDATE CARTERA
   SET    vRazAjustado_Mo    = (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMo) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE CARTERA
   SET    vRazAjustado_Mn    = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE CARTERA
   SET    vRazAjustado_Do    = (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
                             - (SELECT SUM(ValorRazonableMx) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   UPDATE CARTERA
   SET    vDurMacaulActivo   = (SELECT DISTINCT Macaulay   FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurMacaulPasivo   = (SELECT DISTINCT Macaulay   FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vDurModifiActivo   = (SELECT DISTINCT Modificada FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurModifiPasivo   = (SELECT DISTINCT Modificada FROM #Valores_Flujos WHERE TipoFlujo = 2)
   ,      vDurConvexActivo   = (SELECT DISTINCT Convexidad FROM #Valores_Flujos WHERE TipoFlujo = 1)
   ,      vDurConvexPasivo   = (SELECT DISTINCT Convexidad FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  Numero_Operacion   = @Numero_Operacion

   DROP TABLE #Valores_Flujos 

   /*
   SELECT 'DEBUG'
   ,      TipoFlujo
   ,      NumeroFlujo
   ,      FechaInicio
   ,      FechaVence
   ,      NBInteres               As Interes_total
   ,      NBAmortiza              As Amortizacion
   ,      NBInteres + NBAmortiza  As Ingreso
   ,      NBIntDevengado          As Ya_Devengado
   ,      NBDiasCurva             As Remanente
   ,      NBDiasFacDes            As Dias
   ,      TasaAjustada      
   ,      TasaSinAjustar    
   ,      FactorDescuento
   ,      ValorRazonableMo
   ,      ValorRazonableMn
   ,      ValorRazonableMx
   ,      B.Glosa                As COnvInteres
   FROM   #Valores_Flujos        As A 
   ,      Base                   As B
   WHERE  Codigo                 = NBBaseMOneda
   */     -->    Mantener para futuros seguimientos

END
GO
