USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNAPARIDADFORWARD_TURING]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETORNAPARIDADFORWARD_TURING]
   (   @iMoneda		   NUMERIC(5) -- Codigo Moneda
   ,   @iPlazo		   FLOAT      -- NUMERIC(9) -- Plazo Contrato    ¡Por mientras !!!
   ,   @Operacion	   INT    -- 1:Compra; 2:Ventas
   ,   @Fecha		   CHAR(08)   -- Fecha de Hoy
   ,   @dFechaPrxProceso   CHAR(08)   = '19000101'	-- ESTA FECHA SE USA CUANDO 
   -- SE VALORIZA RESULTADO BACK TEST
   )
AS
BEGIN

   -- MODIFICADO PARA RESULTADO BACK TEST 04/02/2008

   SET NOCOUNT ON

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, acfecproc) = DATEPART(MONTH, acfecprox) THEN acfecproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, acfecproc)) *-1, DATEADD(MONTH, 1, acfecproc) )
                               END
      FROM MFAC
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos


   DECLARE @iFound        INT
   ,       @iMinParidad   FLOAT
   ,       @iMaxParidad   FLOAT
   ,       @iMinDias      NUMERIC(9) 
   ,       @iMaxDias      NUMERIC(9)
   ,	   @iAntMaxDias	  NUMERIC(9)
   ,       @iDiferencia   FLOAT
   ,       @iDifDias      NUMERIC(9)

   ,       @Inter         FLOAT
   ,       @ParForward    FLOAT

   ,       @iPrecioPunta  FLOAT
   ,       @iParidadMon   NUMERIC(21,4)
   ,       @nFactor       NUMERIC(21,4)
   ,       @Inferido      FLOAT

   SELECT @ParForward    = 0.0
   ,      @iMinParidad   = 0.0
   ,      @iMaxParidad   = 0.0
   ,      @nFactor       = 1.0

   SELECT @iPrecioPunta = ISNULL( CASE WHEN @Operacion = 1 THEN vmptavta ELSE vmptacmp END , 0.0 )
   FROM   BacParamSuda..VALOR_MONEDA 
   WHERE  vmcodigo      = @iMoneda
   AND    vmfecha       = CASE WHEN @iMoneda = 998 THEN @FechaCalculos ELSE @Fecha END

   SELECT 'Paridad'    = CASE WHEN @Operacion = 1 THEN ask ELSE bid END
   ,      'Intervalo'  = penumero
   ,      'Conversion' = petipo
   ,      'Periodo'    = CASE WHEN petipo = 'D' THEN (penumero * 1.00)
                              WHEN petipo = 'M' THEN (penumero * 30.00)
                              WHEN petipo = 'Y' THEN (penumero * 365.00)
                         END
   ,      'Factor'     = factor 
   INTO   #Paridades_BidAsk
   FROM   MFBIDASK     LEFT JOIN BacParamSuda..PERIODO_TASA_BIDASK ON periodo = pecodigo
   WHERE  moneda       = @iMoneda
   AND    fecha        = CASE WHEN @dFechaPrxProceso <> '19000101'THEN @dFechaPrxProceso ELSE @Fecha END
   ORDER BY periodo

   SELECT @iFound      = -1

   SELECT @iFound      = 0
   ,      @iMinParidad = periodo
   ,      @iMaxParidad = periodo
   ,      @iMinDias    = @iPlazo
   ,      @iMaxDias    = @iPlazo
   ,      @nFactor     = factor
   FROM   #Paridades_BidAsk
   WHERE  Periodo  = @iPlazo

   IF @iFound = -1
   BEGIN
      SELECT @iMinDias    = isnull( MAX(Periodo), 0 )
      FROM   #Paridades_BidAsk
      WHERE  Periodo     <= @iPlazo
	
      SELECT @iMaxDias    = isnull( MIN(Periodo), 0 )
      FROM   #Paridades_BidAsk
      WHERE  Periodo     >= @iPlazo


      IF @iMaxDias = 0 
      BEGIN	
         -- EXTRAPOLACION SUPERIOR
         -- No hay punto superior ==> Extrapolacion Superior
         -- Extrapolar con los dos ultimos puntos de la curva:
         -- Ultimo Punto
         SELECT @iMaxDias    = MAX(Periodo)
         ,      @nFactor     = MAX(Factor) -- Debe ser el mismo en todos		
         FROM   #Paridades_BidAsk			
         -- Antepenultimo
         SELECT @iMinDias    = isnull( MAX(Periodo), 0 )			
         FROM   #Paridades_BidAsk			
         WHERE  Periodo      < @iMaxDias			
			
         SELECT @iMinParidad = paridad
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMinDias

         SELECT @iMaxParidad = paridad
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMaxDias

      END ELSE 
      IF @iMinDias = 0
      BEGIN
         -- EXTRAPOLACION INFERIOR
         -- Extrapolar con los dos primeros puntos ==> Extrapolacion Inferior			
         -- Primer Punto
         SELECT @iMinDias    = MIN(Periodo)
         ,      @nFactor     = MIN(Factor) -- Debe ser el mismo en todos		
         FROM   #Paridades_BidAsk
         -- Segundo Punto
         SELECT @iMaxDias    = MIN(Periodo)
         FROM   #Paridades_BidAsk			
         WHERE  Periodo      > @iMinDias

         SELECT @iMinParidad = paridad
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMinDias

         SELECT @iMaxParidad = paridad
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMaxDias
      END ELSE 	-- Interpolacion
      BEGIN
         SELECT @iMinParidad = paridad   
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMinDias

         SELECT @iMaxParidad = paridad
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMaxDias

         SELECT @nFactor     = factor
         FROM   #Paridades_BidAsk
         WHERE  Periodo      = @iMaxDias
      END

      EXECUTE Sp_Interpolar_Tasas  @iMinDias , @iMinParidad, @iMaxDias, @iMaxParidad, @iPlazo,  @Inferido OUTPUT
      -- SELECT @iMinDias , @iMinParidad, @iMaxDias, @iMaxParidad, @iPlazo,  @Inferido 

   END ELSE -- No fue necesaria interpolacion ni extrapolacion
   BEGIN	
      SELECT 	@iMinParidad = paridad
      ,      	@iMaxParidad = paridad
      ,         @Inferido    = paridad
      ,		@nFactor     = Factor 		
      FROM      #Paridades_BidAsk
      WHERE     Periodo      = @iMinDias

   END

   IF @nFactor > 0 
      SELECT @ParForward     = @iPrecioPunta + ( @Inferido * 1.0 ) / ( @nFactor * 1.0 )
   ELSE
      SELECT @ParForward     = @iPrecioPunta + ( @Inferido * 1.0 ) / 1.0

	SELECT	'PrecioForward'		= ISNULL(@ParForward,0.0)
	,		'ParidadMenor'		= ISNULL(@iMinParidad,0.0)
	,		'ParidadMayor'		= ISNULL(@iMaxParidad,0.0)
	,		'iPrecioPunta'		= ISNULL(@iPrecioPunta,0.0)
	,		'nFactor'			= ISNULL(@nFactor,0.0)

END

GO
