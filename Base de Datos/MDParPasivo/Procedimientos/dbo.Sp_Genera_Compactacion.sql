USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Compactacion]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Genera_Compactacion]
               ( @Tabla         CHAR(25)
               , @xFecha1       DATETIME
               , @xFecha2       DATETIME
               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT DMY

   DECLARE @Cadena      CHAR(255)
         , @Tipo        CHAR(10)
         , @Campo_Fecha CHAR(20)

   CREATE TABLE #GENERACION
               (   id_Sistema            CHAR( 3)
               ,   Tabla                 CHAR(25)
               ,   Nombre_Sistema        CHAR(15) 
               ,   Tipo                  CHAR(10)
               ,   Campo_Fecha           CHAR(20)
               ,   Primer_Dia_Mes        DATETIME
               ,   Ultimo_Dia_Mes        DATETIME
               )

   INSERT INTO #GENERACION EXEC Sp_Compactacion_Datos
   DELETE FROM #GENERACION WHERE Tabla <> @Tabla

   SELECT @Tipo        = Tipo
        , @Campo_Fecha = Campo_fecha
     FROM #GENERACION 


   SELECT @Cadena = ' SELECT "reg" = (' + ' SELECT count(1) FROM ' + LTRIM(RTRIM(@Tipo)) + LTRIM(RTRIM(@Tabla)) + ' WHERE ' + @Campo_Fecha + ' BETWEEN "'  + CONVERT(CHAR(8),@xFecha1,112) + '" AND "'  + CONVERT(CHAR(8),@xFecha2,112) + '"' + '), * FROM ' + 
LTRIM(RTRIM(@Tipo)) + LTRIM(RTRIM(@Tabla)) + ' WHERE ' + @Campo_Fecha + ' BETWEEN "'  + CONVERT(CHAR(8),@xFecha1,112) + '" AND "'  + CONVERT(CHAR(8),@xFecha2,112) + '"'
     EXEC (@Cadena)

   IF @@ERROR = 0 BEGIN

      SELECT @Cadena = ' DELETE FROM ' + LTRIM(RTRIM(@Tipo)) + LTRIM(RTRIM(@Tabla)) + ' WHERE ' + @Campo_Fecha + ' BETWEEN "'  + CONVERT(CHAR(8),@xFecha1,112) + '" AND "'  + CONVERT(CHAR(8),@xFecha2,112) + '"'      
        EXEC (@Cadena)

   END

   SET NOCOUNT OFF

END




GO
