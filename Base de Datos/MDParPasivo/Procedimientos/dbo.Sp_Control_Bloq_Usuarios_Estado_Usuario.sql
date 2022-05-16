USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Bloq_Usuarios_Estado_Usuario]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Control_Bloq_Usuarios_Estado_Usuario    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/

CREATE PROCEDURE [dbo].[Sp_Control_Bloq_Usuarios_Estado_Usuario] (
								@usuario	CHAR(15),
								@id_sistema	CHAR(3)
							 )
								
	
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


	IF EXISTS (SELECT 1 FROM CONTROL_USUARIO) BEGIN

		SELECT bloqueado FROM CONTROL_USUARIO
			WHERE id_sistema = @id_sistema AND
			      usuario	 = @usuario


	END
	ELSE BEGIN
		
		SELECT "ERROR"

	END

	SET NOCOUNT OFF

END









GO
