USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_GetList]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_GetList]
	@IdAplicacion NVARCHAR(30)
	 
	 --WITH ENCRYPTION
AS
	/*
Recupera los usuarios del sistema

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_GetList 'FFMM'

*/

BEGIN
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
	ORDER BY
	       id_user ASC
END

GO
