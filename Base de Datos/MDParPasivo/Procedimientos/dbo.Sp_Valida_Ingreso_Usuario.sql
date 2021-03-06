USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Valida_Ingreso_Usuario]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Valida_Ingreso_Usuario]
               ( @usuario char(15) )
AS

BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT	clave, 
		tipo_usuario, 
		convert(char(10),fecha_expira,103), 
		cambio_clave 

	FROM 	USUARIO 
	WHERE 	usuario = @usuario
	AND ACTIVO = 'S'

END

GO
