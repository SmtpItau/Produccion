USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_GetSiteMapByRole]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_GetSiteMapByRole] 
(@IdAplicacion NVARCHAR(30) ,@IdRole NVARCHAR(30))
--WITH ENCRYPTION
AS
BEGIN
	/*
	Recupera los sitios asociados al role indicado
	
	@Autor : Gabriel Ponce (gbrel)
	@Fecha : Julio - 2009
	@Example: EXEC fwk_MAP_GetSiteMapByRole 'FFMM', 'DEVELOPER'
	
	*/
	
	--DECLARE @IdAplicacion nvarchar(30)
	--DECLARE @IdRole nvarchar(30)
	--SET @IdAplicacion = 'FFMM'
	--SET @IdRole = 'DEVELOPER'
	
	SELECT FWK_SITEMAP.id_aplicacion
	      ,FWK_SITEMAP.id_site
	      ,FWK_SITEMAP.id_site_parent
	      ,FWK_SITEMAP.titulo
	      ,FWK_SITEMAP.descripcion
	      ,FWK_SITEMAP.url
	      ,FWK_SITEMAP.args
	      ,STUFF(
	           (
	               SELECT ',' + A.id_role
	               FROM   FWK_USERS_ROLES A
	                      INNER JOIN FWK_SITEMAP_ROLES B
	                           ON  A.id_aplicacion = B.id_aplicacion
	                               AND A.id_role = B.id_role
	                      INNER JOIN FWK_USERS_ROLES C
	                           ON  C.id_aplicacion = B.id_aplicacion
	                               AND C.id_role = B.id_role
	               WHERE  B.id_aplicacion = FWK_SITEMAP.id_aplicacion
	                      AND B.id_site = FWK_SITEMAP.id_site
	               GROUP BY
	                      A.id_role FOR XML PATH('')
	           )
	          ,1
	          ,1
	          ,''
	       ) AS roles
	      ,CAST(MAX(CAST(FWK_SITEMAP_ROLES.is_find AS SMALLINT)) AS BIT) AS 
	       is_find
	      ,CAST(MAX(CAST(FWK_SITEMAP_ROLES.is_print AS SMALLINT)) AS BIT) AS 
	       is_print
	      ,CAST(MAX(CAST(FWK_SITEMAP_ROLES.is_write AS SMALLINT)) AS BIT) AS 
	       is_write
	      ,CAST(MAX(CAST(FWK_SITEMAP_ROLES.is_erase AS SMALLINT)) AS BIT) AS 
	       is_erase
	FROM   FWK_SITEMAP
	       LEFT OUTER JOIN FWK_SITEMAP_ROLES
	            ON  FWK_SITEMAP.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                AND FWK_SITEMAP.id_site = FWK_SITEMAP_ROLES.id_site
	                AND FWK_SITEMAP_ROLES.id_role = @IdRole
	WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	       --HABILITAR SITIOS FIXED, SEGUN DEFINICION
	       AND NOT EXISTS (
	               SELECT id_nodo
	               FROM   dbo.ufx_MAP_FixedSite(@IdAplicacion)
	               WHERE  id_nodo = FWK_SITEMAP.id_site
	           )
	GROUP BY
	       FWK_SITEMAP.id_aplicacion
	      ,FWK_SITEMAP.id_site
	      ,FWK_SITEMAP.id_site_parent
	      ,FWK_SITEMAP.titulo
	      ,FWK_SITEMAP.descripcion
	      ,FWK_SITEMAP.url
	      ,FWK_SITEMAP.args
	      ,FWK_SITEMAP.orden
	ORDER BY
	       FWK_SITEMAP.orden
END
GO
