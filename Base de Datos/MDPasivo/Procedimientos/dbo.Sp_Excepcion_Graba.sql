USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Excepcion_Graba]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Excepcion_Graba]
		(
		@cUsuario		CHAR(15),
		@id_sistema		CHAR(03),
		@codigo_producto	CHAR(05),
		@cUsuario_Subroga	CHAR(15),
		@cEstado		CHAR(01)
		)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	IF EXISTS(SELECT 1 FROM EXCEPCION_USUARIO
				WHERE	usuario		= @cUsuario	AND
					id_sistema	= @id_sistema	AND
					codigo_producto	= @codigo_producto)BEGIN

		UPDATE EXCEPCION_USUARIO
			SET estado          = @cEstado,
			    usuario_subroga = @cUsuario_Subroga
			WHERE	usuario		= @cUsuario	AND
				id_sistema	= @id_sistema	AND
				codigo_producto	= @codigo_producto
	END ELSE BEGIN
		INSERT INTO EXCEPCION_USUARIO
			(
			Usuario		,
			id_sistema		,
			codigo_producto	,
			Usuario_Subroga	,
			Estado
			)
		VALUES
			(
			@cUsuario		,
			@id_sistema		,
			@codigo_producto	,
			@cUsuario_Subroga	,
			@cEstado
			)
	END
SET NOCOUNT OFF
END




GO
