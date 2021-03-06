USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_RoleExists]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_RoleExists]
(@id_aplicacion NVARCHAR(30) ,@id_role NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Evalua la existencia de un role

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_RoleExists 'GBREL'

*/


BEGIN
	SELECT COUNT(*)
	FROM   FWK_ROLES
	WHERE  id_aplicacion     = @id_aplicacion
	       AND id_role       = @id_role
END
GO
