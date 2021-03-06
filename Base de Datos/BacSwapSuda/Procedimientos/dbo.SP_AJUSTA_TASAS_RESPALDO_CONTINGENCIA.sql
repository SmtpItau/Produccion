USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AJUSTA_TASAS_RESPALDO_CONTINGENCIA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AJUSTA_TASAS_RESPALDO_CONTINGENCIA]
 (   
    @Numero_Operacion   NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iMensaje        VARCHAR(1000)
   SELECT  @iMensaje        = ''

   --> (0.0) Obtengo Fecha de Proceso
   DECLARE @dFechaProceso   DATETIME
   SELECT  @dFechaProceso   = FechaProc
   FROM    SwapGeneral

   --> (0.1) Valores de Monedas
   SELECT vmcodigo , vmvalor INTO #MiValorMoneda FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProceso
      UNION
   SELECT 999 , 1.0
      UNION
   SELECT 13 , vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProceso AND vmcodigo = 994

   --> (0.2) Crea Tabla Temporal para las Tasas por Moneda
   CREATE TABLE #TasasMonedas
   (   iTasa    FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpread  FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotCom FLOAT   NOT NULL DEFAULT(0.0)
   ,   iSpotVen FLOAT   NOT NULL DEFAULT(0.0)
   )
   --> (0.2.0) Crea Tabla Temporal para la Tasa ICP -- MAP N°1 20060928
   CREATE TABLE #TasaICP
   (   iTasaICP    FLOAT   NOT NULL DEFAULT(0.0)
   )

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
   ,   Variable          NUMERIC(1) -- 1: Variable 0: Fijo  MAP 20060822
   )

   --> (0.2.5) Obtiene el valor de tasa ICP nominal y reajustable MAP 20060928 CN°1
   DELETE #TasaICP
   Declare @TNA Float -- Tasa 
   Declare @TRA Float
   INSERT INTO #TasaICP   
   EXECUTE SRV_CALCULO_TPCA 999  
   SELECT  @TNA = iTasaICP FROM #TasaICP
   DELETE #TasaICP
   INSERT INTO #TasaICP   
   EXECUTE SRV_CALCULO_TPCA 998  
   SELECT  @TRA = iTasaICP FROM #TasaICP

   --> (0.3) Genera Cartera Temporal con Todos los Registros de la Cartera para la Operación
   SELECT *
   INTO   #CarteraSwap
   FROM   CARTERA 
   WHERE  Numero_Operacion = @Numero_Operacion

   --> (0.4) Se Define Tipo de Flujo, Para Recorrer La Cartera
   DECLARE @iTipoFlujo      INTEGER
   SELECT  @iTipoFlujo      = 1

   --> (0.5) Recorre la Cartera Por Tipo de Flujo
   WHILE   @iTipoFlujo <= 2                              
   BEGIN
      --> (1.0)    Defino el Tipo de la Tasa [Fija = 0; Variable = 1] 
      --> (1.0.1)  Obtengo Moneda de la Pata y ContaMoneda
      DECLARE @TipoTasa        INTEGER
      ,       @Moneda          INTEGER
      ,       @ContraMoneda    INTEGER
      ,       @TipoSwap        INTEGER
      ,       @MonedaMx        INTEGER
      ,       @BaseMoneda      INTEGER
      ,       @iSwAjuste       INTEGER --> [1 = ON] ; [0 = OFF]
      ,       @iValorMoneda    FLOAT
      ,       @iValorDolar     FLOAT
      ,       @RemanentePata   FLOAT        --> MAP 20060928 CN°2
      ,       @fTasa           FLOAT        --> MAP 20060928 CN°2
      ,       @TipoIndice      NUMERIC(3)   --> MAP 20060928 CN°1
      ,       @FechaTermino    DATETIME     --> MAP 20060928 CN°2

      SELECT  @TipoTasa        = CASE WHEN c.tipo_flujo = 1 THEN CASE WHEN c.compra_codigo_tasa = 0 THEN 0 ELSE 1 END
                                      ELSE                       CASE WHEN c.venta_codigo_tasa  = 0 THEN 0 ELSE 1 END
                                 END
      --> MAP 20060928 CN°1
      ,       @TipoIndice      = CASE WHEN c.Tipo_flujo = 1 THEN c.Compra_codigo_tasa ELSE c.Venta_codigo_tasa END 
      ,       @Moneda          = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda END
      ,       @ContraMoneda    = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda ELSE v.venta_moneda END
      ,       @BaseMoneda      = CASE WHEN c.tipo_flujo = 1 THEN c.compra_base   ELSE c.venta_base   END
      ,       @TipoSwap        = c.tipo_swap
      ,       @MonedaMx        = CASE WHEN mo.mnmx = 'C' THEN 1 ELSE 0 END
      ,       @iSwAjuste       = CASE WHEN mo.mnmx = 'C' AND  cm.mnmx = 'C' THEN 1
                                      WHEN mo.mnmx = ''  AND  cm.mnmx = ''  THEN 0  ELSE 1
                                 END
      ,       @iValorMoneda    = ISNULL(vm.vmvalor,0)
      ,       @iValorDolar     = (SELECT do.vmvalor FROM #MiValorMoneda do WHERE do.vmcodigo = 994)
      --> MAP 20060928 CN°2                   
      ,       @FechaTermino    = c.Fecha_termino                                
      --> MAP 20060928 CN°2                                         
      ,       @RemanentePata   = datediff( dd, @dFechaProceso, c.Fecha_Termino )
      FROM    #CarteraSwap           c
              LEFT JOIN #CarteraSwap v          ON c.tipo_flujo <> v.tipo_flujo
             INNER JOIN BacParamSuda..MONEDA mo ON mo.mncodmon = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
             INNER JOIN BacParamSuda..MONEDA cm ON cm.mncodmon = CASE WHEN v.tipo_flujo = 1 THEN v.compra_moneda ELSE v.venta_moneda  END
             LEFT  JOIN #MiValorMoneda     vm ON vm.vmcodigo = CASE WHEN c.tipo_flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda  END
      WHERE   c.tipo_flujo     = @iTipoFlujo

      --> MAP 20060927 CN°2
      if @TipoTasa = 1 -- Pata Variable implica tomar el plazo remanente del flujo vigente  
         select @RemanentePata = datediff( dd, @dFechaProceso, ( select fecha_vence_flujo from #CarteraSwap c 
                                                         where c.tipo_flujo = @iTipoFlujo
                                                         and (  ( @dFechaProceso > Fecha_inicio_flujo and @dFechaProceso <= Fecha_vence_flujo and numero_flujo <> 1 )         
                                                             or ( @dFechaProceso >= Fecha_cierre and @dFechaProceso <= Fecha_vence_flujo and numero_flujo = 1 ) 
                                                              ) ) )      
      select @Ftasa = 0.0
      DELETE #TasasMonedas
      INSERT INTO #TasasMonedas
      EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDA @Moneda, @RemanentePata  
      SELECT  @fTasa = iTasa
      FROM   #TasasMonedas
      IF   @Moneda = 999 SELECT @fTasa = @fTasa * 12.0


      --> MAP 20060928 CN°1                                               
      if @TipoIndice in ( select tbtasa from BacParamSuda..Tabla_general_detalle 
                           where TbCateg = 1042   -- Indices de Swap   -- Tasas TAB N°17
                           and TbGlosa like '%TAB%' )
      begin
         -->     (6.0)   Obtiene el Valor de la Tasa... Si no Existe Aborta el Proceso
         -->             No hay procedimiento que encapsule esto, se pone directo
         DECLARE @iValorTasa         FLOAT
         ,       @iFound             INTEGER

         SELECT  @iFound             = -1
         SELECT  @iValorTasa         = ISNULL(tasa,0.0)
         ,       @iFound             = 0
         FROM    BacParamSuda..MONEDA_TASA
         WHERE   codmon              = @Moneda
         AND     codtasa             = @TipoIndice
         AND     fecha               = @dFechaProceso
         AND     periodo             = 4 --> Mensual en la Pantalla de Valores de Tasas por Moneda.

         IF @iFound = -1 OR isnull(@iValorTasa,0.0) = 0.0
         BEGIN
            SELECT  @iMensaje        = CONVERT(VARCHAR(100),'Valor de Tasa en TAB XXX a la fecha : ' + CONVERT(CHAR(10),@dFechaProceso,103) + ' Rel. Moneda : ' + LTRIM(RTRIM(@Moneda)))
            select  @iMensaje
            select 'RETURN -1 Sacar esto !!' --
         END      
         select @ftasa = @iValorTasa  --  En formato anual para cualquier moneda
      end  
      if @TipoIndice in ( 13   ) 
      begin -- Tasas ICP N°17
         if @Moneda = 999 select @ftasa = @TNA
         if @Moneda = 998 select @ftasa = @TRA
      end      
            


      IF @iValorMoneda <= 0.0
      BEGIN
         SELECT    @iMensaje = 'Valor Moneda no Existe para Moneda ' + ltrim(rtrim(@Moneda))
         RAISERROR(@iMensaje,16,1,@iMensaje)
         RETURN
      END

      --> (1.1) Obtengo La Cantidad de Flujos A Recorrer
      DECLARE @iMinFlujo       INTEGER
      ,       @iMaxFlujo       INTEGER
      SELECT  @iMinFlujo       = 0
      ,       @iMaxFlujo       = 0
      SELECT  @iMinFlujo       = MIN(Numero_Flujo)
      ,       @iMaxFlujo       = MAX(Numero_Flujo)
      FROM    #CarteraSwap
      WHERE   Tipo_Flujo       = @iTipoFlujo

      --> (1.2) Si La Tasa es Variable, Solo se debe Recalcular el Flujo Vigente y el que vence
      IF @TipoTasa = 1
         SET @iMaxFlujo = @iMinFlujo  

      --> (2.0) Recorre cada uno de los Flujos para la Pata que Corresponda
      WHILE @iMaxFlujo >= @iMinFlujo
      BEGIN
         --> (2.1) Recupero los Datos del Flujo
         DECLARE @nInteres    NUMERIC(21,4)
         ,       @nInteresDev NUMERIC(21,4)
         ,       @nCapital    NUMERIC(21,4)
         ,       @dFecInicio  DATETIME
         ,       @dFecVcto    DATETIME
         ,       @iDias       NUMERIC(9)
         ,       @iDiasRem    NUMERIC(9)
--         ,       @fTasa       FLOAT        -- MAP 20060928 CN°2
         ,       @fTasaAjust  FLOAT
         ,       @nAjuste     FLOAT
         ,       @nSaldo      NUMERIC(21,4)
         ,       @nAmortiza   NUMERIC(21,4)
         ,       @nFlujo      NUMERIC(21,4)
         ,       @Interes     NUMERIC(21,4)
         ,       @Capital     NUMERIC(21,4)
         ,       @Tasa        FLOAT
         ,       @Perioricidad FLOAT

         SELECT  @Interes     = CASE WHEN @iTipoFlujo = 1 THEN compra_interes
                                     ELSE                      venta_interes
                                END
         ,       @Capital     = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + CASE WHEN @TipoTasa = 1 THEN compra_saldo ELSE 0.0 END
                                     ELSE                      venta_amortiza  + CASE WHEN @TipoTasa = 1 THEN venta_saldo  ELSE 0.0 END
                                END
         ,       @Tasa        = CASE WHEN @iTipoFlujo = 1 THEN compra_valor_tasa
                                     ELSE                      venta_valor_tasa
                                END
         ,       @nInteres    = CASE WHEN @iTipoFlujo = 1 THEN compra_interes - devengo_compra_acum
                                     ELSE                      venta_interes  - devengo_venta_acum
                                END
         ,       @nAmortiza   = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza
                                     ELSE                      venta_amortiza
                                END
         ,       @nSaldo      = CASE WHEN @iTipoFlujo = 1 THEN compra_saldo
                                     ELSE                      venta_saldo
                                END
         ,       @nInteresDev = CASE WHEN @iTipoFlujo = 1 THEN devengo_compra_acum
                                     ELSE                      devengo_venta_acum
                                END
         ,       @nCapital    = CASE WHEN @iTipoFlujo = 1 THEN compra_amortiza + compra_saldo
                                     ELSE                      venta_amortiza  + venta_saldo
                                END
         ,       @dFecInicio  = Fecha_Inicio_Flujo
         ,       @dFecVcto    = Fecha_Vence_Flujo         
         ,       @iDias       = DATEDIFF(DAY,Fecha_Inicio_Flujo,Fecha_Vence_Flujo)
         ,       @iDiasRem    = DATEDIFF(DAY,@dFechaProceso,Fecha_Vence_Flujo)
         --> MAP 20060928 CN°1                                               
         --         ,       @fTasa       = 0.0
         ,       @nAjuste     = 0.0
         ,       @Perioricidad = ( select 365.0 / Dias from BacParamSuda..PERIODO_AMORTIZACION 
                                    where Sistema = 'PCS' AND tabla = '1044' 
                                       and Codigo = ( case when @iTipoFlujo = 1 then  compra_codamo_interes else venta_codamo_interes end )  )


         FROM    #CarteraSwap 
         WHERE   Tipo_Flujo   = @iTipoFlujo
         AND     Numero_Flujo = @iMinFlujo
         
         --> MAP 20060928 CN°2  Desctivar este código temporalmente                                               
         --  Si se reactiva este código se debe tener cuidado con el cambio de base, se debería bajar el 
         --  código que obtiene la tasa ICP-TAB
         --  declare @TasaPlazoCadaFlujo Float
         --> (2.2) Recupero las Tasas por Moneda desde Forward con los plazos remanentes de cada flujo
         --  INSERT INTO #TasasMonedas
         --  EXECUTE BacFwdSuda..SP_RetornaTasaMoneda @Moneda , @iDiasRem
         --  SELECT  @TasaPlazoCadaFlujo = iTasa
         --  FROM    #TasasMonedas
         -- IF @Moneda = 999 SELECT @fTasa = @fTasa * 12 -- MAP 20060921, la tasa CLP está en base 30 enla curva Cero 


         --> (2.3) Determino Valor de Ajuste por Periodicidad e Interes
         IF @iSwAjuste = 1
         BEGIN
            IF (@Moneda <> 999 AND @Moneda <> 998)
            BEGIN
               SELECT @nAjuste       = CASE WHEN @iTipoFlujo = 1 THEN ISNULL(Ajuste_Activo,0.0) ELSE ISNULL(Ajuste_Pasivo,0.0) END
               FROM   PERIODICIDAD_TASAS
               WHERE  Tipo_Tasa      = @TipoTasa
               AND   (@iDias         BETWEEN Desde AND Hasta)

               SELECT @fTasaAjust    =   @fTasa / 100.0  +  @nAjuste/10000.0

               SELECT @nAjuste       = CASE WHEN @iTipoFlujo = 1 THEN ISNULL(Ajuste_Activo,0.0) ELSE ISNULL(Ajuste_Pasivo,0.0) END
               FROM   CONVENCION_AJUSTE_INTERES
               WHERE  Tipo_Tasa      = @TipoTasa
               AND    Base           = @BaseMoneda

               SELECT @fTasaAjust    = @fTasaAjust + @nAjuste/10000.0
            END
            --> (2.3.1) Ajuste Especial para los Pesos.
            IF @Moneda = 999
            BEGIN
               SELECT @nAjuste       = ISNULL(Ajuste_Pasivo,0.0)
               FROM   PERIODICIDAD_TASAS
               WHERE  Tipo_Tasa      = 3
               SELECT @fTasaAjust    = @fTasa / 100.0 + @nAjuste/10000.0
            END
            --> (2.3.1) Ajuste Especial para las U.F. 35. ptb
            IF @Moneda = 998
            BEGIN
               SELECT @nAjuste       = ISNULL(Ajuste_Pasivo,0.0)
               FROM   PERIODICIDAD_TASAS
               WHERE  Tipo_Tasa      = 4
               SELECT @fTasaAjust    = @fTasa / 100.0 + @nAjuste/10000.0
            END
         END ELSE
         BEGIN
            --> Sin Ajuste.
            SELECT @fTasaAjust       = @fTasa / 100.00 -- Se están dividiendo todas las tasas por 100.00
         END


         --> (2.2.1) Cálculo Duracion y Convexidad
         DECLARE @FlujoCaja   FLOAT
         ,       @iResultadoC FLOAT
         ,       @iResultadoD FLOAT
         ,       @iResultadoE FLOAT
         ,       @iResultadoF FLOAT
         ,       @iResultadoG FLOAT
         ,       @iResultadoH FLOAT


         SELECT  @FlujoCaja   =   @Interes + @Capital
         SELECT  @iResultadoC =   @FlujoCaja / POWER(  1.0 + @fTasaAjust   , @iDiasRem  / 360.0 + 2.0 )           
         SELECT  @iResultadoD =   @iDiasRem  *   @FlujoCaja / POWER( 1.0 + @fTasaAjust   ,  @iDiasRem/360.0  )    -- Numerador Duration
         SELECT  @iResultadoE =   @iDiasRem  * ( @iDiasRem  +  360.0 ) * @FlujoCaja
         SELECT  @iResultadoF =   @iResultadoE / POWER( 1.0 + @fTasaAjust   ,   @iDiasRem/360.0  )                -- Numerador Convexidad
         SELECT  @iResultadoG =   @FlujoCaja   / POWER( 1.0 + @fTasaAjust   ,  @iDiasRem/360.0  )                 -- Denominador Convexidad y Duration
         SELECT  @iResultadoH =   @fTasa
         --> ***************************************

/*         select  'debug' ,
                 '@iTipoFlujo', @iTipoFlujo,                   
                 '@iMinFlujo', @iMinFlujo,
                 '@TipoTasa', @TipoTasa, 
      '@FlujoCaja', @FlujoCaja,
                 '@iResultadoC', @iResultadoC,
                 '@iResultadoD', @iResultadoD,
                 '@iResultadoE', @iResultadoE, 
                 '@iResultadoF', @iResultadoF,
                 '@iResultadoG', @iResultadoG,
                 '@iResultadoH', @iResultadoH,
                 '@iSwAjuste', @iSwAjuste,
                 '@Perioricidad', @Perioricidad */



         declare @iTasaSinAjustar Numeric(14,4)
         select  @iTasaSinAjustar = @fTasa

         --> Compone el Flujo Dependiendo de la Tasa y la Fecha de Vcto.
         /*
         IF @TipoTasa = 0
         BEGIN
            IF @dFecVcto = @dFechaProceso
               SELECT @nFlujo = @nInteres
            ELSE
               SELECT @nFlujo = @nSaldo + @nInteres
         END ELSE
         BEGIN
            SELECT @nFlujo    = @nInteres + @nAmortiza 
         END
         REEMPLAZAR POR: */

         --> MAP 20060928 CN°3                                               
         --> Compone el Flujo Dependiendo de la Tasa y la Fecha de Vcto.
         IF @TipoTasa <> 0  -- Tasa Variable
         -- PENDIENTE : Agregar la fecha en que se sabe la tasa del proximo flujo
         -- Se conoce desde antes del vencimiento y debería ser ingresada
            IF @dFecVcto = @dFechaProceso        -- Hay vencimiento en la fecha de proceso, PENDIENTE: deberia ser hay cambio 
                                                 -- de tasa en la fecha de proc.
               if @FechaTermino = @dFechaProceso -- El flujo que vence es además el último Flujo
                  SELECT @nFlujo = @nInteres + @nCapital
               else begin
                  Select @iMaxFlujo = @iMaxFlujo + 1 -- Para obligar que procese el Flujo que sigue MAP 20060821
                  SELECT @nFlujo = @nInteres + @nAmortiza
               end            
            ELSE
               SELECT @nFlujo = @nInteres + @nCapital 
         ELSE               -- Tasa Fija
            if @dFecVcto = @FechaTermino         -- Navegando el último Flujo      
               SELECT @nFlujo    = @nInteres + @nCapital
            else
               SELECT @nFlujo    = @nInteres + @nAmortiza

         --> Genera Flujos de Interes a la Tasa y su Variación
         DECLARE @iValorRazonableMo NUMERIC(21,4)
         ,       @iValorRazonableMn NUMERIC(21,4)
         ,       @iValorRazonableMx NUMERIC(21,4)
         ,       @iTasaAjustada     NUMERIC(21,4)

         SELECT  @iValorRazonableMo = @nFlujo / POWER( 1.0 + @fTasaAjust , @iDiasRem / 360.0 ) + @nInteresDev
         SELECT  @iValorRazonableMn = CONVERT(NUMERIC(21,0),ROUND(@iValorRazonableMo * @iValorMoneda,0))
         SELECT  @iValorRazonableMx = @iValorRazonableMn / @iValorDolar
         SELECT  @iTasaAjustada     = CONVERT(NUMERIC(21,4),@fTasaAjust * 100.00 ) -- Presentación o registro en Base de datos
         /*
         select 'debug', '@nFlujo', @nFlujo
                       , '@iMinFlujo', @iMinFlujo
                       , '@dFecVcto', @dFecVcto
                       , '@iValorRazonableMo', @iValorRazonableMo
                       , '@iValorRazonableMn', @iValorRazonableMn
                       , '@iValorRazonableMx', @iValorRazonableMx
                       , '@iTipoFlujo', @iTipoFlujo
                       , '@iDiasRem' , @iDiasRem
                       , '@iTasaAjustada', @iTasaAjustada
         */
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
         DELETE #TasasMonedas
         SET @iMinFlujo = @iMinFlujo + 1
      END

      SET @iTipoFlujo   = @iTipoFlujo + 1
   END     --> Fin (0.2)                        

   DROP TABLE #TasasMonedas

   --> Pata Activa
   -- Falta Dividir nuevamente por la perioricidad
   UPDATE #Valores_Flujos
   SET    Macaulay   = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0  FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo  = 1

   declare @TasaVarAct Float  -- Poner la tasa máxima para que tome la única que hay
   select  @TasaVarAct = isnull( ( select max( TasaAjustada ) from #Valores_Flujos WHERE TipoFlujo = 1 And Variable = 1 ) , 0 )
   declare @TasaVarPas Float
   select  @TasaVarPas = isnull( ( select max( TasaAjustada ) from #Valores_Flujos WHERE TipoFlujo = 2 And Variable = 1 ) , 0 )

   declare @TasaFijAct Float  -- Poner la tasa más lejana
   select  @TasaFijAct = 0.0
   select  @TasaFijAct = TasaAjustada  from #Valores_Flujos WHERE TipoFlujo = 1 And Variable = 0  order by NumeroFlujo 
   declare @TasaFijPas Float
   select  @TasaFijPas = 0.0 
   select  @TasaFijPas =  TasaAjustada  from #Valores_Flujos WHERE TipoFlujo = 2 And Variable = 0 order by NumeroFlujo 


   UPDATE #Valores_Flujos
   SET    Modificada = (SELECT (SUM(ResultadoD) / SUM(ResultadoG) / 360.0  ) /  (1.0 + ( @TasaVarAct + @TasaFijAct )/100.0/ MAX( Perioricidad ) ) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo  = 1
   
   UPDATE #Valores_Flujos
   SET    Convexidad = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0 ) FROM #Valores_Flujos WHERE TipoFlujo = 1)
   WHERE  TipoFlujo  = 1

   --> Pata Pasiva
   UPDATE #Valores_Flujos
   SET    Macaulay   = (SELECT SUM(ResultadoD) /  SUM(ResultadoG) / 360.0   FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2

   UPDATE #Valores_Flujos
   SET    Modificada = (SELECT (SUM(ResultadoD) / SUM(ResultadoG) ) / 360.0 /  (1.0 + ( @TasaVarPas + @TasaFijPas )/100.0/MAX( Perioricidad ) ) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2
   
   UPDATE #Valores_Flujos
   SET    Convexidad = (SELECT (SUM(ResultadoF) / SUM(ResultadoG) / 360.0 / 360.0 ) FROM #Valores_Flujos WHERE TipoFlujo = 2)
   WHERE  TipoFlujo  = 2


   --> ************************************************
   --> SACAR COMENTARIOS UNA VEZ ALTERADAS LAS CARTERAS
   --> ************************************************
  
   --> Genera Actualización a la Cartera

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
   SET    vTasaActivaAjusta  = case when TipoFlujo = 1 then TasaAjustada else 0 end -- MAP 20060822
   ,      vTasaPasivaAjusta  = case when TipoFlujo = 1 then 0 else TasaAjustada end -- MAP 20060822
   FROM   #Valores_Flujos
   WHERE  Numero_Operacion = @Numero_Operacion
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
   SET    vRazAjustado_Mn = (SELECT SUM(ValorRazonableMn) FROM #Valores_Flujos WHERE TipoFlujo = 1) 
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

--   select 'debug', 'DECOMENTAR LA SENTENCIA: DROP TABLE #Valores_Flujos'  
   DROP TABLE #Valores_Flujos 
--    select 'debug', * from #Valores_Flujos
END

GO
