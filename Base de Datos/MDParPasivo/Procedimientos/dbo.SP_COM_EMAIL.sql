USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_COM_EMAIL]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SP_COM_EMAIL]
					(
					@iusuario	CHAR(30)		,
					@icorreo	CHAR(255)	OUTPUT
					)
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON
	SELECT @icorreo = ISNULL((SELECT mail_usuario FROM USUARIO WHERE activo = 'S' AND LTRIM(RTRIM(usuario)) = LTRIM(RTRIM(@iusuario))),' ')
END		




GO
