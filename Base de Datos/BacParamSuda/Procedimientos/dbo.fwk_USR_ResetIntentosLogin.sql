USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_ResetIntentosLogin]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_ResetIntentosLogin] 
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
AS
	/*
Fuerza parametro de intentos de login setearce a 0, para poder controlar los 3 intentos de login failed

@Autor : Eduardo Díaz (ediazr)
@Fecha : Septiembre - 2010
@Example: EXEC  fwk_USR_ResetIntentosLogin 'FFMM','ablanco'

*/

BEGIN
	UPDATE FWK_USERS
	SET    FailedPasswordAttemptCount     = 0
	WHERE  id_user                        = @IdUser
	       AND id_aplicacion              = @IdAplicacion
END
GO
