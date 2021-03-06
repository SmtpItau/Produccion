USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REHACEFLUJOS_PAPA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REHACEFLUJOS_PAPA]  
   (   @iNumOperacion   NUMERIC(9)     
   ,   @iMensaje        VARCHAR(100)  
   ,   @nNumFlujo NUMERIC(9)  
   ,   @dFechaFijacion  DATETIME  
   )  
AS  
BEGIN  
  
 IF @nNumFlujo = 0  
 BEGIN  
  SELECT 'No se puede Modificar el Flujo 0'  
  RETURN  
 END  
  
 /*******************************************************  
 * Modificado por funcionalidad Anticipos  
 * Descarta de este proceso los flujos que liquidan el   
 * anticipo.  
 * Todos los cambios señalados con MAP 20071029  
 *******************************************************/  
   -->    NOTA: Este Proceso. Recalcula el interes para los flujos vigentes, inclusive el que parte hoy y el que se encuentra venciendo  
   -->          para las operaciones que contengan alguna tasa, en que su modalidad de recalculo sea diaria.  
   -->    Eje.: SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 AND nemo = 'S'  
   SET NOCOUNT ON  
  
   -->     (1.0)   Retorna Mensaje de Error (Orror) o de Ok  
   SELECT  @iMensaje           = ''  
   -->     ****************************************  
  
   -->     (2.0)   Obtiene la Fecha de Proceso  
   DECLARE @FechaProceso       DATETIME  
   SELECT  @FechaProceso       = fechaproc  
   FROM    SWAPGENERAL  
   -->     ****************************************  
  
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
   DECLARE @FechaCalculos    DATETIME  
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc  
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )  
                               END  
      FROM BacSwapSuda..SWAPGENERAL  
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
  
  
   -->     (2.1)   Factor para Convertir Interes en Pesos a Dolares  
   DECLARE @DolarObs           FLOAT  
   SELECT  @DolarObs           = ISNULL(vmvalor,1)  
   FROM    bacparamsuda..VALOR_MONEDA  
   WHERE   vmcodigo            = 994  
   AND     vmfecha             = @dFechaFijacion --> @FechaProceso --> Modificacion para recalculo de un flujo  
   -->     ****************************************     
  
   -->     (2.3)   Parametrización Valor MOneda  
   SELECT  vmcodigo  
   ,       vmvalor  
   INTO    #MiValorMoneda  
   FROM    BacParamSuda..VALOR_MONEDA  
   WHERE   vmfecha       = @dFechaFijacion --> CASE WHEN vmcodigo = 998 THEN @FechaCalculos ELSE @FechaProceso END --> Modificacion para recalculo de un flujo  
   AND     vmcodigo     <> 999  
  
   INSERT INTO #MiValorMoneda  
   SELECT  13  
   ,       vmvalor  
   FROM    BacParamSuda..VALOR_MONEDA  
   WHERE   vmfecha       = @dFechaFijacion --> @FechaProceso --> Modificacion para recalculo de un flujo  
   AND     vmcodigo      = 994  
  
   INSERT INTO #MiValorMoneda  
   SELECT  999  
   ,       1.0  
   -->     ****************************************     
  
  
   -->     (Extra)   Genera un "Cursor" por Tipo de Flujo  
      -->   1.- Uno = Compra  
      -->   2.- Dos = Venta  
   DECLARE @TipoFlujo          INTEGER  
   SELECT  @TipoFlujo          = 1  
  
  
   WHILE   2 >= @TipoFlujo  
   BEGIN  
  
      IF @TipoFlujo > 2  
      BEGIN  
         BREAK  
      END  
  
      -->     (3.0)   Obtiene el Codigo de la Tasa respecto al Flujo  
      DECLARE @TipoTasa           INTEGER  
      ,       @iMoneda            INTEGER  
      ,       @iFlujoMenor        INTEGER  
      ,       @iFlujoMayor        INTEGER  
  
      SELECT  @TipoTasa           = CASE WHEN @TipoFlujo = 1 THEN compra_codigo_tasa ELSE venta_codigo_tasa END  
      ,       @iMoneda            = CASE WHEN @TipoFlujo = 1 THEN compra_moneda      ELSE venta_moneda      END  
      FROM    CARTERA  
      WHERE   Numero_Operacion    = @iNumOperacion  
        AND   numero_flujo   = @nNumFlujo --> Modificacion para recalculo de un flujo  
      AND     tipo_flujo          = @TipoFlujo --> 1  
--      AND     Fecha_Inicio_Flujo <= @FechaProceso  
--  AND     Fecha_Vence_Flujo  >= @FechaProceso  
 AND   Estado <> 'N'                            -- MAP 20071029  
      -->     ****************************************  
  
  
      -->     (3.1)   Genera la Cantidad de Flujos Vigentes  
      SELECT  @iFlujoMenor        = MIN(Numero_Flujo)  
      ,       @iFlujoMayor        = MAX(Numero_Flujo)  
      FROM    CARTERA  
      WHERE   Numero_Operacion    = @iNumOperacion  
        AND   numero_flujo   = @nNumFlujo --> Modificacion para recalculo de un flujo  
      AND     tipo_flujo          = @TipoFlujo --> 1  
--      AND     Fecha_Inicio_Flujo <= @FechaProceso  
--      AND     Fecha_Vence_Flujo  >= @FechaProceso  
 AND   Estado <> 'N'                            -- MAP 20071029  
      -->     ****************************************  
  
  
      -->     (4.0)   Determina de se debe realizar el Recalculo de los Flujos Vigentes  
      DECLARE @iRecalculo         INTEGER  
      DECLARE @cGlosaTasa         VARCHAR(25)  
  
      SELECT  @iRecalculo         = 0  
      ,       @cGlosaTasa         = ''  
      SELECT  @iRecalculo         = CASE WHEN ISNULL(nemo,'N') = 'S' THEN 1 ELSE 0 END  
      ,       @cGlosaTasa         = CONVERT(CHAR(25),ISNULL(tbglosa,'No Especificada.'))  
      FROM    BacParamSuda..TABLA_GENERAL_DETALLE  
      WHERE   tbcateg             = 1042   
      AND     tbcodigo1           = @TipoTasa  
      -->     ****************************************  
  
       SET @iRecalculo = 1 --cbb  
  
      -->     (5.0)   Tasa Se Recalcula Diariamente  
      IF @iRecalculo = 1  
      BEGIN  
  
         -->     (6.0)   Obtiene el Valor de la Tasa... Si no Existe Aborta el Proceso  
         DECLARE @iValorTasa         FLOAT  
         ,       @iFound             INTEGER  
  
         SELECT  @iFound             = -1  
         SELECT  @iValorTasa         = ISNULL(tasa,0.0)  
         ,       @iFound             = 0  
         FROM    BacParamSuda..MONEDA_TASA  
         WHERE   codmon              = @iMoneda  
         AND     codtasa             = @TipoTasa  
         AND     fecha               = @dFechaFijacion  
         AND     periodo             = 4 --> Mensual en la Pantalla de Valores de Tasas por Moneda.  
  
  
      -->     (3.1)   Genera la Cantidad de Flujos Vigentes  
      SELECT  @iFound    = 0  
 ,     @iValorTasa   = MIN(CASE WHEN @TipoFlujo = 1 THEN compra_valor_tasa ELSE venta_valor_tasa END)  
      FROM    CARTERA  
      WHERE   Numero_Operacion    = @iNumOperacion  
        AND   numero_flujo   = @nNumFlujo --> Modificacion para recalculo de un flujo  
      AND     tipo_flujo          = @TipoFlujo --> 1  
 AND   Estado <> 'N'                            -- MAP 20071029  
      -->     ****************************************  
  
  
         IF @iFound = -1 OR isnull(@iValorTasa,0.0) = 0.0  
         BEGIN  
            SELECT  @iMensaje        = CONVERT(VARCHAR(100),'Valor de Tasa en ' + LTRIM(RTRIM(ISNULL(@iValorTasa,0.0))) + ' para la : ' + LTRIM(RTRIM(@cGlosaTasa)) + ' a la fecha : ' + CONVERT(CHAR(10),@FechaProceso,103) + ' Rel. Moneda : ' + LTRIM(RTRIM(@iMoneda)))
            RETURN -1   
         END  
         -->     ****************************************  
  
  
         -->     (7.0)   Comienza a recorrer cada uno de los flujos (El que Comienza a Regir y el que se esta Venciendo)  
         DECLARE @dIniFlujo          DATETIME  
         ,       @dFinFlujo          DATETIME  
         ,       @SaldoK             FLOAT  
         ,       @TipoBase           INTEGER  
         ,       @Spread             FLOAT  
         ,       @PeriBase           VARCHAR(5)  
         ,       @PeriDias           VARCHAR(5)  
         ,       @BaseInteres        FLOAT  
         ,       @DifDias            FLOAT  
         ,       @iPlazo             FLOAT  
         ,       @Interes            FLOAT  
         ,       @Dolares            FLOAT  
         ,       @InteresPesos       NUMERIC(21,4)  
  
  
         WHILE @iFlujoMayor >= @iFlujoMenor  
         BEGIN  
            -->     (7.1)   Rescata los valores para ReCalcular el Flujo  
            SELECT  @dIniFlujo          = fecha_inicio_flujo  
            ,       @dFinFlujo          = fecha_vence_flujo  
            ,       @SaldoK             = CASE WHEN @TipoFlujo = 1 THEN compra_saldo + Compra_Amortiza    
                                               ELSE                     venta_saldo  + Venta_Amortiza   
                                          END  
            ,       @TipoBase           = CASE WHEN @TipoFlujo = 1 THEN compra_base   ELSE venta_base   END  
            ,       @Spread             = CASE WHEN @TipoFlujo = 1 THEN compra_spread ELSE venta_spread END  
            FROM    CARTERA  
            WHERE   Numero_Operacion    = @iNumOperacion  
     and     numero_flujo        = @nNumFlujo  
            AND     tipo_flujo          = @TipoFlujo --> 1  
--            AND     Fecha_Inicio_Flujo <= @FechaProceso  
--            AND     Fecha_Vence_Flujo  >= @FechaProceso  
--            AND     Numero_Flujo        = @iFlujoMenor  
     AND   Estado <> 'N'                            -- MAP 20071029  
            -->     ****************************************************  
  
            -->    (7.2)   Rescata Factores para la Asignacion de la Base o Generación de la Diferencia de Dias  
            SELECT @PeriDias  = Dias  
            ,      @PeriBase  = Base  
            FROM   BASE  
            WHERE  Codigo     = @TipoBase  
            -->   ******************************************  
  
            -->    (7.3)   Asignación de Base   
            IF @PeriBase = 'A'  
            BEGIN  
               SELECT @BaseInteres = 365  
            END ELSE  
            BEGIN  
               SELECT @BaseInteres = CONVERT(INTEGER,@PeriBase)  
            END  
            -->   ******************************************  
  
            -->   (7.4)   Generación de la Diferencia de Dias  
            IF @PeriDias = 'A'  
            BEGIN  
               SELECT @DifDias = DATEDIFF(DAY, @dIniFlujo, @dFinFlujo)  
            END ELSE  
            BEGIN  
               EXECUTE DIFDIAS30 @dIniFlujo , @dFinFlujo , @DifDias OUTPUT    
            END  
            -->   ******************************************  
  
            -->   (7.5)   Generación del Plazo en funcion de la Base  
            SELECT @iPlazo       = (@DifDias / @BaseInteres)  
            -->   ******************************************  
  
            -->   (7.6)   Genera el Calculo del Flujo  
            -->    SELECT @SaldoK  ,@iValorTasa,@Spread,(@iPlazo)--CBB  
            SELECT @Interes      = @SaldoK  * ((@iValorTasa + @Spread)/100.0) * (@iPlazo)  
  
            SELECT @InteresPesos = ROUND(@Interes * vmvalor,0)  
            FROM   #MiValorMoneda  
            WHERE  vmcodigo      = @iMoneda  
  
            SELECT @Dolares      = @InteresPesos / @DolarObs  
            -->   ******************************************  
  
            -->   (7.7) Actualización de cartera para la Operacion y el flujo Vigente  
            IF @TipoFlujo = 1  
            BEGIN  
               UPDATE CARTERA  
               SET    compra_interes        = @Interes  
               ,      compra_valor_tasa     = CONVERT(NUMERIC(21,6),@iValorTasa)  
               ,      compra_valor_tasa_hoy = CONVERT(NUMERIC(21,6),@iValorTasa)  
               ,      recibimos_monto_CLP   = @InteresPesos  
               ,      recibimos_monto_USD   = @Dolares  
               FROM   CARTERA  
               WHERE  Numero_Operacion      = @iNumOperacion  
               AND    Numero_Flujo          = @nNumFlujo --> @iFlujoMenor  
               AND    tipo_flujo            = @TipoFlujo --> 1  
                AND   Estado <> 'N'                            -- MAP 20071029  
            END ELSE  
            BEGIN  
               UPDATE CARTERA  
               SET    venta_interes         = @Interes  
               ,      venta_valor_tasa      = CONVERT(NUMERIC(21,6),@iValorTasa)  
               ,      venta_valor_tasa_hoy  = CONVERT(NUMERIC(21,6),@iValorTasa)  
               ,      pagamos_monto_CLP     = @InteresPesos  
               ,      pagamos_monto_USD     = @Dolares  
               FROM   CARTERA  
               WHERE  Numero_Operacion      = @iNumOperacion  
               AND    Numero_Flujo          = @nNumFlujo --> @iFlujoMenor  
               AND    tipo_flujo            = @TipoFlujo --> 1  
        AND   Estado <> 'N'                            -- MAP 20071029  
            END  
            -->   ******************************************  
  
            -->   (7.8)   Mueve el Puntero al Siguiente Flujo Vigente para la operación  
            SELECT  @iFlujoMenor        = @iFlujoMenor + 1  
            -->   ******************************************  
  
         END --> End While            (7.0)  
      END   --> End If del Reclaculo  (5.0)  
  
      SELECT @TipoFlujo = @TipoFlujo + 1  
   END   --> End While Tipo Flujo     (Extra)  
  
   SELECT @iMensaje = 'Calculo Ok para el Swap ' + LTRIM(RTRIM(@iNumOperacion))  
   RETURN 0  
  
END
GO
