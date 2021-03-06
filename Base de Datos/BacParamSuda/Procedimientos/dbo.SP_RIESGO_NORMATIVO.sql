USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIESGO_NORMATIVO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RIESGO_NORMATIVO]
   (   @iTag         INTEGER
   ,   @nCodigo      INTEGER   = 0
   ,   @cGlosa       CHAR(30)  = ''
   ,   @cdescripcion CHAR(70)  = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT codigo_riesgo, glosa_riesgo, descripcion FROM RIESGO_NORMATIVO ORDER BY codigo_riesgo
      RETURN
   END

   IF @iTag = 1
   BEGIN
      IF EXISTS(SELECT 1 FROM RIESGO_NORMATIVO WHERE codigo_riesgo = @nCodigo)
      BEGIN
         IF EXISTS(SELECT 1 FROM MATRIZ_RIESGO_NORMATIVO WHERE codigo_riesgo = @nCodigo)
         BEGIN
            UPDATE RIESGO_NORMATIVO 
               SET glosa_riesgo  = glosa_riesgo
               ,   descripcion   = descripcion
             WHERE codigo_riesgo = @nCodigo
         END ELSE
         BEGIN
            DELETE FROM RIESGO_NORMATIVO 
                  WHERE codigo_riesgo = @nCodigo

            INSERT INTO RIESGO_NORMATIVO (codigo_riesgo, glosa_riesgo, descripcion) VALUES (@nCodigo, @cGlosa, @cdescripcion)
         END
      END ELSE
      BEGIN
         INSERT INTO RIESGO_NORMATIVO (codigo_riesgo, glosa_riesgo, descripcion) VALUES (@nCodigo, @cGlosa, @cdescripcion)
      END
   END

   IF @iTag = 2
   BEGIN
      RETURN
      --> DELETE FROM RIESGO_NORMATIVO
   END

   IF @iTag = 3
   BEGIN
      IF EXISTS(SELECT 1 FROM MATRIZ_RIESGO_NORMATIVO WHERE codigo_riesgo = @nCodigo)
      BEGIN
         SELECT -1, 'Items, se encuentra en uso... No es posible eliminar.'
      END ELSE
      BEGIN
         DELETE FROM RIESGO_NORMATIVO
               WHERE codigo_riesgo = @nCodigo
      END
   END

END
GO
