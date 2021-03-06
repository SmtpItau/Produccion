USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_THRESHOLD_OPERACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_THRESHOLD_OPERACION]
   (   @Sistema           CHAR(3)
   ,   @Producto	  VARCHAR(5)
   ,   @Numero_Operacion  NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION WHERE Sistema          = @Sistema
                                                                      AND Producto         = @Producto
                                                                      AND Numero_Operacion = @Numero_Operacion)
   BEGIN

      DELETE FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION 
            WHERE Sistema          = @Sistema
              AND Producto         = @Producto 
              AND Numero_Operacion = @Numero_Operacion

      IF @@Error <> 0
      BEGIN
         SELECT -1, 'Error al eliminar operación Threshold'
         RETURN
      END

      SELECT 0, 'OK'
      RETURN
   END ELSE
   BEGIN
      SELECT 1,'No hay datos para eliminar'
      RETURN
   END

END
GO
