USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_DESCRIPCION_RELACION_ATRIBUTO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_DESCRIPCION_RELACION_ATRIBUTO]
               ( @iconsulta      CHAR(255) 
               , @icodigo        VARCHAR(15)
               , @odescripcion   VARCHAR(255)   OUTPUT
               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy


   IF @iconsulta = ' ' OR @icodigo = ' ' BEGIN

      SELECT @odescripcion  = ' '
      RETURN

   END

   CREATE TABLE #DETALLE
         (   codigo        VARCHAR(15)
         ,   Descripcion   VARCHAR(255)
         )


   EXEC ('INSERT INTO #DETALLE ' + @iconsulta ) 


   SELECT @odescripcion  = descripcion
     FROM #DETALLE
    WHERE codigo = @icodigo

   SET NOCOUNT OFF

END


GO
