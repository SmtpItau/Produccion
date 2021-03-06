USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Region]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Region] (
				   			 @codigo_region   int,
                 		  			 @codigo_pais     int,
							 @nombre          varchar(50)
                                 		     )
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_region,codigo_pais, nombre FROM REGION
		WHERE	codigo_region	= @codigo_region)
  		BEGIN
		INSERT INTO REGION(Codigo_region, codigo_pais, nombre)

		VALUES (@codigo_region, @codigo_pais, @nombre)

		IF @@ERROR <> 0 
		   BEGIN
 
		   	SELECT 'ERROR'

		   END ELSE
		   BEGIN

			SELECT 'OK'

		   END

	   END ELSE
	   BEGIN
		IF EXISTS(SELECT codigo_region,codigo_pais, nombre FROM REGION
		WHERE	codigo_region	= @codigo_region)
  		BEGIN

			UPDATE REGION SET nombre = @nombre, codigo_pais = @codigo_pais where codigo_region= @codigo_region
	   END ELSE
	   BEGIN
	   	SELECT 'EXISTE'
	   end
   END

END


GO
