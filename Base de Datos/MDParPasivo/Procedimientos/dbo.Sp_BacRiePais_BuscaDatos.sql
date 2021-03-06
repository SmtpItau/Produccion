USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_BuscaDatos]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_BuscaDatos]
         (
              @codigo		NUMERIC (5)
	  ,   @nombre		CHAR   (50)
         )

AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

	IF EXISTS (SELECT 1 FROM RIESGO_PAIS WHERE codigo_pais=@codigo AND nombre = @nombre) BEGIN

		SELECT 	
			codigo_pais,
			nombre,
			porcentaje,
			totalasignado,
			totalocupado,
			totaldisponible,
			totalexceso

		FROM RIESGO_PAIS WHERE codigo_pais=@codigo AND nombre = @nombre 

	END

	ELSE BEGIN

		SELECT "ERROR"

	END

	SET NOCOUNT OFF

END









GO
