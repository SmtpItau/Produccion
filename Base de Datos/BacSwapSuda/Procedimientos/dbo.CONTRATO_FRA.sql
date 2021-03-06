USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_FRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CONTRATO_FRA]
   (   @iNumoper     NUMERIC(9)
   ,   @iRutBanco1   NUMERIC(10)
   ,   @iRutBanco2   NUMERIC(10)
   ,   @iRutCliente1 NUMERIC(10)
   ,   @iRutCliente2 NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso        DATETIME

   DECLARE @NombreBanco1         VARCHAR(20)
   ,       @RutBanco1            VARCHAR(13)
   ,       @DvBanco              CHAR(1)
   ,       @ApoderadoBanco1      VARCHAR(40)
   ,       @RutApoderadoBanco1   VARCHAR(13)
   ,       @DvApoderadoBanco1    CHAR(1)
   ,       @ApoderadoBanco2      VARCHAR(40)
   ,       @RutApoderadoBanco2   VARCHAR(13)
   ,       @DvApoderadoBanco2    CHAR(1)
   ,       @DireccionBanco       CHAR(50)

   DECLARE @NombreCliente1       VARCHAR(20)
   ,       @RutCliente1          VARCHAR(13)
   ,       @DvCliente            CHAR(1)
   ,       @ApoderadoCliente1    VARCHAR(40)
   ,       @RutApoderadoCliente1 VARCHAR(13)
   ,       @DvApoderadoCliente1  CHAR(1)
   ,       @ApoderadoCliente2    VARCHAR(40)
   ,       @RutApoderadoCliente2 VARCHAR(13)
   ,       @DvApoderadoCliente2  CHAR(1)
   ,       @DireccionCliente     CHAR(50)

   -->     Datos del Banco
   SELECT  @dFechaProceso       = fechaproc
   ,       @NombreBanco1        = ISNULL(nombre,'CORPBANCA')
   ,       @RutBanco1           = LTRIM(RTRIM(clrut))
   ,       @DvBanco             = LTRIM(RTRIM(cldv))
   ,       @DireccionBanco      = ISNULL(cldirecc,'HUERFANOS 1072 PISO 9')
   FROM    SWAPGENERAL
           INNER JOIN BacParamSuda..CLIENTE ON clrut = rut and clcodigo = 1

   SELECT  @ApoderadoBanco1     = ''
   ,       @RutApoderadoBanco1  = 0
   ,       @DvApoderadoBanco1   = ''
   SELECT  @ApoderadoBanco1     = ISNULL(apnombre,'')
   ,       @RutApoderadoBanco1  = ISNULL(aprutapo,0)
   ,       @DvApoderadoBanco1   = ISNULL(apdvapo,'')
   FROM    BacParamSuda..CLIENTE_APODERADO
   WHERE   aprutcli             = 97023000 AND aprutapo = @iRutBanco1

   SELECT  @ApoderadoBanco2     = ''
   ,       @RutApoderadoBanco2  = 0
   ,       @DvApoderadoBanco2   = ''
   SELECT  @ApoderadoBanco2     = ISNULL(apnombre,'')
   ,       @RutApoderadoBanco2  = ISNULL(aprutapo,0)
   ,       @DvApoderadoBanco2   = ISNULL(apdvapo,'')
   FROM    BacParamSuda..CLIENTE_APODERADO
   WHERE   aprutcli             = 97023000 AND aprutapo = @iRutBanco2
   -->     Datos del Banco

   -->     Datos del Cliente
   SELECT  @NombreCliente1      = ISNULL(clnombre,'')
   ,       @RutCliente1         = ISNULL(clrut,0)
   ,       @DvCliente           = ISNULL(cldv,'')
   ,       @DireccionCliente    = ISNULL(cldirecc,'')
   FROM    CARTERA
           LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
   WHERE   numero_operacion     = @iNumoper

   SELECT  @ApoderadoCliente1   = ''
   ,       @RutApoderadoCliente1= 0
   ,       @DvApoderadoCliente1 = ''
   SELECT  @ApoderadoCliente1   = ISNULL(apnombre,'')
   ,       @RutApoderadoCliente1= ISNULL(aprutapo,0)
   ,       @DvApoderadoCliente1 = ISNULL(apdvapo,'')
   FROM    BacParamSuda..CLIENTE_APODERADO
   WHERE   aprutcli             = @RutCliente1 AND aprutapo = @iRutCliente1

   SELECT  @ApoderadoCliente2   = ''
   ,       @RutApoderadoCliente2= 0
   ,       @DvApoderadoCliente2 = ''
   SELECT  @ApoderadoCliente2   = ISNULL(apnombre,'')
   ,       @RutApoderadoCliente2= ISNULL(aprutapo,0)
   ,       @DvApoderadoCliente2 = ISNULL(apdvapo,'')
   FROM    BacParamSuda..CLIENTE_APODERADO
   WHERE   aprutcli             = @RutCliente1 AND aprutapo = @iRutCliente2
   -->     Datos del Cliente

   DECLARE @dFechaInicio1   VARCHAR(37)
   SELECT  @dFechaInicio1  = CASE WHEN DATEPART(WEEKDAY,@dFechaProceso) = 1  THEN 'Domingo'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 2  THEN 'Lunes'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 3  THEN 'Martes'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 4  THEN 'Miércoles'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 5  THEN 'Jueves'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 6  THEN 'Viernes'
                                  WHEN DATEPART(WEEKDAY,@dFechaProceso) = 7  THEN 'Sabado'
                             END + ' ' + LTRIM(RTRIM(DATEPART(DAY,@dFechaProceso))) + ' de ' +
                             CASE WHEN DATEPART(MONTH,@dFechaProceso)   = 1  THEN 'Enero'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 2  THEN 'Febrero'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 3  THEN 'Marzo'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 4  THEN 'Abril'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 5  THEN 'Mayo'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 6  THEN 'Junio'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 7  THEN 'Julio'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 8  THEN 'Agosto'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 9  THEN 'Septiembre'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 10 THEN 'Octubre'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 11 THEN 'Noviembre'
                                  WHEN DATEPART(MONTH,@dFechaProceso)   = 12 THEN 'Diciembre'
                              END + ' del ' + LTRIM(RTRIM(DATEPART(YEAR,@dFechaProceso)))

   SELECT /*00*/ 'FechaInicio1'          = @dFechaInicio1

   ,      /*01*/ 'NombreBanco1'          = @NombreBanco1
   ,      /*02*/ 'RutBanco1'             = @RutBanco1
   ,      /*03*/ 'DvBanco'               = @DvBanco
   ,      /*04*/ 'ApoderadoBanco1'       = @ApoderadoBanco1
   ,      /*05*/ 'RutApoderadoBanco1'    = @RutApoderadoBanco1
   ,      /*06*/ 'DvApoderadoBanco1'     = @DvApoderadoBanco1
   ,      /*07*/ 'ApoderadoBanco2'       = @ApoderadoBanco2
   ,      /*08*/ 'RutApoderadoBanco2'    = @RutApoderadoBanco2
   ,      /*09*/ 'DvApoderadoBanco2'     = @DvApoderadoBanco2
   ,      /*11*/ 'DireccionBanco'        = @DireccionBanco

   ,      /*12*/ 'NombreCliente1'        = @NombreCliente1
   ,      /*13*/ 'RutCliente1'           = @RutCliente1
   ,      /*14*/ 'DvCliente'             = @DvCliente
   ,      /*15*/ 'ApoderadoCliente1'     = @ApoderadoCliente1
   ,      /*16*/ 'RutApoderadoCliente1'  = @RutApoderadoCliente1
   ,      /*17*/ 'DvApoderadoCliente1'   = @DvApoderadoCliente1
   ,      /*18*/ 'ApoderadoCliente2'     = @ApoderadoCliente2
   ,      /*19*/ 'RutApoderadoCliente2'  = @RutApoderadoCliente2
   ,      /*20*/ 'DvApoderadoCliente2'   = @DvApoderadoCliente2
   ,      /*21*/ 'DireccionCliente'      = @DireccionCliente

   ,      /*22*/ 'FechaInicio'           = c.Fecha_Cierre
   ,      /*23*/ 'TipoOperacion'         = CASE WHEN c.Tipo_Operacion = 'T' THEN 'Tomador' ELSE 'Prestamista' END
   ,      /*24*/ 'MontoOperacion'        = c.compra_capital
   ,      /*25*/ 'TasaConversion'        = c.compra_valor_tasa -- venta_valor_tasa
   ,      /*26*/ 'Modalidad'             = CASE WHEN c.Modalidad_Pago = 'C' THEN 'Compensacion' ELSE 'Entrega Fisica' END
   ,      /*27*/ 'FechaInicioFlujo'      = CONVERT(CHAR(10),c.Fecha_inicio_flujo,103)
   ,      /*28*/ 'FechaVenceFlujo'       = CONVERT(CHAR(10),c.Fecha_vence_flujo,103)
   ,      /*29*/ 'Dias'                  = DATEDIFF(DAY,c.Fecha_inicio_flujo,c.Fecha_vence_flujo)
   ,      /*30*/ 'MontoCompra'           = c.compra_valor_tasa + c.compra_spread
   ,      /*31*/ 'MontoVenta'            = v.venta_valor_tasa  + v.venta_spread 
   ,      /*32*/ 'nombretasacompra'      = ISNULL(i.tbglosa,'')
   ,      /*33*/ 'nombretasaventa'       = ISNULL(y.tbglosa,'')
   ,      /*34*/ 'pagamosdoc'            = ISNULL(p.glosa,'')
   ,      /*35*/ 'recibimosdoc'          = ISNULL(r.glosa,'')
   ,      /*36*/ 'numero_flujo'          = c.numero_flujo
   ,      /*37*/ 'compra_capital'        = c.compra_capital
   ,      /*38*/ 'compra_amortiza'       = c.compra_amortiza
   ,      /*39*/ 'compra_saldo'          = c.compra_saldo
   ,      /*40*/ 'compra_interes'        = c.compra_interes
   ,      /*41*/ 'compra_spread'         = c.compra_spread
   ,      /*42*/ 'venta_capital'         = v.venta_capital
   ,      /*43*/ 'venta_amortiza'        = v.venta_amortiza
   ,      /*44*/ 'venta_saldo'           = v.venta_saldo
   ,      /*45*/ 'venta_interes'         = v.venta_interes
   ,      /*46*/ 'venta_spread'          = v.venta_spread
   ,      /*47*/ 'pagamos_moneda'        = v.pagamos_moneda
   ,      /*48*/ 'recibimos_moneda'      = c.recibimos_moneda
   ,      /*49*/ 'tipo_flujo'            = c.tipo_flujo
   ,      /*50*/ 'compra_moneda'         = c.compra_moneda
   ,      /*51*/ 'venta_moneda'          = v.venta_moneda
   ,      /*52*/ 'compra_capital'        = c.compra_capital
   ,      /*53*/ 'venta_capital'         = v.venta_capital
   ,      /*54*/ 'MonCompra'             = m.mnnemo
   ,      /*55*/ 'MonVenta'              = n.mnnemo
   ,      /*56*/ 'PagMon'                = g.mnnemo
   ,      /*57*/ 'RecMon'                = f.mnnemo
   FROM   CARTERA c
          LEFT JOIN CARTERA v                     ON c.numero_operacion = v.numero_operacion AND v.tipo_flujo = 2

          LEFT JOIN BacParamSuda..FORMA_DE_PAGO         p ON p.codigo   = c.recibimos_documento
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO         r ON r.codigo   = v.pagamos_documento
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE i ON i.tbcateg  = 1042 AND i.tbcodigo1 = c.compra_codigo_tasa
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE y ON y.tbcateg  = 1042 AND y.tbcodigo1 = v.venta_codigo_tasa
          LEFT JOIN BacParamSuda..MONEDA                m ON m.mncodmon = c.compra_moneda
          LEFT JOIN BacParamSuda..MONEDA                n ON n.mncodmon = v.venta_moneda
          LEFT JOIN BacParamSuda..MONEDA                f ON f.mncodmon = c.recibimos_moneda
          LEFT JOIN BacParamSuda..MONEDA                g ON g.mncodmon = v.pagamos_moneda
   WHERE  c.numero_operacion             = @iNumoper
   AND    c.tipo_flujo                   = 1

END


GO
