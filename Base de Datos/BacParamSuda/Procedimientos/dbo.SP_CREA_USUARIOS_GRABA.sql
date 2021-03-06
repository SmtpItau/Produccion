USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOS_GRABA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CREA_USUARIOS_GRABA]
   (	@tipo			CHAR(15)
   ,	@usuario		CHAR(15)
   ,	@clave			CHAR(15)
   ,	@nombre			CHAR(40)
   ,	@tipo_usuario	CHAR(15)
   ,	@fecha_expira	DATETIME
   ,	@tipo_clave		CHAR(1)
   ,	@dias_exp		NUMERIC(5)
   ,	@largo_clave	NUMERIC(2)
   ,	@clase			CHAR(2)
   ,	@reset_psw		CHAR(1)
   ,	@rut			CHAR(12)    = ''
   ,	@codigomesa		SMALLINT    = 0
   ,	@cModCla		CHAR(1)     = ''
   ,    @Email			VARCHAR(50)	= ''
   ,	@Trader			CHAR(1)     = 'N'
   )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @i				NUMERIC(2)
	DECLARE @cont			NUMERIC(2)
	DECLARE @char			CHAR(50)
	DECLARE @rango			NUMERIC(3)
	DECLARE @sistema		CHAR(3)
	DECLARE @clave2			CHAR(15)
	DECLARE @clave3			CHAR(15)
	DECLARE @clave4			CHAR(15)
	DECLARE @clave5			CHAR(15)
	DECLARE @clave1			CHAR(15)
	DECLARE @NuevaClave		CHAR(15)
   
	-->	Se Agrego por correccion al Email
	set @Trader = case when charindex('TRADER', upper(@tipo_usuario),1) > 0 then 'S' else 'N' end
	set @Email	= lower(@Email)
	-->	Se Agrego por correccion al Email

   /*Asignación Id para Turing*/
	DECLARE @idTuring		int
	select	@idTuring = dbo.fnObtieneIdTuring()

	-->     Buscando o Consulta
	IF @Tipo = 'B'
		SELECT nombre       = nombre
		,      tipo_usuario = tipo_usuario
		,      fecha_expira = CONVERT(CHAR(10), fecha_expira, 103)
		,      clave        = clave
		FROM   USUARIO
		WHERE  usuario      = @usuario

	-->     Determinando el tipo de usuario original
	DECLARE @TipUser_Original   CHAR(15)
		SET @TipUser_Original   = ISNULL((SELECT ISNULL(tipo_usuario, '') FROM BacParamSuda.dbo.USUARIO WHERE usuario = @usuario), '')

	-->     En caso de Elimimnacion o Grabacion
	IF (@tipo = 'E' OR @tipo = 'G') 
	BEGIN
		-->   Cambio de Clave
		IF @cModCla = 'S'	
		BEGIN
			SET @clave1     = ISNULL((SELECT clave           FROM USUARIO WHERE usuario = @usuario), '')
			SET @clave2     = ISNULL((SELECT clave_anterior1 FROM USUARIO WHERE usuario = @usuario), '')
			SET @clave3     = ISNULL((SELECT clave_anterior2 FROM USUARIO WHERE usuario = @usuario), '')         
			SET @clave4     = ISNULL((SELECT Clave_Anterior3 FROM USUARIO WHERE usuario = @usuario), '')
			SET @clave5     = ISNULL((SELECT Clave_Anterior4 FROM USUARIO WHERE usuario = @usuario), '')
			SET @NuevaClave = @Clave
		END

		IF @tipo = 'G'  
		BEGIN
			IF @cModCla = 'S'
			BEGIN
				IF (@NuevaClave = @clave1 OR @NuevaClave = @clave2 OR @NuevaClave = @clave3 OR @NuevaClave = @clave4 OR @NuevaClave = @clave5) 
				BEGIN
					SELECT -1, 'Clave ha sido usada anteriormente'
					RETURN -1
				END 

				IF @clave = '' 
				BEGIN
					SELECT -1, 'Debe Ingresar Clave.'
					RETURN -1
				END 
      
				IF (LEN(LTRIM(RTRIM(@clave))) < @largo_clave)
				BEGIN
					SELECT -1, 'La clave debe tener como minimo un largo de ' + cast(@largo_clave as varchar)
					RETURN -1
				END
			END --> @cModCla = 'S'
      
			IF (@dias_exp < 1)
			BEGIN
				SELECT -1, 'Dias de expiración no deben ser menor a 1 dias.'
				RETURN -1
			END 
			IF (@dias_exp > 60)
			BEGIN
				SELECT -1, 'Dias de expiración no deben ser mayor a 60 dias.'
				RETURN -1
			END 
			IF LTRIM(RTRIM(@nombre)) = '' 
			BEGIN
				SELECT -1, 'Debe Ingresar Nombre Usuario.'
				RETURN -1
			END 
			IF LTRIM(RTRIM(@nombre)) = ltrim(rtrim(@clave))
			BEGIN
				SELECT -1, 'Clave no puede ser igual al Nombre de Usuario.'
				RETURN -1
			END
		END --> @tipo = 'G'

		IF @tipo <> 'G' --> = 'E'
		BEGIN
			DELETE FROM MATRIZ_ATRIBUCION_INSTRUMENTO  WHERE usuario = @usuario 
			DELETE FROM MATRIZ_ATRIBUCION              WHERE usuario = @usuario 
			DELETE FROM USUARIO_ACTIVO                 WHERE usuario = @usuario  
			DELETE FROM CONTROL_USUARIO                WHERE usuario = @usuario  
			DELETE FROM USUARIO                        WHERE usuario = @usuario 
		END ELSE
		BEGIN	 
			IF EXISTS(SELECT 1 FROM USUARIO WHERE usuario = @usuario) 
			BEGIN
				IF @cModCla = 'S'  -->SI MODIFICA LA CLAVE
				BEGIN
					UPDATE USUARIO 
					SET    usuario          = @usuario
					,      nombre           = @nombre
					,      tipo_usuario     = @tipo_usuario
					,      fecha_expira     = @fecha_expira
					,      cambio_clave     = 'S'
					,      clave            = @clave
					,      clave_anterior1  = @clave1
					,      clave_anterior2  = @clave2
					,      clave_anterior3  = @clave3
					,      clave_anterior4  = @clave4
					,      clave_anterior5  = @clave5	
					,      tipo_clave       = @tipo_clave
					,      dias_expiracion  = @dias_exp
					,      largo_clave      = @largo_clave
					,      clase            = @clase
					,      reset_psw        = @reset_psw 
					,      Trader           = @Trader
					,      rutusuario       = @rut
					,      codigomesa       = @codigomesa
					,	   email			= @Email				-->	Se Agrego por correccion al Email
					WHERE  usuario          = @usuario
				END ELSE
				BEGIN
					UPDATE	USUARIO 
					SET		usuario          = @usuario
					,		nombre           = @nombre
					,		tipo_usuario     = @tipo_usuario
					,		fecha_expira     = @fecha_expira
					,		tipo_clave       = @tipo_clave
					,		dias_expiracion  = @dias_exp
					,		largo_clave      = @largo_clave
					,		clase            = @clase
					,		reset_psw        = @reset_psw 
					,		Trader           = @Trader
					,		rutusuario       = @rut
					,		codigomesa       = @codigomesa
					,		email			 = @Email				-->	Se Agrego por correccion al Email
					WHERE	usuario          = @usuario
				END -->  @cModCla = 'S'
			END    -->  IF EXISTS 
		END       -->  @tipo <> 'G'

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA BORRANDO USUARIO.'
			RETURN 1
		END

		IF @tipo = 'E'
		BEGIN
			DELETE	FROM	GEN_PRIVILEGIOS 
					WHERE	usuario = @usuario AND tipo_privilegio = 'U'

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
				RETURN 1
			END
		END
	END   --> (@tipo = 'E' OR @tipo = 'G')


	IF @Tipo = 'G' 
	BEGIN
		IF @tipo_usuario <> @TipUser_Original
		BEGIN
			-->    Elimina Privilegios especiales a usuarios por cambio de Tipo de Usuario
			DELETE	FROM	BacParamSuda.dbo.GEN_PRIVILEGIOS
					WHERE	usuario         = @usuario
					AND		tipo_privilegio = 'U'

			-->    Asigna los privilegios por tipo, como privilegio por usuario, creando un 'Valor por Defecto'
			INSERT INTO BacParamSuda.dbo.GEN_PRIVILEGIOS
			SELECT	tipo_privilegio = 'U'
			,		usuario         = @usuario
			,		entidad         = entidad
			,		opcion          = opcion
			,		habilitado      = habilitado
			FROM	BacParamSuda.dbo.GEN_PRIVILEGIOS
			WHERE	tipo_privilegio = 'T' 
			AND		usuario         = @tipo_usuario
		END

		SET @i       = 0   
		SET @cont    = (SELECT COUNT(*) FROM SISTEMA_CNT) 
		SET @char    = 'PCATESBCCBFWBTRLIMPCSSCF'   
		SET @rango   = 3
		SET @sistema = RIGHT(RTRIM( @char   ), @rango)
		SET @sistema = LEFT (LTRIM( @sistema), 3)

		--> SE AGREGO 06-10-2010..... ¿ QUE HACE ESTA TABLA ... DONDE SE OCUPA... PARA QUE SE OCUPA ... ?
		IF EXISTS(SELECT 1 FROM CONTROL_USUARIO WHERE usuario = @usuario) 
		BEGIN
			DELETE FROM CONTROL_USUARIO WHERE usuario = @usuario 
		END
		--> SE AGREGO 06-10-2010..... ¿ QUE HACE ESTA TABLA ... DONDE SE OCUPA... PARA QUE SE OCUPA ... ?

		IF NOT EXISTS(SELECT 1 FROM CONTROL_USUARIO WHERE usuario = @usuario AND id_sistema = @sistema ) 
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM USUARIO  WHERE usuario = @usuario) 
			BEGIN
				INSERT INTO USUARIO
				(   usuario
				,   nombre
				,   tipo_usuario
				,   fecha_expira
				,   cambio_clave
				,   clave_anterior1
				,   clave_anterior2
				,   clave_anterior3
				,   clave_anterior4
				,   clave_anterior5
				,   clave
				,   tipo_clave
				,   dias_expiracion
				,   largo_clave
				,   clase
				,   reset_psw
				,   Trader
				,   rutusuario
				,   codigomesa
				,	email						-->	Se Agrego por correccion al Email
				,   idTuring
				)
				VALUES
				(   @usuario
				,   @nombre
				,   @tipo_usuario       --- + LTRIM(STR(@I))
				,   @fecha_expira
				,   'S'
				,   @clave1
				,   @clave2
				,   @clave3
				,   @clave4
				,   @clave5
				,   @clave
				,   @tipo_clave
				,   @dias_exp
				,   @largo_clave
				,   @clase
				,   @reset_psw
				,   @Trader
				, 	@rut
				,   @codigomesa
				,   @Email						-->	Se Agrego por correccion al Email
				,   @idTuring
				)
			END  

            INSERT INTO CONTROL_USUARIO
            (   usuario
            ,   id_sistema
            ,   nombre
            ,   terminal
            ,   bloqueado
            )
            VALUES
            (   @usuario
            ,   @sistema
            ,   @nombre
            ,   '000000'
            ,   'N' 
            )
		END

		WHILE @i <= @cont
		BEGIN
			SET @sistema = RIGHT (RTRIM(@char),@rango)
			SET @sistema = LEFT(LTRIM(@sistema),3)

			IF (SELECT operativo FROM SISTEMA_CNT WHERE id_sistema = @sistema) = 'S' 
			BEGIN
				IF NOT EXISTS(SELECT 1 FROM CONTROL_USUARIO  WHERE usuario = @usuario AND id_sistema = @sistema ) 
				BEGIN 

					SELECT @sistema
					,      @i
					,      @cont
					,      @char
					,      @rango
					,      @usuario + LTRIM(STR(@i))
					
					INSERT CONTROL_USUARIO
					(   usuario
					,   id_sistema
					,   nombre
					,   terminal
					,   bloqueado
					)
					VALUES
					(   @usuario ---RTRIM(@USUARIO) + LTRIM(STR(@I)),
					,   @sistema
					,   @nombre
					,   '000000'
					,   'N' 
					)
				END
			END

			SET @i=@i +1
			SET @rango = @rango + 3
		END

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
			RETURN 1
		END
	END

	RETURN 0

END
GO
