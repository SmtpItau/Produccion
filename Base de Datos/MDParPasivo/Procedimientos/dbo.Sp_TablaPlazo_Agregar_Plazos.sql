USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaPlazo_Agregar_Plazos]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaPlazo_Agregar_Plazos](
				  	     	     @codigo_plazo   CHAR  (03),	
						     @Descripcion   varchar(50) 
						   )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_plazo, descripcion FROM PLAZO_PACTO
		WHERE	codigo_plazo	= @codigo_plazo)
  	BEGIN
		INSERT INTO PLAZO_PACTO(codigo_plazo,descripcion)
		VALUES (@codigo_plazo, @descripcion)

	IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE
	   BEGIN

		SELECT 'OK'

	   END

   END ELSE
   BEGIN
	IF EXISTS(SELECT codigo_plazo, descripcion FROM PLAZO_PACTO
		WHERE	codigo_plazo	= @codigo_plazo)
  	BEGIN
		UPDATE PLAZO_PACTO SET descripcion = @descripcion where  codigo_plazo = @codigo_plazo
	   END ELSE
	   BEGIN

	   	SELECT 'EXISTE'
	END

   END

END


GO
