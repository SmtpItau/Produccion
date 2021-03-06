USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_GetSiteMapByAplicacion]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_GetSiteMapByAplicacion] 
(@IdAplicacion NVARCHAR(30) ,@IsReport BIT = 0)
--WITH ENCRYPTION
AS
BEGIN
	/*
	Recupera los sitios asociados a la aplicacion
	
	@Autor : Gabriel Ponce (gbrel)
	@Fecha : Julio - 2009
	@Example: EXEC fwk_MAP_GetSiteMapByAplicacion 'FFMM'
	
	*/
	
	--DECLARE @IdAplicacion nvarchar(30)
	--SET @IdAplicacion = 'FFMM'
	
	IF (@IsReport = 0)
	BEGIN
	    SELECT FWK_SITEMAP.id_aplicacion
	          ,FWK_SITEMAP.id_site
	          ,FWK_SITEMAP.id_site_parent
	          ,FWK_SITEMAP.titulo
	          ,FWK_SITEMAP.descripcion
	          ,FWK_SITEMAP.url
	          ,FWK_SITEMAP.roles
	          ,FWK_SITEMAP.args
	          ,FWK_SITEMAP.orden
	          ,CAST(1 AS BIT)  AS is_find
	          ,CAST(1 AS BIT)  AS is_print
	          ,CAST(1 AS BIT)  AS is_write
	          ,CAST(1 AS BIT)  AS is_erase
	    FROM   FWK_SITEMAP WITH (NOLOCK)
	    WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	    GROUP BY
	           FWK_SITEMAP.id_aplicacion
	          ,FWK_SITEMAP.id_site
	          ,FWK_SITEMAP.id_site_parent
	          ,FWK_SITEMAP.titulo
	          ,FWK_SITEMAP.descripcion
	          ,FWK_SITEMAP.url
	          ,FWK_SITEMAP.roles
	          ,FWK_SITEMAP.args
	          ,FWK_SITEMAP.orden
	    ORDER BY
	           FWK_SITEMAP.orden
	END
	ELSE
	BEGIN
	    SELECT FWK_APLICACIONES.descripcion AS aplicacion
	          ,FWK_SITEMAP.id_site
	          ,FWK_SITEMAP.id_site_parent
	          ,FWK_SITEMAP.titulo
	          ,FWK_SITEMAP.descripcion
	          ,FWK_SITEMAP.url
	          ,FWK_SITEMAP.roles
	          ,FWK_SITEMAP.args
	          ,FWK_SITEMAP.orden
	          ,CAST(1 AS BIT)  AS is_find
	          ,CAST(1 AS BIT)  AS is_print
	          ,CAST(1 AS BIT)  AS is_write
	          ,CAST(1 AS BIT)  AS is_erase
	    FROM   FWK_SITEMAP WITH (NOLOCK)
	           INNER JOIN FWK_APLICACIONES WITH (NOLOCK)
	                ON  FWK_APLICACIONES.id_aplicacion = FWK_SITEMAP.id_aplicacion
	    WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	           --HABILITAR SITIOS FIXED, SEGUN DEFINICION
	           AND NOT EXISTS (
	                   SELECT id_nodo
	                   FROM   dbo.ufx_MAP_FixedSite(@IdAplicacion)
	                   WHERE  id_nodo = FWK_SITEMAP.id_site
	               )
	    GROUP BY
	           FWK_APLICACIONES.descripcion
	          ,FWK_SITEMAP.id_site
	          ,FWK_SITEMAP.id_site_parent
	          ,FWK_SITEMAP.titulo
	          ,FWK_SITEMAP.descripcion
	          ,FWK_SITEMAP.url
	          ,FWK_SITEMAP.roles
	          ,FWK_SITEMAP.args
	          ,FWK_SITEMAP.orden
	    ORDER BY
	           FWK_SITEMAP.orden
	END
END
GO
