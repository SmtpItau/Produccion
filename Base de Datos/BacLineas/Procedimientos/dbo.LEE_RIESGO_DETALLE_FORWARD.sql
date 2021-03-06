USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[LEE_RIESGO_DETALLE_FORWARD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LEE_RIESGO_DETALLE_FORWARD]
AS
BEGIN

   DECLARE @Modulo   CHAR(3)
       SET @Modulo   = 'bfw'

   SELECT Contrato   = canumoper
        , Cliente    = clnombre
        , Rut        = CONVERT(CHAR(16), LTRIM(RTRIM(clrut)) + '-' + cldv)
        , Producto   = pr.descripcion
        , Moneda     = LTRIM(RTRIM(mn.mnnemo)) + '/' + LTRIM(RTRIM(mx.mnnemo))
        , Nocional   = camtomon1
        , vRazonable = ROUND(fres_obtenido, 0)
        , PlazoRes   = caplazovto
        , RiesgoE    = MontoTransaccion
        , Cartera    = tbglosa
     FROM BacFwdSuda..MFCA                                ca with (nolock) 
          INNER JOIN BacParamSuda..CLIENTE                cl with (nolock) ON cl.clrut           = ca.cacodigo AND cl.clcodigo        = ca.cacodcli
          INNER JOIN BacParamSuda..PRODUCTO               pr with (nolock) ON pr.id_sistema      = 'BFW'       AND pr.codigo_producto = ca.cacodpos1
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE  cf with (nolock) ON cf.tbcateg         = 204         AND cf.tbcodigo1       = ca.cacodcart
          LEFT  JOIN BacParamSuda..MONEDA                 mn with (nolock) ON mn.mncodmon        = ca.cacodmon1
          LEFT  JOIN BacParamSuda..MONEDA                 mx with (nolock) ON mx.mncodmon        = ca.cacodmon2
          LEFT  JOIN BacLineas..LINEA_TRANSACCION_DETALLE lt with (nolock) ON lt.NumeroOperacion = ca.canumoper
    WHERE (lt.Id_Sistema = @Modulo AND lt.Linea_Transsaccion = 'LINGEN' AND lt.numerocorre_detalle = 1)
--      AND  cl.cltipcli   IN(1,4)
     ORDER BY clrut, canumoper

END
GO
