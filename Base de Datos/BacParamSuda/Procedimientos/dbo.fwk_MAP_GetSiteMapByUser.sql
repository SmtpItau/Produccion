USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_GetSiteMapByUser]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_GetSiteMapByUser] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30) = NULL
   ,@IdRole           NVARCHAR(30) = NULL
)
--WITH ENCRYPTION
AS
BEGIN
	/*
	Recupera los sitios de acuerdo al usuario
	
	@Autor : Gabriel Ponce (gbrel)
	@Fecha : Julio - 2009
	@Example: 
	EXEC fwk_MAP_GetSiteMapByUser 'FFMM', 'GBREL'
	EXEC fwk_MAP_GetSiteMapByUser 'FFMM', NULL, 'CONTROL DE ACCESO'
	*/
	
	--DECLARE @IdAplicacion nvarchar(30)
	--DECLARE @IdUser nvarchar(30)
	--SET @IdAplicacion = 'FFMM'
	--SET @IdUser = 'AAVILA'
	
	DECLARE @sitios TABLE (
	            id_nodo INT
	           ,PRIMARY KEY(id_nodo ASC) WITH (IGNORE_DUP_KEY = OFF) ON 
	            [PRIMARY]
	        )
	
	DECLARE @nodos TABLE (
	            id_nodo INT
	           ,PRIMARY KEY(id_nodo ASC) WITH (IGNORE_DUP_KEY = OFF) ON 
	            [PRIMARY]
	        )
	
	DECLARE @id_parent     INT
	       ,@id_site       INT
	       ,@ciclos        INT
	
	IF (NOT @IdRole IS NULL)
	BEGIN
	    INSERT @sitios
	    SELECT FWK_SITEMAP.id_site
	    FROM   FWK_SITEMAP WITH (NOLOCK)
	           LEFT OUTER JOIN FWK_SITEMAP_ROLES WITH (NOLOCK)
	                ON  FWK_SITEMAP.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                    AND FWK_SITEMAP.id_site = FWK_SITEMAP_ROLES.id_site
	           INNER JOIN FWK_ROLES WITH (NOLOCK)
	                ON  FWK_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                    AND FWK_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	    WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	           AND FWK_ROLES.id_role = @IdRole
	               -- HABILITAR SITIOS FIXED, SEGUN DEFINICION
	           AND NOT EXISTS (
	                   SELECT id_nodo
	                   FROM   dbo.ufx_MAP_FixedSite(@IdAplicacion)
	                   WHERE  id_nodo = FWK_SITEMAP.id_site
	               )
	    GROUP BY
	           FWK_SITEMAP.id_site
	    HAVING SUM(
	               CAST(ISNULL(FWK_SITEMAP_ROLES.is_find ,0) AS INT) 
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_print ,0) AS INT)
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_write ,0) AS INT)
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_erase ,0) AS INT)
	           ) > 0
	END
	ELSE
	BEGIN
	    INSERT @sitios
	    SELECT FWK_SITEMAP.id_site
	    FROM   FWK_SITEMAP WITH (NOLOCK)
	           LEFT OUTER JOIN FWK_SITEMAP_ROLES WITH (NOLOCK)
	                ON  FWK_SITEMAP.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                    AND FWK_SITEMAP.id_site = FWK_SITEMAP_ROLES.id_site
	           INNER JOIN FWK_USERS_ROLES WITH (NOLOCK)
	                ON  FWK_USERS_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                    AND FWK_USERS_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	                    AND FWK_USERS_ROLES.id_user = @IdUser
	    WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	           -- HABILITAR SITIOS FIXED, SEGUN DEFINICION
	           AND NOT EXISTS (
	                   SELECT id_nodo
	                   FROM   dbo.ufx_MAP_FixedSite(@IdAplicacion)
	                   WHERE  id_nodo = FWK_SITEMAP.id_site
	               )
	    GROUP BY
	           FWK_SITEMAP.id_site
	    HAVING SUM(
	               CAST(ISNULL(FWK_SITEMAP_ROLES.is_find ,0) AS INT) 
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_print ,0) AS INT)
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_write ,0) AS INT)
	               + CAST(ISNULL(FWK_SITEMAP_ROLES.is_erase ,0) AS INT)
	           ) > 0
	END 
	
	--------------------------------------------------------------------------------------------------------
	--	LISTA DE MENUS CONFIGURADOS PARA LOS ROLES DEL USUARIO INDICADO
	--------------------------------------------------------------------------------------------------------
	DECLARE CUR_ CURSOR  
	FOR
	    SELECT id_nodo
	    FROM   @sitios
	--   UNION SELECT 0
	
	-- LOOP POR CADA UNOS DE LOS MENUS PERMITIDOS, PARA OBTENER LOS AGRUPADORES (PARENT)
	OPEN CUR_;
	FETCH NEXT FROM CUR_ INTO @id_site
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SELECT @id_parent = id_site_parent--, @id_nodo = id_site
	    FROM   FWK_SITEMAP
	    WHERE  id_site = @id_site
	    
	    PRINT '========================'
	    PRINT '@id_parent: ' + CONVERT(VARCHAR(10) ,@id_parent)
	    PRINT '@id_site: ' + CONVERT(VARCHAR(10) ,@id_site)
	    PRINT '========================'
	    
	    INSERT @nodos
	      (
	        id_nodo
	      )
	    VALUES
	      (
	        @id_site
	      )
	    
	    SET @ciclos = 0
	    --    -- LOOP HASTA LLEGAR AL NODO RAIZ, COMENZANDO DESDE EL HIJO
	    WHILE ((NOT @id_parent IS NULL) AND (@ciclos < 100))
	    BEGIN
	        SET @ciclos = @ciclos + 1
	        SET @id_site = @id_parent
	        -- VERIFICAR SI EL NODO YA FUE AGREGADO A LA LISTA
	        IF (
	               (
	                   SELECT COUNT(*)
	                   FROM   @nodos
	                   WHERE  id_nodo = @id_site
	               ) = 1
	           )
	        BEGIN
	            SET @id_parent = NULL
	        END
	        ELSE
	        BEGIN
	            SELECT @id_parent = id_site_parent--, @id_nodo = id_site, @is_active = ind_activo
	            FROM   FWK_SITEMAP
	            WHERE  id_site = @id_site
	            
	            PRINT '---------------------------------'
	            PRINT '@id_parent: ' + CONVERT(VARCHAR(10) ,ISNULL(@id_parent ,-1))
	            PRINT '@id_site: ' + CONVERT(VARCHAR(10) ,@id_site)
	            PRINT '---------------------------------'
	            
	            INSERT @nodos
	              (
	                id_nodo
	              )
	            VALUES
	              (
	                @id_site
	              )
	        END
	    END
	    
	    IF (@ciclos > 100)
	        RAISERROR (
	            'Demasiados ciclos generados para obtener el RootNode'
	           ,16
	           ,1
	        )
	    
	    FETCH NEXT FROM CUR_ INTO @id_site
	END
	
	CLOSE CUR_;
	DEALLOCATE CUR_;
	
	
	SELECT FWK_SITEMAP.id_aplicacion
	      ,FWK_SITEMAP.id_site
	      ,FWK_SITEMAP.id_site_parent
	      ,FWK_SITEMAP.titulo
	      ,FWK_SITEMAP.descripcion
	      ,FWK_SITEMAP.url
	      ,STUFF(
	           (
	               SELECT ',' + A.id_role
	               FROM   FWK_USERS_ROLES A
	               WHERE  A.id_aplicacion = FWK_SITEMAP.id_aplicacion
	                      AND A.id_user = @IdUser
	               GROUP BY
	                      A.id_role FOR XML PATH('')
	           )
	          ,1
	          ,1
	          ,''
	       ) AS roles
	      ,FWK_SITEMAP.args
	       
	       -- , STUFF (
	       --    ( SELECT '','' + A.id_role
	       --     FROM FWK_USERS_ROLES A
	       --       INNER JOIN FWK_SITEMAP_ROLES B ON A.id_aplicacion = B.id_aplicacion AND A.id_role = B.id_role
	       --       INNER JOIN FWK_USERS_ROLES C ON C.id_aplicacion = B.id_aplicacion AND C.id_role = B.id_role
	       --     WHERE
	       --       B.id_aplicacion = FWK_SITEMAP.id_aplicacion
	       --       AND B.id_site = FWK_SITEMAP.id_site
	       --       AND C.id_user = @IdUser
	       --     GROUP BY A.id_role FOR XML PATH('''') ), 1 ,1 ,'''' ) as roles
	      ,DATA.is_find
	      ,DATA.is_print
	      ,DATA.is_write
	      ,DATA.is_erase
	FROM   @nodos NODOS
	       INNER JOIN FWK_SITEMAP WITH (NOLOCK)
	            ON  NODOS.id_nodo = FWK_SITEMAP.id_site
	       LEFT OUTER JOIN (
	                SELECT FWK_SITEMAP.id_site
	                      ,MAX(CAST(FWK_SITEMAP_ROLES.is_find AS INT)) AS 
	                       is_find
	                      ,MAX(CAST(FWK_SITEMAP_ROLES.is_print AS INT)) AS 
	                       is_print
	                      ,MAX(CAST(FWK_SITEMAP_ROLES.is_write AS INT)) AS 
	                       is_write
	                      ,MAX(CAST(FWK_SITEMAP_ROLES.is_erase AS INT)) AS 
	                       is_erase
	                FROM   FWK_SITEMAP WITH (NOLOCK)
	                       LEFT OUTER JOIN FWK_SITEMAP_ROLES WITH (NOLOCK)
	                            ON  FWK_SITEMAP_ROLES.id_aplicacion = 
	                                FWK_SITEMAP.id_aplicacion
	                                AND FWK_SITEMAP_ROLES.id_site = FWK_SITEMAP.id_site 
	                                    --        INNER JOIN FWK_USERS_ROLES WITH (NOLOCK) ON FWK_USERS_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                                    --            AND FWK_USERS_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	                                    --            AND FWK_USERS_ROLES.id_user = @IdUser
	                                    
	                       INNER JOIN @nodos DATA
	                            ON  DATA.id_nodo = FWK_SITEMAP.id_site
	                WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	                GROUP BY
	                       FWK_SITEMAP.id_site
	                       --        , FWK_SITEMAP.id_site_parent
	                       --        , FWK_SITEMAP.titulo
	                       --        , FWK_SITEMAP.descripcion
	                       --        , FWK_SITEMAP.url
	                       --        , FWK_SITEMAP.args
	                       
	                       --	SELECT FWK_SITEMAP.id_site
	                       --	 , max(cast(FWK_SITEMAP_ROLES.is_find as int)) as is_find
	                       --	 , max(cast(FWK_SITEMAP_ROLES.is_print as int)) as is_print
	                       --	 , max(cast(FWK_SITEMAP_ROLES.is_write as int)) as is_write
	                       --	 , max(cast(FWK_SITEMAP_ROLES.is_erase as int)) as is_erase
	                       --	FROM FWK_SITEMAP WITH (NOLOCK)
	                       --	 LEFT OUTER JOIN FWK_SITEMAP_ROLES WITH (NOLOCK) ON FWK_SITEMAP_ROLES.id_aplicacion = FWK_SITEMAP.id_aplicacion
	                       --		AND FWK_SITEMAP_ROLES.id_site = FWK_SITEMAP.id_site
	                       --	 INNER JOIN FWK_USERS_ROLES WITH (NOLOCK) ON FWK_USERS_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                       --		AND FWK_USERS_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	                       --		AND FWK_USERS_ROLES.id_user = @IdUser
	                       --	 INNER JOIN @nodos DATA ON DATA.id_nodo = FWK_SITEMAP.id_site
	                       --	WHERE FWK_SITEMAP.id_aplicacion = @IdAplicacion
	                       --	GROUP BY
	                       --	 FWK_SITEMAP.id_aplicacion
	                       --	 , FWK_SITEMAP.id_site
	                       --	 , FWK_SITEMAP.id_site_parent
	                       --	 , FWK_SITEMAP.titulo
	                       --	 , FWK_SITEMAP.descripcion
	                       --	 , FWK_SITEMAP.url
	                       --	 , FWK_SITEMAP.args
	            ) DATA
	            ON  DATA.id_site = FWK_SITEMAP.id_site
	WHERE  FWK_SITEMAP.id_aplicacion = @IdAplicacion
	ORDER BY
	       FWK_SITEMAP.orden
	       
	       
	       /*
	       IF ( (select 1 from FWK_USERS_ROLES where id_aplicacion = @IdAplicacion and id_role = ''*'' and id_user = @IdUser) = 1 )
	       begin
	       SELECT
	       FWK_SITEMAP.id_aplicacion
	       , FWK_SITEMAP.id_site
	       , FWK_SITEMAP.id_site_parent
	       , FWK_SITEMAP.titulo
	       , FWK_SITEMAP.descripcion
	       , FWK_SITEMAP.url
	       
	       , STUFF (
	       ( SELECT '','' + A.id_role
	       FROM FWK_USERS_ROLES A
	       WHERE A.id_aplicacion = FWK_SITEMAP.id_aplicacion AND A.id_user = @IdUser
	       GROUP BY A.id_role FOR XML PATH('''') ), 1 ,1 ,'''' ) as roles
	       
	       , FWK_SITEMAP.args
	       
	       , cast(1 as bit) as is_find
	       , cast(1 as bit) as is_print
	       , cast(1 as bit) as is_write
	       , cast(1 as bit) as is_erase
	       FROM FWK_SITEMAP
	       WHERE
	       FWK_SITEMAP.id_aplicacion = @IdAplicacion
	       GROUP BY
	       FWK_SITEMAP.id_aplicacion
	       , FWK_SITEMAP.id_site
	       , FWK_SITEMAP.id_site_parent
	       , FWK_SITEMAP.titulo
	       , FWK_SITEMAP.descripcion
	       , FWK_SITEMAP.url
	       , FWK_SITEMAP.args
	       , FWK_SITEMAP.orden
	       ORDER BY FWK_SITEMAP.orden
	       end
	       ELSE
	       begin
	       SELECT
	       FWK_SITEMAP.id_aplicacion
	       , FWK_SITEMAP.id_site
	       , FWK_SITEMAP.id_site_parent
	       , FWK_SITEMAP.titulo
	       , FWK_SITEMAP.descripcion
	       , FWK_SITEMAP.url
	       
	       , STUFF (
	       ( SELECT '','' + A.id_role
	       FROM FWK_USERS_ROLES A
	       WHERE A.id_aplicacion = FWK_SITEMAP.id_aplicacion AND A.id_user = @IdUser
	       GROUP BY A.id_role FOR XML PATH('''') ), 1 ,1 ,'''' ) as roles
	       
	       --	 , STUFF (
	       --		( SELECT '','' + A.id_role
	       --		 FROM FWK_USERS_ROLES A 
	       --		   INNER JOIN FWK_SITEMAP_ROLES B ON A.id_aplicacion = B.id_aplicacion AND A.id_role = B.id_role
	       --		   INNER JOIN FWK_USERS_ROLES C ON C.id_aplicacion = B.id_aplicacion AND C.id_role = B.id_role 
	       --		 WHERE 
	       --		   B.id_aplicacion = FWK_SITEMAP.id_aplicacion 
	       --		   AND B.id_site = FWK_SITEMAP.id_site
	       --		   AND C.id_user = @IdUser
	       --		 GROUP BY A.id_role FOR XML PATH('''') ), 1 ,1 ,'''' ) as roles
	       
	       , FWK_SITEMAP.args
	       
	       , max(cast(FWK_SITEMAP_ROLES.is_find as smallint)) as is_find
	       , max(cast(FWK_SITEMAP_ROLES.is_print as smallint)) as is_print
	       , max(cast(FWK_SITEMAP_ROLES.is_write as smallint)) as is_write
	       , max(cast(FWK_SITEMAP_ROLES.is_erase as smallint)) as is_erase
	       FROM FWK_SITEMAP
	       LEFT OUTER JOIN FWK_SITEMAP_ROLES ON  
	       FWK_SITEMAP.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	       AND FWK_SITEMAP.id_site = FWK_SITEMAP_ROLES.id_site
	       INNER JOIN FWK_USERS_ROLES ON 
	       FWK_USERS_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	       AND FWK_USERS_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	       AND FWK_USERS_ROLES.id_user = @IdUser
	       WHERE
	       FWK_SITEMAP.id_aplicacion = @IdAplicacion
	       GROUP BY
	       FWK_SITEMAP.id_aplicacion
	       , FWK_SITEMAP.id_site
	       , FWK_SITEMAP.id_site_parent
	       , FWK_SITEMAP.titulo
	       , FWK_SITEMAP.descripcion
	       , FWK_SITEMAP.url
	       , FWK_SITEMAP.args
	       
	       end
	       --select
	       -- fwk_SiteMap.id_site
	       -- , fwk_SiteMap.titulo
	       -- , fwk_SiteMap.descripcion
	       -- , fwk_SiteMap.url
	       -- , fwk_SiteMap.roles
	       -- , fwk_SiteMap.id_site_parent
	       -- , fwk_SiteMap.type
	       -- , fwk_SiteMap.arguments
	       -- , max(cast(isnull(fwk_Roles.is_grabar,0) as smallint)) as is_grabar
	       -- , max(cast(isnull(fwk_Roles.is_eliminar,0) as smallint)) as is_eliminar
	       -- , max(cast(isnull(fwk_Roles.is_buscar,0) as smallint)) as is_buscar
	       -- , max(cast(isnull(fwk_Roles.is_imprimir,0) as smallint)) as is_imprimir
	       --from fwk_SiteMap
	       -- LEFT OUTER JOIN fwk_Roles
	       --   ON fwk_SiteMap.roles like ''%''+fwk_Roles.id_role+''%''
	       --group by 
	       -- fwk_SiteMap.id_site
	       -- , fwk_SiteMap.titulo
	       -- , fwk_SiteMap.descripcion
	       -- , fwk_SiteMap.url
	       -- , fwk_SiteMap.roles
	       -- , fwk_SiteMap.id_site_parent
	       -- , fwk_SiteMap.type
	       -- , fwk_SiteMap.arguments
	       
	       */
END
GO
