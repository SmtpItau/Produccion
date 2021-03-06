USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PRIVILEGIOS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PRIVILEGIOS]
       (
        @Tipo            CHAR(01),
        @Tipo_Privilegio CHAR(01),
        @Usuario         CHAR(15),
        @Entidad         CHAR(03),
        @Opcion          CHAR(30),
        @Habilitado      CHAR(01)
       )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @SW_Habilitado	CHAR(1)
   DECLARE @Tipo_Usuario        CHAR(15)


   IF @Tipo = 'E' BEGIN 

      DELETE PRIVILEGIO WHERE usuario         = @Usuario           AND
                              tipo_privilegio = @Tipo_Privilegio   AND
                              entidad         = @Entidad
      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
         RETURN 1

      END

   END

   IF @Tipo = 'G'
   BEGIN

	IF @Tipo_Privilegio = 'T'
	BEGIN
		INSERT INTO	PRIVILEGIO(
				tipo_privilegio	,
				usuario		,
				entidad		,
				opcion		,
				habilitado	)
		VALUES(		@Tipo_Privilegio,
				@Usuario	,
				@Entidad	,
				@Opcion		,
				@Habilitado	)

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA AGREGANDO PRIVILEGIOS DE TIPO DE USUARIO.'
			RETURN 1
		END
	END
	ELSE
	BEGIN

		SELECT @SW_Habilitado = 'N'
		SELECT @Tipo_Usuario = Tipo_Usuario FROM usuario WHERE usuario = @Usuario


		SELECT	@SW_Habilitado = habilitado
		FROM	PRIVILEGIO
		WHERE	tipo_privilegio	= 'T'
		AND	usuario		= @Tipo_Usuario
		AND	entidad		= @Entidad
		AND	opcion		= @Opcion


		IF @SW_Habilitado <> @Habilitado
		BEGIN

			INSERT INTO	PRIVILEGIO(
					tipo_privilegio	,
					usuario		,
					entidad		,
					opcion		,
					habilitado	)
			VALUES(		@Tipo_Privilegio,
					@Usuario	,
					@Entidad	,
					@Opcion		,
					@Habilitado	)

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC FALLA AGREGANDO PRIVILEGIOS DE TIPO DE USUARIO.'
				RETURN 1
			END
		END

	END


   END

END

GO
