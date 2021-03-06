USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_BACK_TEST]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_BACK_TEST]
   (   @dFechaInforme   DATETIME
   ,   @gsBac_User      VARCHAR(20)
   ,   @Modulo          CHAR(3) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FiltroModulo    INTEGER
       SET @FiltroModulo    = CASE WHEN @Modulo = 'BFW' THEN 1
                                   WHEN @Modulo = 'PCS' THEN 2
                                   WHEN @Modulo = 'BTR' THEN 3
                                   WHEN @Modulo = 'BEX' THEN 4
                                   ELSE                      -1
                              END

   -->    Parametros
   DECLARE @FechaProceso    CHAR(10)
       SET @FechaProceso    = (SELECT CONVERT(CHAR(10),acfecproc,103) FROM BacTraderSuda..MDAC)
   DECLARE @FechaEmision    CHAR(10)
       SET @FechaEmision    = CONVERT(CHAR(10),GETDATE(),103)
   DECLARE @HoraEmision     CHAR(10)
       SET @HoraEmision     = CONVERT(CHAR(10),GETDATE(),108)
   DECLARE @FechaDatos      CHAR(10)
       SET @FechaDatos      = CONVERT(CHAR(10),@dFechaInforme,103)

   CREATE TABLE #RESULTADO_BACK_TEST
   (   modulo            CHAR(20)        NOT NULL DEFAULT('')
   ,   contrato          NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   correlativo       NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   producto          VARCHAR(25)     NOT NULL DEFAULT('')
   ,   nocional          NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   serie             VARCHAR(20)     NOT NULL DEFAULT('')
   ,   moneda            CHAR(8)         NOT NULL DEFAULT('')	---campo mnnemo es de largo 8
   ,   Conversion        CHAR(8)         NOT NULL DEFAULT('')
   ,   FechaSuscripcion  DATETIME        NOT NULL DEFAULT('')
   ,   FechaVencimento   DATETIME        NOT NULL DEFAULT('')
   ,   vrCambioA         FLOAT           NOT NULL DEFAULT(0.0)
   ,   vrTasaA           FLOAT           NOT NULL DEFAULT(0.0)
   ,   resultadoMTMA     FLOAT           NOT NULL DEFAULT(0.0)
   ,   vrCambioB         FLOAT           NOT NULL DEFAULT(0.0)
   ,   vrTasaB           FLOAT           NOT NULL DEFAULT(0.0)
   ,   resultadoMTMB     FLOAT           NOT NULL DEFAULT(0.0)
   ,   variacionMTM      FLOAT           NOT NULL DEFAULT(0.0)
   ,   Orden             INTEGER         NOT NULL DEFAULT(0)
   )   

   -->    Inicio proceso Forward
   SELECT Producto = CONVERT(INTEGER,codigo_producto)
        ,    Glosa = CONVERT(CHAR(25),descripcion)
     INTO #PRODUCTOS_FORWARD
     FROM BacParamSuda..PRODUCTO  WITH (NOLOCK) 
    WHERE Id_Sistema = 'BFW'

   SELECT canumoper, cacodpos1, camtomon1, cafecha, cafecvcto, cacodmon1, cacodmon2, fres_obtenido, fRes_ObtenidoParPrx, caserie
     INTO #CARTERA_FORWARD 
     FROM BacFwdSuda..MFCARES
    WHERE cafechaproceso = @dFechaInforme

   INSERT INTO #RESULTADO_BACK_TEST
   SELECT modulo           = 'FORWARD'
        , contrato         =  c.canumoper
        , correlativo      =  0
        , producto         =  P.Glosa
        , nocional         =  c.camtomon1
        , serie            =  c.caserie
        , moneda           =  LTRIM(RTRIM(m.mnnemo))
        , Conversion       =  LTRIM(RTRIM(n.mnnemo))
        , FechaSuscripcion =  c.cafecha
        , FechaVencimento  =  c.cafecvcto
        , vrCambioA        =  0.0
        , vrTasaA          =  0.0
        , resultadoMTMA    =  isnull(c.fres_obtenido, 0.0)
        , vrCambioB        =  0.0
        , vrTasaB          =  0.0
        , resultadoMTMB    =  isnull(c.fRes_ObtenidoParPrx, 0.0)
        , variacionMTM     = (isnull(c.fres_obtenido, 0.0) - isnull(c.fRes_ObtenidoParPrx, 0.0))
        , Orden            =  1
     FROM #CARTERA_FORWARD c 
          INNER JOIN BacParamSuda..MONEDA   m WITH (NOLOCK) ON m.mncodmon  = c.cacodmon1
          INNER JOIN BacParamSuda..MONEDA   n WITH (NOLOCK) ON n.mncodmon  = c.cacodmon2
          LEFT  JOIN #PRODUCTOS_FORWARD     p WITH (NOLOCK) ON Producto    = c.cacodpos1
   -->    Fin proceso Forward


   -->    Inicio proceso de Swap
    SELECT Producto = CASE WHEN codigo_producto = 'ST' THEN 1
                           WHEN codigo_producto = 'SM' THEN 2
                           WHEN codigo_producto = 'FR' THEN 3
                           WHEN codigo_producto = 'SP' THEN 4
                      END
        ,    Glosa  = CONVERT(CHAR(25),descripcion)
     INTO #PRODUCTOS_SWAP
     FROM BacParamSuda..PRODUCTO  WITH (NOLOCK) 
    WHERE Id_Sistema = 'PCS'

   SELECT DISTINCT numero_operacion, tipo_swap, compra_capital, fecha_inicio, fecha_termino, compra_moneda, venta_moneda, Valor_RazonableCLP, Valor_RazonableCLPParPrx
   INTO   #CARTERA_SWAP
   FROM   BacSwapSuda..CARTERARES WITH (NOLOCK)
   WHERE  Fecha_Proceso = @dFechaInforme

   UPDATE c
      SET c.venta_moneda = p.venta_moneda
    FROM #CARTERA_SWAP c
      ,  #CARTERA_SWAP p
   WHERE c.compra_capital > 0
     and p.compra_capital = 0
     and p.numero_operacion = c.numero_operacion

   DELETE FROM #CARTERA_SWAP 
         WHERE compra_capital = 0

   INSERT INTO #RESULTADO_BACK_TEST
   SELECT modulo           = 'SWAP'
        , contrato         =  c.numero_operacion
        , correlativo      =  0
        , producto         =  Glosa
        , nocional         =  c.compra_capital
        , serie            =  ''
        , moneda           =  LTRIM(RTRIM(m.mnnemo))
        , Conversion       =  LTRIM(RTRIM(n.mnnemo))
        , FechaSuscripcion =  c.fecha_inicio
        , FechaVencimento  =  c.fecha_termino
        , vrCambioA        =  0.0
        , vrTasaA          =  0.0
        , resultadoMTMA    =  isnull(c.Valor_RazonableCLP, 0.0)
        , vrCambioB        =  0.0
        , vrTasaB          =  0.0
        , resultadoMTMB    =  isnull(c.Valor_RazonableCLPParPrx, 0.0)
        , variacionMTM     = (isnull(c.Valor_RazonableCLP, 0.0) - isnull(c.Valor_RazonableCLPParPrx, 0.0))
        , Orden            =  2
     FROM #CARTERA_SWAP c
          INNER JOIN #PRODUCTOS_SWAP       p ON p.Producto = c.tipo_swap
          INNER JOIN BacParamSuda..MONEDA  m ON m.mncodmon = c.compra_moneda
          INNER JOIN BacParamSuda..MONEDA  n ON n.mncodmon = c.venta_moneda
   -->    Fin proceso de Swap 

   -->    Inicio proceso de Renta Fija
    SELECT Producto = codigo_producto
        ,    Glosa  = CONVERT(CHAR(25),descripcion)
     INTO #PRODUCTOS_TRADER
     FROM BacParamSuda..PRODUCTO  WITH (NOLOCK) 
    WHERE Id_Sistema = 'BTR'

   INSERT INTO #RESULTADO_BACK_TEST
   SELECT modulo           = 'RENTA FIJA MN'
        , contrato         =  c.rmnumdocu
        , correlativo      =  c.rmcorrela
        , producto         =  p.Glosa
        , nocional         =  c.moneda_emision
        , serie            =  c.rminstser
        , moneda           =  LTRIM(RTRIM(m.mnnemo))
        , Conversion       =  ''
        , FechaSuscripcion =  c.tmfecemi
        , FechaVencimento  =  c.tmfecven
        , vrCambioA        =  0.0
        , vrTasaA          =  0.0
        , resultadoMTMA    =  isnull(c.valor_mercado, 0.0)
        , vrCambioB        =  0.0
        , vrTasaB          =  0.0
        , resultadoMTMB    =  isnull(c.ValorMercadoCLPParPrx, 0.0)
        , variacionMTM     = (isnull(c.valor_mercado, 0.0) - isnull(c.ValorMercadoCLPParPrx, 0.0))
        , Orden            =  3
     FROM BacTraderSuda..VALORIZACION_MERCADO c
          INNER JOIN BacParamSuda..MONEDA m ON m.mncodmon = c.moneda_emision
          INNER JOIN #PRODUCTOS_TRADER    p ON p.Producto = c.tipo_operacion
    WHERE fecha_valorizacion = @dFechaInforme
   -->    Fin proceso de Renta Fija

   -->    Inicio proceso de Inversion al Exterior
   INSERT INTO #RESULTADO_BACK_TEST
   SELECT modulo           = 'RENTA FIJA MX'
        , contrato         =  c.rsnumdocu
        , correlativo      =  c.rscorrelativo
        , producto         =  'COMPRA BONOS EXT.'
        , nocional         =  c.rsnominal
        , serie            =  c.id_instrum
        , moneda           =  LTRIM(RTRIM(m.mnnemo))
        , Conversion       =  ''
        , FechaSuscripcion =  c.rsfecemis
        , FechaVencimento  =  c.rsfecvcto
        , vrCambioA        =  0.0
        , vrTasaA          =  0.0
        , resultadoMTMA    =  isnull(c.rsvalmerc, 0.0)
        , vrCambioB        =  0.0
        , vrTasaB          =  0.0
        , resultadoMTMB    =  isnull(c.RsTirMercParPrx, 0.0)
        , variacionMTM     = (isnull(c.rsvalmerc, 0.0) - isnull(c.RsTirMercParPrx, 0.0))
        , Orden            =  4
     FROM BacBonosExtSuda..TEXT_RSU c
          INNER JOIN BacParamSuda..MONEDA m ON m.mncodmon = c.rsmonemi
    WHERE rsfecpro         = @dFechaInforme
   -->    Fin proceso de Inversion al Exterior

   SELECT modulo
        , contrato
        , correlativo
        , producto
        , nocional
        , serie
        , moneda
        , Conversion
        , FechaSuscripcion
        , FechaVencimento
        , vrCambioA
        , vrTasaA
        , resultadoMTMA
        , vrCambioB
        , vrTasaB
        , resultadoMTMB
        , variacionMTM
        , FechaProceso   = @FechaProceso
        , FechaEmision   = @FechaEmision
        , HoraEmision    = @HoraEmision
        , FechaDatos     = @FechaDatos
        , Usuario        = @gsBac_User
        , Orden
    FROM #RESULTADO_BACK_TEST 
   WHERE (Orden          = @FiltroModulo OR @FiltroModulo = -1)
    ORDER BY Orden, Producto, Moneda, conversion

END
GO
