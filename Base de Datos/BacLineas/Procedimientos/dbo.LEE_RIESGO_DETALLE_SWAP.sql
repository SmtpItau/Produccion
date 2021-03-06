USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[LEE_RIESGO_DETALLE_SWAP]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LEE_RIESGO_DETALLE_SWAP]
AS
BEGIN

   DECLARE @Modulo      CHAR(3)
       SET @Modulo      = 'PCS'

   DECLARE @nRutCliente  INTEGER
       SET @nRutCliente  = 0 --> 97006000

   SET NOCOUNT ON

   DECLARE @dFecha       DATETIME
       SET @dFecha       = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL with(nolock))

      SELECT DISTINCT numero_operacion  = ca.numero_operacion
                    , rut_cliente       = ca.rut_cliente
                    , codigo_cliente    = ca.codigo_cliente
                    , cartera_inversion = ca.cartera_inversion
                    , tipo_swap         = pr.descripcion
                    , Moneda1           = mn.mnnemo 
                    , Moneda2           = (SELECT DISTINCT mx.mnnemo FROM BacSwapSuda..CARTERA cm 
                                                                LEFT JOIN BacParamSuda..MONEDA mx with(nolock) ON mx.mncodmon = cm.venta_moneda 
                                                                    WHERE cm.numero_operacion = ca.numero_operacion 
                                                                      and cm.numero_flujo     = ca.numero_flujo 
                                                                      and cm.tipo_flujo       = 2)
                    , compra_capital     = ca.compra_capital
                    , valor_razonableclp = ca.valor_razonableclp
                    , RemanenteFlujo     = DATEDIFF(DAY, @dFecha, ca.fecha_vence_flujo)
                    , RemanenteOperacion = DATEDIFF(DAY, @dFecha, ca.fecha_termino)
        INTO #CARTERA_SWAP
        FROM BacSwapSuda..CARTERA              ca with(nolock)
             INNER JOIN BacParamSuda..PRODUCTO pr with(nolock) ON pr.id_sistema = 'PCS' AND pr.codigo_producto = CASE WHEN tipo_swap = 1 THEN 'ST'
                                                                                                                      WHEN tipo_swap = 2 THEN 'SM'
                                                                                                                      WHEN tipo_swap = 3 THEN 'FR'
                                                                                                                      WHEN tipo_swap = 4 THEN 'SP'   
                                                                                                                 END
             LEFT JOIN BacParamSuda..MONEDA    mn with(nolock) ON mn.mncodmon = ca.compra_moneda
       WHERE ca.numero_flujo       = (SELECT MIN(fl.numero_flujo) FROM BacSwapSuda..CARTERA fl WHERE fl.numero_operacion = ca.numero_operacion)
         and ca.tipo_flujo         = 1

   SELECT DISTINCT
          Contrato   = numero_operacion
        , Cliente    = cl.clnombre
        , Rut        = CONVERT(CHAR(16), LTRIM(RTRIM(clrut)) + '-' + cldv)
        , Producto   = tipo_swap
        , Moneda     = LTRIM(RTRIM(Moneda1)) + '/' + LTRIM(RTRIM(Moneda2))
        , Nocional   = compra_capital
        , vRazonable = ROUND(valor_razonableclp, 0)
        , PlazoFl    = RemanenteFlujo
        , PlazoOp    = RemanenteOperacion
        , RiesgoE    = MontoTransaccion
        , Cartera    = tbglosa
    FROM #CARTERA_SWAP                                   ca with (nolock)
         INNER JOIN BacParamSuda..CLIENTE                cl with (nolock) ON cl.clrut           = ca.rut_cliente AND cl.clcodigo = ca.codigo_cliente
         INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE  td with (nolock) ON td.tbcateg         = 204 and td.tbcodigo1 = ca.cartera_inversion
         INNER JOIN BacLineas..LINEA_TRANSACCION_DETALLE lt with (nolock) ON lt.NumeroOperacion = ca.numero_operacion 
         INNER JOIN BacLineas..LINEA_SISTEMA             ls with (nolock) ON ls.Rut_Cliente     = ca.rut_cliente and ls.Codigo_Cliente = ca.codigo_cliente
   WHERE lt.Id_Sistema    = @Modulo AND lt.Linea_Transsaccion = 'LINGEN' AND lt.numerocorre_detalle= 1
--     AND cl.cltipcli      IN(1,4)
     AND ls.Id_Sistema    = @Modulo
     AND (ca.rut_cliente  = @nRutCliente or @nRutCliente = 0)
    ORDER BY Cliente, Producto, Contrato


END
GO
