USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GUARDA_LINEAS_CLIENTE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GUARDA_LINEAS_CLIENTE]
   ( @Estado        CHAR(1)
   , @rut_cliente   NUMERIC(9)
   , @cod_cliente   NUMERIC(9)
   ,   @MotivoBloqueo   VARCHAR(2000)
   )
AS
BEGIN

   SET NOCOUNT ON

   UPDATE LINEA_GENERAL 
      SET bloqueado      = @Estado 
    WHERE rut_cliente    = @rut_cliente 
      AND codigo_cliente = @cod_cliente

   IF @@ERROR <> 0 
   BEGIN
      SELECT -1 , 'Problemas en la Actualización de la Linea General ...'
      RETURN
   END
      
   UPDATE LINEA_SISTEMA 
      SET bloqueado      = @Estado 
    WHERE rut_cliente    = @rut_cliente 
      AND codigo_cliente = @cod_cliente 

   IF @@ERROR <> 0 
   BEGIN
      SELECT -1 , 'Problemas en la Actualización de la Linea Sistema ...'
      RETURN
   END

   UPDATE BacParamSuda.dbo.CLIENTE
   SET    motivo_bloqueo = CASE WHEN @Estado = 'S' THEN @MotivoBloqueo ELSE '' END 
   WHERE  clrut    	 = @rut_cliente 
   AND    clcodigo 	 = @cod_cliente

   IF @@ERROR <> 0 
   BEGIN
      SELECT -1 , 'Problemas en la Actualización de la Linea General ...'
      RETURN
END

   SELECT 0 , 'Actualización Bloqueos de Lineas OK ...'

END
GO
