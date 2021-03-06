USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_COBERTURA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_COBERTURA]
(   @dFecha             DATETIME
,   @nCobertura         NUMERIC(9)
,   @cModulo            CHAR(3)
,   @nDerivado          NUMERIC(9)
,   @nCorrela           NUMERIC(9)
,   @nMontoOperacion    NUMERIC(21,4)
,   @nMontoOcupado      NUMERIC(21,4)
,   @nMontoDisponible   NUMERIC(21,4)
,   @nVRazonableOcup    NUMERIC(21,4)
,   @nVRazonableDisp    NUMERIC(21,4)
,   @nVRazonableMonto   NUMERIC(21,4)
)
AS
BEGIN

   SET NOCOUNT ON


   IF @nCobertura = 0.0
   BEGIN
      IF NOT EXISTS( SELECT 1 FROM BacTraderSuda..CONTROL_COBERTURAS )
      BEGIN
         INSERT INTO BacTraderSuda..CONTROL_COBERTURAS
         SELECT 1
      END ELSE
      BEGIN
         UPDATE BacTraderSuda..CONTROL_COBERTURAS 
         SET    Cobertura   = Cobertura + 1
      END
      SELECT @nCobertura    = Cobertura
      FROM   BacTraderSuda..CONTROL_COBERTURAS
   END

   IF EXISTS(SELECT 1 FROM BacTraderSuda..COBERTURAS WHERE nCobertura = @nCobertura)
   BEGIN
      UPDATE BacTraderSuda..COBERTURAS
      SET    nMontoOperacion  = @nMontoOperacion
      ,      nMontoOcupado    = @nMontoOcupado
      ,      nMontoDisponible = @nMontoDisponible
      ,      nVRazonableOcup  = @nVRazonableOcup
      ,      nVRazonableDisp  = @nVRazonableDisp
      ,      nVRazonableMonto = @nVRazonableMonto
      WHERE  nCobertura       = @nCobertura
   END ELSE
   BEGIN
      INSERT INTO BacTraderSuda..COBERTURAS
      SELECT @dFecha
      ,      @nCobertura
      ,      @cModulo
      ,      @nDerivado
      ,      @nCorrela
      ,      @nMontoOperacion
      ,      @nMontoOcupado
      ,      @nMontoDisponible
      ,      @nVRazonableOcup
      ,      @nVRazonableDisp
      ,      @nVRazonableMonto
   END

   SELECT @nCobertura

END



GO
