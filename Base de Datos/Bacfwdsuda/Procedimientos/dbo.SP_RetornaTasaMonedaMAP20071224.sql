USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RetornaTasaMonedaMAP20071224]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RetornaTasaMonedaMAP20071224]
   (   @iMoneda         NUMERIC(5)
   ,   @iPlazo          NUMERIC(9)
   ,   @cModulo         CHAR(3)    = 'BFW'
   ,   @cProducto       VARCHAR(5) = '*'
   ,   @iTipoTasa       INTEGER    = -1
   ,   @iTipoFlujo      INTEGER    = -1
   ,   @iTipoBase       INTEGER    = 0
   ,   @cTipoOperacion  CHAR(1)    = 'C'
   )
AS
BEGIN

   SET NOCOUNT ON

   -->     ***************************************************
   --      *******  NUEVO PROCESO DE RESCATE DE TASAS  *******
   -->     ***************************************************

   IF @cModulo <> 'PCS'
   BEGIN
      SET @iTipoBase = 0
   END

   IF @cModulo <> 'PCS' AND @cProducto <> 'SM'
   BEGIN
      SET @iTipoTasa  = -1
      --> Identifica el flujo Entregamos o Recibimos de Swap
      SET @iTipoFlujo = -1
   END

   DECLARE @cInstrumento        VARCHAR(20)
   ,       @cEmisor             VARCHAR(20)
   ,       @iDias               FLOAT
   ,       @cCurvaPrincipal     VARCHAR(20)
   ,       @cCurvaAlternativa   VARCHAR(20)
   ,       @sSpread             CHAR(1)
   ,       @cCurvaSpread        VARCHAR(20)
   ,       @ValorCurvaProducto  FLOAT
   ,       @ValorCurvaSpread    FLOAT
   ,       @iCurvasHoy          INTEGER
   ,       @iTasaEmision        INTEGER
   ,       @cTipoTasa           CHAR(1)

   SELECT  @cInstrumento        = '*'
   ,       @cEmisor             = '*'
   ,       @iDias               = @iPlazo
   ,       @cCurvaPrincipal     = ''
   ,       @cCurvaAlternativa   = ''
   ,       @sSpread             = ''
   ,       @cCurvaSpread        = ''
   ,       @ValorCurvaProducto  = 0.0
   ,       @ValorCurvaSpread    = 0.0
   ,       @iCurvasHoy          = 0
   ,       @iTasaEmision        = 0
   ,       @cTipoTasa           = CASE WHEN @iTipoTasa = -1 THEN 'N'
                                       WHEN @iTipoTasa = 0  THEN 'F'
                                       WHEN @iTipoTasa = 1  THEN 'V'
                                  END

   -->     (3.0) Verifica la Existencia de Datos para la Fecha.
   declare @iFound            integer
   SET     @iFound            = -1
   SELECT  @iFound            = 0
   FROM    BacParamSuda..CURVAS             (INDEX = Curvas_FechaGeneracion)
   WHERE   FechaGeneracion    = '20071227' --( select  acfecproc  FROM    BacTraderSuda..MDAC )

   if @iFound = -1 
      set @iCurvasHoy = 1 

   -->     Rescata las Tasas Desde Proceso Genérico
   EXECUTE BacParamSuda..SP_RETORNA_CURVAS_PRODUCTO_20071227 @cModulo
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
                                                ,   1 -- @iCurvasHoy
                                                ,   @iTasaEmision
                                                ,   @cTipoTasa
                                                ,   @iTipoFlujo
                                                ,   @iTipoBase


   DECLARE @iSpotCompra   FLOAT
   DECLARE @iSpotVenta    FLOAT
   DECLARE @dFecha        DATETIME

   SELECT  @dFecha        = '20071227' --acfecproc
   FROM    BacTraderSuda..MDAC

   IF @iMoneda = 999
   BEGIN
      SET @iSpotCompra   = 1.0
  SET @iSpotVenta    = 1.0
   END ELSE
   BEGIN
      SET @iSpotCompra   = ISNULL(( SELECT TOP 1 SpotCompra FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @dFecha AND Codigo_Moneda = CASE WHEN @iMoneda = 13 THEN 994 ELSE @iMoneda END),0.0)
      SET @iSpotVenta    = ISNULL(( SELECT TOP 1 SpotVenta  FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @dFecha AND Codigo_Moneda = CASE WHEN @iMoneda = 13 THEN 994 ELSE @iMoneda END),0.0)
   END

   SELECT  Tasa           = @ValorCurvaProducto -- / 100.0
   ,       Spreed         = 0.0
   ,       SpotCompra     = @iSpotCompra
   ,       SpotCompra     = @iSpotVenta

   --> ***************************************************
   --  *******  NUEVO PROCESO DE RESCATE DE TASAS  *******
   --> ***************************************************
RETURN

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

END

GO
