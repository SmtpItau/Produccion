USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAR_COBERTURA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINAR_COBERTURA]
   (   @nCobertura   NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   BEGIN TRANSACTION

   DELETE DETALLE_COBERTURAS
    WHERE nCobertura = @nCobertura

   IF @@ERROR <> 0
   BEGIN
      ROLLBACK TRANSACTION
      RETURN
   END

   DELETE COBERTURAS
    WHERE nCobertura = @nCobertura

   IF @@ERROR <> 0
   BEGIN
      ROLLBACK TRANSACTION
      RETURN
   END

   COMMIT TRANSACTION

END



GO
