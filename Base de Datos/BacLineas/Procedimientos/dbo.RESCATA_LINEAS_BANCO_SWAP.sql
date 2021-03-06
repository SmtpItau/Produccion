USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[RESCATA_LINEAS_BANCO_SWAP]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[RESCATA_LINEAS_BANCO_SWAP]
AS
BEGIN

   DECLARE @Modulo      CHAR(3)
       SET @Modulo      = 'PCS'

   DECLARE @nRutCliente  INTEGER
       SET @nRutCliente  = 0 --> 97006000


   SET NOCOUNT ON


      SELECT DISTINCT numero_operacion, rut_cliente, codigo_cliente, cartera_inversion, tipo_swap = pr.descripcion INTO #CARTERA_SWAP
        FROM BacSwapSuda..CARTERA with(nolock)
             INNER JOIN BacParamSuda..PRODUCTO pr ON pr.id_sistema = 'PCS' AND pr.codigo_producto = CASE WHEN tipo_swap = 1 THEN 'ST'
                                                                                                         WHEN tipo_swap = 2 THEN 'SM'
                                                                                                         WHEN tipo_swap = 3 THEN 'FR'
                                                                                                         WHEN tipo_swap = 4 THEN 'SP'   
                                                                                                    END

      SELECT DISTINCT
             numero_operacion
           , Rut              = clrut
           , clnombre         = cl.clnombre
           , cacodcart        = ca.cartera_inversion
           , tbglosa          = td.tbglosa
           , Producto         = tipo_swap
           , MontoTransaccion = ( lt.MontoTransaccion )
           , TotalAsignado    = ls.TotalAsignado
           , TotalOcupado     = ls.TotalOcupado
           , TotalDisponible  = ls.TotalDisponible
           , TotalExceso      = ls.TotalExceso
        INTO #TMP_SWAP
        FROM #CARTERA_SWAP                                   ca with (nolock)
             INNER JOIN BacParamSuda..CLIENTE                cl with (nolock) ON cl.clrut           = ca.rut_cliente AND cl.clcodigo = ca.codigo_cliente
             INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE  td with (nolock) ON td.tbcateg         = 204 and td.tbcodigo1 = ca.cartera_inversion
             INNER JOIN BacLineas..LINEA_TRANSACCION_DETALLE lt with (nolock) ON lt.NumeroOperacion = ca.numero_operacion 
             INNER JOIN BacLineas..LINEA_SISTEMA             ls with (nolock) ON ls.Rut_Cliente     = ca.rut_cliente and ls.Codigo_Cliente = ca.codigo_cliente
       WHERE lt.Id_Sistema    = @Modulo AND lt.Linea_Transsaccion = 'LINGEN' AND lt.numerocorre_detalle= 1
         AND cl.cltipcli      IN(1,4)
         AND ls.Id_Sistema    = @Modulo
         AND (ca.rut_cliente  = @nRutCliente or @nRutCliente = 0)
    ORDER BY cl.clnombre

      SELECT Rut              = Rut
           , Cliente          = clnombre
           , Cartera          = tbglosa
           , Producto         = Producto
           , MontoTransaccion = SUM(MontoTransaccion)
           , TotalAsignado    = MIN(TotalAsignado)
           , TotalOcupado     = MIN(TotalOcupado)
           , TotalDisponible  = MIN(TotalDisponible)
           , TotalExceso      = MIN(TotalExceso)
         FROM #TMP_SWAP
      GROUP BY Producto, Rut, clnombre, tbglosa
      ORDER BY Producto, clnombre , tbglosa

      DROP TABLE #TMP_SWAP
      DROP TABLE #CARTERA_SWAP
END
GO
