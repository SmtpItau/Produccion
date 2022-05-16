USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Bloq_Usuarios_Salir]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Control_Bloq_Usuarios_Salir    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[Sp_Control_Bloq_Usuarios_Salir](
							@usuario	CHAR(15),							
							@terminal	CHAR(3),
							@sistema	CHAR(3)
						  )
AS
BEGIN
	DECLARE 
		@cont		NUMERIC(2),
		@nombre		Char(50)	


   	SET DATEFORMAT DMY
	SET NOCOUNT ON
		
---     SET @NOMBRE = (SELECT NOMBRE FROM CONTROL_USUARIO WHERE USUARIO = @USUARIO)

		DELETE FROM USUARIO_ACTIVO WHERE	usuario	 = @usuario AND
							terminal = @terminal AND
							id_sistema  = @sistema
 

---		SELECT *, @CONT FROM CONTROL_USUARIO WHERE NOMBRE = @NOMBRE 
		SELECT usuario,id_sistema,terminal FROM USUARIO_ACTIVO WHERE usuario = @usuario
		

	SET NOCOUNT OFF

END








GO
