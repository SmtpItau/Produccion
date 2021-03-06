USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PRIVILEGIOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_PRIVILEGIOS]( @Tipo            CHAR(1)  ,
                                  @Tipo_Privilegio CHAR(1)  ,
                                  @Usuario         CHAR(15) ,
                                  @Entidad         CHAR(3)  ,
                                  @Opcion          CHAR(20) ,
                                  @Habilitado      CHAR(1)  )
AS
BEGIN

	SET NOCOUNT ON
	IF @Tipo = 'E'
		BEGIN    
			DELETE 	gen_privilegios 
			WHERE 	usuario         = @Usuario 
				AND tipo_privilegio = @Tipo_Privilegio
				AND entidad         = @Entidad

			IF @@ERROR <> 0
				BEGIN
					PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
					RETURN 1
				END

		END

	IF @Tipo = 'G'
		BEGIN
			INSERT 	gen_privilegios( 	tipo_privilegio	,
							usuario		,
							entidad		,
							opcion 		,
							habilitado 
						)
			VALUES( @Tipo_Privilegio,
				@Usuario	,
                           	@Entidad	,
				@Opcion 	,
				@Habilitado 
			      )

			IF @Tipo_Privilegio = 'T'
				BEGIN
					UPDATE 	gen_privilegios
					SET 	tipo_privilegio = 'T'		,
						habilitado  = 'S'
					FROM	usuario
					WHERE 	@Opcion 		= gen_privilegios.opcion	AND
						@entidad 		= gen_privilegios.entidad	AND
						usuario.tipo_usuario 	= @Usuario 			AND
						usuario.usuario    	= gen_privilegios.usuario 
				END

			IF @@ERROR <> 0
				BEGIN
					PRINT 'ERROR_PROC FALLA AGREGANDO PRIVILEGIOS DE USUARIO.'
					RETURN 1
				END
		END

	RETURN 0

END   /* FIN PROCEDIMIENTO */

-- SELECT * into tmp_gen_privilegios FROM GEN_PRIVILEGIOS
-- select * from 
GO
