USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEOPTHRESHOLDFILTROS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEOPTHRESHOLDFILTROS]
   (   @Sistema	        CHAR(3)
   ,   @Producto	CHAR(5)
   ,   @RutCliente	NUMERIC(14,5)
   ,   @CodCliente	NUMERIC(5)
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT Modulo          = th.Sistema
   ,      GlosaModulo     = si.nombre_sistema
   ,      Producto        = th.Producto
   ,      GlosaProducto   = pr.descripcion
   ,      RutCliente      = th.Rut_Cliente
   ,      CodCliente      = th.Cod_Cliente
   ,      NombreCliente   = LTRIM(RTRIM( cl.Clnombre ))
   ,      Contrato        = th.Numero_Operacion
   ,      Rec             = ROUND(th.Rec, 0)
   ,      MntoThreshold   = ROUND(th.Threshold_Aplicado,0)
   ,      AplicaThreshold = 'NO'
   ,      OperacionDia    = 'NO'
   INTO   #TmpCarteraThresholdOp
   FROM   BacParamSuda.dbo.TBL_THRESHOLD_OPERACION th with(nolock)
          INNER JOIN Bacparamsuda.dbo.CLIENTE      cl with(nolock) ON cl.Clrut      = th.Rut_Cliente AND cl.Clcodigo = th.Cod_Cliente
          INNER JOIN Bacparamsuda.dbo.SISTEMA_CNT  si with(nolock) ON si.id_sistema = th.Sistema
          INNER JOIN Bacparamsuda.dbo.PRODUCTO     pr with(nolock) ON th.Sistema    = pr.id_sistema
                                                                  AND th.Producto   = CASE WHEN pr.codigo_producto = 'ST' AND th.Sistema = 'PCS' THEN 1
                                                                                           WHEN pr.codigo_producto = 'SM' AND th.Sistema = 'PCS' THEN 2
                                                                                           WHEN pr.codigo_producto = 'FR' AND th.Sistema = 'PCS' THEN 3
                                                                                           WHEN pr.codigo_producto = 'SP' AND th.Sistema = 'PCS' THEN 4
                                                                                           WHEN                               th.Sistema = 'BFW' THEN pr.codigo_producto
                                                                                       END

   WHERE (th.Sistema 	= @Sistema OR @Sistema = '')
   AND 	 (th.Producto	= CASE WHEN @Producto  = 'ST' AND th.Sistema = 'PCS' THEN 1
                               WHEN @Producto  = 'SM' AND th.Sistema = 'PCS' THEN 2
                               WHEN @Producto  = 'FR' AND th.Sistema = 'PCS' THEN 3
                               WHEN @Producto  = 'SP' AND th.Sistema = 'PCS' THEN 4
                               WHEN                       th.Sistema = 'BFW' THEN @Producto
                          END OR @Producto = '')
   AND	  (cl.Clrut 	= @RutCliente OR @RutCliente = 0)
   AND	  (cl.Clcodigo	= @CodCliente OR @CodCliente = 0)

   UPDATE #TmpCarteraThresholdOp
      SET AplicaThreshold = CASE WHEN Threshold = 'S' THEN 'SI' ELSE 'NO' END
     FROM BacFwdSuda.dbo.MFCA
    WHERE Modulo          = 'BFW'
      AND Contrato        = canumoper

   UPDATE #TmpCarteraThresholdOp
      SET OperacionDia    = 'SI'
     FROM BacFwdSuda.dbo.MFMO
    WHERE Modulo          = 'BFW'
      AND Contrato        = monumoper

   UPDATE #TmpCarteraThresholdOp
      SET AplicaThreshold = CASE WHEN Threshold = 'S' THEN 'SI' ELSE 'NO' END
     FROM BacSwapSuda.dbo.CARTERA
    WHERE Modulo          = 'PCS'
      AND Contrato        = numero_operacion

   UPDATE #TmpCarteraThresholdOp
      SET OperacionDia    = 'SI'
     FROM BacSwapSuda.dbo.MOVDIARIO
    WHERE Modulo          = 'PCS'
      AND Contrato        = numero_operacion

   SELECT Modulo
   ,      GlosaModulo
   ,      Producto
   ,      GlosaProducto
   ,      RutCliente
   ,      CodCliente
   ,      NombreCliente
   ,      Contrato
   ,      Rec
   ,      MntoThreshold
   ,      AplicaThreshold
   FROM   #TmpCarteraThresholdOp
   WHERE  OperacionDia   = 'SI'
   ORDER BY NombreCliente, Modulo, Producto, Contrato

END
GO
