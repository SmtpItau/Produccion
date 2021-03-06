USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Comuna]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Comuna] (
				    			@codigo_comuna   int,
				    			@codigo_ciudad   int,		
				    			@nombre          char(50) 
				   		     )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA
		WHERE	codigo_comuna	= @codigo_comuna)
	  	BEGIN	
		INSERT INTO COMUNA (codigo_comuna,codigo_ciudad,nombre)
		VALUES (@codigo_comuna, @codigo_ciudad, @nombre)

		IF @@ERROR <> 0 
		   BEGIN
 
		   	SELECT 'ERROR'

		   END ELSE
		   BEGIN

			SELECT 'OK'

		   END

	   END ELSE
	   BEGIN
		IF EXISTS(SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA
			WHERE	codigo_comuna	= @codigo_comuna)
	  		BEGIN	
			UPDATE COMUNA SET nombre = @nombre, codigo_ciudad = @codigo_ciudad where codigo_comuna= @codigo_comuna
		   END ELSE
		   BEGIN

			   	SELECT 'EXISTE'
	      	   END	
    END

END


GO
