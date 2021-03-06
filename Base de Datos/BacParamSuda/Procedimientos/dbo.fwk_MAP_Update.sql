USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_Update]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_Update] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdSite           INT
   ,@IdSiteParent     INT
   ,@Titulo           VARCHAR(60)
   ,@Descripcion      VARCHAR(512)
   ,@Url              VARCHAR(512)
   ,@Roles            VARCHAR(512)
   ,@Args             VARCHAR(50)
   ,@Orden            INT
   ,@IsDelete         BIT = 0
)
--WITH ENCRYPTION
AS
	/*
Actualiza la informacion del sitio

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_MAP_Update ...

*/

BEGIN
	IF (@IsDelete = 1)
	BEGIN
	    DELETE 
	    FROM   FWK_SITEMAP_ROLES
	    WHERE  id_aplicacion = @IdAplicacion
	           AND id_site = @IdSite 
	    
	    DELETE 
	    FROM   FWK_SITEMAP
	    WHERE  id_aplicacion = @IdAplicacion
	           AND id_site = @IdSite
	END
	ELSE
	BEGIN
	    IF EXISTS (
	           SELECT id_aplicacion
	           FROM   FWK_SITEMAP
	           WHERE  id_aplicacion     = @IdAplicacion
	                  AND id_site       = @IdSite
	       )
	    BEGIN
	        -- actualizar la informacion
	        UPDATE FWK_SITEMAP
	        SET    titulo             = @Titulo
	              ,descripcion        = @Descripcion
	              ,URL                = @Url
	              ,roles              = @Roles
	              ,id_site_parent     = @IdSiteParent
	              ,args               = @Args
	              ,orden              = @Orden
	        WHERE  id_aplicacion      = @IdAplicacion
	               AND id_site        = @IdSite
	    END
	    ELSE
	    BEGIN
	        -- generar la informacion
	        INSERT INTO FWK_SITEMAP
	          (
	            id_aplicacion
	           ,id_site
	           ,id_site_parent
	           ,titulo
	           ,descripcion
	           ,URL
	           ,roles
	           ,args
	           ,orden
	          )
	        VALUES
	          (
	            @IdAplicacion
	           ,@IdSite
	           ,@IdSiteParent
	           ,@Titulo
	           ,@Descripcion
	           ,@Url
	           ,@Roles
	           ,@Args
	           ,@Orden
	          )
	    END
	END
END
GO
