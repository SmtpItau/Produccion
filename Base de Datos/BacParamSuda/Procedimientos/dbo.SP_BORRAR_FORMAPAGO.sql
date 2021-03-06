USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_FORMAPAGO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_FORMAPAGO]
   (   @codigo   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE
   FROM   FORMA_DE_PAGO
   WHERE  codigo = @codigo

   IF @@ERROR <> 0
   BEGIN
      SELECT -1, 'Error: No es posible eliminar registro de medio de pago.'
      RETURN
   END

   SELECT 0 , 'Registro se ha eliminado en forma correcta.'

END

GO
