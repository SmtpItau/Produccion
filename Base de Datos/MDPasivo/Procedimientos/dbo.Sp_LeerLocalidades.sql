USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerLocalidades]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LeerLocalidades] 
         (   @Categoria     NUMERIC(5)
         ,   @Codigo        NUMERIC(5)
         ) 
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   IF @Categoria = 1
   BEGIN

	IF @Codigo = 0
		SELECT codigo_pais
        	,   nombre 
		,   codigo_pais_super
        	FROM PAIS ORDER BY nombre
	ELSE
		SELECT codigo_pais_super
        	,   nombre 
		,   codigo_pais
        	FROM PAIS ORDER BY nombre

   END ELSE IF @Categoria = 2 BEGIN

      SELECT codigo_region
         ,   nombre 
         FROM REGION
        WHERE codigo_pais = @Codigo
        ORDER BY nombre

   END ELSE IF @Categoria = 3 BEGIN

      SELECT codigo_ciudad
         ,   nombre 
         FROM CIUDAD
        WHERE codigo_region = @Codigo
        ORDER BY nombre

   END ELSE IF @Categoria = 4 BEGIN

      SELECT codigo_comuna
         ,   nombre 
         FROM COMUNA
        WHERE codigo_ciudad = @Codigo
        ORDER BY nombre

   END

END





GO
