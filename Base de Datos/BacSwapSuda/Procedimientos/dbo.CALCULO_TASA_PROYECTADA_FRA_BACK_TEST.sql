USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[CALCULO_TASA_PROYECTADA_FRA_BACK_TEST]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CALCULO_TASA_PROYECTADA_FRA_BACK_TEST]
   (   @iNumOper          NUMERIC(9)   
   ,   @iTipoTasa         INTEGER
   ,   @Fecha_Proc        DATETIME
   ,   @Fecha_Prox        DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   --> Fecha de Proceso
   DECLARE @FechaProceso     DATETIME
       SET @FechaProceso     = @Fecha_Proc
   DECLARE @dFechaProceso    DATETIME
       SET @dFechaProceso    = @Fecha_Proc

   --> Deja el Tipo Tasa Sin Efecto Para los Fra
   SET @iTipoTasa = -1

   DECLARE @iTasaProyectada    FLOAT
   DECLARE @dNocional          FLOAT

   --> Valor del Dolar
   DECLARE @DolarObs           FLOAT
   SELECT  @DolarObs           = ISNULL(vmvalor,1)
   FROM    bacparamsuda..VALOR_MONEDA
   WHERE   vmcodigo            = 994
   AND     vmfecha             = @FechaProceso
   --> Valor del Dolar

   --> Valores de Moneda
   SELECT  vmcodigo , vmvalor INTO #MiValorMoneda FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @FechaProceso AND vmcodigo <> 999
   INSERT INTO #MiValorMoneda SELECT 13 , vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @FechaProceso AND vmcodigo  = 994
   INSERT INTO #MiValorMoneda SELECT 999, 1.0
   --> Valores de Moneda

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha         = @dFechaProceso
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)

   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   #MiValorMoneda
   WHERE  vmcodigo      IN(994,995,997,998,999)

   SELECT @DolarObs    = ISNULL(vmvalor,1)
   FROM   #VALOR_TC_CONTABLE
   WHERE  vmcodigo     = 994

   --> ******************************** <--
   --> Calculo de Tasas Proyectadas FRA <--
   --> ******************************** <--
   CREATE TABLE #TasasMonedas
   (   iTasa    FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpread  FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotCom FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotVen FLOAT   NOT NULL DEFAULT(0.0)
   )

   DECLARE @dFechaHoy            DATETIME
   ,       @dFechaCierre         DATETIME
   ,       @dFechaEfectiva       DATETIME
   ,       @dMadurez             DATETIME
   ,       @dSpread              FLOAT
   ,       @iPlazoHolding        INTEGER
   ,       @iMoneda              INTEGER
   ,       @iCodigoTasa          INTEGER
   ,       @iIndiceSpot          FLOAT
   ,       @iTasaPlazoHolding    FLOAT
   ,       @iIndiceProyectado    FLOAT
   ,       @iTasaFijaProyectada  FLOAT
   ,       @iFechaFijacionTasa   DATETIME
   ,       @cProducto            VARCHAR(5)
   ,       @iTipoFlujo           INTEGER
   ,       @iTipoBase            INTEGER

   --> Determina Codigo Tasa Variable a Proyectar
   SELECT  @dFechaHoy            = @FechaProceso
   ,       @dFechaCierre         = cart.Fecha_Cierre
   ,       @dFechaEfectiva       = cart.FechaEfectiva
   ,       @dNocional		 = case when cart.tipo_operacion = 'P' THEN cart.Venta_capital     ELSE cart.Compra_capital     END 
   ,       @dSpread              = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_Spread      ELSE cart.compra_Spread      END
   ,       @dMadurez             = cart.Madurez
   ,       @iMoneda              = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_moneda      ELSE cart.compra_moneda      END
   ,       @iCodigoTasa          = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_codigo_tasa ELSE cart.compra_codigo_tasa END
   ,       @iFechaFijacionTasa   = cart.fecha_fijacion_tasa
   ,       @cProducto            = CASE WHEN cart.tipo_swap = 1 THEN 'ST'
                                        WHEN cart.tipo_swap = 2 THEN 'SM'
                                        WHEN cart.tipo_swap = 3 THEN 'FR'
                                        WHEN cart.tipo_swap = 4 THEN 'SP'
                                   END
   ,       @iTipoFlujo           = CASE WHEN cart.tipo_operacion = 'P' THEN 2 ELSE 1 END
   ,       @iTipoBase            = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_base ELSE cart.compra_base END
   FROM    #CARTERA_TEMPORAL     cart
   WHERE   cart.numero_operacion = @iNumOper
   AND     cart.tipo_flujo       = CASE WHEN cart.tipo_operacion = 'P' THEN 2 ELSE 1 END
   --> Determina Codigo Tasa Variable a Proyectar

   --> Determina Valor Tasa Fija a Proyectar
   DECLARE @iTasaFija            FLOAT
   DECLARE @iTasaVar		 FLOAT
   DECLARE @iPlazoTotal          INTEGER
   DECLARE @iTasaPlazoTotal      FLOAT
   DECLARE @iPlazoPrestamo       INTEGER
   DECLARE @iTasaPlazoPrestamo   FLOAT
   DECLARE @TipoBase             INTEGER

   SELECT  @iTasaFija            = CASE WHEN cart.tipo_operacion = 'P' THEN cart.compra_valor_tasa ELSE cart.venta_valor_tasa  END
   ,       @iTasaVar             = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_valor_tasa  ELSE cart.Compra_valor_tasa END
   ,       @TipoBase             = CASE WHEN cart.tipo_operacion = 'P' THEN Compra_base            ELSE Venta_base             END
   FROM    #CARTERA_TEMPORAL     cart
   WHERE   cart.numero_operacion = @iNumOper
   AND     cart.tipo_flujo       = CASE WHEN cart.tipo_operacion = 'P' THEN 1 ELSE 2 END
   --> Determina Valor Tasa Fija a Proyectar

   SELECT  @iTasaVar             = CASE WHEN cart.tipo_operacion = 'P' THEN cart.venta_valor_tasa ELSE cart.Compra_valor_tasa END
   FROM    #CARTERA_TEMPORAL     cart
   WHERE   cart.numero_operacion = @iNumOper
   AND     cart.tipo_flujo       = CASE WHEN cart.tipo_operacion = 'P' THEN 2 ELSE 1 END
   --> Rescata la tasa Fija hace dias reset

   --> Genera Plazo Holding
   SET @iPlazoHolding = DATEDIFF(DAY,@dFechaHoy,@dFechaEfectiva)
   --> Genera Plazo Holding

   --> Rescate Indice Variable Spot
   SELECT  @iIndiceSpot          = ISNULL(tasa,0.0)
   FROM    BacParamSuda..MONEDA_TASA
   WHERE   sistema               = 'PCS'
   AND     codmon                = @iMoneda
   AND     codtasa               = @iCodigoTasa
   AND     fecha                 = @Fecha_Prox
   --> Rescate Indice Variable Spot

   --> Rescate Tasas a Plazo Holding
   INSERT INTO #TasasMonedas
        EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA    @iMoneda  
                                                ,   @iPlazoHolding
                                                ,   'PCS'
                                                ,   @cProducto
                                                ,   @iTipoTasa
                                                ,   @iTipoFlujo
                                                ,   @iTipoBase 
                                                ,   'C' 
                                                ,   @iCodigoTasa        --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                                ,   'TIR'               --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                                ,   @Fecha_Proc
                                                ,   @Fecha_Prox

   SET    @iTasaPlazoHolding   = 0.0

   SELECT @iTasaPlazoHolding   = ISNULL(iTasa,0.0)
   FROM   #TasasMonedas

   IF @iMoneda = 999
      SET @iTasaPlazoHolding = @iTasaPlazoHolding * 12.0
   --> Rescate Tasas a Plazo Holding

   --> Detemina Base y Plazo Contrato o Plazo Total
   DECLARE @PeriBase           VARCHAR(5)
   DECLARE @PeriDias           VARCHAR(5)
   DECLARE @BaseInteres        FLOAT
   DECLARE @DifDias            INTEGER

   SELECT  @PeriDias           = Dias
   ,       @PeriBase           = Base
   FROM    BASE
   WHERE   Codigo              = @TipoBase

   IF @PeriBase = 'A'
      SET @BaseInteres = 365
   ELSE
      SET @BaseInteres = CONVERT(INTEGER,@PeriBase)

   IF @PeriDias = 'A'
      SET @iPlazoPrestamo = DATEDIFF(DAY,@dFechaEfectiva,@dMadurez)
   ELSE
      EXECUTE DIFDIAS30 @dFechaEfectiva , @dMadurez , @iPlazoPrestamo OUTPUT  
   --> Detemina Base y Plazo Contrato o Plazo Total

   SET @iPlazoTotal = (@iPlazoPrestamo + @iPlazoHolding)


   --> MAP 20061121 Obtener la tasa para el plazo del préstamo @iPlazoPrestamo
   TRUNCATE TABLE #TasasMonedas

   INSERT INTO #TasasMonedas
      EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA   @iMoneda   
                                             ,   @iPlazoPrestamo 
                                             ,   'PCS' 
                                             ,   @cProducto
                                             ,   @iTipoTasa
                                             ,   @iTipoFlujo
                                             ,   @iTipoBase
                                             ,   'C' 
                                             ,   @iCodigoTasa        --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                             ,   'TIR'               --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                             ,   @Fecha_Proc
                                             ,   @Fecha_Prox

   SET    @iTasaPlazoPrestamo   = 0
   SELECT @iTasaPlazoPrestamo   = ISNULL(iTasa,0.0)
   FROM   #TasasMonedas

   IF @iMoneda = 999 
      SET @iTasaPlazoPrestamo = @iTasaPlazoPrestamo * 12.0  

   --> MAP 20061121 Obtener la tasa para el plazo del préstamo @iPlazoTotal
   TRUNCATE TABLE #TasasMonedas

   INSERT INTO #TasasMonedas
      EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA   @iMoneda   
                                             ,   @iPlazoTotal 
                                             ,   'PCS' 
                                             ,   @cProducto
                                             ,   @iTipoTasa
                                             ,   @iTipoFlujo
                                             ,   @iTipoBase
                                             ,   'C' 
                                             ,   @iCodigoTasa        --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                             ,   'TIR'               --> Adrián Fecha : 30-04-2008.- (FALTO EN HOMOLOGACION ORIGINAL)
                                             ,   @Fecha_Proc
                                             ,   @Fecha_Prox

   SET    @iTasaPlazoTotal   = 0
   SELECT @iTasaPlazoTotal   = ISNULL(iTasa,0.0)
   FROM   #TasasMonedas

   IF @iMoneda = 999 
      SET @iTasaPlazoTotal = @iTasaPlazoTotal * 12.0 

   --> Genera Proyección de la Tasa Variable a la fecha efectiva
   SET @iIndiceProyectado   = 0.0

   --> Calcula de la tasa implícita
   SET @iIndiceProyectado   = (   (1.0 + (@iTasaPlazoTotal   / 100.0) * (@iPlazoTotal   / 360.0))
                                / (1.0 + (@iTasaPlazoHolding / 100.0) * (@iPlazoHolding / 360.0))
                                   - 1.0
                              ) * 360.0 /  @iPlazoPrestamo * 100
    
   --> Descuenta a la fecha efectiva
   SET @iIndiceProyectado  = @iIndiceProyectado / (1.0 + (@iIndiceProyectado/100.0) * (@iPlazoPrestamo/360.0))
   --> Genera Proyección de la Tasa Variable

   --> Genera Descuento de la Tasa Fija a la fecha efectiva
   SET @iTasaFijaProyectada = 0.0
   SET @iTasaFijaProyectada = @iTasaFija        / (1.0 + (@iIndiceProyectado/100.0) * (@iPlazoPrestamo/360.0) )
   --> Genera Proyección de la Tasa Fija

   DECLARE @iIndiceMercadoPlazo FLOAT 
   SET  @iIndiceMercadoPlazo = @iTasaPlazoTotal 

   IF @iPlazoHolding = 0  -- COMPENSACION !!!
      SET @iIndiceProyectado = @iTasaVar / (1.0 + (@iIndiceProyectado / 100.0) * (@iPlazoPrestamo / 360.0))
   --> Hay que generar compensacion, tomar la tasa variable grabada en el flujo

   --> Actualiza Proyeccion de Indices en la Base de datos
   --> Los flujos quedan posicionados en la fecha efectiva: cuando vence el contrato.
   --> con esto se tiene un C08.
   UPDATE #CARTERA_TEMPORAL
   SET    CompraTasaProyectada = CASE WHEN tipo_operacion = 'T' THEN @iIndiceProyectado   ELSE @iTasaFijaProyectada END
   ,      ventatasaproyectada  = 0	
   ,      compra_mercado_tasa  = @iTasaVar 
   ,      venta_mercado_tasa   = @iTasaVar  
   ,      Compra_interes       = CASE WHEN fecha_fijacion_tasa > @FechaProceso THEN (@dNocional * (@iPlazoPrestamo*1.0) / (@BaseInteres*100.0)) 
                                   * (CASE WHEN tipo_operacion = 'T' THEN @iIndiceProyectado ELSE @iTasaFijaProyectada END) 
                                           ELSE Compra_interes 
                                 END
   WHERE  tipo_flujo           = 1 -- CASE WHEN tipo_operacion = 'T' THEN 1 ELSE 2 END  
   AND    numero_operacion     = @iNumOper 
    --> 'T' Se activa Variable se actualiza registro 1 con indices proyectados
    --> 'P' Se activa Variable se actualiza registro 1 con Tasa Fija descontada

   UPDATE #CARTERA_TEMPORAL
   SET    ventatasaproyectada  = CASE WHEN tipo_operacion = 'T' THEN @iTasaFijaProyectada ELSE @iIndiceProyectado   END
   ,      compratasaproyectada = 0
   ,      compra_mercado_tasa  = @iTasaVar
   ,      venta_mercado_tasa   = @iTasaVar
   ,      venta_interes        = CASE WHEN fecha_fijacion_tasa > @FechaProceso THEN (@dNocional * (@iPlazoPrestamo * 1.0) / (@BaseInteres * 100.0)) 
                                   * (CASE WHEN tipo_operacion = 'T' THEN @iTasaFijaProyectada  ELSE @iIndiceProyectado END) 
                                     ELSE Venta_interes 
                                END
   WHERE  tipo_flujo           = 2 -- CASE WHEN tipo_operacion = 'T' THEN 2 ELSE 1 END
   AND    numero_operacion     = @iNumOper 
    --> 'T' Se Pasiva Fija se actualiza registro 2 con Tasa Fija descontada 
    --> 'P' Se Pasiva Variable se actualiza registro 2 con indices proyectados

   --> Actualiza Proyeccion de Indices en la Base de datos
   SET @iTasaProyectada  = ISNULL(@iIndiceProyectado,0.0)
   --> Calculo de Tasa Proyectada FRA
  
   --> Recalcula los Intereses
   DECLARE @dIniFlujo          DATETIME
   ,       @dFinFlujo          DATETIME
   ,       @SaldoK             FLOAT
   ,       @Spread             FLOAT
   ,       @iPlazo             FLOAT
   ,       @Interes            FLOAT
   ,       @Dolares            FLOAT
   ,       @InteresPesos       NUMERIC(21,4)
   ,       @TipoFlujo          INTEGER
   ,       @TipoTasa           INTEGER
   ,       @iValorTasa         FLOAT
   ,       @nTipBase           INTEGER

   SET     @TipoFlujo  = 1

   WHILE   @TipoFlujo <= 2
   BEGIN
      SELECT  @dIniFlujo          = fecha_inicio_flujo
      ,       @dFinFlujo          = fecha_vence_flujo
      ,       @SaldoK             = CASE WHEN tipo_Flujo = 1 THEN compra_saldo + compra_amortiza
                                         ELSE                     venta_saldo  + venta_amortiza
                                    END
      ,       @TipoBase           = CASE WHEN tipo_Flujo = 1 THEN Compra_base          ELSE Venta_base          END
      ,       @Spread             = CASE WHEN tipo_Flujo = 1 THEN Compra_spread        ELSE Venta_spread        END
      ,       @TipoTasa           = CASE WHEN tipo_Flujo = 1 THEN Compra_codigo_tasa   ELSE Venta_codigo_tasa   END
      ,       @iValorTasa         = CASE WHEN tipo_Flujo = 1 THEN CompraTasaProyectada ELSE VentaTasaProyectada END
      ,       @nTipBase           = CASE WHEN tipo_Flujo = 1 THEN compra_base          ELSE venta_base          END
      FROM    #CARTERA_TEMPORAL
      WHERE   Numero_Operacion    = @iNumOper
      AND     tipo_flujo          = @TipoFlujo --> 1
      AND     Numero_Flujo        = 1

         SELECT @PeriDias   = Dias
         ,      @PeriBase   = Base
         FROM   BASE
         WHERE  Codigo      = @TipoBase

         SET    @iPlazo     = @iPlazoHolding

         IF @PeriBase = 'A'
            SET @BaseInteres = 365
         ELSE
            SET @BaseInteres = CONVERT(INTEGER,@PeriBase)

         IF @PeriDias = 'A'
            SET @DifDias     = DATEDIFF(DAY,@dIniFlujo,@dFinFlujo)
         ELSE
            EXECUTE DIFDIAS30 @dIniFlujo , @dFinFlujo , @DifDias OUTPUT  

         SET @iPlazo     = (@DifDias / @BaseInteres)
         SET @Interes    =  @SaldoK  * ((@iValorTasa + @Spread)/100.0) * (@iPlazo)

         SELECT @InteresPesos = ROUND(@Interes * vmvalor,0)
         FROM   #VALOR_TC_CONTABLE -- #MiValorMoneda
         WHERE  vmcodigo      = @iMoneda

         SET    @Dolares    = @InteresPesos / @DolarObs

      /*END --> Recalculo Automatico ***********************
      ************** Para los FRA recalcularemos siempre *******/
      SET  @TipoFlujo = @TipoFlujo + 1
   END

   -- Calcula Dur Mac - Dur MOd - Convx
   EXECUTE SP_AJUSTA_TASAS_FRA_BACK_TEST   @iNumOper  
                                       ,   @Fecha_Proc
                                       ,   @Fecha_Prox
END
GO
