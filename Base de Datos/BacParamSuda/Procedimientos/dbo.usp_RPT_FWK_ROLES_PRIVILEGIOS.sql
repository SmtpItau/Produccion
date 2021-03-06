USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[usp_RPT_FWK_ROLES_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RPT_FWK_ROLES_PRIVILEGIOS]
	@fchProceso DATETIME = '20081124'
	 ,
	@IdAplicacion NVARCHAR(30) = 'FFMM'
	 --WITH ENCRYPTION
AS
BEGIN
	/*
	Procedimiento destinado al reporte que lleva su nombre
	
	@Autor       : Gabriel Ponce (gbrel)
	@Fecha     : Abril 2010
	@Example  :
	EXEC usp_RPT_FWK_ROLES_PRIVILEGIOS '20081124', 'FFMM'
	*/ 
	
	DECLARE @Menus TABLE (
	            id_aplicacion NVARCHAR(30),
	            id_site INT,
	            id_site_parent INT,
	            titulo VARCHAR(60),
	            descripcion VARCHAR(512),
	            URL VARCHAR(512),
	            args VARCHAR(50),
	            roles VARCHAR(512),
	            is_find BIT,
	            is_print BIT,
	            is_write BIT,
	            is_erase BIT,
	            PRIMARY KEY(id_aplicacion ASC, id_site ASC) WITH (IGNORE_DUP_KEY = OFF) 
	            ON [PRIMARY]
	        )
	
	DECLARE @Datos TABLE (
	            id_role NVARCHAR(30),
	            id_aplicacion NVARCHAR(30),
	            id_site INT,
	            id_site_parent INT,
	            titulo VARCHAR(60),
	            is_find BIT,
	            is_print BIT,
	            is_write BIT,
	            is_erase BIT,
	            PRIMARY KEY(id_role ASC, id_aplicacion ASC, id_site ASC) WITH (IGNORE_DUP_KEY = OFF) 
	            ON [PRIMARY]
	        )
	
	DECLARE @IdRole NVARCHAR(30)
	DECLARE CUR_PRI CURSOR  
	FOR
	    SELECT FWK_ROLES.id_role
	    FROM   FWK_APLICACIONES
	           INNER JOIN FWK_ROLES
	                ON  FWK_APLICACIONES.id_aplicacion = FWK_ROLES.id_aplicacion
	    WHERE  FWK_ROLES.id_role <> FWK_APLICACIONES.fixed_role
	           --        AND FWK_ROLES.id_role = 'CONTROL DE ACCESO'
	    ORDER BY
	           FWK_ROLES.id_role
	
	
	OPEN CUR_PRI;
	FETCH NEXT FROM CUR_PRI INTO @IdRole
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    PRINT 'ROLE: ' + @IdRole
	    INSERT @Menus
	    EXEC fwk_MAP_GetSiteMapByUser @IdAplicacion,
	         NULL,
	         @IdRole
	    --EXEC FMParametros..fwk_MAP_GetSiteMapByRole @IdAplicacion, @IdRole
	    
	    INSERT @Datos
	    SELECT @IdRole,
	           id_aplicacion,
	           id_site,
	           id_site_parent,
	           titulo,
	           is_find,
	           is_print,
	           is_write,
	           is_erase
	    FROM   @Menus
	    
	    DELETE 
	    FROM   @Menus
	    
	    FETCH NEXT FROM CUR_PRI INTO @IdRole
	END
	
	CLOSE CUR_PRI;
	DEALLOCATE CUR_PRI;
	
	SELECT FWK_APLICACIONES.descripcion AS aplicacion,
	       D.id_role,
	       D.id_site,
	       D.id_site_parent,
	       D.titulo,
	       D.is_find,
	       D.is_print,
	       D.is_write,
	       D.is_erase
	       --    , FWK_SITEMAP.orden
	       --    , FWK_SITEMAP.url
	FROM   @Datos D
	       INNER JOIN FWK_APLICACIONES
	            ON  FWK_APLICACIONES.id_aplicacion = D.id_aplicacion
	       INNER JOIN FWK_SITEMAP
	            ON  D.id_aplicacion = FWK_SITEMAP.id_aplicacion
	            AND FWK_SITEMAP.id_site = D.id_site
	ORDER BY
	       D.id_role,
	       FWK_SITEMAP.orden
END
GO
