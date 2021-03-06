USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_GetAllRoles]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_GetAllRoles]
	@id_aplicacion NVARCHAR(30)
	 --WITH ENCRYPTION
AS
	/*
Recupera todos los roles

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_GetAllRoles 'FFMM'

*/

BEGIN
	SELECT id_role
	      ,descripcion
	FROM   FWK_ROLES
	WHERE  id_aplicacion = @id_aplicacion
	ORDER BY
	       id_role
END
GO
