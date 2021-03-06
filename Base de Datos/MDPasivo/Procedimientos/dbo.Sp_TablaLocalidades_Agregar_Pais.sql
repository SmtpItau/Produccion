USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Pais]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Pais] (
							@codigo_pais		NUMERIC(05)	,
							@nombre			VARCHAR(50)	,
							@codigo_pais_super	NUMERIC(05)	,
							@codigo_pais_Espana	NUMERIC(04)	
						   )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_pais, nombre FROM PAIS
		WHERE	codigo_pais	= @codigo_pais)
  	BEGIN
		INSERT INTO PAIS(codigo_pais		,
				nombre			,
				codigo_pais_super	,
				codigo_pais_Espana	)
		VALUES 		(@codigo_pais		,
				@nombre			,
				@codigo_pais_super	,
				@codigo_pais_Espana	)

	IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE
	   BEGIN

		SELECT 'OK'

	   END

   END ELSE
   BEGIN
	IF EXISTS(SELECT codigo_pais, nombre FROM PAIS
		WHERE	codigo_pais	= @codigo_pais)
  	BEGIN
		UPDATE PAIS SET	nombre = @nombre 					,
				codigo_pais_super 	=	@codigo_pais_super	,
				codigo_pais_Espana	=	@codigo_pais_Espana	
				where  	codigo_pais 	= 	@codigo_pais
	   END ELSE
	   BEGIN

	   	SELECT 'EXISTE'
	end	
	
   END

END


GO
