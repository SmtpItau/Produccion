USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_OPERACIONES_COBERTURA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_OPERACIONES_COBERTURA]
   (   @dFecProc   DATETIME   = ''
   ,   @cModulo    CHAR(3)    = ''
   ,   @cProducto  VARCHAR(5) = ''
   ,   @nCobertura NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON   

CREATE TABLE #Operaciones
   (   cSistema      CHAR(3)         NOT NULL DEFAULT('')
   ,   nNumdocu      NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   nCorrela      NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   cSerie        VARCHAR(12)     NOT NULL DEFAULT('')
   ,   iMoneda       INTEGER         NOT NULL DEFAULT(0)
   ,   nNominal      NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   vMercado      NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   )

   IF (@cModulo = 'BTR' and @cProducto in('CP','')) OR (@cModulo = '')
   BEGIN
      INSERT INTO #Operaciones
      SELECT 'BTR'
      ,      cp.cpnumdocu
      ,      cp.cpcorrela
      ,      cp.cpinstser
      ,      di.dimoneda
      ,      di.dinominal
      ,      cp.cpvptirc
      FROM   BacTraderSuda..MDCP           cp WITH (NoLock)
             LEFT JOIN BacTraderSuda..MDDI di ON cp.cpnumdocu = di.dinumdocu AND cp.cpcorrela = di.dicorrela
      WHERE  cp.cpnominal   > 0
      AND    di.dinominal   > 0
      ORDER BY cp.cpinstser , cp.cpnumdocu , cp.cpcorrela
   END

   IF (@cModulo = 'BTR' and @cProducto in('CI','ICAP','ICOL','')) OR (@cModulo = '')
   BEGIN
      INSERT INTO #Operaciones
      SELECT 'BTR'
      ,      ci.cinumdocu
      ,      ci.cicorrela
      ,      ci.ciinstser
      ,      ci.cimonpact
      ,      ci.cinominal
      ,      ci.civptirc
      FROM   BacTraderSuda..MDCI           ci WITH (NoLock)
             LEFT JOIN BacTraderSuda..MDDI di ON ci.cinumdocu = di.dinumdocu AND ci.cicorrela = di.dicorrela
      WHERE  ci.cinominal   > 0
      AND    di.dinominal   > 0
      ORDER BY ci.ciinstser , ci.cinumdocu , ci.cicorrela
   END

   IF (@cModulo = 'BTR' OR @cModulo = '')
   BEGIN
      UPDATE #Operaciones
         SET vMercado            = ISNULL(valor_mercado,0.0)
      FROM   BacTraderSuda..VALORIZACION_MERCADO WITH (NoLock)
      ,      BacTraderSuda..MDAC                 WITH (NoLock)
      WHERE  fecha_valorizacion  = acfecproc
      AND    cSistema            = 'BTR'
      and    cSerie              = rminstser
   END


   IF (@cModulo = 'BEX' AND @cProducto = 'CPX') OR (@cModulo = '')
   BEGIN
      INSERT INTO #Operaciones
      SELECT 'BEX'
      ,      cp.cpnumdocu
      ,      cp.cpcorrelativo
      ,      cp.cod_nemo
      ,      cp.cpmonemi
      ,      cp.cpnominal
      ,      ISNULL(rsvalmerc,cpvptirc)
      FROM   BacBonosExtSuda..TEXT_CTR_INV cp WITH (NoLock)
             LEFT JOIN BacBonosExtSuda..TEXT_RSU rs ON rs.rsfecpro = @dFecProc and cp.cpnumdocu = rs.rsnumdocu AND cp.cpcorrelativo = rs.rscorrelativo
      WHERE  cp.cpnominal > 0
      ORDER BY cp.cod_nemo , cp.cpnumdocu , cp.cpcorrelativo
   END

   IF (@cModulo = 'BFW' OR @cModulo = '')
   BEGIN
      INSERT INTO #Operaciones
      SELECT 'BFW'
      ,      ca.canumoper
      ,      correlativo = 1
      ,      ca.caserie
      ,      ca.cacodmon1
      ,      ca.camtomon1
      ,      ca.fres_obtenido
      FROM   BacFwdSuda..MFCA ca       WITH (NoLock)
      WHERE  ca.cafecvcto            > @dFecProc
      AND    ca.cacartera_normativa <> 'C'
      AND   (ltrim(rtrim(ca.cacodpos1)) = @cProducto or @cProducto = '')
      ORDER BY ca.cacodpos1 , ca.caserie , ca.canumoper
   END

   IF (@cModulo = 'PCS' OR @cModulo = '')
   BEGIN
      SELECT numerooperacion           = ca.numero_operacion 
      ,      numeroflujo               = MIN(ca.numero_flujo)
      INTO   #swap_1
      FROM   BacSwapSuda..CARTERA ca     WITH (NoLock)
      WHERE  ca.tipo_swap             <> 2
      AND    ca.tipo_flujo             = 1
      AND    ca.car_Cartera_Normativa <> 'C'
      AND   (@cProducto                = '' OR ca.tipo_swap  = CASE WHEN @cProducto = 'ST' THEN 1
                                                                WHEN @cProducto = 'SM' THEN 2
                                                                    WHEN @cProducto = 'FR' THEN 3
                                                                    WHEN @cProducto = 'SP' THEN 4
                                                                    ELSE                        0
                                                               END)
      GROUP BY ca.numero_operacion   

      INSERT INTO #Operaciones   
      SELECT 'PCS'
      ,      ca.numero_operacion
      ,      ca.numero_flujo
      ,      caserie  = ''
      ,      ca.compra_moneda
      ,      ca.compra_capital
      ,      Valor_RazonableCLP
      FROM   BacSwapSuda..CARTERA ca      WITH (NoLock)
             INNER JOIN #swap_1 ON ca.numero_operacion = numerooperacion AND ca.numero_flujo = numeroflujo
      WHERE  tipo_swap    NOT IN(2)
      AND    tipo_flujo   = 1
      ORDER BY ca.tipo_swap , ca.numero_operacion , ca.numero_flujo
   END

   /*
CREATE TABLE #DetalleAgrupado
   (   Sistema  CHAR(3)
   ,   NumDocu  NUMERIC(9)
   ,   Correla  NUMERIC(9)
   ,   Monto    NUMERIC(21,4)
   ,   Puntero  INTEGER Identity(1,1)
   )

   INSERT INTO #DetalleAgrupado
   SELECT cSistema , nDocumento , nCorrelativo , SUM(nCubierto) 
   FROM   BacTraderSuda..DETALLE_COBERTURAS
   GROUP BY cSistema , nDocumento , nCorrelativo 

   DECLARE @Maximo   NUMERIC(9)
   ,       @Minimo   NUMERIC(9)
   ,       @nMonto   NUMERIC(21,4)

   SELECT  @Maximo   = MAX(Puntero)
   ,       @Minimo   = MIN(Puntero)
   FROM    #DetalleAgrupado

   WHILE   @Maximo >= @Minimo
   BEGIN
      UPDATE #Operaciones
      SET    nNominal         = (nNominal - Det.Monto)
      FROM   #DetalleAgrupado Det
      WHERE  Det.Sistema      = #Operaciones.cSistema
      AND    Det.NumDocu      = #Operaciones.nNumdocu
      AND    Det.Correla      = #Operaciones.nCorrela
      AND    Det.Puntero      = @Minimo

      SELECT @Minimo = @Minimo + 1
   END

   DELETE #Operaciones
   FROM   BacTraderSuda..DETALLE_COBERTURAS Cob
   WHERE  Cob.cSistema       = #Operaciones.cSistema
   AND    Cob.nDocumento     = #Operaciones.nNumdocu
   AND    Cob.nCorrelativo   = #Operaciones.nCorrela
   AND    Cob.nLibre        <= 0.0
   */

   DELETE #Operaciones
   FROM   BacTraderSuda..DETALLE_COBERTURAS Cob
   WHERE  Cob.cSistema       = #Operaciones.cSistema
   AND    Cob.nDocumento     = #Operaciones.nNumdocu
   AND    Cob.nCorrelativo   = #Operaciones.nCorrela
   --> AND    Cob.nCobertura     = @nCobertura --> Disponibilidad para Asociar a otro Derivado; Estado:Desconectado.

   SELECT 'cSistema'      = cSistema
   ,      'nNumdocu'      = nNumdocu
   ,      'nCorrela'      = nCorrela
   ,      'cSerie'        = cSerie
   ,      'iMoneda'       = mnnemo + space(100) + LTRIM(iMoneda)
   ,      'nNominal'      = nNominal
   ,      'Porcentaje'    = 0.0
   ,      'vMercado'      = vMercado
   FROM   #Operaciones 
          LEFT JOIN BacParamSuda..MONEDA  ON mncodmon = iMoneda
   ORDER BY cSistema

END


GO
