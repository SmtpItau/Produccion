USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REHACEFLUJOS_TPCA_Paso]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REHACEFLUJOS_TPCA_Paso]
   (   @iNumOperacion   NUMERIC(9)   )
AS
BEGIN

	/***********************************************
	* Modificado por funcionalidad de Antitipos
	* Todos los cambios MAP 20071029
	************************************************/

   SET NOCOUNT ON

   DECLARE @iTipoFlujo   INTEGER
   ,       @iTCP         FLOAT    -- NUMERIC(21,4)
   ,       @Moneda       INTEGER
   ,       @dIniFlujo    DATETIME
   ,       @dFinFlujo    DATETIME
   ,       @TipoBase     INTEGER
   ,       @DolarObs     FLOAT    -- NUMERIC(21,4)
   ,       @CantFlujos   INTEGER
   ,       @RegiFlujos   INTEGER
   ,       @Interes      FLOAT    -- NUMERIC(21,4)
   ,       @SaldoK       FLOAT    -- NUMERIC(21,4)
   ,       @Spread       FLOAT    -- NUMERIC(21,4)
   ,       @BaseInteres  FLOAT    -- INTEGER
   ,       @DifDias      FLOAT    -- NUMERIC(21,4)
   ,       @PeriBase     VARCHAR(5)
   ,       @PeriDias     VARCHAR(5)
   ,       @iPlazo       FLOAT    -- NUMERIC(21,4)
   ,       @Dolares      FLOAT    -- NUMERIC(21,4)

   ,       @Primera         CHAR(1)
   ,       @FechaProceso    DATETIME
   DECLARE @MinNumFlujo     INTEGER


   SELECT  @FechaProceso = fechaproc
   FROM    SWAPGENERAL  


   --   Factor para Convertir Interes en Pesos a Dolares
   SELECT  @DolarObs         = ISNULL(vmvalor,1)
   FROM    bacparamsuda..VALOR_MONEDA
   WHERE   vmcodigo          = 994
   and     vmfecha           = @FechaProceso

-- select 'debug', '@DolarObs', @DolarObs, '@FechaProceso', @FechaProceso 

   SELECT  @MinNumFlujo       = MIN(numero_flujo)
   FROM    CARTERA
   WHERE   numero_operacion   = @iNumOperacion
   AND     fecha_vence_flujo >= @FechaProceso
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

   --   Tipo de Flujo Indica que se tomaran valores de Compra o Venta 
   SELECT  @iTipoFlujo      = CASE WHEN compra_codigo_tasa = 13 THEN 1 ELSE 2 END
   FROM    CARTERA
   WHERE   numero_operacion = @iNumOperacion
   and     numero_flujo     = @MinNumFlujo
   and     tipo_flujo       = 1
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

   -- MAP 20090102 Contingencia
   select  @iTipoFlujo = ( select distinct tipo_flujo from cartera where  numero_operacion = @iNumOperacion and compra_Codigo_tasa + venta_codigo_tasa = 13  )

   SELECT  @CantFlujos         = MAX(numero_flujo)
   ,       @RegiFlujos         = MIN(numero_flujo)
   FROM    CARTERA
   WHERE   numero_operacion    = @iNumOperacion
   AND     tipo_flujo          = @iTipoFlujo
   AND     fecha_vence_flujo  >= @FechaProceso
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

   SELECT @Primera   = 'S'

   --   Ciclo que recalculara Intereses para y por cada uno de los flujos que esten vigentes

   WHILE @CantFlujos >= @RegiFlujos
   BEGIN


      SELECT @Moneda            = CASE WHEN @iTipoFlujo = 1 THEN Compra_moneda ELSE venta_moneda END
      ,      @dIniFlujo         = fecha_inicio_flujo
      ,      @dFinFlujo         = fecha_vence_flujo
      ,      @SaldoK            = CASE WHEN @iTipoFlujo = 1 THEN compra_saldo + Compra_Amortiza  
                                           ELSE                      venta_saldo  + Venta_Amortiza 
                                  END
      ,      @TipoBase          = CASE WHEN @iTipoFlujo = 1 THEN compra_base   ELSE venta_base   END
      ,      @Spread            = CASE WHEN @iTipoFlujo = 1 THEN compra_spread ELSE venta_spread END
      FROM   CARTERA
      WHERE  numero_operacion   = @iNumOperacion
      AND    tipo_flujo         = @iTipoFlujo
      AND    numero_flujo       = @RegiFlujos
      AND    fecha_vence_flujo >= @FechaProceso

      --   Factores para la Asignacion de la Base o Generación de la Diferencia de Dias
      SELECT @PeriDias  = Dias
      ,      @PeriBase  = Base
      FROM   BASE
      WHERE  Codigo     = @TipoBase

      --   Asignación de Base 
      IF @PeriBase = 'A'
      BEGIN
         SELECT @BaseInteres = 365
      END ELSE
      BEGIN
         SELECT @BaseInteres = CONVERT(INTEGER,@PeriBase)
      END

      --   Generación de la Diferencia de Dias
    IF @PeriDias = 'A'
      BEGIN
         SELECT @DifDias = DATEDIFF(DAY,@dIniFlujo,@dFinFlujo)
      END ELSE
      BEGIN
         EXECUTE DIFDIAS30 @dIniFlujo , @dFinFlujo , @DifDias OUTPUT  
      END

      --   Generación del Plazo en funcion de la Base
      SELECT  @iPlazo = (@DifDias / @BaseInteres)


      IF @@ERROR <> 0
      BEGIN
         SELECT -1
         RETURN -1
      END
      --   Generación del Calculo de la Tasa (SOLO CON EL PRIMER FLUJO)

--      select 'a', @Primera

      IF @Primera = 'S'
      BEGIN

         SELECT  @iTCP         = 0.0

         EXECUTE SRV_CALCULO_TPCA_DEV @Moneda , @dIniFlujo , @dFinFlujo , @iTCP OUTPUT  

         IF @iTCP = -9999 --> -1
         BEGIN
            RETURN -1
         END
      END

      SELECT @Interes = @SaldoK  * ((@iTCP+@Spread)/100.0) * (@iPlazo)
      SELECT @Dolares = @Interes / @DolarObs

      IF @iTipoFlujo = 1
      BEGIN
         UPDATE CARTERA
         SET    compra_interes        = @Interes
         ,      compra_valor_tasa     = CONVERT(NUMERIC(21,4),@iTCP)
         ,      compra_valor_tasa_hoy = CONVERT(NUMERIC(21,4),@iTCP)
         ,      recibimos_monto_CLP   = @Interes
         ,      recibimos_monto_USD   = @Dolares
         WHERE  numero_operacion      = @iNumOperacion
         AND    tipo_flujo            = @iTipoFlujo
         AND    numero_flujo         >= @RegiFlujos
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

      END ELSE
      BEGIN

         UPDATE CARTERA
         SET    venta_interes         = @Interes
         ,      venta_valor_tasa      = CONVERT(NUMERIC(21,4),@iTCP)
         ,      venta_valor_tasa_hoy  = CONVERT(NUMERIC(21,4),@iTCP)
         ,      pagamos_monto_CLP     = @Interes
         ,      pagamos_monto_USD     = @Dolares
         WHERE  numero_operacion      = @iNumOperacion
         AND    tipo_flujo            = @iTipoFlujo
         AND    numero_flujo         >= @RegiFlujos
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

      END

      SELECT @RegiFlujos    = @RegiFlujos + 1
      SELECT @Primera       = 'N'
   END

   RETURN 0

END


GO
