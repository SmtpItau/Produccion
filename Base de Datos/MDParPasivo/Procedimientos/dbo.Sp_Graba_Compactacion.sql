USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Compactacion]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Graba_Compactacion]
               ( @Valores   VARCHAR(1500)
               , @TABLA     CHAR(25)
               )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @Cadena      CHAR(2000)
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

   INSERT INTO #GENERACION EXECUTE Sp_Compactacion_Datos
   DELETE FROM #GENERACION WHERE Tabla <> @Tabla

   SELECT @Tipo        = Tipo
        , @Campo_Fecha = Campo_fecha
     FROM #GENERACION 

   SELECT @Cadena  = 'INSERT INTO ' + LTRIM(RTRIM(@Tipo)) + LTRIM(RTRIM(@Tabla)) + ' VALUES (' + @Valores + ')'
   
   SELECT @Cadena

   EXEC (@Cadena)

END


GO
