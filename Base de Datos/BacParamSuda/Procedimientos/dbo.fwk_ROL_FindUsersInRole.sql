USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_FindUsersInRole]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_FindUsersInRole]
(
    @id_aplicacion     NVARCHAR(30)
   ,@id_role           NVARCHAR(30)
   ,@userToMatch       NVARCHAR(30)
)
--WITH ENCRYPTION
AS
	/*
Buscar parte del nombre de usuario para el role indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_FindUsersInRole 'GBREL'

*/

BEGIN
	SET @userToMatch = @userToMatch + '%'
	
	SELECT FWK_USERS.id_user
	FROM   FWK_ROLES
	       INNER JOIN FWK_USERS_ROLES
	            ON  FWK_ROLES.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_ROLES.id_role = FWK_USERS_ROLES.id_role
	       INNER JOIN FWK_USERS
	            ON  FWK_USERS.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_USERS.id_user = FWK_USERS_ROLES.id_user
	WHERE  FWK_ROLES.id_aplicacion = @id_aplicacion
	       AND FWK_ROLES.id_role = @id_role
	       AND FWK_USERS.id_user LIKE @userToMatch
	ORDER BY
	       FWK_USERS.id_user
END
GO
