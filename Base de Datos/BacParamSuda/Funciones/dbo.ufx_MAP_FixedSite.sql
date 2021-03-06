USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ufx_MAP_FixedSite]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufx_MAP_FixedSite]
(
	@IdAplicacion NVARCHAR(30)
)
RETURNS @OutputTable TABLE (
            id_nodo INT
           ,PRIMARY KEY(id_nodo ASC) WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
        )
        --WITH ENCRYPTION
AS
	/*
Metodo destinado a construir una tabla (de una columna), de acuerdo a la configuracion indicada
en la tabla FWK_SITEMAP_FIXED, la cual define los nodos habilitados solo para el role FIDEX

@Autor : 
@Fecha : Enero 2010
@Example: SELECT * FROM dbo.ufx_FWK_SiteMapFixed('FFMM') 

*/

BEGIN
	DECLARE @id_child     INT
	       ,@id_site      INT
	       ,@ciclos       INT
	--------------------------------------------------------------------------------------------------------
	--	LISTA DE MENUS CONFIGURADOS PARA LOS ROLES DEL USUARIO INDICADO
	--------------------------------------------------------------------------------------------------------
	DECLARE CUR_ CURSOR  
	FOR
	    SELECT id_site
	    FROM   FWK_SITEMAP_FIXED WITH (NOLOCK)
	    WHERE  id_aplicacion = @IdAplicacion
	    GROUP BY
	           id_site
	
	
	-- LOOP POR CADA UNOS DE LOS MENUS PERMITIDOS, PARA OBTENER LOS AGRUPADORES (PARENT)
	OPEN CUR_;
	FETCH NEXT FROM CUR_ INTO @id_site
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT @OutputTable
	    SELECT id_site
	    FROM   FWK_SITEMAP
	    WHERE  id_site               = @id_site
	           OR id_site_parent     = @id_site
	    
	    SET @id_child = @@ROWCOUNT
	    SET @ciclos = 0
	    
	    -- LOOP HASTA LLEGAR AL NODO HIJO, COMENZANDO DESDE EL ROOT
	    WHILE ((@id_child > 0) AND (@ciclos < 100))
	    BEGIN
	        SET @ciclos = @ciclos + 1
	        
	        INSERT @OutputTable
	        SELECT id_site
	        FROM   FWK_SITEMAP
	               INNER JOIN @OutputTable NODOS
	                    ON  id_site_parent = id_nodo
	        WHERE  NOT EXISTS (
	                   SELECT id_nodo
	                   FROM   @OutputTable
	                   WHERE  id_nodo = id_site
	               )
	        
	        SET @id_child = @@ROWCOUNT
	    END
	    
	    --    IF (@ciclos > 100)
	    --       RAISERROR ('Demasiados ciclos generados para obtener el RootNode', 16, 1)
	    
	    FETCH NEXT FROM CUR_ INTO @id_site
	END
	
	CLOSE CUR_;
	DEALLOCATE CUR_; 
	
	RETURN
END

GO
