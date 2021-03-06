USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_DETALLE_COBERTURA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_DETALLE_COBERTURA]
(   @nCobertura           NUMERIC(9)
,   @cSistema             CHAR(3)
,   @nDocumento           NUMERIC(9)
,   @nCorrelativo         NUMERIC(9)
,   @cSerie               VARCHAR(15)
,   @iMoneda              INTEGER
,   @nMontoOperacion      NUMERIC(21,4)
,   @nValorMercado        NUMERIC(21,4)
,   @nMontoCubrir         NUMERIC(21,4)
,   @nVRazonableCubrir    NUMERIC(21,4)
,   @nMontoDerivado       NUMERIC(21,4)
,   @nRazonableDerivado   NUMERIC(21,4)
,   @pEfectividad         NUMERIC(21,4)
,   @dFechaIngreso        DATETIME
)
AS
BEGIN

   SET NOCOUNT ON


   IF EXISTS(SELECT 1 FROM BacTraderSuda..DETALLE_COBERTURAS 
             WHERE nCobertura = @nCobertura AND cSistema = @cSistema AND nDocumento = @nDocumento AND nCorrelativo = @nCorrelativo)
   BEGIN
      UPDATE BacTraderSuda..DETALLE_COBERTURAS
      SET    nMontoOperacion      = @nMontoOperacion
      ,      nValorMercado        = @nValorMercado
      ,      nMontoCubrir         = @nMontoCubrir
      ,      nVRazonableCubrir    = @nVRazonableCubrir
      ,      nMontoDerivado       = @nMontoDerivado
      ,      nRazonableDerivado   = @nRazonableDerivado
      ,      pEfectividad         = @pEfectividad
      ,      dFechaIngreso        = @dFechaIngreso
      WHERE  nCobertura           = @nCobertura
      AND    cSistema             = @cSistema
      AND    nDocumento           = @nDocumento
      AND    nCorrelativo         = @nCorrelativo

   END ELSE
   BEGIN

      INSERT INTO BacTraderSuda..DETALLE_COBERTURAS
      SELECT @nCobertura
      ,      @cSistema
      ,      @nDocumento
      ,      @nCorrelativo
      ,      @cSerie
      ,      @iMoneda
      ,      @nMontoOperacion
      ,      @nValorMercado
      ,      @nMontoCubrir
      ,      @nVRazonableCubrir
      ,      @nMontoDerivado
      ,      @nRazonableDerivado
      ,      @pEfectividad
      ,      @dFechaIngreso

   END

END



GO
