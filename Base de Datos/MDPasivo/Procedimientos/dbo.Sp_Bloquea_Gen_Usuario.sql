USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Bloquea_Gen_Usuario]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Bloquea_Gen_Usuario]
                                       (@xusuario CHAR(15),
                                        @xbloqueo CHAR(1))
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   UPDATE USUARIO SET bloqueado = @xbloqueo 
   WHERE USUARIO.usuario = @xusuario 
   AND USUARIO.usuario <> 'ADMINISTRA'
   AND USUARIO.activo = 'S'
 
END



GO
