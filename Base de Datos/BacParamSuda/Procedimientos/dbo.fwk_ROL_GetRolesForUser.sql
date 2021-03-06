USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_GetRolesForUser]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_GetRolesForUser]
(@id_aplicacion NVARCHAR(30) ,@id_user NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Roles por usuario

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_GetRolesForUser 'GBREL'

*/

BEGIN
	SELECT FWK_ROLES.id_role
	      ,FWK_ROLES.descripcion
	FROM   FWK_ROLES
	       INNER JOIN FWK_USERS_ROLES
	            ON  FWK_ROLES.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_ROLES.id_role = FWK_USERS_ROLES.id_role
	       INNER JOIN FWK_USERS
	            ON  FWK_USERS.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_USERS.id_user = FWK_USERS_ROLES.id_user
	WHERE  (FWK_ROLES.id_aplicacion = @id_aplicacion)
	       AND (FWK_USERS.id_user = @id_user)
	GROUP BY
	       FWK_ROLES.id_role
	      ,FWK_ROLES.descripcion
END
GO
