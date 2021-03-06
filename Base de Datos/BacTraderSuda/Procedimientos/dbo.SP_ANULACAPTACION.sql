USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULACAPTACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ANULACAPTACION]
   (   @numoper   NUMERIC(10,0)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @IdPaquete   NUMERIC(10)
       SET @IdPaquete   = ISNULL((SELECT Id_Paquete FROM BacParamSuda..MDLBTR WHERE sistema = 'BTR' AND numero_operacion = @numoper AND Estado_Paquete = 'A'),0)

   IF @IdPaquete > 0
   BEGIN
      SELECT -4, 'OPERACION NO SE PUEDE ANULAR... ES PARTE DE UN GRUPO DE PAGO.'
      RETURN
   END

   BEGIN TRANSACTION

   /* Anulo Operaci¢n de tabla de movimiento 
   ======================================= */

   UPDATE MDMO 
      SET mostatreg = 'A'  
    WHERE monumoper = @numoper

   IF @@ERROR<>0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT 'NO', 'PROBLEMAS EN ANULACI¢N DE CAPTACION, << MOVIMIENTO >>'
      SET NOCOUNT OFF
      RETURN 0
   END

   UPDATE GEN_CAPTACION 
      SET estado ='A' 
    WHERE numero_operacion = @numoper 

   IF @@ERROR<>0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT 'NO', 'PROBLEMAS EN ANULACI¢N DE CAPTACION, << GEN_CAPTACION >> '
      SET NOCOUNT OFF
      RETURN 0
   END

   UPDATE bacparamsuda..MDLBTR
      SET estado_envio     = 'A'
    WHERE sistema          = 'BTR'
      AND numero_operacion = @numoper
      AND estado_envio     = 'P'


   COMMIT TRANSACTION
   SELECT 'SI', 'ANULACION REALIZADA SATISFACTORIAMENTE'
   SET NOCOUNT OFF
END


GO
