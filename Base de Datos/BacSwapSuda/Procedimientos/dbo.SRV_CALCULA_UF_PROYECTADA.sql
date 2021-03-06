USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CALCULA_UF_PROYECTADA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SRV_CALCULA_UF_PROYECTADA]
   (   @FechaProceso   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   -- Se solicita agregar  return hasta verificar que no haya dependencias en curso, para más  adelante eliminar este proceso
   RETURN
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )
                               END
      FROM BacSwapSuda..SWAPGENERAL
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

   IF @FechaProceso <> @FechaCalculos
      SET @FechaProceso = @FechaCalculos

   DECLARE @Contrato    NUMERIC(10)
   DECLARE @Flujo       NUMERIC(10)
   DECLARE @iMoneda     INTEGER
   DECLARE @TipoFlujo   INTEGER
   DECLARE @TipoTasa    INTEGER
   DECLARE @Plazo       NUMERIC(9)
   DECLARE @PlazoInicio NUMERIC(9)
   DECLARE @dftermino   DATETIME
   DECLARE @dVctoFlujo  DATETIME
   DECLARE @dIniFlujo   DATETIME
   DECLARE @TasaUF      FLOAT
   DECLARE @TasaCLP     FLOAT
   DECLARE @vUFProy     FLOAT
   DECLARE @vUFIni      FLOAT

   CREATE TABLE #TASA_MONEDA
   (   Tasa         FLOAT
   ,   Spreed       FLOAT
   ,   SpotCompra   FLOAT
   ,   SpotVenta    FLOAT
   )

   -->    Genera TMP con los valores necesarios para calcular UF proyectada
   SELECT Contrato           = numero_operacion
   ,      Flujo              = numero_flujo
   ,      TipoFlujo          = tipo_flujo
   ,      Plazo              = DATEDIFF(DAY, @FechaCalculos, fecha_vence_flujo) --> DATEDIFF(DAY, @FechaProceso, fecha_vence_flujo) -- fecha_termino)
   ,      Moneda             = CASE WHEN tipo_flujo = 1 THEN compra_moneda 
                                    ELSE                     venta_moneda
                               END
   ,      TipoTasa           = CASE WHEN tipo_flujo = 1 THEN CASE WHEN compra_codigo_tasa = 0 THEN 0 ELSE 1 END
                                    ELSE                     CASE WHEN venta_codigo_tasa  = 0 THEN 0 ELSE 1 END
                               END
   ,      fecha_termino      = fecha_termino
   ,      fecha_vence_flujo  = fecha_vence_flujo
   ,      fecha_inicio_flujo = fecha_inicio_flujo
   ,      Puntero            = identity(INT)
   INTO   #CARTERA_SWAP
   FROM   BacSwapSuda..CARTERA 
   WHERE  CASE WHEN Tipo_Flujo = 1 THEN compra_moneda ELSE venta_moneda END = 998
      
   CREATE INDEX #ixt_CARTERA_SWAP ON #CARTERA_SWAP (Puntero)

   DECLARE @iRegistros      NUMERIC(10)
       SET @iRegistros      = (SELECT MAX(Puntero) FROM #CARTERA_SWAP)

   DECLARE @iContador       NUMERIC(10)
       SET @iContador       = 1

   -->    Recorre la TMP para calcular UF proyectada
   WHILE @iRegistros >= @iContador
   BEGIN
      SELECT @Contrato    = Contrato
      ,      @Flujo       = Flujo
      ,      @TipoFlujo   = TipoFlujo
      ,      @Plazo       = Plazo
      ,      @iMoneda     = Moneda
      ,      @TipoTasa    = TipoTasa
      ,      @dftermino   = fecha_termino
      ,      @dVctoFlujo  = fecha_vence_flujo
      ,      @dIniFlujo   = fecha_inicio_flujo
      FROM   #CARTERA_SWAP
      WHERE  Puntero      = @iContador

      -->    Solamente para los contratos en Moneda UF
      IF @iMoneda = 998
      BEGIN
         --> Proyecion UF a Fecha Inicio Flujo
             --> Si la UF de Inicio es conocida, se asume el valor a la fecha de Inicio del Flujo
         SET @vUFIni  = 0.0
         SET @vUFIni  = ISNULL( (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dIniFlujo AND vmcodigo = 998), 0.0)

             --> Si la UF de Inicio No es conocida, se debe proyectar a la fecha de Inicio del Flujo
         IF  @vUFIni = 0.0
         BEGIN
            SET @PlazoInicio = DATEDIFF(DAY, @FechaCalculos, @dIniFlujo) --> DATEDIFF(DAY, @FechaProceso, @dIniFlujo)

            TRUNCATE TABLE #TASA_MONEDA
            INSERT INTO #TASA_MONEDA EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA 998, @PlazoInicio, 'BFW', 3, -1, -1, -1, 'C'  
                    SET @TasaUF  = (SELECT Tasa FROM #TASA_MONEDA)

            TRUNCATE TABLE #TASA_MONEDA
            INSERT INTO #TASA_MONEDA EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA 999, @PlazoInicio, 'BFW', 3, -1, -1, -1, 'C'  
                    SET @TasaCLP = (SELECT Tasa FROM #TASA_MONEDA)

            --> EXECUTE SP_CALCULO_UF_PROY_SWAP @FechaProceso,  @dIniFlujo, @TasaUF, @TasaCLP, @vUFIni OUTPUT
                EXECUTE SP_CALCULO_UF_PROY_SWAP @FechaCalculos, @dIniFlujo, @TasaUF, @TasaCLP, @vUFIni OUTPUT
         END
         --> Proyecion UF a Fecha Inicio Flujo

         --> Si la UF de termino es conocida, no se proyecta, Se debe utilizar la UF Conocida.
         SET @vUFProy = 0.0
         SET @vUFProy = ISNULL( (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dVctoFlujo AND vmcodigo = 998), 0.0)

         --> Proyecion UF a Fecha Termino Flujo
         IF @vUFProy = 0.0
         BEGIN
            IF @TipoTasa  = 1
               SET @Plazo = DATEDIFF(DAY, @FechaCalculos, @dVctoFlujo) --> DATEDIFF(DAY, @FechaProceso, @dVctoFlujo)

            TRUNCATE TABLE #TASA_MONEDA
            INSERT INTO #TASA_MONEDA EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA 998, @Plazo, 'BFW', 3, -1, -1, -1, 'C'  
                    SET @TasaUF  = (SELECT Tasa FROM #TASA_MONEDA)

            TRUNCATE TABLE #TASA_MONEDA
            INSERT INTO #TASA_MONEDA EXECUTE BacFwdSuda..SP_RETORNATASAMONEDA 999, @Plazo, 'BFW', 3, -1, -1, -1, 'C'  
                    SET @TasaCLP = (SELECT Tasa FROM #TASA_MONEDA)

            --> EXECUTE SP_CALCULO_UF_PROY_SWAP @FechaProceso,  @dVctoFlujo, @TasaUF, @TasaCLP, @vUFProy OUTPUT
                EXECUTE SP_CALCULO_UF_PROY_SWAP @FechaCalculos, @dVctoFlujo, @TasaUF, @TasaCLP, @vUFProy OUTPUT
         END
         --> Proyecion UF a Fecha Termino Flujo

         DELETE FROM RELACION_CONTRATO_UFPROYECTADA 
               WHERE FechaProceso   = @FechaProceso 
                 AND NumeroContrato = @Contrato
                 AND TipoFlujo      = @TipoFlujo
                 AND NumeroFlujo    = @Flujo

         INSERT INTO RELACION_CONTRATO_UFPROYECTADA
         (   FechaProceso
         ,   NumeroContrato
         ,   TipoFlujo
         ,   NumeroFlujo
         ,   Plazo
         ,   CurvaUf
         ,   CurvaClp
         ,   UFProyectada
         ,   UFProyInicio
         )
         VALUES
         (   @FechaProceso
         ,   @Contrato
         ,   @TipoFlujo
         ,   @Flujo
         ,   @Plazo
         ,   @TasaUF
         ,   @TasaCLP
         ,   @vUFProy
         ,   @vUFIni
         )
      END

      SET @iContador = @iContador + 1
   END

END
GO
