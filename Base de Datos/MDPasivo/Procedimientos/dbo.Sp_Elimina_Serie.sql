USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Serie]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Elimina_Serie]
                  (@xSerie  CHAR(12))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

   IF EXISTS(Select 1 FROM VIEW_MOVIMIENTO_TRADER WHERE momascara = @xSerie)  BEGIN
     SET NOCOUNT OFF
     SELECT 'NO'
     RETURN
   END

   DELETE TABLA_DESARROLLO WHERE tdmascara= @xSerie

   IF @@error <> 0 BEGIN
    SET NOCOUNT OFF
    SELECT 'NO'
    RETURN
   END

   DELETE SERIE WHERE seserie = @xSerie

   IF @@error <> 0 BEGIN
    SET NOCOUNT OFF
    SELECT 'NO'
    RETURN
   END
SET NOCOUNT OFF

SELECT 'SI'

END



GO
