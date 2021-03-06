USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_READNOMFILE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_READNOMFILE]
   (   @IdArchivo   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   IF NOT EXISTS( SELECT 1 FROM TBL_ARCHIVOS WHERE IdArchivo = @IdArchivo)
   BEGIN
      SELECT -1, 'Nombre de Archivo no Encontrado'
   END ELSE
   BEGIN
      SELECT Id        = ISNULL( IdArchivo, -1)
      ,      Nombre    = ISNULL( Nombre,    'No Existe Archivo Definido')
      ,      Path      = PathDestino
      FROM   TBL_ARCHIVOS
      WHERE  IdArchivo = @IdArchivo
   END

END

GO
