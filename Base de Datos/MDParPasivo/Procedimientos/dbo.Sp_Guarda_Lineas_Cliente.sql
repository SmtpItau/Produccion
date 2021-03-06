USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Guarda_Lineas_Cliente]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Guarda_Lineas_Cliente]
   ( @Estado        CHAR(1)
   , @rut_cliente   NUMERIC(9)
   , @cod_cliente   NUMERIC(9)
   )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT DMY
   SET NOCOUNT ON

   UPDATE LINEA_GENERAL WITH (ROWLOCK)
   SET    bloqueado      = @Estado 
   WHERE  rut_cliente    = @rut_cliente 
     AND  codigo_cliente = @cod_cliente

   IF @@ERROR <> 0 
   BEGIN
      SELECT -1 , 'Problemas en la Actualización de la Linea General ...'
      RETURN
   END
      
   UPDATE LINEA_SISTEMA WITH (ROWLOCK)
   SET    bloqueado      = @Estado 
   WHERE  rut_cliente    = @rut_cliente 
     AND  codigo_cliente = @cod_cliente 

   IF @@ERROR <> 0 
   BEGIN
      SELECT -1 , 'Problemas en la Actualización de la Linea Sistema ...'
      RETURN
   END

   SELECT 0 , 'Actualización de Lineas OK ...'

END


GO
