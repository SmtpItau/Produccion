USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_FLI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_FLI]
   (   @Operacion   NUMERIC(9)   
   ,   @TipoPago    CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

	IF @TipoPago = 'T'
		SELECT 0, 'OK'
/*   IF @TipoPago = 'T'
   BEGIN
      IF EXISTS( SELECT 1 FROM PAGOS_FLI WHERE panumoper = @Operacion)
         SELECT -1, 'Operacion ya tiene pagos parciales, no se puede pagar total, debera pagar parcial el saldo existente.'
      ELSE
         SELECT 0, 'Se puede pagar Total, por que no tiene pagos parciales.'
   END
  */ 
   IF @TipoPago = 'A'
   BEGIN
      IF EXISTS( SELECT 1 FROM PAGOS_FLI WHERE panumoper = @Operacion)
         SELECT -1, 'No es posible anular, por que la operacion tiene pagos.'
      ELSE
         SELECT 0, 'Se puede anular, por que existen pagos.'
   END

END


GO
