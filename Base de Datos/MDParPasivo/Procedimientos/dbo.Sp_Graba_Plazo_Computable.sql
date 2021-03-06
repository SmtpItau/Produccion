USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Plazo_Computable]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Graba_Plazo_Computable]
   (   @codigo_intervalo  NUMERIC(5)
   ,   @codigo_canasta    NUMERIC(5)
   ,   @rango_desde       CHAR(06)
   ,   @rango_hasta       CHAR(06)
   ,   @porcentaje        NUMERIC(10,4)
   )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy
 
   UPDATE PORCENTAJE_COMPUTABLE
   SET    porcentaje       = @porcentaje
     ,    rango_desde      = @rango_desde
     ,    rango_hasta      = @rango_hasta
   WHERE  codigo_canasta   = @codigo_canasta
     AND  codigo_intervalo = @codigo_intervalo
   
   IF @@ERROR = 0
   BEGIN

      SELECT 0 , 'Grabación Exitosa'

   END ELSE BEGIN

      SELECT -1 , 'Problemas en la Grabación'

   END

   SET NOCOUNT OFF

END   



GO
