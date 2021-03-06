USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_Datos_Porc_Computable]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Buscar_Datos_Porc_Computable]
            (   @codigo_canasta   NUMERIC(5)
            )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF EXISTS(SELECT 1 FROM PORCENTAJE_COMPUTABLE
             WHERE codigo_canasta = @codigo_canasta
            )
   BEGIN

      SELECT 'Intervalo'     = codigo_intervalo
         ,   'Rango_Desde'   = rango_desde
         ,   'Rango_Hasta'   = rango_hasta
         ,   'Porcentaje'    = porcentaje      
      FROM   PORCENTAJE_COMPUTABLE
      WHERE  codigo_canasta  = @codigo_canasta
      ORDER BY codigo_intervalo

   END ELSE BEGIN

      SELECT 'Intervalo'    = 1
         ,   'Rango_Desde'  = REPLICATE('0',6)
         ,   'Rango_Hasta'  = REPLICATE('0',6)
         ,   'Porcentaje'   = CONVERT(NUMERIC(10,4),0)
      INTO #TEMPORAL

      INSERT INTO #TEMPORAL
      SELECT 'Intervalo'    = 2
         ,   'Rango_Desde'  = REPLICATE('0',6)
         ,   'Rango_Hasta'  = REPLICATE('0',6)
         ,   'Porcentaje'   = CONVERT(NUMERIC(10,4),0)

      INSERT INTO #TEMPORAL
      SELECT 'Intervalo'    = 3
         ,   'Rango_Desde'  = REPLICATE('0',6)
         ,   'Rango_Hasta'  = REPLICATE('0',6)
         ,   'Porcentaje'   = CONVERT(NUMERIC(10,4),0)

      SELECT * FROM #TEMPORAL ORDER BY Intervalo

   END

END



GO
