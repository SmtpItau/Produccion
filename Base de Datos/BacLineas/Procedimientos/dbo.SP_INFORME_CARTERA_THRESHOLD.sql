USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_THRESHOLD]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_THRESHOLD]
   (   @dFecha      DATETIME    = ''
   ,   @IdSistema   CHAR(3)     = ''
   ,   @IdProducto  INTEGER     = 0
   ,   @RutCliente  NUMERIC(9)  = 0
   ,   @CodCliente  INTEGER     = 0
   ,   @AplicaThr   CHAR(1)     = ''
   ,   @Operador    VARCHAR(15) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso  DATETIME
       SET @dFechaProceso  = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @dFechaAnterior DATETIME
       SET @dFechaAnterior = (SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @dFechaForward  DATETIME
       SET @dFechaForward  = (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC         with(nolock) )

   DECLARE @dFechaSwap     DATETIME
       SET @dFechaSwap     = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )

   DECLARE @FechaProceso   CHAR(10)
       SET @FechaProceso   = (SELECT CONVERT(CHAR(10), acfecproc, 103) FROM BacTraderSuda.dbo.MDAC)

   DECLARE @FechaEmision   CHAR(10)
       SET @FechaEmision   = CONVERT(CHAR(10), GETDATE(), 103)

   DECLARE @HoraEmision    CHAR(10)
       SET @HoraEmision    = CONVERT(CHAR(10), GETDATE(), 108)

   DECLARE @vValorUf       FLOAT
       SET @vValorUf       = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock)
                                            WHERE vmfecha = @dFechaAnterior AND vmcodigo = 998 )



   CREATE TABLE #TMP_CARTERA_THRESHOLD
   (   /*01*/ Modulo            CHAR(3)
   ,   /*02*/ Producto          VARCHAR(50)
   ,   /*03*/ RutCliente        NUMERIC(12)
   ,   /*04*/ CodCliente        INTEGER
   ,   /*05*/ NombreCliente     VARCHAR(50)
   ,   /*06*/ Contrato          NUMERIC(9)
   ,   /*07*/ Operacion         VARCHAR(10)
   ,   /*08*/ FechaInicio       CHAR(10)
   ,   /*09*/ FechaTermino      CHAR(10)
   ,   /*10*/ Plazo             NUMERIC(9)
   ,   /*11*/ Nocional          NUMERIC(21,4)
   ,   /*12*/ TasaForward       NUMERIC(21,4)
   ,   /*13*/ ValorMercado      NUMERIC(21,4)
   ,   /*14*/ MontoThreshold    NUMERIC(21,4)
   ,   /*15*/ Excesos           NUMERIC(21,4)
   ,   /*16*/ Rec               NUMERIC(21,4)
   ,   /*17*/ AplicaThreshold   CHAR(1)
   ,   /*18*/ Registros         NUMERIC(9)
   ,   /*19*/ CodMoneda         INTEGER
   ,   /*20*/ NemMoneda         VARCHAR(10)
   ,   /*21*/ MontoGarantias    NUMERIC(21,4)
   ,   /*22*/ EstadoCliente     VARCHAR(50)
   ,   /*23*/ MotivoBloqueo     VARCHAR(100)
   ,   /*24*/ NocionalPesos     NUMERIC(21,0)
   ,   /*25*/ ContratosNuevos   CHAR(2)
   )

   CREATE TABLE #TMP_CARTERAS
   (   /*01*/ RutCliente     NUMERIC(12)
   ,   /*02*/ CodCliente     NUMERIC(9)
   ,   /*03*/ Contrato       NUMERIC(9)
   ,   /*04*/ Tipo           VARCHAR(5)
   ,   /*05*/ Producto       VARCHAR(5)
   ,   /*06*/ FechaInicio    DATETIME
   ,   /*07*/ FechaTermino   DATETIME
   ,   /*08*/ Plazo          NUMERIC(9)
   ,   /*09*/ Moneda         INTEGER
   ,   /*10*/ Nocional       NUMERIC(21,4)
   ,   /*11*/ Tasa           NUMERIC(21,4)
   ,   /*12*/ Mercado        NUMERIC(21,4)
   ,   /*13*/ Threshold      CHAR(1)
   ,   /*14*/ Modulo         CHAR(3)
   )

   CREATE TABLE #TMP_FLUJO_ACTIVO
   (   Documento   NUMERIC(9)
   ,   Flujo       INTEGER
   )

   --********************************--
   --           FORWARD              --
   --********************************--
   IF (@IdSistema = 'BFW' OR @IdSistema = '')
   BEGIN

      IF @dFechaForward = @dFecha
      BEGIN
         INSERT INTO #TMP_CARTERAS
         SELECT /*01*/ RutCliente     = car.cacodigo
            ,   /*02*/ CodCliente     = car.cacodcli
            ,   /*03*/ Contrato       = car.canumoper
            ,   /*04*/ Tipo           = car.catipoper
            ,   /*05*/ Producto       = car.cacodpos1
            ,   /*06*/ FechaInicio    = car.cafecha
            ,   /*07*/ FechaTermino   = car.cafecvcto
            ,   /*08*/ Plazo          = car.caplazo
            ,   /*09*/ Moneda         = car.cacodmon1
            ,   /*10*/ Nocional       = car.camtomon1
            ,   /*11*/ Tasa           = car.catipcam
            ,   /*12*/ Mercado        = car.fres_obtenido
            ,   /*13*/ Threshold      = CASE WHEN car.Threshold = 'S' THEN 'S' ELSE 'N' END
            ,   /*14*/ Modulo         = 'BFW'
         FROM   BacFwdSuda.dbo.MFCA   car with(nolock) 
         WHERE (car.cafecha           < @dFecha)
         AND   (@IdSistema            = 'BFW'        OR @IdSistema   = '') --> Filtra por Sistema
         AND   (car.cacodpos1         = @IdProducto  OR @IdProducto  = 0)  --> Filtra por Productos
         AND  ((car.cacodigo          = @RutCliente AND car.cacodcli = @CodCliente) 
            OR (@RutCliente           = 0           AND @CodCliente  = 0)) --> Filtra por Clientes

      END ELSE
      BEGIN

         INSERT INTO #TMP_CARTERAS
         SELECT /*01*/ RutCliente     = car.cacodigo
            ,   /*02*/ CodCliente     = car.cacodcli
            ,   /*03*/ Contrato       = car.canumoper
            ,   /*04*/ Tipo           = car.catipoper
            ,   /*05*/ Producto       = car.cacodpos1
            ,   /*06*/ FechaInicio    = car.cafecha
            ,   /*07*/ FechaTermino   = car.cafecvcto
            ,   /*08*/ Plazo          = car.caplazo
            ,   /*09*/ Moneda         = car.cacodmon1
            ,   /*10*/ Nocional       = car.camtomon1
            ,   /*11*/ Tasa           = car.catipcam
            ,   /*12*/ Mercado        = car.fres_obtenido
            ,   /*13*/ Threshold      = CASE WHEN car.Threshold = 'S' THEN 'S' ELSE 'N' END
            ,   /*14*/ Modulo         = 'BFW'      
         FROM   BacFwdSuda.dbo.MFCARES car with(nolock) 
         WHERE (cafechaproceso        = @dFecha)                                 --> Filtra Operaciones Historicas
         AND   (@IdSistema            = 'BFW'        OR @IdSistema   = '')       --> Filtra Por Sistema
         AND   (car.cacodpos1         = @IdProducto  OR @IdProducto  = 0)        --> Filtra por Producto
         AND  ((car.cacodigo          = @RutCliente  AND car.cacodcli = @CodCliente)    
            OR (@RutCliente           = 0            AND @CodCliente  = 0))       --> Filtra por Cliente

      END
   END


   --********************************--
   --              SWAP              --
   --********************************--
   IF (@IdSistema = 'PCS' OR @IdSistema = '')
   BEGIN

      IF @dFechaSwap = @dFecha
      BEGIN

         INSERT INTO #TMP_FLUJO_ACTIVO 
              SELECT numero_operacion, MIN(numero_flujo) 
                FROM BacSwapSuda.dbo.CARTERA WHERE Fecha_Cierre < @dFecha
                                               AND Tipo_Flujo   = 1 AND Estado <> 'C' GROUP BY numero_operacion

         INSERT INTO #TMP_CARTERAS
         SELECT /*01*/ RutCliente   = car.rut_cliente
            ,   /*02*/ CodCliente   = car.codigo_cliente
            ,   /*03*/ Contrato     = car.numero_operacion
            ,   /*04*/ Tipo         = car.tipo_operacion
            ,   /*05*/ Producto     = CASE WHEN car.tipo_swap = 1 THEN 'ST'
                                           WHEN car.tipo_swap = 2 THEN 'SM'
                                           WHEN car.tipo_swap = 3 THEN 'FR'
                                           WHEN car.tipo_swap = 4 THEN 'SP'
                                      END
            ,   /*06*/ FechaInicio  = car.fecha_cierre
            ,   /*07*/ FechaTermino = car.fecha_termino
            ,   /*08*/ Plazo        = DATEDIFF( DAY, car.fecha_cierre, car.fecha_termino)
            ,   /*09*/ Moneda       = car.compra_moneda
            ,   /*10*/ Nocional     = car.compra_capital
            ,   /*11*/ Tasa         = car.compra_valor_tasa
            ,   /*12*/ Mercado      = car.Valor_RazonableCLP
            ,   /*13*/ Threshold    = CASE WHEN car.Threshold = 'S' THEN 'S' ELSE 'N' END
            ,   /*14*/ Modulo       = 'PCS'
         FROM   BacSwapSuda.dbo.CARTERA car with(nolock)
                INNER JOIN #TMP_FLUJO_ACTIVO ON Documento = car.numero_operacion AND Flujo = car.numero_flujo
         WHERE (car.tipo_flujo      = 1)
         AND   (@IdSistema          = 'PCS'        OR @IdSistema         = '')      --> Filtra por Modulo
         AND   (car.tipo_swap       = @IdProducto  OR @IdProducto        = 0)       --> Filtra por Producto
         AND  ((car.rut_cliente     = @RutCliente AND car.codigo_cliente = @CodCliente)
            OR (@RutCliente         = 0           AND @CodCliente        = 0))       --> Filtra por Cliente

      END ELSE
      BEGIN

         INSERT INTO #TMP_FLUJO_ACTIVO
              SELECT numero_operacion, MIN(numero_flujo) 
                FROM BacSwapSuda.dbo.CARTERARES WHERE Fecha_Proceso = @dFecha AND Tipo_Flujo = 1 AND Estado <> 'C' GROUP BY numero_operacion

         INSERT INTO #TMP_CARTERAS
         SELECT /*01*/ RutCliente   = car.rut_cliente
            ,   /*02*/ CodCliente   = car.codigo_cliente
            ,   /*03*/ Contrato     = car.numero_operacion
            ,   /*04*/ Tipo         = car.tipo_operacion
            ,   /*05*/ Producto     = CASE WHEN car.tipo_swap = 1 THEN 'ST'
                                           WHEN car.tipo_swap = 2 THEN 'SM'
                                           WHEN car.tipo_swap = 3 THEN 'FR'
                                           WHEN car.tipo_swap = 4 THEN 'SP'
                                      END
            ,   /*06*/ FechaInicio  = car.fecha_cierre
            ,   /*07*/ FechaTermino = car.fecha_termino
            ,   /*08*/ Plazo        = DATEDIFF( DAY, car.fecha_cierre, car.fecha_termino)
            ,   /*09*/ Moneda       = car.compra_moneda
            ,   /*10*/ Nocional     = car.compra_capital
            ,   /*11*/ Tasa         = car.compra_valor_tasa
            ,   /*12*/ Mercado      = car.Valor_RazonableCLP
            ,   /*13*/ Threshold    = CASE WHEN car.Threshold = 'S' THEN 'S' ELSE 'N' END
            ,   /*14*/ Modulo       = 'PCS'
         FROM   BacSwapSuda.dbo.CARTERARES car with(nolock)
                INNER JOIN #TMP_FLUJO_ACTIVO ON Documento = car.numero_operacion AND Flujo = car.numero_flujo
         WHERE (car.Fecha_Proceso   = @dFecha)                                      --> Filtra por Fecha
         AND   (car.tipo_flujo      = 1)
         AND   (@IdSistema          = 'PCS'        OR @IdSistema         = '')      --> Filtra por Modulo
         AND   (car.tipo_swap       = @IdProducto  OR @IdProducto        = 0)       --> Filtra por Producto
         AND  ((car.rut_cliente     = @RutCliente AND car.codigo_cliente = @CodCliente)
            OR (@RutCliente         = 0           AND @CodCliente        = 0))       --> Filtra por Cliente

      END

   END

   INSERT INTO #TMP_CARTERA_THRESHOLD
   SELECT /*01*/ Modulo            = car.Modulo
      ,   /*02*/ Producto          = pro.descripcion
      ,   /*03*/ RutCliente        = car.RutCliente
      ,   /*04*/ CodCliente        = car.CodCliente
      ,   /*05*/ NombreCliente     = isnull( substring(cli.clnombre,1, 50) , '')
      ,   /*06*/ Contrato          = car.Contrato
      ,   /*07*/ Operacion         = CASE WHEN car.Tipo = 'C' THEN 'COMPRA' ELSE 'VENTA' END
      ,   /*08*/ FechaInicio       = CONVERT( CHAR(10), car.FechaInicio,  103)
      ,   /*09*/ FechaTermino      = CONVERT( CHAR(10), car.FechaTermino, 103)
      ,   /*10*/ Plazo             = car.Plazo
      ,   /*11*/ Nocional          = car.Nocional
      ,   /*12*/ TasaForward       = car.Tasa
      ,   /*13*/ ValorMercado      = car.Mercado
      ,   /*14*/ MontoThreshold    = isnull(Thr.Threshold_Aplicado, 0.0)
      ,   /*15*/ Excesos           = CASE WHEN car.Threshold = 'S' AND car.Mercado > ISNULL(Thr.Threshold_Aplicado, 0.0) THEN car.Mercado - isnull(Thr.Threshold_Aplicado, 0.0)
                                          ELSE                                                                                0.0
                                     END
      ,   /*16*/ Rec               = isnull(Thr.Rec, 0.0)
      ,   /*17*/ AplicaThreshold   = car.Threshold
      ,   /*18*/ Registros         = 0 --> @iRegistros
      ,   /*19*/ CodMoneda         = mon.mncodmon
      ,   /*20*/ NemMoneda         = mon.mnnemo
      ,   /*21*/ MontoGarantias    = ISNULL(cli.garantiatotal, 0.0)
      ,   /*22*/ EstadoCliente     = CASE WHEN cli.Bloqueado = 'S'                         THEN 'CLIENTE BLOQUEADO'
                                          WHEN cli.Bloqueado = 'N' and lgn.Bloqueado = 'S' THEN 'LINEA GENERAL BLOQUEADA'
                                          ELSE                                                  'LINEA VIGENTE'
                                     END
      ,   /*23*/ MotivoBloqueo     = CASE WHEN cli.Bloqueado = 'S'                         THEN SUBSTRING(cli.motivo_bloqueo, 1, 100)
                                          WHEN cli.Bloqueado = 'N' and lgn.Bloqueado = 'S' THEN SUBSTRING(cli.motivo_bloqueo, 1, 100)
                                          ELSE                                                  ' '
                                     END
      ,   /*24*/ NocionalPesos     = CASE WHEN mon.mncodmon = 999 THEN ROUND(car.Nocional, 0)
                                          WHEN mon.mncodmon = 998 THEN ROUND(car.Nocional * @vValorUf,   0)
                                          ELSE                         ROUND(car.Nocional * Tipo_Cambio, 0)
                                     END
      ,   /*25*/ ContratosNuevos   = CASE WHEN cli.nuevo_ccg_firmado = 'S' THEN 'SI' ELSE 'NO' END 
   FROM   #TMP_CARTERAS                                      car
          LEFT JOIN BacParamSuda.dbo.CLIENTE                 cli with(nolock) ON cli.clrut = car.RutCliente AND cli.clcodigo = car.CodCliente
          LEFT JOIN BacLineas.dbo.LINEA_GENERAL              lgn with(nolock) ON lgn.rut_cliente = car.RutCliente and lgn.codigo_cliente = car.CodCliente
          LEFT JOIN BacParamSuda.dbo.MONEDA                  mon with(nolock) ON mon.mncodmon = car.Moneda
          LEFT JOIN BacParamSuda.dbo.PRODUCTO                pro with(nolock) ON pro.id_sistema = car.Modulo AND pro.codigo_producto = car.Producto
          LEFT JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION Thr with(nolock) ON Thr.Sistema = car.Modulo
                                                                             and Thr.Numero_Operacion = car.Contrato
          LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE   vmo with(nolock) ON vmo.fecha            = @dFechaAnterior 
                                                                             AND vmo.codigo_moneda    = CASE WHEN mon.mncodmon = 13 THEN 994 ELSE mon.mncodmon END

   WHERE (car.Threshold            = @AplicaThr OR @AplicaThr = '')

   UPDATE BacLineas.dbo.LINEA_GENERAL 
      SET Bloqueado      = 'S'
     FROM #TMP_CARTERA_THRESHOLD
    WHERE (rut_cliente   = #TMP_CARTERA_THRESHOLD.RutCliente AND Codigo_Cliente = #TMP_CARTERA_THRESHOLD.CodCliente)
      AND (Excesos       > 0)

   UPDATE BacParamSuda.dbo.CLIENTE
      SET motivo_bloqueo = 'LINEA GENERAL BLOQUEADA POR EXCESO EN THRESHOLD.'
     FROM #TMP_CARTERA_THRESHOLD
    WHERE (clrut         = #TMP_CARTERA_THRESHOLD.RutCliente AND clcodigo = #TMP_CARTERA_THRESHOLD.CodCliente)
      AND (Excesos       > 0)

   UPDATE #TMP_CARTERA_THRESHOLD
      SET EstadoCliente  = 'LINEA GENERAL BLOQUEADA'
      ,   MotivoBloqueo  = 'LINEA GENERAL BLOQUEADA POR EXCESO EN THRESHOLD.'
    WHERE Excesos        > 0

   DECLARE @iRegistros   NUMERIC(9)
       SET @iRegistros   = (SELECT COUNT(1) FROM #TMP_CARTERA_THRESHOLD)

   SELECT /*01*/ Modulo          = Modulo
      ,   /*02*/ Producto        = Producto
      ,   /*03*/ RutCliente      = RutCliente
      ,   /*04*/ CodCliente      = CodCliente
      ,   /*05*/ NombreCliente   = NombreCliente
      ,   /*06*/ Contrato        = Contrato
      ,   /*07*/ Operacion       = Operacion
      ,   /*08*/ FechaInicio     = FechaInicio
      ,   /*09*/ FechaTermino    = FechaTermino
      ,   /*10*/ Plazo           = Plazo
      ,   /*11*/ Nocional        = Nocional
      ,   /*12*/ TasaForward     = TasaForward
      ,   /*13*/ ValorMercado    = ValorMercado
      ,   /*14*/ MontoThreshold  = MontoThreshold
      ,   /*15*/ Excesos         = Excesos
      ,   /*16*/ Rec             = Rec
      ,   /*17*/ AplicaThreshold = AplicaThreshold
      ,   /*18*/ Registros       = @iRegistros
      ,   /*19*/ CodMoneda       = CodMoneda
      ,   /*20*/ NemMoneda       = NemMoneda
      ,   /*21*/ MontoGarantias  = MontoGarantias
      ,   /*22*/ EstadoCliente   = EstadoCliente
      ,   /*23*/ MotivoBloqueo   = MotivoBloqueo
      ,   /*24*/ FechaProceso    = @FechaProceso
      ,   /*25*/ FechaEmision    = @FechaEmision
      ,   /*26*/ HoraEmision     = @HoraEmision
      ,   /*27*/ Operador        = @Operador
      ,   /*28*/ NocionalPesos   = NocionalPesos
      ,   /*29*/ ContratosNuevos = ContratosNuevos
   FROM   #TMP_CARTERA_THRESHOLD
   ORDER BY NombreCliente, AplicaThreshold, Contrato, CodMoneda

END
GO
