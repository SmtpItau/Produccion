USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENCIMIENTOS_COBERTURAS]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VENCIMIENTOS_COBERTURAS]
AS
BEGIN

   RETURN

   
   SET NOCOUNT    ON
-- SET XACT_ABORT ON

   DECLARE @dFecaProceso   DATETIME
   ,       @nCobertura     NUMERIC(9)
   ,       @Maximo         INTEGER
   ,       @Minimo         INTEGER

   SELECT  @dFecaProceso = acfecproc
   FROM    BacTraderSuda..MDAC


   --> Proceso de Vencimientos de Derivados
      CREATE TABLE #Vencimientos
      (   Modulo      CHAR(3)
      ,   Operacion   NUMERIC(9)
      ,   Correlativo NUMERIC(9)
      ,   Cobertura   NUMERIC(9)
      ,   Puntero     INTEGER Identity(1,1)
      )

      --> Vencimientos Forward
      INSERT INTO #Vencimientos
      SELECT  'BFW'
      ,       canumoper
      ,       1
      ,       nCobertura
      FROM    BacFwdSuda..MFCA          WITH (NoLock)
              INNER JOIN BacTraderSuda..COBERTURAS ON cModulo = 'BFW' AND nDerivado = canumoper
      WHERE   cafecvcto    <= @dFecaProceso

      SELECT  @Maximo       = MAX(Puntero)
      ,       @Minimo       = MIN(Puntero)
      FROM    #Vencimientos

      WHILE   @Maximo >= @Minimo
      BEGIN
         SELECT @nCobertura = Cobertura
         FROM   #Vencimientos
         WHERE  Puntero     = @Minimo

         DELETE  BacTraderSuda..DETALLE_COBERTURAS   WITH (RowLock)
         WHERE   nCobertura    = @nCobertura

         DELETE  BacTraderSuda..COBERTURAS           WITH (RowLock)
         WHERE   nCobertura    = @nCobertura

         SELECT @Minimo = @Minimo + 1
      END
      DELETE #Vencimientos
      --> Vencimientos Forward

      --> Vencimientos Swap
      INSERT INTO #Vencimientos
      SELECT 'PCS'
      ,      numero_operacion
      ,      1
      ,      nCobertura   
      FROM   BacSwapSuda..CARTERA      WITH (NoLock)
             INNER JOIN BacTraderSuda..COBERTURAS ON cModulo = 'PCS' AND nDerivado = numero_operacion
      WHERE  fecha_termino = @dFecaProceso

      SELECT  @Maximo       = MAX(Puntero)
      ,       @Minimo       = MIN(Puntero)
      FROM    #Vencimientos

      WHILE   @Maximo >= @Minimo
      BEGIN
         SELECT @nCobertura = Cobertura
         FROM   #Vencimientos
         WHERE  Puntero     = @Minimo

         DELETE  BacTraderSuda..DETALLE_COBERTURAS    WITH (RowLock)
         WHERE   nCobertura    = @nCobertura

         DELETE  BacTraderSuda..COBERTURAS            WITH (RowLock)
         WHERE   nCobertura    = @nCobertura

         SELECT @Minimo = @Minimo + 1
      END
      DELETE #Vencimientos
      --> Vencimientos Swap
   --> Fin Proceso de Vencimientos de Derivados


   --> Proceso de Vencimiento de Instrumentos y Operaciones.
      --> Vencimientos de Instrumentos de Renta Fija
      DELETE BacTraderSuda..DETALLE_COBERTURAS
      FROM   BacTraderSuda..MDRS         WITH (NoLock)
      WHERE  rsfecha      = @dFecaProceso
      AND    rstipoper    = 'VC'
      AND    cSistema     = 'BTR' 
      AND    nDocumento   = rsnumdocu 
      AND    nCorrelativo = rscorrela
      --> Vencimientos de Instrumentos de Renta Fija

      --> Vencimientos de Instrumentos de Inversion Exterior
      DELETE BacTraderSuda..DETALLE_COBERTURAS
      FROM   BacBonosExtSuda..TEXT_RSU WITH (NoLock)
      WHERE  rsfecpro     = @dFecaProceso
      AND    rstipoper    IN('V','VCP')
      AND    cSistema     = 'BEX' 
      AND    nDocumento   = rsnumdocu 
      AND    nCorrelativo = rscorrelativo
      --> Vencimientos de Instrumentos de Inversion Exterior

      --> Vencimientos de Operaciones Forward
      DELETE BacTraderSuda..DETALLE_COBERTURAS
      FROM   BacFwdSuda..MFCA         WITH (NoLock)
      WHERE  cafecvcto    = @dFecaProceso
      AND    cSistema     = 'BFW' 
      AND    nDocumento   = canumoper
      AND    nCorrelativo = 1
      --> Vencimientos de Operaciones Forward

      --> Vencimientos de Operaciones Swap
      DELETE BacTraderSuda..DETALLE_COBERTURAS      
      FROM   BacSwapSuda..CARTERA      WITH (NoLock)
      WHERE  fecha_termino = @dFecaProceso
      AND    cSistema      = 'PCS'
      AND    nDocumento    = numero_operacion
      AND    nCorrelativo  = 1
      --> Vencimientos de Operaciones Swap
   --> Proceso de Vencimiento de Instrumentos y Operaciones.

--   SET XACT_ABORT OFF
END





GO
