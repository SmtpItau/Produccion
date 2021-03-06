USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PRIVILEGIOS_USUARIO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_PRIVILEGIOS_USUARIO]
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
	END
END


GO
