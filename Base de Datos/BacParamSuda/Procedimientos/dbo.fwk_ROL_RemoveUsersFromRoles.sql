USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_RemoveUsersFromRoles]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_RemoveUsersFromRoles]
(
    @id_aplicacion     NVARCHAR(30)
   ,@id_user           NVARCHAR(30)
   ,@id_role           NVARCHAR(30)
)
--WITH ENCRYPTION
AS
	/*
Retira la relacion USERIO-ROLE

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_RemoveUsersFromRoles 'FFMM', 'GBREL', 'DEVELOPER'

*/

BEGIN
	DELETE 
	FROM   FWK_USERS_ROLES
	WHERE  id_aplicacion = @id_aplicacion
	       AND id_user = @id_user
	       AND id_role = @id_role
END
GO
