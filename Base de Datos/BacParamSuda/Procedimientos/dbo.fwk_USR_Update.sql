USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_Update]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_Update]
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Email            NVARCHAR(255)
   ,@Comment          NVARCHAR(255)
   ,@IsLockedOut      BIT
)
--WITH ENCRYPTION
AS
	/*
Actualiza al usuario

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_Update ...

*/

BEGIN
	UPDATE FWK_USERS
	SET    Email             = @Email
	      ,Comment           = @Comment
	      ,IsLockedOut       = @IsLockedOut
	WHERE  id_aplicacion     = @IdAplicacion
	       AND id_user       = @IdUser
END

GO
