USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_PERFIL]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_PERFIL]
         (@FOLIO_PERFIL     NUMERIC(9))
AS 
BEGIN
      
   SET NOCOUNT OFF
   DECLARE @CONTROL_ERROR  INTEGER
   
   SELECT @CONTROL_ERROR = 0
   	
	DELETE PERFIL_CNT WHERE    folio_perfil    = @FOLIO_PERFIL
		IF @@ERROR <> 0
		BEGIN
   			SET NOCOUNT OFF
   			SELECT @CONTROL_ERROR = 1
   			PRINT 'ERROR_PROC FALLA ELIMINACION DE PERFIL.'
   			GOTO FIN_PROCEDIMIENTO
		END

	DELETE PERFIL_DETALLE_CNT WHERE folio_perfil = @FOLIO_PERFIL
		IF @@ERROR <> 0
		BEGIN
   			SET NOCOUNT OFF
   			SELECT @CONTROL_ERROR = 1
			PRINT 'ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL.'
   			GOTO FIN_PROCEDIMIENTO
		END

	DELETE  PERFIL_VARIABLE_CNT WHERE folio_perfil = @FOLIO_PERFIL
		IF @@ERROR <> 0
		BEGIN
   			SET NOCOUNT OFF
	   		SELECT @CONTROL_ERROR = 1
   			PRINT 'ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL VARIABLE.'
			GOTO FIN_PROCEDIMIENTO
		END

FIN_PROCEDIMIENTO:

	IF @CONTROL_ERROR = 0 BEGIN
   	SET NOCOUNT OFF
   		SELECT 'OK'
   			
	END ELSE BEGIN
   
   	SET NOCOUNT OFF
   		SELECT 'ERROR'
   		
	END

RETURN @CONTROL_ERROR
END   /* FIN PROCEDIMIENTO */
GO
