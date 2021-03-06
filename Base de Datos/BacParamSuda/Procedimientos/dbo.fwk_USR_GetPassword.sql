USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_GetPassword]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_GetPassword]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Recupera el password

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_GetPassword 'FFMM', 'GBREL'

*/

BEGIN
	SELECT PASSWORD
	      ,PasswordAnswer
	      ,IsLockedOut
	FROM   FWK_USERS
	WHERE  id_aplicacion = @IdAplicacion
	       AND id_user = @IdUser
END
GO
