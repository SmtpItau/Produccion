USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Plaza]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Plaza](@codigo_plaza INT)
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   IF NOT EXISTS(SELECT Codigo_Plaza FROM CORRESPONSAL 
		      WHERE  Codigo_Plaza = @codigo_plaza)
   BEGIN	

           DELETE FERIADO WHERE plaza = @codigo_plaza
   	   DELETE PLAZA WHERE	codigo_plaza	= @codigo_plaza
	
   END ELSE
   BEGIN
   	SELECT 'RELACIONADA'
   END

END


GO
