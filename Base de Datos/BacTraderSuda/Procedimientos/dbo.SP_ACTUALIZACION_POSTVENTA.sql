USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZACION_POSTVENTA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZACION_POSTVENTA]
   (   @Sistema      CHAR(3)
   ,   @Documento    NUMERIC(9)
   ,   @Correlativo  NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT    ON
   -- REQ. 7619
   --SET XACT_ABORT ON

   DECLARE @dFecaProceso      DATETIME
   DECLARE @nCobertura        NUMERIC(9)
   ,       @nSumMontoOcupado  NUMERIC(21,4)

   --> Lee la Fecha de Proceso
   SELECT  @dFecaProceso      = acfecproc
   ,       @nSumMontoOcupado  = 0.0
   FROM    BacTraderSuda..MDAC  WITH (NoLock)

   --> Determina si se trata de la Venta de un Derivado de Cobertura, Para Eliminar la Cobertuta
   IF EXISTS(SELECT 1 FROM BacTraderSuda..COBERTURAS WITH (NoLock) WHERE cModulo = @Sistema AND nDerivado = @Documento AND nCorrela = @Correlativo)
   BEGIN
      --> Lee N° de Cobertura, asociado al Derivado
      SELECT @nCobertura = nCobertura 
      FROM   BacTraderSuda..COBERTURAS         WITH (NoLock)
      WHERE  cModulo     = @Sistema 
      AND    nDerivado   = @Documento 
      AND    nCorrela    = @Correlativo

      --> Elimina el Detalle de la Cobertura
      DELETE BacTraderSuda..DETALLE_COBERTURAS WITH(RowLock)
      WHERE  nCobertura  = @nCobertura

      --> Elimina la Cobertura
      DELETE BacTraderSuda..COBERTURAS         WITH(RowLock)
      WHERE  nCobertura  = @nCobertura      
      -- REQ. 7619
      -- SET XACT_ABORT OFF
      RETURN
   END


   DECLARE @Maximo   INTEGER
   ,       @Minimo   INTEGER

   CREATE TABLE #Miscoberturas
   (   numdocu   NUMERIC(9)               NOT NULL DEFAULT(0.0)
   ,   correla   NUMERIC(9)               NOT NULL DEFAULT(0.0)
   ,   cobertura NUMERIC(9)               NOT NULL DEFAULT(0.0)
   ,   puntero   INTEGER Identity(1,1)
   )

   ------------------------------------------------------
   --> Rescata Los N° de Cobertura Asociados a la Operacion
   INSERT INTO #Miscoberturas
   SELECT nDocumento
   ,      nCorrelativo
   ,      nCobertura
   FROM   BacTraderSuda..DETALLE_COBERTURAS    WITH (NoLock)
   WHERE  cSistema          = @Sistema 
   AND    nDocumento        = @Documento 
   AND    nCorrelativo      = @Correlativo

   SELECT @Maximo   = MAX(puntero)
   ,      @Minimo   = MIN(puntero)
   FROM   #Miscoberturas

   --> Recorro Cada una del Coberturas Asociadas a la Operacion
   WHILE  @Maximo  >= @Minimo
   BEGIN
      SELECT @nCobertura = cobertura
      FROM   #Miscoberturas
      WHERE  puntero     = @Minimo

      --> Se Elimina el Elemento Cubiero
      DELETE BacTraderSuda..DETALLE_COBERTURAS     WITH (RowLock)
      WHERE  cSistema          = @Sistema
      AND    nDocumento        = @Documento
      AND    nCorrelativo      = @Correlativo
      AND    nCobertura        = @nCobertura

      --> Questiona la Existencia de Otra Operacion Asociadad a la Cobertura
      IF NOT EXISTS(SELECT 1 FROM BacTraderSuda..DETALLE_COBERTURAS WITH (NoLock) WHERE nCobertura = @nCobertura)
      BEGIN
         --> Al No Existir mas Documentos Asociados, Elimina La Cobertura
         DELETE BacTraderSuda..COBERTURA            WITH (RowLock)
         WHERE  nCobertura = @nCobertura
      END ELSE
      BEGIN
         --> Se Obtiene el Monto Real Ocupado del Derivado
         SELECT @nSumMontoOcupado = nMontoDerivado
         FROM   BacTraderSuda..DETALLE_COBERTURAS   WITH (NoLock)
         WHERE  nCobertura        = @nCobertura

         --> Se Actualiza el Monto Total Ocupado del Derivado
         UPDATE BacTraderSuda..COBERTURAS           WITH (RowLock)
         SET    nMontoOcupado     = @nSumMontoOcupado
         WHERE  nCobertura        = @nCobertura

         --> Se Obtiene el Monto Total Disponible para Coberturas
         UPDATE BacTraderSuda..COBERTURAS           WITH (RowLock)
         SET    nMontoDisponible  = ABS(nMontoOperacion - nMontoOcupado)
         WHERE  nCobertura        = @nCobertura

         --> Se Obtiene el Valor Razonable para el Monto Total Ocupado
         UPDATE BacTraderSuda..COBERTURAS WITH (RowLock)
         SET    nVRazonableOcup   = (nMontoOcupado    * nVRazonableMonto) / nMontoOperacion
         WHERE  nCobertura        = @nCobertura

         --> Se Obtiene el Valor Razonable para el Monto Total Disponible
         UPDATE BacTraderSuda..COBERTURAS           WITH (RowLock)
         SET    nVRazonableDisp   = (nMontoDisponible * nVRazonableMonto) / nMontoOperacion
         WHERE  nCobertura        = @nCobertura
      END

      --> Siguiente Registro
      SELECT @Minimo     = @Minimo + 1
   END
   -- REQ. 7619 
   -- SET XACT_ABORT OFF

END




GO
