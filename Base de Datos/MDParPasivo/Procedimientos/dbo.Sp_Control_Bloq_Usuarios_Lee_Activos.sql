USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Bloq_Usuarios_Lee_Activos]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Control_Bloq_Usuarios_Lee_Activos    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[Sp_Control_Bloq_Usuarios_Lee_Activos]

AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

	SELECT * FROM USUARIO_ACTIVO ORDER BY TERMINAL 

	SET NOCOUNT OFF

END








GO
