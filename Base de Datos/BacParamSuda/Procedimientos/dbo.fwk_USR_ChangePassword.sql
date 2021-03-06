USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_ChangePassword]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_ChangePassword]
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Password         NVARCHAR(128)
)
--WITH ENCRYPTION
AS
	/*
Modifica el password del usuario

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_ChangePassword ...

*/

BEGIN
	UPDATE FWK_USERS
	SET    Password4                   = Password3
	      ,Password3                   = Password2
	      ,Password2                   = Password1
	      ,Password1                   = PASSWORD
	      ,PASSWORD                    = @Password
	      ,LastPasswordChangedDate     = GETDATE()
	      ,IsReset                     = 0
	WHERE  id_aplicacion               = @IdAplicacion
	       AND id_user                 = @IdUser
END

GO
