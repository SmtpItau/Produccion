USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limpia_TablaDesarrollo]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Limpia_TablaDesarrollo]
               (@xMascara	CHAR(12))
AS
BEGIN
   
      SET NOCOUNT ON
      SET DATEFORMAT dmy

      DELETE TABLA_DESARROLLO WHERE tdmascara = @xMascara


      SELECT "OK"
      SET NOCOUNT OFF
END








GO
