USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Region]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Region](@codigo_region int,
						     @nombre	    char(50)
						    )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	IF NOT EXISTS(SELECT 1 FROM CLIENTE
	   WHERE  Clcodfox = @codigo_region)
    	   BEGIN
		 
		SELECT Ciudad = codigo_Ciudad 
		INTO #CIUDAD
		FROM CIUDAD 
		WHERE codigo_region = @codigo_region

		SELECT Comuna = codigo_comuna 
		INTO #COMUNA
		FROM COMUNA , #CIudad
		WHERE codigo_ciudad = Ciudad	  		

		   DELETE COMUNA FROM #COMUNA WHERE Codigo_comuna = comuna 	
		   DELETE CIUDAD WHERE  codigo_region   = @codigo_region	
	   	   DELETE REGION WHERE	codigo_region	= @codigo_region

        END ELSE
	   BEGIN

	   	   SELECT 'RELACIONADA'

	END

   SET NOCOUNT ON
END


GO
