USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PRIVILEGIOS_TIPO_USUARIO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_PRIVILEGIOS_TIPO_USUARIO]
						(
						@ctipo			CHAR(01)	,
						@ctipo_Privilegio	CHAR(01)	,
						@cusuario		CHAR(15)	,
						@centidad		CHAR(03)	,
						@copcion		CHAR(30)	,
						@chabilitado		CHAR(01)
						)
AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @ncontador_1	INTEGER
	DECLARE @ncontador_2	INTEGER
	DECLARE	@cusuarios	CHAR(15)

	IF @ctipo = 'E' 
	BEGIN 
		DELETE PRIVILEGIO 
		WHERE	usuario		= @cusuario		AND
			tipo_privilegio	= @ctipo_Privilegio	AND
			entidad		= @centidad

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
			RETURN 1
		END

		CREATE TABLE #Temp_Usuario_Privilegio_1 
							(
							usuario		CHAR(15)		,
							contador	int IDENTITY (1,1)
							)

		INSERT	INTO #Temp_Usuario_Privilegio_1
		SELECT	usuario	
		FROM	USUARIO WHERE tipo_usuario = @cusuario

		SELECT @ncontador_2 = (SELECT COUNT(*) FROM #Temp_Usuario_Privilegio_1)
		SELECT @ncontador_1 = 1


		WHILE @ncontador_1 <= @ncontador_2
		BEGIN
			SELECT	@cusuarios = usuario
			FROM	#Temp_Usuario_Privilegio_1
			WHERE	contador = @ncontador_1

			
			DELETE PRIVILEGIO 
			WHERE	usuario		= @cusuarios 		AND
				tipo_privilegio	= 'U'			AND
				entidad		= @centidad
	
			SELECT @ncontador_1 = @ncontador_1 + 1
		END	

	END

	IF @ctipo = 'G'
	BEGIN
		INSERT INTO PRIVILEGIO	(
					tipo_privilegio		,
					usuario			,
					entidad			,
					opcion			,
					habilitado
					)
		VALUES			(
					@ctipo_Privilegio	,
					@cusuario		,
					@centidad		,
					@copcion		,
					@chabilitado
					)
		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA AGREGANDO PRIVILEGIOS DE USUARIO.'
			RETURN 1
		END


		CREATE TABLE #Temp_Usuario_Privilegio_2 
							(
							usuario		CHAR(15)		,
							contador	int IDENTITY (1,1)
							)

		INSERT	INTO #Temp_Usuario_Privilegio_2 
		SELECT	usuario	
		FROM	USUARIO WHERE tipo_usuario = @cusuario

		SELECT @ncontador_2 = (SELECT COUNT(*) FROM #Temp_Usuario_Privilegio_2)
		SELECT @ncontador_1 = 1


		WHILE @ncontador_1 <= @ncontador_2
		BEGIN
			SELECT	@cusuarios = usuario
			FROM	#Temp_Usuario_Privilegio_2
			WHERE	contador = @ncontador_1

			
		INSERT INTO PRIVILEGIO	(
					tipo_privilegio		,
					usuario			,
					entidad			,
					opcion			,
					habilitado
					)
		VALUES			(
					'U'			,
					@cusuarios		,
					@centidad		,
					@copcion		,
					@chabilitado
					)
	
			SELECT @ncontador_1 = @ncontador_1 + 1
		END	

	END
END


GO
