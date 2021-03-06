USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_CARTERA_DERIVADOS_MARCA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEE_CARTERA_DERIVADOS_MARCA]
   (   @nRutCliente   NUMERIC(10)   = 0
   ,   @nCodCliente   INTEGER       = 0
   ,   @dFecha        DATETIME      = '19000101'
   ,   @nMoneda       INTEGER       = 0
   ,   @eFiltro       INTEGER       = 0
   ,   @nNumDerivado  NUMERIC(9)    = 0
   ,   @cOrigen       CHAR(3)       = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_RETORNO_CARTERA_DERIVADOS
   (   Modulo            CHAR(3)
   ,   Glosa_Producto    VARCHAR(50)
   ,   Codigo_Producto   VARCHAR(5)
   ,   Numero_Operacion  NUMERIC(9)
   ,   Nombre_Cliente    VARCHAR(100)
   ,   Rut_Cliente       VARCHAR(15)
   ,   Moneda_Activa     CHAR(5)
   ,   Monto_Activo      FLOAT
   ,   Moneda_Pasiva     CHAR(5)
   ,   Monto_Pasivo      FLOAT
   ,   Fecha_Vcto        DATETIME
   ,   Ajuste_Noc        VARCHAR(5)
   ,   CodigoCliente     INTEGER
   ,   MarcaRelacion     NUMERIC(1)
   ,   Fecha_Liquidacion DATETIME
   )

   IF @cOrigen = 'BFW' OR @cOrigen = ''
   BEGIN
      INSERT INTO #TMP_RETORNO_CARTERA_DERIVADOS 
      SELECT 'Modulo'           = 'BFW'
         ,   'Glosa_Producto'   = pro.descripcion
         ,   'Codigo_Producto'  = car.cacodpos1
         ,   'Numero_Operacion' = car.canumoper
         ,   'Nombre_Cliente'   = cli.clnombre
         ,   'Rut_Cliente'      = LTRIM(RTRIM( cli.clrut )) + '-' + cli.cldv
         ,   'Moneda_Activa'    = act.mnnemo
         ,   'Monto_Activo'     = car.camtomon1
         ,   'Moneda_Pasiva'    = pas.mnnemo
         ,   'Monto_Pasivo'     = car.camtomon2
         ,   'Fecha_Vcto'       = car.cafecvcto
         ,   'Ajuste_Noc'       = 'N'
         ,   'CodigoCliente'    = cli.clcodigo
         ,   'MarcaRelacion'    = ISNULL(Marca.MarcaRelacion,0)
         ,   'Fecha_Liquidacion' = ''
      FROM   BacFwdSuda.dbo.MFCA                  car
             LEFT  JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'BFW'  AND  Marca.NumDerivado = car.canumoper
             LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.cacodigo AND cli.clcodigo = car.cacodcli
             INNER JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'BFW'        AND CONVERT(INTEGER, pro.codigo_producto) = car.cacodpos1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   act ON act.mncodmon   = car.cacodmon1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   pas ON pas.mncodmon   = car.cacodmon2
      WHERE  car.caestado       = ''
        AND (car.cacodigo       = @nRutCliente  or @nRutCliente  = 0)
        AND (car.cacodcli       = @nCodCliente  or @nCodCliente  = 0)
        AND (car.cacodmon1      = @nMoneda      or @nMoneda      = 0)
        AND (car.cafecvcto      = @dFecha       or @dFecha       = '19000101')
        AND (car.canumoper      = @nNumDerivado or @nNumDerivado = 0)
        ORDER BY pro.descripcion, car.cacodigo, car.cacodcli
   END

   IF @cOrigen = 'PCS' OR @cOrigen = ''
   BEGIN
      INSERT INTO #TMP_RETORNO_CARTERA_DERIVADOS
      SELECT 'Modulo'           = 'PCS'
         ,   'Glosa_Producto'   = pro.descripcion
         ,   'Codigo_Producto'  = car.tipo_swap
         ,   'Numero_Operacion' = car.numero_operacion
         ,   'Nombre_Cliente'   = cli.clnombre
         ,   'Rut_Cliente'      = LTRIM(RTRIM( cli.clrut )) + '-' + cli.cldv
         ,   'Moneda_Activa'    = mna.mnnemo
         ,   'Monto_Activo'     = car.compra_capital
         ,   'Moneda_Pasiva'    = mnp.mnnemo 
         ,   'Monto_Pasivo'     = pas.venta_capital
         ,   'Fecha_Vcto'       = car.fecha_vence_flujo
         ,   'Ajuste_Noc'       = 'N'
         ,   'CodigoCliente'    = cli.clcodigo
         ,   'MarcaRelacion'    = ISNULL(Marca.MarcaRelacion,0)
         ,   'Fecha_Liquidacion' = car.FechaLiquidacion         
      FROM   BacSwapSuda.dbo.CARTERA car
             LEFT  JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'PCS'  AND  Marca.NumDerivado = car.numero_operacion
             LEFT JOIN BacSwapSuda.dbo.CARTERA    pas ON pas.numero_operacion = car.numero_operacion and pas.tipo_flujo = 2 
                                                     AND pas.numero_flujo     IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                                                                   WHERE numero_operacion = pas.numero_operacion
                                                                                     AND pas.tipo_flujo = 2)
             LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.rut_cliente AND cli.clcodigo = car.codigo_cliente
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'PCS' AND pro.codigo_producto = CASE WHEN car.tipo_swap = 1 THEN 'ST'
                                                                                                               WHEN car.tipo_swap = 2 THEN 'SM'
                                                                                                               WHEN car.tipo_swap = 3 THEN 'FR'
                                                                                                               WHEN car.tipo_swap = 4 THEN 'SP'
                                                                                                          END
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mna ON mna.mncodmon = car.compra_moneda
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mnp ON mnp.mncodmon = pas.venta_moneda
      WHERE  car.numero_flujo      IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                        WHERE numero_operacion = car.numero_operacion and car.tipo_flujo = 1)
      AND    car.tipo_flujo        = 1
      AND   (car.rut_cliente       = @nRutCliente or @nRutCliente = 0)
      AND   (car.codigo_cliente    = @nCodCliente or @nCodCliente = 0)
      AND   (car.compra_moneda     = @nMoneda     or @nMoneda     = 0)
      AND   (car.fecha_vence_flujo = @dFecha
          or                         @dFecha = '19000101')
      ORDER BY pro.descripcion, car.rut_cliente, car.codigo_cliente
   END


      SELECT Modulo
         ,   Glosa_Producto
         ,   Codigo_Producto
         ,   Numero_Operacion
         ,   Nombre_Cliente
         ,   Rut_Cliente
         ,   Moneda_Activa
         ,   Monto_Activo
         ,   Moneda_Pasiva
         ,   Monto_Pasivo
         ,   Fecha_Vcto
         ,   Ajuste_Noc
         ,   Registros   = (SELECT COUNT(1) FROM #TMP_RETORNO_CARTERA_DERIVADOS)
         ,   CodigoCliente
         ,   MarcaRelacion
         ,   Fecha_Liquidacion
        FROM #TMP_RETORNO_CARTERA_DERIVADOS der
      ORDER BY Modulo, Codigo_Producto, Numero_Operacion


END
GO
