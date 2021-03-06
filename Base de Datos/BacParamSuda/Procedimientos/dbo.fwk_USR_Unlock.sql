USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_Unlock]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_Unlock]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Desbloque el usuario indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_Unlock 'FFMM', 'GBREL'

*/

BEGIN
	UPDATE FWK_USERS
	SET    IsLockedOut                    = 0
	      ,FailedPasswordAttemptCount     = 0
	      ,LastLockedOutDate              = GETDATE()
	WHERE  id_aplicacion                  = @IdAplicacion
	       AND id_user                    = @IdUser
END

GO
