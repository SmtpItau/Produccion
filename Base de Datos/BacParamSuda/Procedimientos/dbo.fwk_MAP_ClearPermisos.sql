USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_ClearPermisos]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_ClearPermisos] 
(@IdAplicacion NVARCHAR(30) ,@IdRole NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Resetear los permisos del sitio indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_MAP_ClearPermisos 'FFMM', 'DEVELOPER'

*/

BEGIN
	DELETE 
	FROM   FWK_SITEMAP_ROLES
	WHERE  id_aplicacion = @IdAplicacion
	       AND id_role = @IdRole
END
GO
