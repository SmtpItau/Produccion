USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ERRORES_MONITOREO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_ERRORES_MONITOREO]
   (   @cId_sistema       CHAR   (10)
   ,   @nNumero_Operacion   NUMERIC(10)
   ,   @nTipo_Error         NUMERIC(03)
   )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF @nTipo_Error = 1
   BEGIN

      SELECT 'Mensaje_Error' = Mensaje_Error
         ,   'Monto_Exceso'  = MontoExceso
      FROM   LINEA_TRANSACCION_DETALLE  WITH (NOLOCK)
      WHERE  Error           = 'S'
        AND  NumeroOperacion = @nNumero_Operacion
        AND  Id_sistema    = @cId_sistema

   END

   IF @nTipo_Error = 2
   BEGIN

      SELECT 'Mensaje_Error'   = Mensaje
         ,   'Monto_Operacion' = Monto
      FROM   LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
      WHERE  NumeroOperacion = @nNumero_Operacion
        AND  Id_sistema    = @cId_sistema
	AND  Tipo_Control    = ''

   END

   -- PENDIENTE PARA ERRORES EN LA P.U.
   IF @nTipo_Error = 3
   BEGIN
       RETURN
		
   END

	
   IF @nTipo_Error = 4
   BEGIN
      SELECT 'Mensaje_Error'   = Mensaje
         ,   'Monto_Operacion' = Monto
      FROM   LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
      WHERE  NumeroOperacion = @nNumero_Operacion
        AND  Id_sistema    = @cId_sistema
	AND  Tipo_Control  <> ''
   END

END

GO
