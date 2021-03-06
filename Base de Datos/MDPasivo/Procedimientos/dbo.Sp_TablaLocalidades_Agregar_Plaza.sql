USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Plaza]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Plaza] (
				   			 @codigo_plaza    int,
                 		  			 @glosa		  varchar(10),
							 @nombre          varchar(50),
							 @codigo_pais     int
                                 		     )
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON
	
   	IF NOT EXISTS(SELECT codigo_plaza, codigo_pais FROM PLAZA
		WHERE	codigo_plaza	= @codigo_plaza)
  		BEGIN
		INSERT INTO PLAZA(codigo_plaza, glosa, nombre, codigo_pais)

		VALUES (@codigo_plaza, @glosa, @nombre, @codigo_pais)

		IF @@ERROR <> 0 
		   BEGIN
 
		   	SELECT 'ERROR'

		   END ELSE
		   BEGIN

			SELECT 'OK'

		   END

	   END ELSE
	   BEGIN
		IF EXISTS(SELECT codigo_plaza, codigo_pais FROM PLAZA
		WHERE	codigo_plaza = @codigo_plaza)
  		BEGIN

			UPDATE PLAZA SET nombre = @nombre, glosa = @glosa, codigo_pais = @codigo_pais  where codigo_plaza = @codigo_plaza
	   END ELSE
	   BEGIN
	   	SELECT 'EXISTE'
	   end
   END

END


GO
