USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Perfil]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Perfil    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Perfil    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[Sp_Elimina_Perfil]
         (@FOLIO_PERFIL     NUMERIC(9))
AS 
BEGIN
      
      SET NOCOUNT OFF
   DECLARE @CONTROL_ERROR  INTEGER
   BEGIN TRANSACTION
   SELECT @CONTROL_ERROR = 0
   DELETE PERFIL_CNT WHERE    folio_perfil    = @FOLIO_PERFIL
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   SELECT @CONTROL_ERROR = 1
   PRINT "ERROR_PROC FALLA ELIMINACION DE PERFIL."
   GOTO FIN_PROCEDIMIENTO
END
DELETE PERFIL_DETALLE_CNT WHERE folio_perfil = @FOLIO_PERFIL
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   SELECT @CONTROL_ERROR = 1
   PRINT "ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL."
   GOTO FIN_PROCEDIMIENTO
END
DELETE  PERFIL_VARIABLE_CNT WHERE folio_perfil = @FOLIO_PERFIL
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   SELECT @CONTROL_ERROR = 1
   PRINT "ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL VARIABLE."
END
FIN_PROCEDIMIENTO:
IF @CONTROL_ERROR = 0 BEGIN
   SET NOCOUNT OFF
   SELECT "OK"
   COMMIT
END
ELSE
   BEGIN
   
   SET NOCOUNT OFF
   SELECT "ERR"
   ROLLBACK
END
RETURN @CONTROL_ERROR
END   /* FIN PROCEDIMIENTO */


GO
