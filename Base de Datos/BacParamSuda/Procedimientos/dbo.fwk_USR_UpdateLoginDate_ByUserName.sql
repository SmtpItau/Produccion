USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_UpdateLoginDate_ByUserName]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_UpdateLoginDate_ByUserName]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Indica la ultima vez que el usuario modifico su password

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_UpdateLoginDate_ByUserName 'FFMM', 'GBREL'

*/

BEGIN
	UPDATE FWK_USERS
	SET    LastLoginDate                  = GETDATE()
	      ,FailedPasswordAttemptCount     = 0
	      ,FailedPasswordAnswerAttemptCount = 0
	WHERE  id_aplicacion                  = @IdAplicacion
	       AND id_user                    = @IdUser
END
GO
