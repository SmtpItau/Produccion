USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_GetByEmail]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_GetByEmail]
(@IdAplicacion NVARCHAR(30) ,@Email NVARCHAR(255))
--WITH ENCRYPTION
AS
	/*
Recupera al usuario de acuerdo al mail

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_GetByEmail 'FFMM', 'gponce@info.cl'

*/

BEGIN
	SET @Email = @Email + '%'
	
	SELECT id_user
	      ,Email
	      ,PasswordQuestion
	      ,Comment
	      ,IsApproved
	      ,IsLockedOut
	      ,CreationDate
	      ,LastLoginDate
	      ,LastActivityDate
	      ,LastPasswordChangedDate
	      ,LastLockedOutDate
	FROM   FWK_USERS
	WHERE  id_aplicacion = @IdAplicacion
	       AND Email LIKE @Email
	ORDER BY
	       id_user ASC
END
GO
