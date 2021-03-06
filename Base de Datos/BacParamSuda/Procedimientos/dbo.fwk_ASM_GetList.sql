USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ASM_GetList]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ASM_GetList] 
(@IdUser NVARCHAR(30) = NULL)
--WITH ENCRYPTION
AS
BEGIN
	/*
	
	Ensamblados por actualizar
	
	@Autor : Gabriel Ponce (gbrel)
	@Fecha : Julio - 2009
	@Example: 
	EXEC fwk_ASM_GetList
	EXEC fwk_ASM_GetList 'Admin'
	*/
	
	DECLARE @Datos TABLE (
	            id_file NVARCHAR(30)
	           ,PRIMARY KEY(id_file ASC) WITH (IGNORE_DUP_KEY = OFF) ON 
	            [PRIMARY]
	        )
	
	IF (@IdUser IS NULL)
	BEGIN
	    SELECT FWK_REPOSITORIO.id_file
	          ,FWK_REPOSITORIO.extension
	          ,FWK_REPOSITORIO.version
	          ,FWK_REPOSITORIO.created_ticks
	           --, FWK_REPOSITORIO.data
	    FROM   FWK_REPOSITORIO
	    WHERE  FWK_REPOSITORIO.is_optional = 0
	END
	ELSE
	BEGIN
	    -- =================================================================================
	    -- DETERMINAR LA LISTA DE ENSAMBLADOS UTILIZADOS
	    -- , DE ACUERDO A LOS MENUS A LOS CUALES EL USUARIO PUEDE ACCEDER
	    -- =================================================================================
	    INSERT @Datos
	    SELECT RIGHT(
	               FWK_SITEMAP.url
	              ,LEN(FWK_SITEMAP.url) - CHARINDEX(',' ,FWK_SITEMAP.url)
	           )
	    FROM   FMParametros..FWK_APLICACIONES
	           INNER JOIN FMParametros..FWK_ROLES
	                ON  FWK_APLICACIONES.id_aplicacion = FWK_ROLES.id_aplicacion
	           INNER JOIN FMParametros..FWK_USERS_ROLES
	                ON  FWK_ROLES.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                    AND FWK_ROLES.id_role = FWK_USERS_ROLES.id_role
	           INNER JOIN FMParametros..FWK_SITEMAP_ROLES
	                ON  FWK_ROLES.id_aplicacion = FWK_SITEMAP_ROLES.id_aplicacion
	                    AND FWK_ROLES.id_role = FWK_SITEMAP_ROLES.id_role
	           INNER JOIN FMParametros..FWK_SITEMAP
	                ON  FWK_SITEMAP_ROLES.id_aplicacion = FWK_SITEMAP.id_aplicacion
	                    AND FWK_SITEMAP_ROLES.id_site = FWK_SITEMAP.id_site
	    WHERE  FWK_ROLES.id_role <> FWK_APLICACIONES.fixed_role
	           AND FWK_USERS_ROLES.id_user <> FWK_APLICACIONES.fixed_user
	           AND FWK_USERS_ROLES.id_user = @IdUser
	           AND CHARINDEX(',' ,FWK_SITEMAP.url) > 1
	    GROUP BY
	           RIGHT(
	               FWK_SITEMAP.url
	              ,LEN(FWK_SITEMAP.url) - CHARINDEX(',' ,FWK_SITEMAP.url)
	           )
	    
	    --=================================================================================
	    -- ENSAMBLADOS RESULTANTES QUE DEBEN SER ACTUALIZADOS X LA APLICACION
	    --=================================================================================
	    SELECT REP.id_file
	          ,REP.extension
	          ,REP.version
	          ,REP.created_ticks
	           --, REP.data
	    FROM   FWK_REPOSITORIO
	           INNER JOIN FWK_REPOSITORIO_DEPENDENCIAS
	                ON  FWK_REPOSITORIO.id_file = FWK_REPOSITORIO_DEPENDENCIAS.id_file
	           INNER JOIN FWK_REPOSITORIO REP
	                ON  FWK_REPOSITORIO_DEPENDENCIAS.id_file_parent = REP.id_file
	           INNER JOIN @Datos DAT
	                ON  FWK_REPOSITORIO.id_file = DAT.id_file
	    WHERE  NOT EXISTS (
	               SELECT D.id_file
	               FROM   FWK_REPOSITORIO D
	               WHERE  D.is_optional = 0
	                      AND D.id_file = REP.id_file
	           )
	    UNION 
	    SELECT REP.id_file
	          ,REP.extension
	          ,REP.version
	          ,REP.created_ticks
	           --, REP.data
	    FROM   FWK_REPOSITORIO REP
	           INNER JOIN @Datos DAT
	                ON  REP.id_file = DAT.id_file
	    WHERE  NOT EXISTS (
	               SELECT D.id_file
	               FROM   FWK_REPOSITORIO D
	               WHERE  D.is_optional = 0
	                      AND D.id_file = REP.id_file
	           )
	END
END
GO
