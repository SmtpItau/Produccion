USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAINTERBANCARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ANULAINTERBANCARIO]
   (   @Numoper   NUMERIC(10,0)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @IdPaquete   NUMERIC(10)
       SET @IdPaquete   = ISNULL((SELECT Id_Paquete FROM BacParamSuda..MDLBTR WHERE sistema = 'BTR' AND numero_operacion = @Numoper AND Estado_Paquete = 'A'),0)

   IF @IdPaquete > 0
   BEGIN
      SELECT -4, 'OPERACION NO SE PUEDE ANULAR... ES PARTE DE UN GRUPO DE PAGO.'
      RETURN
   END


   BEGIN TRANSACTION

   UPDATE MDMO
      SET mostatreg = 'A'
    WHERE monumoper = @Numoper 
      AND motipoper = 'IB'

   IF @@ERROR<>0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT 'ERR' 
      SET NOCOUNT OFF
      RETURN
  END

  DELETE MDCI 
   WHERE cinumdocu = @Numoper

   IF @@ERROR<>0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT 'ERR' 
      SET NOCOUNT OFF
      RETURN
   END

   COMMIT TRANSACTION
   SELECT 'OK'
   SET NOCOUNT OFF
END


GO
