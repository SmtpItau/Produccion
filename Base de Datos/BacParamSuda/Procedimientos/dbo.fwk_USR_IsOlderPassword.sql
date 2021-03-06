USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_IsOlderPassword]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_IsOlderPassword]
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Password         NVARCHAR(128)
)
--WITH ENCRYPTION
AS
	/*
Evalua si el password ha sido utilizado con anterioridad

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_IsOlderPassword ...

*/

BEGIN
	SELECT 1
	FROM   FWK_USERS
	WHERE  id_aplicacion     = @IdAplicacion
	       AND id_user       = @IdUser
	       AND @Password IN (PASSWORD ,Password1 ,Password2 ,Password3 ,Password4)
END
GO
