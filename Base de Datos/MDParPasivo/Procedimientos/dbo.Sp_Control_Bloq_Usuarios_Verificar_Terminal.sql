USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Bloq_Usuarios_Verificar_Terminal]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Control_Bloq_Usuarios_Verificar_Terminal    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[Sp_Control_Bloq_Usuarios_Verificar_Terminal] (
								@usuario	CHAR(15),
								@id_sistema	CHAR(3),
								@terminal	CHAR(2)
							 )
								
	
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


	---DELETE FROM USUARIO_ACTIVO WHERE LEFT(TERMINAL,1)="N" 	

	IF EXISTS (SELECT 1 FROM USUARIO_ACTIVO) BEGIN

		SELECT usuario,terminal,id_sistema FROM USUARIO_ACTIVO
			WHERE id_sistema = @id_sistema AND
			      usuario	 = @usuario AND 
			      terminal   = @terminal


	END
	ELSE BEGIN
		
		SELECT "ERROR"

	END

	SET NOCOUNT OFF

END









GO
