USE [BacLineas]
GO
/****** Object:  StoredProcedure [bacuser].[RESCATA_LINEAS_BANCO_FWD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [bacuser].[RESCATA_LINEAS_BANCO_FWD]
AS 
BEGIN
   SET NOCOUNT ON

   DECLARE @Modulo   CHAR(3)
       SET @Modulo   = 'bfw'

   SELECT Rut              = clrut
        , clnombre         = cl.clnombre
        , cacodcart        = ca.cacodcart
        , tbglosa          = td.tbglosa
        , MontoTransaccion = ( lt.MontoTransaccion )
        , TotalAsignado    = ls.TotalAsignado
        , TotalOcupado     = ls.TotalOcupado
        , TotalDisponible  = ls.TotalDisponible
        , TotalExceso      = ls.TotalExceso
        , Producto         = pr.descripcion
     INTO #TMP_FORWARD
     FROM BacFwdSuda..MFCA                                ca with (nolock)
          INNER JOIN BacParamSuda..CLIENTE                cl with (nolock) ON cl.clrut = ca.cacodigo AND cl.clcodigo = ca.cacodcli
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE  td with (nolock) ON td.tbcateg = 204 and td.tbcodigo1 = ca.cacodcart
          LEFT  JOIN BacLineas..LINEA_TRANSACCION_DETALLE lt with (nolock) ON lt.NumeroOperacion = ca.canumoper
          LEFT  JOIN BacLineas..LINEA_SISTEMA             ls with (nolock) ON ls.Rut_Cliente = ca.cacodigo and ls.Codigo_Cliente = ca.cacodcli
          INNER JOIN BacParamSuda..PRODUCTO               pr with (nolock) ON pr.id_sistema = 'BFW' and pr.codigo_producto = ca.cacodpos1
    WHERE lt.Id_Sistema = @Modulo AND lt.Linea_Transsaccion = 'LINGEN' AND lt.numerocorre_detalle= 1
      AND cl.cltipcli   IN(1,4)
      AND ls.Id_Sistema = @Modulo
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
      FROM #TMP_FORWARD
   GROUP BY Producto, Rut, clnombre, tbglosa
   ORDER BY Producto, clnombre , tbglosa

   DROP TABLE #TMP_FORWARD
END

GO
