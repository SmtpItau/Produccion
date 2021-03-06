USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_ResetPassword]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_ResetPassword]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Resetea el password del usuario indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_ResetPassword 'FFMM', 'GBREL'

*/

BEGIN
	UPDATE FWK_USERS
	SET    Password4                   = Password3
	      ,Password3                   = Password2
	      ,Password2                   = Password1
	      ,Password1                   = PASSWORD
	      ,PASSWORD                    = 'tluanuFccVz7lC44oR+WCY7NoYo='
	      ,LastPasswordChangedDate     = GETDATE()
	      ,IsReset                     = 1
	WHERE  id_aplicacion               = @IdAplicacion
	       AND id_user                 = @IdUser
END

GO
