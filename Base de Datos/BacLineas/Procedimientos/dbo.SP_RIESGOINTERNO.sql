USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIESGOINTERNO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RIESGOINTERNO]
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
      SELECT codigo_riesgo, glosa_riesgo, descripcion FROM RIESGOINTERNO ORDER BY codigo_riesgo
      RETURN
   END

   IF @iTag = 1
   BEGIN
      IF EXISTS(SELECT 1 FROM RIESGOINTERNO WHERE codigo_riesgo = @nCodigo)
      BEGIN
         DELETE FROM RIESGOINTERNO
               WHERE codigo_riesgo = @nCodigo
      END
      INSERT INTO RIESGOINTERNO (codigo_riesgo, glosa_riesgo, descripcion) VALUES (@nCodigo, @cGlosa, @cdescripcion)
   END

   IF @iTag = 2
   BEGIN
      DELETE FROM RIESGOINTERNO
   END

   IF @iTag = 3
   BEGIN
      IF EXISTS(SELECT 1 FROM LCRRIEPARMDAPON WHERE codigo_riesgo = @nCodigo)
      BEGIN
         SELECT -1, 'Items en uso... no se puede eliminar.'
         RETURN
      END

      DELETE FROM RIESGOINTERNO 
            WHERE codigo_riesgo = @nCodigo
   END

   IF @iTag = 4
   BEGIN
      IF EXISTS(SELECT 1 FROM LCRRIEPARMDAPON WHERE codigo_riesgo = @nCodigo)
      BEGIN
         SELECT -1, 'Items en uso... no se puede eliminar.'
         RETURN
      END
      SELECT 0, 'Se permite la Modificación'
   END

END
GO
