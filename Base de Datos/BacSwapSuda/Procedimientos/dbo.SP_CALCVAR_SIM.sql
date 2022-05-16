USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCVAR_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CALCVAR_SIM]
   (   @Fecha_Proc            DATETIME,  
       @Operacion             NUMERIC(05)  
   )  
AS      
BEGIN  
-- SP_CALCVAR_SIM '20140408', 177  
    SET NOCOUNT ON  
  
    DECLARE @iFound      INTEGER  
    DECLARE @iFound2     INTEGER     
    DECLARE @fechaant    DATETIME   
  
    DECLARE @CurvaUsada  VARCHAR(20)  
    DECLARE @CurvaUsadaForward   VARCHAR(20)  
    DECLARE @CurvaUsadaDescont VARCHAR(20)  
  
  
    DECLARE @Accion      CHAR(8)  
    DECLARE @DiasBaseTasaForward   INTEGER  
    DECLARE @PlazoLargoTasaForward INTEGER  
    DECLARE @FechaLiquidacion      Datetime  
    DECLARE @dFechaTermino         DATETIME  
    DECLARE @DiasReset             integer   
    DECLARE @CtaDiasReset          integer  
    DECLARE @FechaItera            datetime  
    DECLARE @MonedaExtranjera      char(4) --select mnmx from bacParamSuda..moneda MAP 20081202  
  
   -->     Agregado (20080909)  
   DECLARE @TipoCurvaMon          VARCHAR(5)  
       SET @TipoCurvaMon          = ''  
  
   DECLARE @dFechaProc            DATETIME  
       SET @dFechaProc            = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL with(nolock) )  
   -->     Agregado (20080909)  
  
    SET    @iFound      = -1  
    SET    @iFound2     = -1  
  
    SELECT @iFound       = 0           
      FROM BacParamSuda..VALOR_MONEDA_CONTABLE, SWAPGENERAL  
     WHERE Fecha         = fechaproc  
       AND Tipo_Cambio  <> 0  
  
    SELECT @fechaant     = fechaant   
    FROM   SWAPGENERAL  
  
  
    IF @iFound = -1  
    BEGIN  
--        RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')  
--      RETURN  
  
       SELECT @iFound2       = 0  
       FROM BacParamSuda..VALOR_MONEDA_CONTABLE, SWAPGENERAL  
       WHERE Fecha         = fechaant  
       AND Tipo_Cambio  <> 0  
  
       IF @iFound2 = -1  
       BEGIN  
        SELECT 0,'¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY Y FECHA ANTERIOR. !','','',''   
        RETURN(1)  
       END   
  
    END  
  
  
  
    DECLARE @cMensajes          VARCHAR(100)  
    DECLARE @nTipoTasa          INTEGER  
  
    DECLARE @cProducto          CHAR(3)  
    DECLARE @Numero_Operacion   NUMERIC(7)  
    DECLARE @Numero_Flujo       NUMERIC(3)  
    DECLARE @Tipo_Flujo         NUMERIC(1)  
    DECLARE @FlujoVigente       NUMERIC(1)  
    DECLARE @FecIniFlujo        DATETIME  
    DECLARE @FecVncFlujo        DATETIME  
  
    -- Variables de calculo  
    DECLARE @Interes            FLOAT  
    DECLARE @ValorParMon        FLOAT  
    DECLARE @Capital            FLOAT  
    DECLARE @DiasBase           FLOAT  
    DECLARE @BaseTasa           FLOAT  
    DECLARE @CodigoTasa         NUMERIC(5)  
    DECLARE @Fecha_UDM          DATETIME  
    DECLARE @Plazo              FLOAT  
    DECLARE @TasaMTM            FLOAT  
    DECLARE @SpreadMTM          FLOAT  
    DECLARE @Base               NUMERIC(3)  
    DECLARE @Moneda             NUMERIC(3)  
    DECLARE @MnNemo             CHAR(3)  
    DECLARE @MnTipoPar          CHAR(1)  
    DECLARE @MontoC08           FLOAT  
    DECLARE @MontoFlujoAdicional FLOAT  
    DECLARE @MontoC08USD        FLOAT  
    DECLARE @MontoC08CLP        FLOAT   
    DECLARE @ValorDO_UDM        FLOAT  
  
    -- Variables para calculo de descuentos (valor razonable)  
    DECLARE @PlazoDesc          FLOAT  
    DECLARE @TasaDesc           FLOAT  
    DECLARE @SpreadDesc         FLOAT  
    DECLARE @FlujoDesc          FLOAT  
    DECLARE @FlujoDescUSD       FLOAT  
    DECLARE @FlujoDescCLP       FLOAT  
    DECLARE @ValRazonable       FLOAT  
    DECLARE @ValRazonableMO     FLOAT  
    DECLARE @ValRazonableUSD    FLOAT  
    DECLARE @ValRazonableCLP    FLOAT  
  
-- Para el calculo de tasa implícita  
    DECLARE @FecIniFlujoAnt     DATETIME  
    DECLARE @PlazoAnt           FLOAT  
    DECLARE @TasaPlazoAnt       FLOAT  
  
    -- Para la inclusion de la amortización en el monto a descontar  
    DECLARE @Amortiza           FLOAT  
    DECLARE @Tipo_Swap          NUMERIC(3)  
  
    --Valorización Swap x Curva '0'  
--    DECLARE @CantDiasAA         NUMERIC(3)    -- 20080319  
    DECLARE @FinOperacion       DATETIME  
    DECLARE @FinFlujo           DATETIME  
    DECLARE @PlazoTIR           FLOAT  
    DECLARE @Tir                FLOAT  
    DECLARE @EstadoFlujo        NUMERIC(5)  
    DECLARE @TipoInt            NUMERIC(1)  
    DECLARE @TirCnv             FLOAT  
    DECLARE @FechaFijacionTasa  DATETIME  
    DECLARE @GlosaTasa          CHAR(30)  
  
    --Valorización Swap x Curva '0'  
    DECLARE @Spread             FLOAT  
  
    DECLARE @iRegistros         INTEGER  
    DECLARE @iRegistro          INTEGER  
    DECLARE @PeriodoInt         INTEGER  
    DECLARE @PeriodoIntReal     INTEGER  
  
    -- N° 5 MAP 20080320 Parar calcular el flujo vigente Swap ICP  
    DECLARE @TasaICP            FLOAT  
    DECLARE @PlazoDevengado     FLOAT  
    DECLARE @PlazoPorDevengar   FLOAT  
    DECLARE @TasaPlazo          FLOAT  
  
    DECLARE @CarPlazoFlujo      INTEGER  
  
    DECLARE   @FeriadoFlujoChile int    
            , @FeriadoFlujoEEUU  int  
            , @FeriadoFlujoEnglan int  
  
  
    SET @Spread     = 0.0  
    SET @PlazoAnt   = 0  
--    SET @CantDiasAA = 360  --DATEDIFF(DD, @Fecha_Proc, DATEADD(YY, 1, @Fecha_Proc)) --Valorización Swap x Curva '0' -- 20080319  
  
    -- Todas las conversiones necesarias serán realizadas contra valores SPOT (Hoy)  
    -- Por lo tanto se dejará en la variable @Fecha_UDM la fecha de proceso.  
    -- PENDIENTE: renombrar la variable para dejar mantenible el código  
    -- MAP 20060814 Se vuele a comentar              
    -- MAP 20060906 Se vuelve a activar, la habia desactivado por los EUR, la interfaz está conviertiendo más . Punto !!  
  
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
   DECLARE @FechaCalculos    DATETIME  
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc  
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )  
                               END  
      FROM BacSwapSuda..SWAPGENERAL  
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
  
  
   SET @Fecha_UDM = @Fecha_Proc   
  
  
   SELECT @ValorDO_UDM  = Tipo_Cambio  
     FROM BacParamSuda..VALOR_MONEDA_CONTABLE  
    WHERE Codigo_Moneda = 994  
      AND fecha         = CASE WHEN @iFound =-1 THEN @fechaant ELSE @Fecha_Proc END  
  
   IF ISNULL(@ValorDO_UDM,0) = 0   
   BEGIN  
      SELECT 0, 'NO EXISTE VALOR DO ULTIMO DIA MES ANTERIOR','','',''   
      RETURN(1)  
  
   END  
  
   SET @Fecha_UDM = @Fecha_Proc   -- Se vuelve a dejar con los valores del día, revisar el tema para los EUR!!  
  
   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --  
   SELECT vmcodigo           = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END  
      ,   vmvalor            = Tipo_Cambio  
   INTO   #VALOR_TC_CONTABLE  
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
   WHERE  Fecha              = CASE WHEN @iFound =-1 THEN  @fechaant ELSE @Fecha_Proc END   
   AND    Codigo_Moneda      NOT IN(13,995,997,998,999)  
  
   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --  
   INSERT INTO #VALOR_TC_CONTABLE  
   SELECT vmcodigo  
      ,   vmvalor  
   FROM   BacParamSuda..VALOR_MONEDA  
   WHERE  vmfecha    = @Fecha_UDM  
   AND    vmcodigo   IN(994, 995, 997, 999) --> IN(994, 995, 997, 998, 999)  
  
   INSERT INTO #VALOR_TC_CONTABLE  
   SELECT vmcodigo  
      ,   vmvalor  
   FROM   BacParamSuda..VALOR_MONEDA   
   WHERE  vmfecha    = @FechaCalculos  
AND    vmcodigo   IN(998)  
  
  
  
   -- 25/07/2008  Se usa para el calculo de valor razonable en la moneda   
   -- en que se realiza el pago, no soportaba el caso capital 999,   
   -- moneda de pago 13.  
   DELETE FROM #VALOR_TC_CONTABLE  
         WHERE vmcodigo = 999  
      
   INSERT INTO #VALOR_TC_CONTABLE  
        SELECT 999, 1.0  
  
  
   --> Tabla temporal para almacenar resultados de SP que retorna la tasa por plazo.                          
    CREATE TABLE #TasaMoneda  
           (  
             Tasa               FLOAT NOT NULL DEFAULT(0.0),  
             Spreed             FLOAT NOT NULL DEFAULT(0.0),  
             SpotCompra         FLOAT NOT NULL DEFAULT(0.0),  
             SpotVenta          FLOAT NOT NULL DEFAULT(0.0)  
           )  
  
    --> Tabla temporal Obtiene operaciones sin tasa MTM, por flujo, plazo y moneda  
    CREATE TABLE #OperacSNTasa   
           (  
            Numero_Operacion NUMERIC(7),  
            Numero_Flujo     NUMERIC(3),  
            Tipo_Flujo       NUMERIC(1),  
            Moneda           NUMERIC(3),  
            Plazo            FLOAT,  
            Sistema          CHAR(3),  
            Producto         CHAR(5),  
            Tipo_Tasa        CHAR(5),  
            Base             NUMERIC(5),  
            Glosa            CHAR(100)  
           )  
  
    -- ¿¿¿ QUE PASA CUANDO SE ENVIA UN 0 EN EL PROCEDIMIENTO ???  
   -- solo se ejecuta cuando se envia de a uno, para el caso  
    -- gloabal del cierre este proceso lo hace el devengo  
    if @Operacion <> 0   
        EXECUTE SP_FLUJO_VIGENTE_SIM @Operacion   
  
    --> Tabla de paso para calculo de datos.   
    SELECT Numero_Operacion,  
           Numero_Flujo,  
           Tipo_Flujo,  
           Tipo_Swap,  
           Fecha_Inicio_Flujo,  
           Fecha_Vence_Flujo,  
           Fecha_Inicio,  
           fecha_fijacion_tasa,  
  
           Compra_capital,  
           Compra_Amortiza,  
           Compra_Saldo,  
           Compra_Moneda,  
           Compra_Interes,    
           Compra_Codigo_Tasa,  
           Compra_Valor_tasa,  
           Compra_Base,  
           Compra_Spread,  
  
           Venta_capital,  
           Venta_Amortiza,  
           Venta_Saldo,  
           Venta_Moneda,  
           Venta_Interes,  
           Venta_Codigo_Tasa,  
           Venta_Valor_tasa,  
           Venta_Base,  
           Venta_Spread,  
           'Plazo'                 = CONVERT(NUMERIC(05,0),0.0), -->  CAST(0 AS NUMERIC(5)),  
           'DiasBase'              = CONVERT(NUMERIC(05,0),0.0), -->  CAST(0 AS NUMERIC(5))  
           'TasaMTM'               = CONVERT(NUMERIC(12,8),0.0), -->  CAST(0 AS NUMERIC(12,8))  
           'MontoC08'              = CONVERT(NUMERIC(19,4),0.0), -->  CAST(0 AS NUMERIC(19,4))  
           'ValorParMon'           = CONVERT(NUMERIC(19,4),0.0), -->  CAST(0 AS NUMERIC(19,4))     
           'MontoC08CLP'           = CONVERT(NUMERIC(19,0),0.0), -->  CAST(0 AS NUMERIC(19))  
           'Marca'                 = ' ',  
           'PeriodoInt'            = (12 / ISNULL(pa.meses,1) ),  
           'PeriodoIntReal'        = pa.dias,  
           'registrocorrelativo'   = identity(INT),  
           'Estado_Flujo'    = Estado_Flujo,  
           'Compra_Flujo_Adicional'= Compra_Flujo_Adicional,           -- PENDIENTE: Deben ser cambpos físicos  
           'Venta_Flujo_Adicional' = Venta_Flujo_Adicional,            -- PENDIENTE: Deben ser cambpos físicos  
           'IntercPrinc'           = IntercPrinc,  -- Intercambio de nocionales 'apaga o enciende las amortizaciones'  
           'FechaLiquidacion'      = FechaLiquidacion,  
           'Fecha_Termino'         = Fecha_Termino,  
           'Dias_Reset'            = DiasReset,  
           'FeriadoFlujoChile'     = FeriadoFlujoChile,  
           'FeriadoFlujoEEUU'      = FeriadoFlujoEEUU,  
           'FeriadoFlujoEnglan'    = FeriadoFlujoEnglan  
       ,   'OrigenCurva'           = OrigenCurva   -->     Agregado (20080909)  
      INTO #Cartera_Sim  
      FROM dbo.CARTERA_SIM   
           LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION pa ON pa.sistema = 'PCS' and pa.tabla = 1044 and codigo = (venta_codamo_interes + compra_codamo_interes)  
     WHERE ( Numero_Operacion       = @Operacion  
        OR @Operacion             = 0 ) And Estado <> 'N'    
     ORDER BY Numero_Operacion, Numero_Flujo, Tipo_Flujo  
  
    CREATE INDEX #IX_Cartera ON #Cartera_Sim ( Numero_Operacion, Numero_Flujo, Tipo_Flujo )  
  
    SELECT @iRegistros       = MAX(registrocorrelativo),  
           @iRegistro        = MIN(registrocorrelativo)  
      FROM #Cartera_Sim  
  
  
  
    WHILE @iRegistros >= @iRegistro -- 1 = 1  
    BEGIN  
  
        SELECT @Numero_Operacion   = Numero_Operacion,  
               @Numero_Flujo       = Numero_Flujo,  
               @Tipo_Flujo         = Tipo_Flujo,  
               @FecIniFlujo        = Fecha_Inicio_Flujo,  
               @FecVncFlujo        = Fecha_Vence_Flujo,  
               @FlujoVigente       = CASE WHEN @FechaCalculos /*@Fecha_Proc*/ BETWEEN Fecha_inicio_Flujo AND Fecha_Vence_Flujo THEN 1 ELSE 0 END,  
               @Capital            = CASE WHEN Tipo_Flujo = 1 THEN Compra_Saldo + Compra_Amortiza   
                                                              ELSE Venta_Saldo  + Venta_Amortiza  
                                     END,  
               @Moneda             = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda      ELSE Venta_Moneda      END,  
               @Base               = CASE WHEN Tipo_Flujo = 1 THEN Compra_Base        ELSE Venta_Base        END,  
               @CodigoTasa         = CASE WHEN Tipo_Flujo = 1 THEN Compra_Codigo_Tasa ELSE Venta_Codigo_Tasa END,  
               @TasaMTM            = CASE WHEN Tipo_Flujo = 1 THEN Compra_Valor_Tasa +   
                                                                     case when compra_codigo_tasa in (13,21) then 0.0  -- MAP 20090218 Se sumara después el Spread  
                                                                          else Compra_Spread  end  
                                                              ELSE Venta_Valor_Tasa +   
                                                                     case when Venta_codigo_tasa in (13,21) then 0.0   -- MAP 20090218 Se sumara después el Spread  
                                                                          else Venta_Spread  end  
  
                                                              END,  
  
               @MontoC08           = CASE WHEN Tipo_Flujo = 1 THEN Compra_Interes     ELSE Venta_Interes     END,  
               @MontoFlujoAdicional= CASE WHEN Tipo_Flujo = 1 THEN Compra_Flujo_Adicional   
                                                              ELSE Venta_Flujo_Adicional  
                                     END,   
               @PeriodoInt         = CONVERT(INTEGER,ROUND(PeriodoInt,0)),  
               @PeriodoIntReal     = CONVERT(INTEGER,ROUND(PeriodoIntReal,0)),  
               @Amortiza           = ( Compra_Amortiza + Venta_Amortiza ) * IntercPrinc ,  
               @Tipo_Swap          = Tipo_Swap,  
               @FechaFijacionTasa  = fecha_fijacion_tasa,  
               @Spread             = CASE WHEN Tipo_Flujo = 1 THEN Compra_Spread     ELSE Venta_Spread     END  ,      
        @EstadoFlujo        = Estado_Flujo ,  
               @FechaLiquidacion   = fechaLiquidacion,  
               @dFechaTermino      = Fecha_Termino,  
               @DiasReset          = Dias_Reset,  
               @FeriadoFlujoChile  = FeriadoFlujoChile,  
               @FeriadoFlujoEEUU   = FeriadoFlujoEEUU,  
               @FeriadoFlujoEnglan = FeriadoFlujoEnglan  
           ,   @TipoCurvaMon       = OrigenCurva       -->     Agregado (20080909)  
          FROM #Cartera_Sim-- (INDEX=#IX_Cartera)  
         WHERE Marca              <> '-'  
           AND registrocorrelativo = @iRegistro  
  
        IF @@ROWCOUNT = 0  
        BEGIN  
            BREAK  
  
        END  
  
        SET @BaseTasa = 360.0  
        --  20080319 Se retoma la base de la operación.    
        SELECT @BaseTasa = CASE WHEN Base = 'A' THEN 365 ELSE Base END     
        FROM   BASE  
        WHERE  codigo    = @Base  
  
  
        --> Registrar el plazo del flujo para mostrar en confirmaciones  
        IF @Base IN (4,5)  -- 30/360 30/365  
        BEGIN  
            EXECUTE BacBonosExtSuda..SVC_FMU_DIF_D30 @FecIniFlujo, @FecVncFlujo, @CarPlazoFlujo OUTPUT      
  
        END ELSE  
        BEGIN  
            SELECT @CarPlazoFlujo = DATEDIFF(DAY, @FecIniFlujo, @FecVncFlujo) --> Dias normales   
  
        END  
  
  
        SELECT @GlosaTasa = tbglosa    
          FROM BacParamSuda..TABLA_GENERAL_DETALLE    
         WHERE tbcateg    = 1042  
           AND tbcodigo1  = @CodigoTasa  
  
        SET @cProducto   = CASE WHEN @Tipo_SWAP = 1 THEN 'ST'  
                                WHEN @Tipo_SWAP = 2 THEN 'SM'  
                                WHEN @Tipo_SWAP = 3 THEN 'FR'  
                                WHEN @Tipo_SWAP = 4 THEN 'SP'  
                           END  
  
        SET @nTipoTasa   = CASE WHEN @CodigoTasa = 0 THEN 0 ELSE 1 END  
        SET @Tircnv = 0.0    
  
        --Valorización Swap x Curva '0'  
        IF  @Tipo_Flujo = 1  
        BEGIN  
            SELECT @FinOperacion    = fecha_termino,  
                   @FinFlujo        = CASE WHEN compra_codigo_tasa = 0 THEN fecha_termino ELSE fecha_vence_flujo END  
              FROM dbo.Cartera_Sim   
             WHERE Numero_Operacion = @Numero_Operacion  
               AND Estado_Flujo     = 1  
        AND Tipo_Flujo       = @Tipo_Flujo  
  
        END ELSE  
        BEGIN  
             SELECT @FinOperacion   = fecha_termino,  -- 05/03/2008  
         @FinFlujo       = CASE WHEN venta_codigo_tasa = 0 THEN fecha_termino ELSE fecha_vence_flujo END  
              FROM dbo.Cartera_Sim   
             WHERE Numero_Operacion = @Numero_Operacion  
               AND Estado_Flujo     = 1  
        AND Tipo_Flujo       = @Tipo_Flujo  
  
        END  
  
        --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
        SET @PlazoTIR = DATEDIFF(DAY, @FechaCalculos, CASE WHEN @nTipoTasa = 1 THEN @FinFlujo ELSE @FinOperacion END) --> DATEDIFF(DD, @Fecha_Proc, CASE WHEN @nTipoTasa =1 THEN @FinFlujo ELSE @FinOperacion END) -- 05/03/2008  
        SET @TipoInt  = 2 -- CASE WHEN  @PlazoTIR <= @CantDiasAA THEN 1 ELSE  2 END  -- 20080319  
  
        SET @Tir = 0           -- PRD 20732   
 -- 05/03/2008  
 /* Se elimina el rescate TIR. -- PRD 20732 
        DELETE FROM #TasaMoneda  
  
        INSERT INTO #TasaMoneda  
            EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA @Moneda, @PlazoTIR, 'PCS', @cProducto, @nTipoTasa, @Tipo_Flujo, @Base, 'C', @CodigoTasa, 'TIR', 'Descont', @CurvaUsada OUTPUT      
  
  
         -- Rescata valor de tasa y redondeo a 8 decimales   
         SET    @Tir = 0  
         SELECT @Tir   = ROUND(Tasa,8)  
           FROM #TasaMoneda    
  
         IF @Tir = 0.0  
            SET @Tir = 0.0001  
  
         IF @Tir  = 0.0  and  @dFechaTermino > @Fecha_Proc  
         BEGIN  
            INSERT INTO #OperacSNTasa   
                VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoTIR,'PCS', @cProducto, @nTipoTasa, @Base, ' (1) al rescatar Tasa con valor ' + char(39) + 'cero' +  char(39) + ' para TIR con Indice ' + @GlosaTasa)  
  
         END  
  
         -- PENDIENTE: Según sea activa o pasiva actualizar en BD: Compra_Curva_TIR o Venta_Curva_TIR  
         SET @TirCnv = 0.0  
  
         IF @Tir <> 0.0 and @dFechaTermino > @FechaCalculos /*@Fecha_Proc*/  
         begin  
            --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda   
       EXECUTE SP_TRANSFORMA_TASA @Tir, @TipoInt, @FechaCalculos, @FinFlujo, @Base, @TirCnv OUTPUT   
            --> EXECUTE SP_TRANSFORMA_TASA @Tir, @TipoInt, @Fecha_Proc, @FinFlujo, @Base, @TirCnv OUTPUT  
         end  
  */  -- PRD 20732 
  
        --Valorización Swap x Curva '0'  
        IF @Tipo_Swap = 3  -- Gatillar recualculo de Flujo   
        BEGIN  
  
            EXEC CALCULO_TASA_PROYECTADA_FRA_SIM @Numero_Operacion  
            -- Volver a rescatar la información  
            SELECT @MontoC08            = CASE WHEN Tipo_Flujo = 1 THEN Compra_Interes ELSE Venta_Interes END  
              FROM #Cartera_Sim --(INDEX=#IX_Cartera)  
      WHERE Marca               <> '-'  
        AND registrocorrelativo  = @iRegistro  
  
        END  
  
  
  
/* 20080319 Recuperar Dias base como estaba antes,  
        según la convención de operación  
        con esto se obtiene una tasa Forward en  
        la base de la operación y no hay que transformarla  
  
   SET @DiasBase = DATEDIFF(DAY,@FecIniFlujo,@FecVncFlujo) --> Dias normales   
*/    
--  Valorización Swap x Curva '0'  
        -->Dias segun base para bases con meses de 30 dias.              
        IF @Base IN (4,5)  -- 30/360 30/365  
        BEGIN  
            EXECUTE BacBonosExtSuda..SVC_FMU_DIF_D30  @FecIniFlujo, @FecVncFlujo, @DiasBase OUTPUT      
        END ELSE  
        BEGIN  
            SELECT @DiasBase = DATEDIFF(DAY, @FecIniFlujo, @FecVncFlujo) --> Dias normales   
        END  
  
        select @DiasBase = case when @DiasBase = 0 then 1 else @DiasBase end   --> MAP 20080428 Inclusion del flujo de intercambio nocional inicial  
  
        -- Perioricidad del índice:  
        select @DiasBaseTasaForward = @DiasBase  
        select @DiasBaseTasaForward = dias from BacParamSuda..PERIODO_AMORTIZACION Per,  
                                                BacParamsuda..tabla_general_Detalle Tas  
        where tabla = 1044   and tbcateg = 1042 and  per.codigo = Tas.tbtasa  and   tbcodigo1 = @CodigoTasa   
  
        select @DiasBaseTasaForward = case when @codigoTasa not in(13,21) then isnull( @DiasBaseTasaForward, @DiasBase )   
                                                                  else @DiasBase end        
  
        --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
        SET @Plazo    = DATEDIFF(DAY, @FechaCalculos, @FecVncFlujo) --> DATEDIFF(DAY,@Fecha_Proc ,@FecVncFlujo)  -- TAG MPNG 20051109, ojo es para descontar !!!  
  
        -- La tasa forward debe estar en función de la fecha Fixing, ubicándose el   
        -- inicio del plazo corto en la fecha finxing más los dias reset.   
        set @FechaItera = @FechaFijacionTasa  
        set @CtaDiasReset = 0  
        while @CtaDiasReset < @DiasReset  begin  
              set @CtaDiasReset = @CtaDiasReset + 1  
              exec SP_FECHA_PROXIMA_HABIL_FER_INTERNACIONALES @FechaItera , @FechaItera OUTPUT, @FeriadoFlujoChile, @FeriadoFlujoEEUU , @FeriadoFlujoEnglan   
        end  
  
        --SET @PlazoLargoTasaForward = case when @codigoTasa <> 13 then DATEDIFF(DAY, @Fecha_Proc, @FecIniFlujo) + @DiasBaseTasaForward  
        --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
        SET @PlazoLargoTasaForward = case when @codigoTasa not in(13,21) then DATEDIFF(DAY, @FechaCalculos, @FechaItera) + @DiasBaseTasaForward --> DATEDIFF(DAY, @Fecha_Proc, @FechaItera ) + @DiasBaseTasaForward  
                                                                 else @Plazo   
                                     end  
  
        -- OJO LO COMENTE  
--          SET     @cProducto   = CASE WHEN @Tipo_SWAP = 1 THEN 'ST'  
--                                      WHEN @Tipo_SWAP = 2 THEN 'SM'  
--                                      WHEN @Tipo_SWAP = 3 THEN 'FR'  
--                                      WHEN @Tipo_SWAP = 4 THEN 'SP'  
--                                 END  
  
         -- N° 5 MAP 20080320     
         SET @TasaICP  = @TasaMTM -- Recordar que esta variable registra la tasa del flujo vigente   
  
        --> Obtiene tasa para flujos variables futuros, para flujo en curso o FRA (tipo=3) mantiene los intereses.      
  
        select @CurvaUsadaForward = 'NO APLICA'  
        select @CurvaUsadaDescont = 'NO HAY CURVA'  

        IF (      @CodigoTasa <> 0 AND @FechaFijacionTasa > @FechaCalculos -- Variable con fecha fijacion futura  
              OR  @CodigoTasa in (13,21)                              -- La pata es ICP  
           )  AND @Tipo_SWAP <> 3                                          -- Producto no es FRA  
      
        BEGIN  
          --> Busca tasa MTM segun plazo y moneda              
            -- *  
--            SET @nTipoTasa   = CASE WHEN @CodigoTasa = 0 THEN 0 ELSE 1 END     -- Valorización Swap x Curva '0'  
  
            DELETE #TasaMoneda    
  
            INSERT INTO #TasaMoneda  
                   EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA @Moneda, @PlazoLargoTasaForward, 'PCS', @cProducto, @nTipoTasa, @Tipo_Flujo, @Base, 'C', @CodigoTasa, 'CERO', 'Forward', @CurvaUsada OUTPUT      
            SELECT @CurvaUsadaForward = @CurvaUsada   
            -- Rescata valor de tasa y redondeo a 8 decimales   
            SELECT @TasaMTM   = CASE WHEN @CodigoTasa = 21 THEN Tasa  ELSE ROUND(Tasa,8)   END, --ROUND(Tasa,8),  
                   @SpreadMTM = Spreed  
              FROM #TasaMoneda    
  
            IF @TasaMTM  = 0.0 and  @dFechaTermino > @Fecha_Proc  
            BEGIN  
                INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoLargoTasaForward,'PCS', @cProducto, @nTipoTasa, @Base, ' al rescatar Tasa con valor ' + char(39) + 'cero' +  char(39) + ' para Curva con Indic
e
 ' + @GlosaTasa) --convert( char(5), @CodigoTasa))  
            END  
  
            SET @FecIniFlujoAnt  = ''  
  
             --> REVISAR <--  
             --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
             SET @PlazoAnt = DATEDIFF(DAY, @FechaCalculos, CASE WHEN @CodigoTasa in (13,21) THEN @FecIniFlujo ELSE @FechaItera END) --> SET @PlazoAnt = DATEDIFF(DAY, @Fecha_Proc,    CASE WHEN @CodigoTasa = 13 THEN @FecIniFlujo ELSE @FechaItera END)   
  
             DECLARE @nPlazoAntOrig   NUMERIC(9)  
                 SET @nPlazoAntOrig   = DATEDIFF(DAY, @Fecha_Proc,   CASE WHEN @CodigoTasa in (13,21) THEN @FecIniFlujo ELSE @FechaItera END)   
  
             -- N° 5 MAP 20080320 comenzó a devengar un promedio de cámara  
             -- por tanto se debe calcular el flujo vigente  
  
       -- Esto solo se dará para ICP Vigente, es señal de devengo  
             IF  (@PlazoAnt      < 0 AND @Fecha_Proc  = @FechaCalculos)   
              OR (@nPlazoAntOrig < 0 AND @Fecha_Proc <> @FechaCalculos)  
  
             BEGIN  
                 
                --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
                SET @PlazoDevengado   = DATEDIFF(DAY, @FecIniFlujo, @FechaCalculos) --> datediff( Day, @FecIniFlujo, @Fecha_Proc )  -- plazo devengado  
                SET @PlazoPorDevengar = @Plazo   
                SET @TasaPlazo        = @TasaMTM   
  
                SET @TasaMTM          = (      ( 1.0 + @TasaICP   / 100.0 * @PlazoDevengado   / @BaseTasa ) *   
          POWER( 1.0 + @TasaPlazo / 100.0 , @PlazoPorDevengar / 360.0 )   
                                           - 1.0   
                   ) * 360.0 / @DiasBase  
             END ELSE   
             BEGIN     
  
               -->Este codigo se activará para todos los flujos futuros   
  
        -->Busca tasa MTM segun plazo Ant y moneda  
                DELETE #TasaMoneda   
  
         -- Utilizar un procedimiento que recapitalice la tasa  
               INSERT INTO #TasaMoneda  
                   EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA @Moneda, @PlazoAnt, 'PCS', @cProducto, @nTipoTasa, @Tipo_Flujo, @Base, 'C', @CodigoTasa, 'CERO', 'Forward', @CurvaUsada OUTPUT      
  
               SELECT @TasaPlazoAnt = CASE WHEN @CodigoTasa = 21 THEN Tasa   ELSE ROUND( Tasa, 8 ) END  --ROUND( Tasa, 8 )  
                 FROM #TasaMoneda  
  
               IF @TasaPlazoAnt  = 0.0   
               BEGIN  
                 INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoAnt,'PCS', @cProducto, @nTipoTasa, @Base, ' al rescatar Tasa con valor [cero] para Curva con Indice ' + @GlosaTasa) --convert( char(5), @CodigoTasa))
  
               END  
  
  
               --Valorización Swap x Curva '0'  
     
        /*  
        20080319 Calculo de tasa Forward , los factores de capitalización encapsulan la convensión de tasas, luego  
        se puede inferir la tasa forward de la siguiente manera: ( 1 + Tasa2/100 )^(p2/360) = ( 1 + Tasa1/100 )^(p1/360)*( 1 + TasaForward/100 * Convensión(pl2-pl1)/BaseOperacion )  
        */  
   /*  
          print '@Capital-->' +cast (@Capital as varchar)  
    
        print '(POWER((1 + @TasaMTM     /100.0), ( @PlazoLargoTasaForward / @BaseTasa))  
                                / POWER((1 + @TasaPlazoAnt/100.0), ( @PlazoAnt              / @BaseTasa))-1)   
                                 * (@BaseTasa / @DiasBaseTasaForward )' +' '+ cast(@TasaMTM as varchar)+' '+ cast(@PlazoLargoTasaForward as varchar)  
        +' '+ cast(@BaseTasa as varchar) +' '+ cast(@TasaPlazoAnt as varchar)+' '+cast(@PlazoAnt as varchar)  
   */  
               SELECT @TasaMTM = (POWER((1 + @TasaMTM     /100.0), ( @PlazoLargoTasaForward / @BaseTasa))  
                                / POWER((1 + @TasaPlazoAnt/100.0), ( @PlazoAnt              / @BaseTasa))-1)   
                                 * (@BaseTasa / @DiasBaseTasaForward )  
  
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
  
             
  
  
        END  
  
          
  
        -- FIN flujos variables  
        --Rescata valor de tasa de descuento con plazo de descuento para flujo pagamos  
        -->plazo de descuento   
        -- SET @PlazoDesc = DATEDIFF(DAY,@Fecha_Proc ,@FecVncFlujo)  
  
        --> Modificado Aplicando la Variable '@FechaCalculos' a Fecha Fin Mes Especial o proceso segun corresponda      
        SET @PlazoDesc = DATEDIFF(DAY, @FechaCalculos, @FechaLiquidacion) --> DATEDIFF(DAY,@Fecha_Proc , @FechaLiquidacion ) --   
  
  
        -- Ver camp mnmx de moneda que indica si es moneda Extranjera o no  
        -- MAP 20090225 Vuelta a atrás, recuperar cuando usuario autorice paso  
        -- a producción  
        select @MonedaExtranjera = ''
        select @MonedaExtranjera = mnmx from bacparamsuda..moneda where mncodmon = @Moneda
  
        -- Acción: determinar, según la moneda de la otra pata cómo hay que descontar  
        select @Accion = 'Descont'   
  
  
  
        -- MAP 20090225 Vuelta a atrás, recuperar cuando usuario autorice paso  
        -- a producción  
        --if  @MonedaExtranjera = 'C'   
        --    select @Accion = case when /*@Moneda = 13 and */ ( select max( compra_moneda + venta_moneda ) from #Cartera_Sim   
        --                                                   where numero_operacion = @Numero_Operacion   
        --                                                   and   tipo_Flujo = ( case when @Tipo_Flujo = 1 then 2 else 1 end ) )   
        --                                     in ( 999, 998 ) -- Moneda de la otra para es nacional   
        --                          then 'DescMxMn' else @Accion end   
  
  

        -- PRODXXXX, MAP: Leonardo Muñoz, 21 Junio 2011: solo los Cross utilizaran 
        -- curvas Locales.

        -- MAP 20090225 Vuelta a atrás, recuperar Versión anterior  
        --if  @Moneda = 13 
        --    select @Accion = case when @Moneda = 13 and  ( select max( compra_moneda + venta_moneda ) from #Cartera_Sim 
        --                                                   where numero_operacion = @Numero_Operacion 
        --                                                   and   tipo_Flujo = ( case when @Tipo_Flujo = 1 then 2 else 1 end ) ) 
        --                                                 in ( 999, 998 ) -- Moneda de la otra para es nacional 
        --                          then 'DescMxMn' else @Accion end 
  
  
        -- PRODXXXX, MAP: Leonardo Muñoz, 21 Junio 2011: solo los Cross utilizaran 
        -- curvas Locales.

        -- MAP: 1. Ya no se pesquizará la moneda del frente: se comenta codigo SCC
        --SCC 
        --SCC DECLARE @nContraMon   INTEGER
        --SCC    SET @nContraMon   = ( SELECT MAX( compra_moneda + venta_moneda )
        --SCC                            FROM #CARTERA 
        --SCC                           WHERE numero_operacion = @Numero_Operacion 
        --SCC                             AND tipo_Flujo       = CASE WHEN @Tipo_Flujo = 1 THEN 2 ELSE 1 END )

  /* Ya se manejará una curva de descuento para cada moneda producto, ei. no hay distincion entre curva
     local o no MAP 20140430
        IF @MonedaExtranjera = 'C'
              --SCC PROD XXXX SET @Accion = CASE WHEN @nContraMon = 999 OR @nContraMon = 998 THEN 'DescMxMn' ELSE @Accion END
              SET @Accion = CASE WHEN @Tipo_Swap = 2 THEN 'DescMxMn' ELSE @Accion END
   */
        -- PRODXXXX, MAP: Leonardo Muñoz, 21 Junio 2011: solo los Cross utilizaran 
        -- curvas Locales.
  
  
        --> Obtiene tasa de descuento segun plazo de dias corridos.      
        DELETE #TasaMoneda  
  
        INSERT INTO #TasaMoneda  
               EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA @Moneda, @PlazoDesc, 'PCS', @cProducto , @nTipoTasa, @Tipo_Flujo, @Base, 'C', @CodigoTasa, 'CERO', @Accion, @CurvaUsada OUTPUT      
  
        SELECT @TasaDesc   = ROUND(Tasa,8),  
               @SpreadDesc = Spreed  
          FROM #TasaMoneda  
  
        IF @TasaDesc  = 0.0 and  @dFechaTermino > @Fecha_Proc  
        BEGIN  
            INSERT INTO #OperacSNTasa VALUES (@Numero_Operacion, @Numero_Flujo, @Tipo_Flujo, @Moneda, @PlazoDesc, 'PCS', @cProducto , @nTipoTasa, @Base, ' al rescatar Tasa con valor ' + char(39) + 'cero' +  char(39) + ' para Curva con Indice ' + @GlosaTasa) --convert( char(5), @CodigoTasa))
  
        END  
  
         -->     Agregado (20080909)   
         EXECUTE dbo.SP_RETORNATIPOORIGEN_PCS 'PCS', @cProducto, @Moneda, @nTipoTasa, @Base, @CodigoTasa, @PlazoDesc, @dFechaProc, @TasaDesc, @Tipo_Flujo, @TipoCurvaMon OUTPUT      
         -->     Agregado (20080909)  
  
        select @CurvaUsadaDescont = @CurvaUsada  
  
        --> MAP 20080505 No agregar al AVR el monto del cupón que se paga Hoy  
        --> Tema solicitado desde 27 de Noviembre 2007 en la valorizacion antigua  
        if @FechaLiquidacion = @Fecha_Proc begin  
            set @MontoC08 = 0.0   
            set @Amortiza = 0.0   
            set @MontoFlujoAdicional = 0.0  
        end  
          
  
        --> Calculo de descuentos de interes con plazo de dias corridos.  
        --> 05-Ago-2005 Se incluye el monto amortizar como parte del valor razonable.  
/*  
        IF @PlazoDesc <= @CantDiasAA  --Valorización Swap x Curva '0'  
        BEGIN  
    SET @FlujoDesc = (@MontoC08 + @Amortiza) / (1 + ((@TasaDesc + @SpreadDesc) /100.0) * (@PlazoDesc/@BaseTasa))  
  
        END ELSE  
        BEGIN  
*/ -- 20080319  
 -- 20080319 Calculo del descuento debe ser siempre calculado con interes compuesto, solo utilizar esta formula  
/*  
     print '@Numero_Operacion-->' + cast(@Numero_Operacion as varchar)  
     print '@Numero_Flujo-->' + cast(@Numero_Flujo as varchar)  
     print '@Tipo_Flujo-->' + cast(@Tipo_Flujo as varchar)  
     print '@FecIniFlujo-->' + cast(@FecIniFlujo as varchar)  
     print '@FecVncFlujo-->' + cast(@FecVncFlujo as varchar)  
  
     print '@MontoC08 + @Amortiza + @MontoFlujoAdicional ' + cast(@MontoC08 as varchar) +' ' +cast(@Amortiza as varchar) +' ' +cast(@MontoFlujoAdicional as varchar)  
     print '@Amortiza-->' + cast(@Amortiza as varchar)  
  
     print '@TasaDesc-->' + cast(@TasaDesc as varchar)  
     print '@TasaDesc-->' + cast(@TasaDesc as varchar)  
*/  
            SET @FlujoDesc =  ( @MontoC08 + @Amortiza + @MontoFlujoAdicional ) / power( 1 + ( @TasaDesc + @SpreadDesc ) / 100.0 , @PlazoDesc / @BaseTasa ) --Valorización Swap x Curva '0'  
--        END  
  
        --  descontar DIVIDIDO por ( 1 + Tasa/100 * Plazo/360)  
        --> Redondeo a 4 decimales.   
        SET @FlujoDesc = ROUND(@FlujoDesc , 4)   
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
                  FROM BacParamSuda..MONEDA  
                 WHERE mncodmon   = @Moneda  
  
                IF NOT EXISTS(SELECT 1 FROM #VALOR_TC_CONTABLE WHERE vmcodigo = @Moneda AND vmvalor <> 0)  
                BEGIN  
/*  
                    SET @cMensajes = '¡ NO EXISTEN VALORES PARA LA MONEDA ' + @MnNemo + ' A LA FECHA !.'   
                    RAISERROR (@cMensajes ,16,6,'ERROR.')  
                    RETURN  
*/  
      SELECT 0,'¡ NO EXISTEN VALORES PARA LA MONEDA ' + @MnNemo + ' A LA FECHA !.','','',''   
      RETURN(1)  
  
  
                END ELSE  
                BEGIN  
                    SELECT @ValorParMon = ISNULL((SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13)  
                                               / (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = @Moneda),0.0)  
  
                    IF @ValorParMon = 0.0  
                    BEGIN  
                        SELECT 0,'NO SE PUDO DETERMINAR PARIDAD BCCH PARA EL ' + @MnNemo,'','',''  
                        BREAK  
  
                    END  
  
                END  
  
                --> A Usd  
                SET @MontoC08USD  = ROUND(@MontoC08     / @ValorParMon, 4)    
                SET @FlujoDescUSD = ROUND(@FlujoDesc    / @ValorParMon, 4)   
  
                SET @MontoC08CLP  = ROUND(@MontoC08     / @ValorParMon, 4)    
                SET @FlujoDescCLP = ROUND(@FlujoDesc    / @ValorParMon, 4)   
  
                --> A CLP  
                SET @MontoC08CLP  = ROUND(@MontoC08CLP  * @ValorDO_UDM, 0)    
                SET @FlujoDescCLP = ROUND(@FlujoDescCLP * @ValorDO_UDM, 0)     
  
            END ELSE  
            BEGIN  
  
                SELECT @ValorParMon = vmvalor  
                  FROM #VALOR_TC_CONTABLE  
                 WHERE vmcodigo     = @Moneda  
  
                IF @ValorParMon = 0.0  
                BEGIN  
/*  
                    SET @cMensajes = 'NO SE PUDO DETERMINAR VALOR PARA LA MONEDA ' + @MnNemo   
                    RAISERROR(@cMensajes,16,6,'ERROR.')     
                    RETURN  
*/  
                    SELECT 0,'NO SE PUDO DETERMINAR VALOR PARA LA MONEDA ' + @MnNemo,'','',''   
    RETURN(1)  
                END  
  
                SET @MontoC08CLP  = ROUND( @MontoC08     * @ValorParMon, 0)    
                SET @FlujoDescCLP = ROUND( @FlujoDesc    * @ValorParMon, 0)    
                SET @MontoC08USD  = ROUND( @MontoC08CLP  / @ValorDO_UDM, 4)    
                SET @FlujoDescUSD = ROUND( @FlujoDescCLP / @ValorDO_UDM, 4)   
  
            END  
  
        END  
  
  
  
  
        -->Actualizando marca en cartera temporal  
        UPDATE #Cartera_Sim   
           SET Marca            = '-'  
         WHERE Numero_Operacion = @Numero_Operacion  
           AND Numero_Flujo     = @Numero_Flujo  
           AND Tipo_Flujo       = @Tipo_Flujo  
  
        -->Actualizando calculos en cartera vigente  
        SELECT @CurvaUsadaForward  = isnull( @CurvaUsadaForward, 'No Hay Curva')  
        SELECT @CurvaUsadaDescont  = isnull( @CurvaUsadaDescont, 'No Hay Curva')  
        UPDATE CARTERA_SIM  
           SET Tasa_Compra_Curva   = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@TasaMTM,8)                ELSE 0 END,  
               Tasa_Venta_Curva    = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@TasaMTM,8)                ELSE 0 END,  
  Activo_MO_C08       = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08,4)               ELSE 0 END,  
               Activo_USD_C08      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08USD,4)            ELSE 0 END,  
               Activo_CLP_C08      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@MontoC08CLP,0)            ELSE 0 END,  
               Pasivo_MO_C08       = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08,4)               ELSE 0 END,  
               Pasivo_USD_C08      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08USD,4)            ELSE 0 END,  
               Pasivo_CLP_C08      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@MontoC08CLP,0)            ELSE 0 END,  
               Tasa_Compra_CurvaVR = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@TasaDesc + @SpreadDesc,8) ELSE 0 END,  
               Tasa_Venta_CurvaVR  = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@TasaDesc + @SpreadDesc,8) ELSE 0 END,  
               Activo_FlujoMO      = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDesc,4)              ELSE 0 END,  
               Activo_FlujoUSD     = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDescUSD,4)           ELSE 0 END,  
               Activo_FlujoCLP     = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@FlujoDescCLP,4)           ELSE 0 END,  
    Pasivo_FlujoMO      = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDesc,4)              ELSE 0 END,  
               Pasivo_FlujoUSD     = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDescUSD,4)           ELSE 0 END,  
               Pasivo_FlujoCLP     = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@FlujoDescCLP,4)           ELSE 0 END,  
               Valor_RazonableMO   = 0,  
               Valor_RazonableUSD  = 0,  
        Valor_RazonableCLP  = 0,  
               --Valorización Swap x Curva '0'  
               ActivoTir           = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@Tir,8)        ELSE 0 END,  
               ActivoTirCnv        = CASE WHEN @Tipo_Flujo = 1 THEN ROUND(@TirCnv,8)     ELSE 0 END,  
               PasivoTir           = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@Tir,8)        ELSE 0 END,  
               PasivoTirCnv        = CASE WHEN @Tipo_Flujo = 2 THEN ROUND(@TirCnv,8)     ELSE 0 END,  
  
               Compra_curva_Forward= case when @tipo_Flujo = 1 then  @CurvaUsadaForward  else '' END,   
               Venta_curva_Forward = case when @tipo_Flujo = 2 then  @CurvaUsadaForward  else '' END,   
               Compra_curva_Descont= case when @tipo_Flujo = 1 then  @CurvaUsadaDescont  else '' END,   
               Venta_curva_Descont = case when @tipo_Flujo = 2 then  @CurvaUsadaDescont  else '' END,  
  
               PlazoFlujo          = @CarPlazoFlujo -- Para desplegar en las confirmaciones  
               --Valorización Swap x Curva '0'  
         ,    OrigenCurva          = @TipoCurvaMon   -->     Agregado (20080909)  
         WHERE Numero_Operacion    = @Numero_Operacion  
           AND Numero_Flujo        = @Numero_Flujo  
           AND Tipo_Flujo          = @Tipo_Flujo  
          
        SET @iRegistro = @iRegistro + 1  
    END  
  
  
   /*  
   02/04/2008   
   Este cambio se realiza con el fin de presentar más facilmente los datos en el reporte de valor razonable   
   y permitir la obtención del dato, en formato Activo - Pasivo sin navegar más que los flujos marcados con 1.  
   */  
  
    UPDATE  CARTERA_SIM  
    SET Compra_mercado          = ISNULL((SELECT SUM(Activo_FlujoMO)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0)  -- SUM(Activo_FlujoMO)  
    ,   Compra_mercado_usd     = ISNULL((SELECT SUM(Activo_FlujoUSD)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0) -- SUM(Activo_FlujoUSD)  
    , Compra_mercado_clp      = ISNULL((SELECT SUM(Activo_FlujoCLP)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0) -- SUM(Activo_FlujoCLP)  
    ,   Compra_Valor_presente   = ISNULL((SELECT SUM(Activo_FlujoMO)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0)  -- COnvierte solo si es necesario  
                                  * ( case when recibimos_moneda = compra_moneda Then 1.0  
                                      else ( select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = compra_moneda )  
                                          / ( Case when   
                                                   0 = isnull( (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = recibimos_moneda) , 0 ) then 1.0  
                                                  else (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = recibimos_moneda) end )  
                                      end )  
  
    WHERE  tipo_flujo = 1 and ( @Operacion = 0 or Numero_operacion = @Operacion )  
  
    UPDATE  CARTERA_SIM      
    SET Venta_mercado     = ISNULL((SELECT SUM(Pasivo_FlujoMO)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0)  --SUM(Pasivo_FlujoMO)  
    ,   Venta_mercado_usd   = ISNULL((SELECT SUM(Pasivo_FlujoUSD)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0) --SUM(Pasivo_FlujoUSD)  
    , Venta_mercado_clp      = ISNULL((SELECT SUM(Pasivo_FlujoCLP)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0) --SUM(Pasivo_FlujoCLP)  
    ,   Venta_Valor_presente    = ISNULL((SELECT SUM(Pasivo_FlujoMO)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion And Estado <> 'N'),0)  -- COnvierte solo si es necesario  
                                  * ( case when Pagamos_moneda = venta_moneda Then 1.0  
                                      else ( select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = Venta_moneda )  
  / ( Case when   
                 0 = isnull( (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = Pagamos_moneda) , 0 ) then 1.0  
                                                  else (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = pagamos_moneda) end )  
                                      end )  
    WHERE  tipo_flujo = 2 and ( @Operacion = 0 or Numero_operacion = @Operacion )  
  
--  02/04/2008   
  
    --> Calculando valor razonable  
    UPDATE CARTERA_SIM  
       SET Valor_RazonableMO  = Activo_FlujoMO  - Pasivo_FlujoMO,  
           Valor_RazonableUSD = Activo_FlujoUSD - Pasivo_FlujoUSD,  
           Valor_RazonableCLP = Activo_FlujoCLP - Pasivo_FlujoCLP  
    where  @Operacion = 0   
        or Numero_operacion = @Operacion   
       And Estado <> 'N'    
  
    SELECT 'NumeroOperacion'   = Numero_Operacion,  
 'ValorRazonableMO'  = SUM(Valor_RazonableMO),  
           'ValorRazonableUSD' = SUM(Valor_RazonableUSD),  
           'ValorRazonableCLP' = SUM(Valor_RazonableCLP)  
  
      INTO #tmpCarteraVRazonable  
      FROM dbo.CARTERA_SIM Ctr  
      WHERE @Operacion = 0 or Numero_operacion = @Operacion  
      And Estado <> 'N'    
     GROUP BY  
    Numero_Operacion  
          
    UPDATE CARTERA_SIM   
       SET Valor_RazonableMO  = ValorRazonableMO,  -- (SELECT SUM(Valor_RazonableMO)  FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion)  
           Valor_RazonableUSD = ValorRazonableUSD, -- (SELECT SUM(Valor_RazonableUSD) FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion)  
           Valor_RazonableCLP = ValorRazonableCLP  -- (SELECT SUM(Valor_RazonableCLP) FROM CARTERA_SIM Ctr WHERE Ctr.Numero_Operacion = Cartera_Sim.Numero_Operacion)  
  
      FROM #tmpCarteraVRazonable  
     WHERE Numero_Operacion   = NumeroOperacion and ( @Operacion = 0 or CARTERA_SIM.Numero_operacion = @Operacion )  
  
    EXECUTE SP_CALCULA_DUR_CNVX_SWAP_SIM @Fecha_Proc, @Operacion  --Valorización Swap x Curva '0'      
  
    -- retorna operaciones sin tasaMTM. (validar si depuracion sera necesaria en el futuro)  
    IF (SELECT COUNT(*) FROM #OperacSNTasa) > 0  
    BEGIN  
        SELECT DISTINCT sistema, numero_operacion, moneda, producto, glosa FROM #OperacSNTasa   
        RETURN (1)  
  
    END  
  
---    SELECT 3, Valor_RazonableCLP FROM CARTERA_SIM WHERE Numero_Operacion = @Operacion AND numero_flujo = 1 AND tipo_flujo = 1  
    RETURN(1)  
  
END
GO
