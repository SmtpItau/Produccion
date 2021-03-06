USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOS_GRABA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CREA_USUARIOS_GRABA]
       (
	@tipo          CHAR(15),
        @usuario       CHAR(15),
        @clave         CHAR(15),
        @nombre        CHAR(40),
        @tipo_usuario  CHAR(15),
        @fecha_expira  DATETIME,
        @tipo_clave    CHAR(01),
        @dias_exp      NUMERIC(05),
        @largo_clave   NUMERIC(02),  
        @clase         CHAR(02),
        @codigo_area   VARCHAR(05) = ' ',
	@email	 	CHAR(100)
       )
AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @i        NUMERIC(2)
	DECLARE @cont     NUMERIC(2)
	DECLARE @char     CHAR(50)
	DECLARE @rango    NUMERIC(03)
	DECLARE @sistema  CHAR(03)
	DECLARE @clave2   CHAR(15)
	DECLARE @clave3   CHAR(15)
	DECLARE @claveAnt CHAR(15)
	DECLARE @tipo_ant CHAR(15)


	IF @Tipo = 'B'
	BEGIN
		SELECT	nombre,
			tipo_usuario,
			CONVERT(CHAR(10), fecha_expira, 103),
			clave	,
			mail_usuario
		FROM	USUARIO
		WHERE	usuario = @usuario

	END ELSE IF @tipo = 'E'
	BEGIN 

		DELETE	PRIVILEGIO
		WHERE	usuario = @usuario
		AND	tipo_privilegio = 'U'

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC_01 FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
			SET NOCOUNT OFF
			RETURN 1
		END

		UPDATE	USUARIO
		SET	ACTIVO='N'
		WHERE	usuario = @usuario 
         
		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC_05 FALLA BORRANDO USUARIO.'
			SET NOCOUNT OFF
			RETURN 1

		END     

	END ELSE IF @Tipo = 'G'
	BEGIN 

		IF EXISTS( SELECT * FROM USUARIO  WHERE usuario = @usuario )
		BEGIN
			SELECT	@claveAnt = ISNULL( clave, @clave ),
				@clave2   = ISNULL( clave_anterior2, @clave),
				@clave3   = ISNULL( clave_anterior3, @clave),
				@tipo_ant = tipo_usuario
			FROM	USUARIO
			WHERE	usuario = @usuario

			UPDATE	USUARIO
			SET	usuario         = @usuario,
				nombre          = @nombre,
				tipo_usuario    = @tipo_usuario,
				fecha_expira    = @fecha_expira,
				cambio_clave    = 'S',
				clave_anterior1 = @clave2,
				clave_anterior2 = @clave3,
				clave_anterior3 = @claveAnt,
				clave           = @clave,
				tipo_clave      = @tipo_clave,
				dias_expiracion = @dias_exp,
				largo_clave     = @largo_clave,
				clase           = @clase,
				codigo_area     = @codigo_area,
				mail_usuario    = @email
			WHERE	usuario         = @usuario

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC_06 FALLA AGREGANDO USUARIO.'
				SET NOCOUNT OFF
				RETURN 1
			END


			IF @tipo_ant <> @tipo_usuario
	 		BEGIN

				DELETE	PRIVILEGIO
				WHERE	tipo_privilegio = 'U'
				AND	usuario = @usuario


/*				INSERT INTO PRIVILEGIO (
					tipo_privilegio,
					usuario,
					entidad,
					opcion,
					habilitado)
				SELECT	'U',
					@usuario,
					PRIVILEGIO.entidad,
					PRIVILEGIO.opcion,
					PRIVILEGIO.habilitado 
				FROM	PRIVILEGIO,
					MENU
				WHERE	PRIVILEGIO.tipo_privilegio = 'T'
				AND	PRIVILEGIO.usuario	= @tipo_usuario
				AND	PRIVILEGIO.entidad	= MENU.entidad
				AND	PRIVILEGIO.opcion	= MENU.nombre_objeto
*/

			END

		END ELSE BEGIN

			SELECT @i=0   
			SELECT @char = 'PCATESBCCBFWBTRLIMPCSSCFSGF'   
			SELECT @rango= 3      
			SELECT @cont = COUNT(*) FROM SISTEMA
			SELECT @sistema = RIGHT (RTRIM(@char),@rango)
			SELECT @sistema = LEFT(LTRIM(@sistema),3)

			INSERT INTO USUARIO ( 
				usuario,
				nombre,
				tipo_usuario,
				fecha_expira,
				cambio_clave,
				clave_anterior1,
				clave_anterior2,
				clave_anterior3,
				clave,
				tipo_clave,
				dias_expiracion,
				largo_clave,
				clase,
				codigo_area,
				mail_usuario)
			VALUES(	@usuario,
				@nombre,
				@tipo_usuario, --- + LTRIM(STR(@I)),
				@fecha_expira,
				'S',
				ISNULL( @clave2, ' ' ),
				ISNULL( @clave3, ' ' ),
				ISNULL( @claveAnt, ' ' ),
				ISNULL( @clave, ' ' ),
				@tipo_clave,    
				@dias_exp,      
				@largo_clave,   
				@clase,
				@codigo_area,
				@email)

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC_07 FALLA AGREGANDO USUARIO.'
				SET NOCOUNT OFF
				RETURN 1
			END


/*
			INSERT INTO PRIVILEGIO (
				tipo_privilegio,
				usuario,
				entidad,
				opcion,
				habilitado)
			SELECT	'U',
				@usuario,
				PRIVILEGIO.entidad,
				PRIVILEGIO.opcion,
				PRIVILEGIO.habilitado 
			FROM	PRIVILEGIO,
				MENU
			WHERE	PRIVILEGIO.tipo_privilegio = 'T'
			AND	PRIVILEGIO.usuario	= @tipo_usuario
			AND	PRIVILEGIO.entidad	= MENU.entidad
			AND	PRIVILEGIO.opcion	= MENU.nombre_objeto

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC_09 FALLA AGREGANDO USUARIO.'
				SET NOCOUNT OFF
				RETURN 1
			END
*/


		END

	END

END
-- SELECT * FROM PRIVILEGIO WHERE USUARIO = 'MQUILODRAN' AND entidad ='BTR'
-- SELECT * FROM PRIVILEGIO WHERE USUARIO = 'FRONTOFFICE' AND entidad ='BTR'

GO
