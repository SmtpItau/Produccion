USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERLOCALIDADES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERLOCALIDADES]
         (   @Categoria     NUMERIC(5)
         ,   @Codigo        NUMERIC(5)
         ) 
AS
BEGIN
   IF @Categoria = 1
   BEGIN
      SELECT codigo_pais
         ,   nombre 
         FROM VIEW_PAIS ORDER BY nombre
   END ELSE IF @Categoria = 2 BEGIN
      SELECT codigo_region
         ,   nombre 
         FROM VIEW_REGION
        WHERE codigo_pais = @Codigo
        ORDER BY nombre
   END ELSE IF @Categoria = 3 BEGIN
      SELECT codigo_ciudad
         ,   nombre 
         FROM VIEW_CIUDAD
        WHERE codigo_region = @Codigo
        ORDER BY nombre
   END ELSE IF @Categoria = 4 BEGIN
      SELECT codigo_comuna
         ,   nombre 
         FROM VIEW_COMUNA
        WHERE codigo_ciudad = @Codigo
        ORDER BY nombre
   END
END


GO
