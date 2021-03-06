USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_CreatePermiso]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_CreatePermiso] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdRole           NVARCHAR(30)
   ,@IdSite           INT
   ,@IsFind           BIT
   ,@IsPrint          BIT
   ,@IsWrite          BIT
   ,@IsErase          BIT
)
--WITH ENCRYPTION
AS
	/*
Crea los permisos sobre el sitio indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_MAP_CreatePermiso 'FFMM', 'DEVELOPER', 3, 1 , 1, 1, 1

*/

BEGIN
	INSERT INTO FWK_SITEMAP_ROLES
	  (
	    id_aplicacion
	   ,id_role
	   ,id_site
	   ,is_find
	   ,is_print
	   ,is_write
	   ,is_erase
	  )
	VALUES
	  (
	    @IdAplicacion
	   ,@IdRole
	   ,@IdSite
	   ,@IsFind
	   ,@IsPrint
	   ,@IsWrite
	   ,@IsErase
	  )
END
GO
