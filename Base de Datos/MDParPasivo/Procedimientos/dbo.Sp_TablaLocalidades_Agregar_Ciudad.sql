USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Ciudad]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Ciudad] (
						      @codigo_ciudad   int,
		     	 			      @codigo_region   int,		
				    		      @nombre          char(50) 
				   		     )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_ciudad FROM CIUDAD
		WHERE	codigo_ciudad	= @codigo_ciudad )
	  	BEGIN
		INSERT INTO CIUDAD (codigo_ciudad,codigo_region,nombre)
		VALUES (@codigo_ciudad  , @codigo_region, @nombre)

	END ELSE
		BEGIN
		IF EXISTS(SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD
			WHERE	codigo_ciudad	= @codigo_ciudad)
		  	BEGIN
			UPDATE CIUDAD SET nombre = @nombre, codigo_region = @codigo_region  where codigo_ciudad= @codigo_ciudad
	   END ELSE
	   BEGIN
	
		   	SELECT 'EXISTE'
	   END
   END


END


GO
