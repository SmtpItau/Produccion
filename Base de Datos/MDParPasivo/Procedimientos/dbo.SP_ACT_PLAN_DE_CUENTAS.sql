USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PLAN_DE_CUENTAS]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_PLAN_DE_CUENTAS]
   (   @cCuenta_Contable  CHAR(15)
   ,   @cRistra_Contable  CHAR(69)
   ,   @nCodigo_Inversion NUMERIC(05) = 0
   ,   @nTipo_Producto    NUMERIC(03) = 0
   )
AS 
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF NOT EXISTS(SELECT 1 FROM PLAN_CUENTA_CONTABLE
                 WHERE  ristra_contable = @cRistra_Contable)
   BEGIN

      INSERT INTO PLAN_CUENTA_CONTABLE
         (   cuenta_contable
         ,   ristra_contable
         ,   codigo_inversion
         ,   tipo_producto
         )
      SELECT @cCuenta_Contable
         ,   @cRistra_Contable
         ,   @nCodigo_Inversion
         ,   @nTipo_Producto

      IF @@error <> 0 
      BEGIN

         SELECT -1, 'No se pudo Agregar al Plan de Cuentas.'
         SET NOCOUNT OFF
         RETURN

      END

   END ELSE BEGIN 

      UPDATE PLAN_CUENTA_CONTABLE
      SET    cuenta_contable  = @cCuenta_Contable
         ,   codigo_inversion = @nCodigo_Inversion
         ,   tipo_producto    = @nTipo_Producto
      WHERE  ristra_contable  = @cRistra_Contable

      IF @@error <> 0 
      BEGIN

         SELECT -1, 'No se pudo Actualizar Cuenta.'
         SET NOCOUNT OFF
         RETURN

      END

   END

   SELECT 0, 'Proceso realizado con éxito.'
   SET NOCOUNT OFF

END 



GO
