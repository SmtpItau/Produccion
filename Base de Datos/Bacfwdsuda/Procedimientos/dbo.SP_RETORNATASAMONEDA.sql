USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNATASAMONEDA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNATASAMONEDA]
   (   @iMoneda         NUMERIC(5)
   ,   @iPlazo          NUMERIC(9)
   ,   @cModulo         CHAR(3)    = 'BFW'
   ,   @cProducto       VARCHAR(5) = '*'
   ,   @iTipoTasa       INT    = -1
   ,   @iTipoFlujo      INT    = -1
   ,   @iTipoBase       INT    = 0
   ,   @cTipoOperacion  CHAR(1)    = 'C'
   ,   @iIndicador      INT    = -1 --> Indica la Tasa.
   ,   @TipoCurva       VARCHAR(5) = ''
   ,   @Accion          CHAR(8)    = 'Forward'  -- Acciones posibles: 'Forward': calcula tasa Forward
                                                --                    'Descont': para descontar
                                                --                    'DescMxMn: para caso Mx con Mn
   ,   @CurvaUsada      VARCHAR(20)= 'CURVA'  OUTPUT      -- Curva usada para valorizar
   ,   @dFecProc        DATETIME   = '19000101' -- SE UTILIZA PARA RESULTADO BACK TEST
   ,   @dFecPrxProc     DATETIME   = '19000101' -- SE UTILIZA PARA RESULTADO BACK TEST
 
   )
AS
BEGIN  

   SET NOCOUNT ON

   DECLARE @FechaProcesoBTR   DATETIME
      SET  @FechaProcesoBTR   = (SELECT acfecproc FROM BacTraderSuda..MDAC with(nolock) )

   -->     ***************************************************
   --      *******  NUEVO PROCESO DE RESCATE DE TASAS  *******
   -->     ***************************************************

   -->     Centraliza las curvas con la fecha e BacTrader
   DECLARE @dFechaProceso      CHAR(08)
       SET @dFechaProceso      = CONVERT(CHAR(8),@dFecProc,112)

   DECLARE @dFechaPrxProceso   CHAR(08)
       SET @dFechaPrxProceso   = CONVERT(CHAR(8),@dFecPrxProc,112)

   IF @cModulo <> 'PCS'
   BEGIN
      SET @iTipoBase  = 0
      SET @iIndicador = -1
      SET @TipoCurva  = ''
   END

   IF @cModulo <> 'PCS' AND @cProducto <> 'SM'
   BEGIN
      SET @iTipoTasa  = -1
      --> Identifica el flujo Entregamos o Recibimos de Swap
      SET @iTipoFlujo = -1
   END

   DECLARE @cInstrumento        VARCHAR(20)
   DECLARE @cEmisor             VARCHAR(20)
   DECLARE @iDias               FLOAT
   DECLARE @cCurvaPrincipal     VARCHAR(20)
   DECLARE @cCurvaAlternativa   VARCHAR(20)
   DECLARE @sSpread             CHAR(1)
   DECLARE @cCurvaSpread        VARCHAR(20)
   DECLARE @ValorCurvaProducto  FLOAT
   DECLARE @ValorCurvaSpread    FLOAT
   DECLARE @iCurvasHoy          INT
   DECLARE @iTasaEmision        INT
   DECLARE @cTipoTasa           CHAR(1)

       SET @cInstrumento        = '*'
       SET @cEmisor             = '*'
       SET @iDias               = @iPlazo
       SET @cCurvaPrincipal     = ''
       SET @cCurvaAlternativa   = ''
       SET @sSpread             = ''
       SET @cCurvaSpread        = ''
       SET @ValorCurvaProducto  = 0.0
       SET @ValorCurvaSpread    = 0.0
       SET @iCurvasHoy          = 0
       SET @iTasaEmision        = 0
       SET @cTipoTasa           = CASE WHEN @iTipoTasa = -1 THEN 'N'
                                       WHEN @iTipoTasa = 0  THEN 'F'
                                       WHEN @iTipoTasa = 1  THEN 'V'
                                  END

   -->     (3.0) Verifica la Existencia de Datos para la Fecha.
   DECLARE @iFound            INT

      SET  @iFound            = -1
   SELECT  @iFound            = 0
   FROM    BacParamSuda..CURVAS --(INDEX = Curvas_FechaGeneracion)
   WHERE   FechaGeneracion    = CASE WHEN @dFechaPrxProceso <> '19000101' THEN @dFechaPrxProceso 
                                     ELSE                                      @FechaProcesoBTR --> ( SELECT  acfecproc FROM BacTraderSuda..MDAC )
                                END

   IF @iFound = -1 
      SET @iCurvasHoy = 1 

   -->     Rescata las Tasas Desde Proceso Genérico
   EXECUTE BacParamSuda..SP_RETORNA_CURVAS_PRODUCTO @cModulo
                                                ,   @cProducto
                                                ,   @cTipoOperacion
                                             ,   @iMoneda
                                                ,   @cInstrumento
                                                ,   @cEmisor
                                                ,   @iDias
                                                ,   @cCurvaPrincipal     OUTPUT
                                                ,   @cCurvaAlternativa   OUTPUT
                                                ,   @sSpread             OUTPUT
                                                ,   @cCurvaSpread        OUTPUT
                                                ,   @ValorCurvaProducto  OUTPUT
                                                ,   @ValorCurvaSpread    OUTPUT
                                                ,   @iCurvasHoy
                                                ,   @iTasaEmision
                                                ,   @cTipoTasa
                                                ,   @iTipoFlujo
                                                ,   @iTipoBase
                                                ,   @iIndicador
                                                ,   @TipoCurva
                                                ,   @Accion              -- MAP 20080421
                                                ,   @CurvaUsada          OUTPUT -- MAP 20080421
                                                ,   @dFechaPrxProceso

   DECLARE @iSpotCompra   FLOAT
   DECLARE @iSpotVenta    FLOAT
   DECLARE @dFecha        DATETIME

   IF @dFechaProceso <> '19000101' 
   BEGIN
      SET @dFecha = @dFechaProceso
   END ELSE 
   BEGIN	
      SET @dFecha = @FechaProcesoBTR --> (SELECT acfecproc FROM BacTraderSuda..MDAC)
   END

   IF @iMoneda = 999
   BEGIN
      SET @iSpotCompra   = 1.0
      SET @iSpotVenta    = 1.0
   END ELSE
   BEGIN
      SET @iSpotCompra   = ISNULL(( SELECT TOP 1 SpotCompra FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFecha AND Codigo_Moneda = CASE WHEN @iMoneda = 13 THEN 994 ELSE @iMoneda END),0.0)
      SET @iSpotVenta    = ISNULL(( SELECT TOP 1 SpotVenta  FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFecha AND Codigo_Moneda = CASE WHEN @iMoneda = 13 THEN 994 ELSE @iMoneda END),0.0)
   END

   SELECT  Tasa           = @ValorCurvaProducto -- / 100.0
   ,       Spreed         = 0.0
   ,       SpotCompra     = @iSpotCompra
   ,       SpotCompra     = @iSpotVenta

   --> ***************************************************
   --  *******  NUEVO PROCESO DE RESCATE DE TASAS  *******
   --> ***************************************************
RETURN
/*
   DECLARE @iMinPlazo   NUMERIC(9)
   ,       @iMinTasa    FLOAT
   ,       @iMaxPlazo   NUMERIC(9)
   ,       @iMaxTasa    FLOAT

   DECLARE @iTasa     FLOAT
   ,       @iSpreed   FLOAT
   ,       @iSpotCom  FLOAT
   ,       @iSpotVen  FLOAT

   SELECT  @iTasa     = 0.0
   ,       @iSpreed   = 0.0
   ,       @iSpotCom  = 0.0
   ,       @iSpotVen  = 0.0
   ,       @iMinPlazo = 0
   ,       @iMinTasa  = 0.0
   ,       @iMaxPlazo = 0
   ,       @iMaxTasa  = 0.0

   SELECT  @iMinPlazo   = isnull( MAX(Plazo_Fin) , 0 )
   FROM    MF_TASAS_MTM
   WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
   AND     Plazo_Fin   <= @iPlazo

   SELECT  @iMaxPlazo   = isnull( MIN(Plazo_Fin) , 0 )
   FROM    MF_TASAS_MTM
   WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
   AND     Plazo_Fin   >= @iPlazo

   if @iMinPlazo = 0
   Begin -- Extrapolacion Inferior
      Select  @iMinPlazo   = @iMaxPlazo
      SELECT  @iMaxPlazo   = isnull( MIN(Plazo_Fin) , 0 )
      FROM    MF_TASAS_MTM
      WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
      AND     Plazo_Fin    > @iMinPlazo 
   end Else
   if @iMaxPlazo = 0
   Begin -- Extrapolacion Superior      
      SELECT  @iMaxPlazo   = isnull( MAX(Plazo_Fin) , 0 )
      FROM    MF_TASAS_MTM
      WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END

      SELECT  @iMinPlazo   = isnull( MAX(Plazo_Fin) , 0 )
      FROM    MF_TASAS_MTM
      WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
      AND     Plazo_Fin    < @iMaxPlazo   
   End

   SELECT  @iMinTasa    = (Tasa + Spread)
   ,       @iSpotCom    = fSpotCom
   ,       @iSpotVen    = fSpotVen
   FROM    MF_TASAS_MTM
   WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
   AND     Plazo_Fin    = @iMinPlazo

   SELECT  @iMaxTasa    = (Tasa + Spread)
   FROM    MF_TASAS_MTM
   WHERE   Moneda       = CASE WHEN @iMoneda = 994 THEN 13 ELSE @iMoneda END
   AND     Plazo_Fin    = @iMaxPlazo

   IF (@iMinPlazo <> @iMaxPlazo) AND (@iMinTasa <> @iMaxTasa)
   BEGIN
      EXECUTE Sp_Interpolar_Tasas @iMinPlazo , @iMinTasa , @iMaxPlazo , @iMaxTasa , @iPlazo , @iTasa OUTPUT
   END ELSE
   BEGIN
      SET @iTasa = @iMinTasa
   END

   SELECT  @iTasa      as Tasa
   ,       @iSpreed    as Spreed
   ,       @iSpotCom   as SpotCompra
   ,       @iSpotVen   as SpotVenta
*/
END

GO
