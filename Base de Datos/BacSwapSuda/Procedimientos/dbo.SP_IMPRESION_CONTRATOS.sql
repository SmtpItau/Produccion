USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRESION_CONTRATOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_IMPRESION_CONTRATOS]
   (   @nContrato      NUMERIC(9)   
   ,   @ApoEntidad1    NUMERIC(9) = 0
   ,   @ApoEntidad2    NUMERIC(9) = 0
   ,   @ApoCliente1    NUMERIC(9) = 0
   ,   @ApoCliente2    NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT  Contrato         = CONVERT(NUMERIC(9),  Numero_Operacion )
      ,    TipoFlujo        = tipo_flujo
      ,    NumeroFlujo      = numero_flujo
      ,    nRutCliente      = clrut
      ,    nCodCliente      = clcodigo
      ,    RutCliente       = CONVERT(VARCHAR(15), LTRIM(RTRIM( rut_cliente )) + '-' + LTRIM(RTRIM( cldv )) )
      ,    Cliente          = CONVERT(VARCHAR(50), SUBSTRING(clnombre, 1, 50) )
      ,    DirCliente       = cldirecc
      ,    Moneda           = ISNULL( mnnemo , '')
      ,    Nocional         = compra_capital
      ,    Tasa             = CONVERT(VARCHAR(15), tbglosa)
      ,    Fecha_Cierre     = CONVERT(CHAR(10), Fecha_Cierre, 103)
      ,    Fecha_Inicio     = CONVERT(CHAR(10), Fecha_Inicio_Flujo, 103)
      ,    Fecha_pago       = CONVERT(CHAR(10), FechaLiquidacion,   103)
      ,    PlazoFlujo       = PlazoFlujo
      ,    Amortizacion     = compra_amortiza
      ,    Capital          = CONVERT(NUMERIC(21,4), compra_saldo + compra_Amortiza)
      ,    ValorTasa        = compra_valor_tasa
      ,    MontoInteres     = compra_interes
      ,    Documento        = glosa
      ,    NomApoCli1       = ISNULL( LTRIM(RTRIM( a.apnombre ))                                  , '')
      ,    RutApoCli1       = ISNULL( LTRIM(RTRIM( a.aprutapo )) + '-' + LTRIM(RTRIM( a.apdvapo )), '')
      ,    NomApoCli2       = ISNULL( LTRIM(RTRIM( b.apnombre ))                                  , '')
      ,    RutApoCli2       = ISNULL( LTRIM(RTRIM( b.aprutapo )) + '-' + LTRIM(RTRIM( b.apdvapo )), '')
      ,    Fecha_CondGrales = CONVERT(CHAR(10), clFechaFirma_cond, 103)
      ,    MonedaCompra     = ISNULL( mnnemo , '')
      ,    MonedaVenta      = ''
      ,    MontoCompra      = compra_capital
      ,    MontoVenta       = venta_capital
      ,    FechaInicio      = CONVERT(CHAR(10), fecha_inicio,  103)
      ,    FechaTermino     = CONVERT(CHAR(10), fecha_termino, 103)
      ,    TasaCompra       = compra_valor_tasa
      ,    TasaVenta        = venta_valor_tasa
      ,    DesTasaCompra    = CONVERT(VARCHAR(15), tbglosa)
      ,    DesTasaVenta     = CONVERT(VARCHAR(15), '')
   INTO    #TMP_CONTRATO
   FROM    BacSwapSuda..CARTERA 
           INNER JOIN BacParamSuda..CLIENTE               with(nolock) ON clrut    = rut_cliente AND clcodigo  = codigo_cliente
           LEFT  JOIN BacParamSuda..MONEDA                with(nolock) ON mncodmon = compra_moneda
           LEFT  JOIN BacParamSuda..TABLA_GENERAL_DETALLE with(nolock) ON tbcateg  = 1042        AND tbcodigo1 = compra_codigo_tasa
           LEFT  JOIN BacParamSuda..FORMA_DE_PAGO         with(nolock) ON codigo   = recibimos_documento
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   a with(nolock) ON a.aprutcli = clrut AND a.apcodcli = clcodigo AND a.aprutapo = @ApoCliente1
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   b with(nolock) ON b.aprutcli = clrut AND b.apcodcli = clcodigo AND b.aprutapo = @ApoCliente2
   WHERE   numero_operacion = @nContrato
     AND   tipo_flujo       = 1

   UNION 

   SELECT  contrato         = CONVERT(NUMERIC(9),  Numero_Operacion )
      ,    TipoFlujo        = tipo_flujo
      ,    NumeroFlujo      = numero_flujo
      ,    nRutCliente      = clrut
      ,    nCodCliente      = clcodigo
      ,    RutCliente       = CONVERT(VARCHAR(15), LTRIM(RTRIM( rut_cliente )) + '-' + LTRIM(RTRIM( cldv )) )
      ,    Cliente          = CONVERT(VARCHAR(50), SUBSTRING(clnombre, 1, 50) )
      ,    DirCliente       = cldirecc
      ,    Moneda           = ISNULL( mnnemo , '')
      ,    Nocional         = venta_capital
      ,    Tasa             = CONVERT(VARCHAR(15), tbglosa)
      ,    Fecha_Cierre     = CONVERT(CHAR(10), Fecha_Cierre, 103)
      ,    Fecha_Inicio     = CONVERT(CHAR(10), fecha_inicio_flujo, 103)
      ,    Fecha_pago       = CONVERT(CHAR(10), FechaLiquidacion, 103)
      ,    PlazoFlujo       = PlazoFlujo
      ,    Amortizacion     = venta_amortiza
      ,    Capital          = CONVERT(NUMERIC(21,4), venta_saldo + venta_Amortiza)
      ,    ValorTasa        = venta_valor_tasa
      ,    MontoInteres     = venta_interes
      ,    Documento        = glosa
      ,    NomApoCli1       = ISNULL( LTRIM(RTRIM( a.apnombre ))                                  , '')
      ,    RutApoCli1       = ISNULL( LTRIM(RTRIM( a.aprutapo )) + '-' + LTRIM(RTRIM( a.apdvapo )), '')
      ,    NomApoCli2       = ISNULL( LTRIM(RTRIM( b.apnombre ))                                  , '')
      ,    RutApoCli2       = ISNULL( LTRIM(RTRIM( b.aprutapo )) + '-' + LTRIM(RTRIM( b.apdvapo )), '')
      ,    Fecha_CondGrales = CONVERT(CHAR(10), clFechaFirma_cond, 103)
      ,    MonedaCompra     = ''
      ,    MonedaVenta      = ISNULL( mnnemo , '')
      ,    MontoCompra      = compra_capital
      ,    MontoVenta       = venta_capital
      ,    FechaInicio      = CONVERT(CHAR(10), fecha_inicio,  103)
      ,    FechaTermino     = CONVERT(CHAR(10), fecha_termino, 103)
      ,    TasaCompra       = compra_valor_tasa
      ,    TasaVenta        = venta_valor_tasa
      ,    DesTasaCompra    = CONVERT(VARCHAR(15), '')
      ,    DesTasaVenta     = CONVERT(VARCHAR(15), tbglosa)
   FROM    BacSwapSuda..CARTERA
           INNER JOIN BacParamSuda..CLIENTE               with(nolock) ON clrut      = rut_cliente AND clcodigo  = codigo_cliente
           LEFT  JOIN BacParamSuda..MONEDA                with(nolock) ON mncodmon   = venta_moneda
           LEFT  JOIN BacParamSuda..TABLA_GENERAL_DETALLE with(nolock) ON tbcateg    = 1042        AND tbcodigo1 = venta_codigo_tasa
           LEFT  JOIN BacParamSuda..FORMA_DE_PAGO         with(nolock) ON codigo     = pagamos_documento
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   a with(nolock) ON a.aprutcli = clrut AND a.apcodcli = clcodigo AND a.aprutapo = @ApoCliente1
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   b with(nolock) ON b.aprutcli = clrut AND b.apcodcli = clcodigo AND b.aprutapo = @ApoCliente2
   WHERE   numero_operacion = @nContrato
     AND   tipo_flujo       = 2

   IF (SELECT COUNT(1) FROM #TMP_CONTRATO) = 0
   BEGIN
      DECLARE @dFechaCierre    DATETIME
          SET @dFechaCierre    = (SELECT MIN(Fecha_Proceso) FROM BacSwapSuda..CARTERARES WHERE numero_operacion = @nContrato)

      INSERT INTO #TMP_CONTRATO
      SELECT  Contrato         = CONVERT(NUMERIC(9),  Numero_Operacion )
         ,    TipoFlujo        = tipo_flujo
         ,    NumeroFlujo      = numero_flujo
         ,    nRutCliente      = clrut
         ,    nCodCliente      = clcodigo
         ,    RutCliente       = CONVERT(VARCHAR(15), LTRIM(RTRIM( rut_cliente )) + '-' + LTRIM(RTRIM( cldv )) )
         ,    Cliente          = CONVERT(VARCHAR(50), SUBSTRING(clnombre, 1, 50) )
         ,    DirCliente       = cldirecc
         ,    Moneda           = ISNULL( mnnemo , '')
         ,    Nocional         = compra_capital
         ,    Tasa             = CONVERT(VARCHAR(15), tbglosa)
         ,    Fecha_Cierre     = CONVERT(CHAR(10), Fecha_Cierre, 103)
         ,    Fecha_Inicio     = CONVERT(CHAR(10), Fecha_Inicio_Flujo, 103)
         ,    Fecha_pago       = CONVERT(CHAR(10), FechaLiquidacion,   103)
         ,    PlazoFlujo       = PlazoFlujo
         ,    Amortizacion     = compra_amortiza
         ,    Capital          = CONVERT(NUMERIC(21,4), compra_saldo + compra_Amortiza)
         ,    ValorTasa        = compra_valor_tasa
         ,    MontoInteres     = compra_interes
         ,    Documento        = glosa
         ,    NomApoCli1       = ISNULL( LTRIM(RTRIM( a.apnombre ))                                  , '')
         ,    RutApoCli1       = ISNULL( LTRIM(RTRIM( a.aprutapo )) + '-' + LTRIM(RTRIM( a.apdvapo )), '')
         ,    NomApoCli2       = ISNULL( LTRIM(RTRIM( b.apnombre ))                                  , '')
         ,    RutApoCli2       = ISNULL( LTRIM(RTRIM( b.aprutapo )) + '-' + LTRIM(RTRIM( b.apdvapo )), '')
         ,    Fecha_CondGrales = CONVERT(CHAR(10), clFechaFirma_cond, 103)
         ,    MonedaCompra     = ISNULL( mnnemo , '')
         ,    MonedaVenta      = ''
         ,    MontoCompra      = compra_capital
         ,    MontoVenta       = venta_capital
         ,    FechaInicio      = CONVERT(CHAR(10), fecha_inicio,  103)
         ,    FechaTermino     = CONVERT(CHAR(10), fecha_termino, 103)
         ,    TasaCompra       = compra_valor_tasa
         ,    TasaVenta        = venta_valor_tasa
         ,    DesTasaCompra    = CONVERT(VARCHAR(15), tbglosa)
         ,    DesTasaVenta     = CONVERT(VARCHAR(15), '')
      FROM    BacSwapSuda..CARTERARES
              INNER JOIN BacParamSuda..CLIENTE               with(nolock) ON clrut    = rut_cliente AND clcodigo  = codigo_cliente
              LEFT  JOIN BacParamSuda..MONEDA                with(nolock) ON mncodmon = compra_moneda
              LEFT  JOIN BacParamSuda..TABLA_GENERAL_DETALLE with(nolock) ON tbcateg  = 1042        AND tbcodigo1 = compra_codigo_tasa
              LEFT  JOIN BacParamSuda..FORMA_DE_PAGO         with(nolock) ON codigo   = recibimos_documento
              LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   a with(nolock) ON a.aprutcli = clrut AND a.apcodcli = clcodigo AND a.aprutapo = @ApoCliente1
              LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   b with(nolock) ON b.aprutcli = clrut AND b.apcodcli = clcodigo AND b.aprutapo = @ApoCliente2
      WHERE   fecha_proceso    = @dFechaCierre
        AND   numero_operacion = @nContrato
        AND   tipo_flujo       = 1

      UNION 

      SELECT  contrato         = CONVERT(NUMERIC(9),  Numero_Operacion )
         ,    TipoFlujo        = tipo_flujo
         ,    NumeroFlujo      = numero_flujo
         ,    nRutCliente      = clrut
         ,    nCodCliente      = clcodigo
         ,    RutCliente       = CONVERT(VARCHAR(15), LTRIM(RTRIM( rut_cliente )) + '-' + LTRIM(RTRIM( cldv )) )
         ,    Cliente          = CONVERT(VARCHAR(50), SUBSTRING(clnombre, 1, 50) )
         ,    DirCliente       = cldirecc
         ,    Moneda           = ISNULL( mnnemo , '')
         ,    Nocional         = venta_capital
         ,    Tasa             = CONVERT(VARCHAR(15), tbglosa)
         ,    Fecha_Cierre     = CONVERT(CHAR(10), Fecha_Cierre, 103)
         ,    Fecha_Inicio     = CONVERT(CHAR(10), fecha_inicio_flujo, 103)
         ,    Fecha_pago       = CONVERT(CHAR(10), FechaLiquidacion, 103)
         ,    PlazoFlujo       = PlazoFlujo
         ,    Amortizacion     = venta_amortiza
         ,    Capital          = CONVERT(NUMERIC(21,4), venta_saldo + venta_Amortiza)
         ,    ValorTasa        = venta_valor_tasa
         ,    MontoInteres     = venta_interes
         ,    Documento        = glosa

         ,    NomApoCli1       = ISNULL( LTRIM(RTRIM( a.apnombre ))                                  , '')
         ,    RutApoCli1       = ISNULL( LTRIM(RTRIM( a.aprutapo )) + '-' + LTRIM(RTRIM( a.apdvapo )), '')
         ,    NomApoCli2       = ISNULL( LTRIM(RTRIM( b.apnombre ))                                  , '')
         ,    RutApoCli2       = ISNULL( LTRIM(RTRIM( b.aprutapo )) + '-' + LTRIM(RTRIM( b.apdvapo )), '')
         ,    Fecha_CondGrales = CONVERT(CHAR(10), clFechaFirma_cond, 103)
         ,    MonedaCompra     = ''
         ,    MonedaVenta      = ISNULL( mnnemo , '')
         ,    MontoCompra      = compra_capital
         ,    MontoVenta       = venta_capital
         ,    FechaInicio      = CONVERT(CHAR(10), fecha_inicio,  103)
         ,    FechaTermino     = CONVERT(CHAR(10), fecha_termino, 103)
         ,    TasaCompra       = compra_valor_tasa
         ,    TasaVenta        = venta_valor_tasa
         ,    DesTasaCompra    = CONVERT(VARCHAR(15), '')
         ,    DesTasaVenta     = CONVERT(VARCHAR(15), tbglosa)
      FROM    BacSwapSuda..CARTERARES
              INNER JOIN BacParamSuda..CLIENTE               with(nolock) ON clrut      = rut_cliente AND clcodigo  = codigo_cliente
              LEFT  JOIN BacParamSuda..MONEDA                with(nolock) ON mncodmon   = venta_moneda
              LEFT  JOIN BacParamSuda..TABLA_GENERAL_DETALLE with(nolock) ON tbcateg    = 1042        AND tbcodigo1 = venta_codigo_tasa
              LEFT  JOIN BacParamSuda..FORMA_DE_PAGO         with(nolock) ON codigo     = pagamos_documento
              LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   a with(nolock) ON a.aprutcli = clrut AND a.apcodcli = clcodigo AND a.aprutapo = @ApoCliente1
              LEFT  JOIN BacParamSuda..CLIENTE_APODERADO   b with(nolock) ON b.aprutcli = clrut AND b.apcodcli = clcodigo AND b.aprutapo = @ApoCliente2
      WHERE   fecha_proceso    = @dFechaCierre
        AND   numero_operacion = @nContrato
        AND   tipo_flujo       = 2
   END

   DECLARE @nMonCompra  CHAR(3)
       SET @nMonCompra  = (SELECT TOP 1 MonedaCompra FROM #TMP_CONTRATO WHERE TipoFlujo = 1)
   DECLARE @nMonVenta   CHAR(3)
       SET @nMonVenta   = (SELECT TOP 1 MonedaVenta  FROM #TMP_CONTRATO WHERE TipoFlujo = 2)
   
   DECLARE @nMtoCompra  NUMERIC(21,4)
       SET @nMtoCompra  = (SELECT TOP 1 MontoCompra  FROM #TMP_CONTRATO WHERE TipoFlujo = 1)
   DECLARE @nMtoVenta   NUMERIC(21,4)
       SET @nMtoVenta   = (SELECT TOP 1 MontoVenta   FROM #TMP_CONTRATO WHERE TipoFlujo = 2)

   DECLARE @nTasaCompra FLOAT
       SET @nTasaCompra = (SELECT TOP 1 TasaCompra   FROM #TMP_CONTRATO WHERE TipoFlujo = 1)
   DECLARE @nTasaVenta  FLOAT
       SET @nTasaVenta  = (SELECT TOP 1 TasaVenta    FROM #TMP_CONTRATO WHERE TipoFlujo = 2)

   DECLARE @cTasaCompra VARCHAR(15)
       SET @cTasaCompra = (SELECT TOP 1 DesTasaCompra FROM #TMP_CONTRATO WHERE TipoFlujo = 1)

   DECLARE @cTasaVenta  VARCHAR(15)
       SET @cTasaVenta  = (SELECT TOP 1 DesTasaVenta  FROM #TMP_CONTRATO WHERE TipoFlujo = 2)

   UPDATE #TMP_CONTRATO SET MonedaCompra = @nMonCompra, MontoCompra = @nMtoCompra, TasaCompra = @nTasaCompra, DesTasaCompra = @cTasaCompra
   UPDATE #TMP_CONTRATO SET MonedaVenta  = @nMonVenta,  MontoVenta  = @nMtoVenta,  TasaVenta  = @nTasaVenta,  DesTasaVenta  = @cTasaVenta


   DECLARE @RutEntidad   VARCHAR(15)
   DECLARE @Entidad      VARCHAR(30)
   DECLARE @DirEntidad   VARCHAR(50)
   DECLARE @NomApoEnt1   VARCHAR(40)
   DECLARE @RutApoEnt1   VARCHAR(15)
   DECLARE @NomApoEnt2   VARCHAR(40)
   DECLARE @RutApoEnt2   VARCHAR(15)

   DECLARE @NomApoCli1   VARCHAR(40)
   DECLARE @RutApoCli1   VARCHAR(15)
   DECLARE @NomApoCli2   VARCHAR(40)
   DECLARE @RutApoCli2   VARCHAR(15)
   
    SELECT @RutEntidad  = LTRIM(RTRIM( clrut )) + '-' + LTRIM(RTRIM( cldv ))
        ,  @Entidad     = nombre 
        ,  @DirEntidad  = direccion
        ,  @NomApoEnt1  = LTRIM(RTRIM( a.apnombre ))
        ,  @RutApoEnt1  = LTRIM(RTRIM( a.aprutapo )) + '-' + LTRIM(RTRIM( a.apdvapo ))
        ,  @NomApoEnt2  = LTRIM(RTRIM( b.apnombre ))
        ,  @RutApoEnt2  = LTRIM(RTRIM( b.aprutapo )) + '-' + LTRIM(RTRIM( b.apdvapo ))
      FROM BacSwapSuda..SWAPGENERAL                     with(nolock)
           INNER JOIN BacParamSuda..CLIENTE             with(nolock) ON clrut      = rut   AND clcodigo   = 1
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO a with(nolock) ON a.aprutcli = clrut AND a.apcodcli = clcodigo AND a.aprutapo = @ApoEntidad1
           LEFT  JOIN BacParamSuda..CLIENTE_APODERADO b with(nolock) ON b.aprutcli = clrut AND b.apcodcli = clcodigo AND b.aprutapo = @ApoEntidad2

   SELECT  contrato         = contrato         --> 01
      ,    Fecha_Cierre     = Fecha_Cierre     --> 02
      ,    RutEntidad       = @RutEntidad      --> 03
      ,    Entidad          = @Entidad         --> 04
      ,    DirEntidad       = @DirEntidad      --> 05
      ,    NomApoEnt1       = @NomApoEnt1      --> 06
      ,    RutApoEnt1       = @RutApoEnt1      --> 07
      ,    NomApoEnt2       = @NomApoEnt2      --> 08
      ,    RutApoEnt2       = @RutApoEnt2      --> 09

      ,    RutCliente       = RutCliente       --> 10
      ,    Cliente          = Cliente          --> 11
      ,    DirCliente       = DirCliente       --> 12
      ,    NomApoCli1       = NomApoCli1       --> 13
      ,    RutApoCli1       = RutApoCli1       --> 14
      ,    NomApoCli2       = NomApoCli2       --> 15
      ,    RutApoCli2       = RutApoCli2       --> 16

      ,    TipoFlujo        = TipoFlujo        --> 17
      ,    NumeroFlujo      = NumeroFlujo      --> 18
      ,    Moneda           = Moneda           --> 19
      ,    Nocional         = Nocional         --> 20
      ,    Tasa             = Tasa             --> 21
      ,    Fecha_Inicio     = Fecha_Inicio     --> 22
      ,    Fecha_pago       = Fecha_pago       --> 23
      ,    PlazoFlujo       = PlazoFlujo       --> 24
      ,    Amortizacion     = Amortizacion     --> 25
      ,    Capital          = Capital          --> 26
      ,    ValorTasa        = ValorTasa        --> 27
      ,    MontoInteres     = MontoInteres     --> 28
      ,    Documento        = Documento        --> 29
      ,    Fecha_CondGrales = Fecha_CondGrales --> 30
      ,    MonedaCompra     = MonedaCompra     --> 31
      ,    MonedaVenta      = MonedaVenta      --> 32
      ,    MontoCompra      = MontoCompra      --> 33
      ,    MontoVenta       = MontoVenta       --> 34
      ,    FechaInicio      = FechaInicio      --> 35
      ,    FechaTermino     = FechaTermino     --> 36
      ,    TasaCompra       = TasaCompra       --> 37
      ,    TasaVenta        = TasaVenta        --> 38
      ,    DesTasaCompra    = DesTasaCompra    --> 39
      ,    DesTasaVenta     = DesTasaVenta     --> 40
   FROM   #TMP_CONTRATO 
   ORDER BY TipoFlujo, NumeroFlujo

END
GO
