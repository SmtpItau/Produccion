USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TABLA_CONTROL]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TABLA_CONTROL]
   (   @Segmento    INTEGER
   ,   @Modulo      CHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT GlosaProducto = descripcion
      ,   Plazo         = Plazo
      ,   Threshold     = Threshold
      ,   Riesgo        = CASE WHEN Riesgo = 'S' THEN 'CON CLAS.'
                               WHEN Riesgo = 'N' THEN 'SIN CLAS.'
                               ELSE                   ''
                           END
      ,   Producto      = Producto
     FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)
          INNER JOIN BacParamSuda.dbo.PRODUCTO   with(nolock) ON Estado   = 1 
                                                             AND Modulo   = id_sistema
                                                             AND Producto = CASE WHEN Modulo = 'PCS' AND codigo_producto = 'ST' THEN 1
                                                                                 WHEN Modulo = 'PCS' AND codigo_producto = 'SM' THEN 2
                                                                                 WHEN Modulo = 'PCS' AND codigo_producto = 'SP' THEN 4
                                                                                 WHEN Modulo = 'PCS' AND codigo_producto = 'FR' THEN 3
                                                                                 ELSE codigo_producto
                                                                          END
    WHERE Modulo        = @Modulo
      AND Segmento      = @Segmento
    ORDER BY Producto, Plazo

END
GO
