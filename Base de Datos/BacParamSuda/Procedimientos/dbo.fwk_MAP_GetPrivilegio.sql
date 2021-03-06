USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_GetPrivilegio]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_GetPrivilegio] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@IdSite           INT
)
--WITH ENCRYPTION
AS
	/*
Recupera los privilegios del usuario para el sitio indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_MAP_GetPrivilegio 'FFMM', 'GBREL', 8

*/


BEGIN
	SELECT FWK_SITEMAP_ROLES.id_aplicacion
	      ,FWK_SITEMAP_ROLES.id_site
	      ,MAX(CAST(FWK_SITEMAP_ROLES.is_find AS SMALLINT)) AS is_find
	      ,MAX(CAST(FWK_SITEMAP_ROLES.is_print AS SMALLINT)) AS is_print
	      ,MAX(CAST(FWK_SITEMAP_ROLES.is_write AS SMALLINT)) AS is_write
	      ,MAX(CAST(FWK_SITEMAP_ROLES.is_erase AS SMALLINT)) AS is_erase
	FROM   FWK_SITEMAP_ROLES
	       INNER JOIN FWK_USERS_ROLES
	            ON  FWK_SITEMAP_ROLES.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_SITEMAP_ROLES.id_role = FWK_USERS_ROLES.id_role
	WHERE  FWK_SITEMAP_ROLES.id_aplicacion = @IdAplicacion
	       AND FWK_SITEMAP_ROLES.id_site = @IdSite
	       AND FWK_USERS_ROLES.id_user = @IdUser
	GROUP BY
	       FWK_SITEMAP_ROLES.id_aplicacion
	      ,FWK_SITEMAP_ROLES.id_site
END
GO
