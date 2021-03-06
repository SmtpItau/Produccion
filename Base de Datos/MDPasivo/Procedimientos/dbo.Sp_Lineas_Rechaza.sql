USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Rechaza]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Rechaza]
			(
			@dFecha		DATETIME	,
			@Id_sistema	CHAR   (10)	,
			@nNumoper	NUMERIC(10)	,
			@cOperador_Ap	CHAR   (15)	,
			@cOperador_Chq	CHAR   (15)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE	@GlosaExcepcion           VARCHAR(100)
	DECLARE	@Numero_Operacion         NUMERIC(10)
	DECLARE	@Numero_Documento         NUMERIC(10)
	DECLARE	@Numero_Correlativo       NUMERIC(10)
	DECLARE	@Rut_Cliente              NUMERIC(09)
	DECLARE	@Codigo_Cliente           NUMERIC(09)
	DECLARE	@Numero_Traspaso          NUMERIC(10)
	DECLARE	@Codigo_Producto          CHAR(05)
	DECLARE	@Tipo_Operacion           CHAR(05)
	DECLARE	@Codigo_Excepcion         CHAR(02)
	DECLARE	@Operador                 CHAR(15)
	DECLARE	@cCodigo_Grupo		  CHAR(10)
	DECLARE	@xCodigo_Grupo		  CHAR(10)
	DECLARE	@Contador                 INTEGER
	DECLARE	@Total                    INTEGER
	DECLARE	@Monto_Autorizado         FLOAT

	/********************************************************************************************/
	/**************** LINEAS DE CLIENTES ********************************************************/
	/********************************************************************************************/

	IF EXISTS(SELECT 1 FROM LINEA_TRANSACCION WITH (NOLOCK) WHERE NumeroOperacion = @nNumoper	 AND
							Id_sistema	= @Id_sistema    AND
							Operador	= @cOperador_Chq) --AND
--							FechaInicio	= @dFecha)
		BEGIN
		SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No puede rechazar una operacion realizada por el mismo'
		RETURN
	END

	IF EXISTS(SELECT 1 FROM LIMITE_TRANSACCION  WITH (NOLOCK) WHERE NumeroOperacion = @nNumoper	  AND
							 Id_sistema	 = @Id_sistema    AND
							 Operador	 = @cOperador_Chq) --AND
--							 FechaOperacion  = @dFecha)
		BEGIN
		SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No puede rechazar una operacion realizada por el mismo'
		RETURN
	END


	SELECT @Contador = 1
	SELECT @Total = COUNT(1) FROM LINEA_TRANSACCION_DETALLE  WITH (NOLOCK) WHERE NumeroOperacion = @nNumoper AND Id_sistema = @Id_sistema



	WHILE @Contador <= @Total BEGIN
		SET ROWCOUNT @Contador
		SELECT	@nNumoper	    = NumeroOperacion	,
			@Numero_Documento   = NumeroDocumento	,
			@Numero_Correlativo = NumeroCorrelativo	,
			@Numero_Traspaso    = 0			,
			@Codigo_Producto    = Codigo_Producto	,
			@Tipo_Operacion     = ' '		,
			@Operador           = ' '		,
			@Monto_Autorizado   = MontoTransaccion	,
			@Codigo_Excepcion   = 'RE'		,
			@xCodigo_Grupo	    = Codigo_Grupo
		FROM	LINEA_TRANSACCION_DETALLE  WITH (NOLOCK)
		WHERE	NumeroOperacion = @nNumoper	AND
			Id_sistema	= @Id_sistema


		SET ROWCOUNT 0
	
			SELECT	@Rut_Cliente	= Rut_Cliente	,
				@Codigo_Cliente = Codigo_Cliente,
				@Tipo_Operacion = ' '
			FROM	LINEA_TRANSACCION  WITH (NOLOCK)
			WHERE	NumeroOperacion  = @nNumoper
			AND	Id_sistema       = @Id_sistema
			AND	NumeroDocumento	 = @Numero_Documento
			AND	NumeroCorrelativo= @Numero_Correlativo



			SELECT	@Tipo_Operacion = Tipo_Operacion 	,
				@Operador       = Operador
			FROM	LINEA_TRANSACCION  WITH (NOLOCK)
			WHERE	NumeroOperacion = @nNumoper
			AND	Id_sistema      = @Id_sistema
			AND	NumeroDocumento	 = @Numero_Documento
			AND	NumeroCorrelativo= @Numero_Correlativo

			SELECT @Contador = @Contador + 1

			IF NOT  EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	      = @cOperador_Chq	 AND
									     Id_sistema	      = @Id_sistema      AND
									     Codigo_Producto  = @Codigo_Producto) OR
				EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	      = @cOperador_Chq	 AND
									     Id_sistema	      = @Id_sistema      AND
									     Codigo_Producto  = @Codigo_Producto AND
									     estado	      = 'N')           BEGIN

				SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No tiene atribuciones asignadas para rechazar esta operación.'
				RETURN
			END

			IF EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE  WITH (NOLOCK) WHERE usuario		 = @cOperador_Chq   AND
										Id_sistema	 = @Id_sistema      AND
										Codigo_Producto  = @Codigo_Producto AND
										codigo_excepcion = 'RE'		    AND
										estado		 = 'N') BEGIN
					SELECT @GlosaExcepcion = mensaje FROM EXCEPCION  WITH (NOLOCK) WHERE codigo_excepcion = 'RE'
					SELECT @GlosaExcepcion = ISNULL(@GlosaExcepcion,' ')

					SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', ' + @GlosaExcepcion
					RETURN
			END



		IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION  WITH (NOLOCK) WHERE numerooperacion  = @nNumoper	AND
 								     Codigo_sistema   = @Id_sistema     AND
								     codigo_excepcion = @Codigo_Excepcion)
			INSERT LINEA_AUTORIZACION
				(
				codigo_excepcion	,
				FechaAutorizo		,
				NumeroOperacion		,
				NumeroDocumento		,
				NumeroCorrelativo	,
				Rut_Cliente		,
				Codigo_Cliente		,
				NumeroTraspaso		,
				Codigo_Grupo		,
				TipoOperacion		,
				Operador		,
				MontoAutorizo		,
				UsuarioAutorizo		,
				Activo			,
				Hora_Autorizacion	,
				Codigo_Sistema
				)
			VALUES
				(
				@Codigo_Excepcion	,
				@dFecha			,
				@nNumoper		,
				@Numero_Documento	,
				@Numero_Correlativo	,
				@Rut_Cliente		,
				@Codigo_Cliente		,
				@Numero_Traspaso +1	,
				@xCodigo_Grupo		,
				@Tipo_Operacion		,
				@Operador		,
				@Monto_Autorizado	,
				@cOperador_Ap		,
				'S'			,
				CONVERT(CHAR(08),GETDATE(),114),
				@Id_Sistema
                              )
	END

	/********************************************************************************************/
	/**************** LIMITES DE USUARIO ********************************************************/
	/********************************************************************************************/
	SELECT @Contador = 1

	SELECT @Total = 0

	SELECT @Total = COUNT(1) FROM LIMITE_TRANSACCION  WITH (NOLOCK) WHERE  NumeroOperacion = @nNumoper	AND
										Id_sistema      = @Id_sistema

	WHILE @Contador <= @Total BEGIN

            SET ROWCOUNT @Contador

		SELECT	@Numero_Documento   = NumeroOperacion	,
			@Numero_Correlativo = 0			,
			@Rut_Cliente        = 0			,
			@Codigo_Cliente     = 0			,
			@Numero_Traspaso    = 0			,
			@Tipo_Operacion     = ' '		,
			@Operador           = Operador		,
			@Monto_Autorizado   = MontoTransaccion	,
			@Codigo_Excepcion   = 'RE'		,
			@xCodigo_Grupo	    = Codigo_Grupo	,
			@Codigo_Producto    = Codigo_Producto
		FROM LIMITE_TRANSACCION  WITH (NOLOCK)
		WHERE	NumeroOperacion = @nNumoper	AND
			Id_Sistema	= @Id_Sistema

		SET ROWCOUNT 0
		SET ROWCOUNT 1

			IF @Id_sistema = 'BTR' BEGIN
				SELECT	@Rut_Cliente	= morutcli	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = motipoper
				FROM VIEW_MOVIMIENTO_TRADER
				WHERE monumoper = @nNumoper
			END

			IF @Id_sistema = 'BCC' BEGIN
				SELECT	@Rut_Cliente	= morutcli	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = motipope
				FROM VIEW_MOVIMIENTO_CAMBIO
				WHERE monumope = @nNumoper
			END


			IF @Id_sistema = 'BFW' BEGIN
				SELECT	@Rut_Cliente	= mocodigo	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = motipoper
				FROM VIEW_MOVIMIENTO_FORWARD
				WHERE monumoper = @nNumoper


				SELECT	@Rut_Cliente	= rut_cliente	,
					@Codigo_Cliente = codigo_cliente,
					@Tipo_Operacion = tipo_operacion
				FROM	VIEW_MOVIMIENTO_FORWARD_PAPEL
				WHERE	numero_operacion = @nNumoper

			END



			SET ROWCOUNT 0
			SELECT @Contador = @Contador + 1


		IF NOT  EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	      = @cOperador_Chq	  AND
							             Id_sistema	      = @Id_sistema       AND
								     Codigo_Producto  = @Codigo_Producto) OR
			EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	      = @cOperador_Chq	  AND
							    	     Id_sistema	      = @Id_sistema       AND
								     Codigo_Producto  = @Codigo_Producto  AND
								     estado	      = 'N')            BEGIN

			SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No tiene atribuciones asignadas para rechazar esta operación.'
			RETURN
		END

		IF EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE  WITH (NOLOCK) WHERE	usuario		 = @cOperador_Chq   AND
									Id_sistema	 = @Id_sistema      AND
									Codigo_Producto  = @Codigo_Producto AND
									codigo_excepcion = 'RE'		    AND
									estado		 = 'N') BEGIN

			SELECT @GlosaExcepcion = mensaje FROM EXCEPCION  WITH (NOLOCK) WHERE codigo_excepcion = 'RE'
			SELECT @GlosaExcepcion = ISNULL(@GlosaExcepcion,' ')
			SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', ' + @GlosaExcepcion
			RETURN
		END



		IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION  WITH (NOLOCK) WHERE numerooperacion  = @nNumoper	AND
								     codigo_Sistema   = @Id_Sistema	AND
								     codigo_excepcion = @Codigo_Excepcion)
		INSERT LINEA_AUTORIZACION
			(
			codigo_excepcion	,
			FechaAutorizo		,
			NumeroOperacion		,
			NumeroDocumento		,
			NumeroCorrelativo	,
			Rut_Cliente		,
			Codigo_Cliente		,
			NumeroTraspaso		,
			Codigo_Grupo		,
			TipoOperacion		,
			Operador		,
			MontoAutorizo		,
			UsuarioAutorizo		,
			Activo			,
			Hora_Autorizacion	,
			Codigo_Sistema

			)
		VALUES
			(
			@Codigo_Excepcion	,
			@dFecha			,
			@nNumoper		,
			@Numero_Documento	,
			@Numero_Correlativo	,
			@Rut_Cliente		,
			@Codigo_Cliente		,
			@Numero_Traspaso	,
			@xCodigo_Grupo		,
			@Tipo_Operacion		,
			@Operador		,
			@Monto_Autorizado	,
			@cOperador_Ap		,
			'S'			,
			CONVERT(CHAR(08),GETDATE(),114),
			@Id_Sistema
			)
	END

	/**********************************************************************************************/
	/**********************************************************************************************/

        IF @Id_Sistema = 'BTR' UPDATE VIEW_MOVIMIENTO_TRADER  			SET mostatreg = 'R' 		WHERE monumoper = @nNumoper
        IF @Id_Sistema = 'BFW' UPDATE VIEW_MOVIMIENTO_FORWARD 			SET moestado  = 'R' 		WHERE monumoper = @nNumoper
        IF @Id_Sistema = 'BFW' UPDATE VIEW_CARTERA_FORWARD    			SET caestado  = 'R' 		WHERE canumoper = @nNumoper
        IF @Id_Sistema = 'BFW' UPDATE VIEW_MOVIMIENTO_FORWARD_PAPEL 		SET estado  = 'R' 		WHERE numero_operacion = @nNumoper
        IF @Id_Sistema = 'BFW' UPDATE VIEW_CARTERA_FORWARD_PAPEL    		SET estado  = 'R' 		WHERE numero_operacion = @nNumoper
        IF @Id_Sistema = 'BCC' UPDATE VIEW_MOVIMIENTO_CAMBIO  			SET moestatus = 'R' 		WHERE monumope  = @nNumoper
	IF @id_sistema = 'INV' UPDATE VIEW_MOVIMIENTO_INVERSION_EXTERIOR	SET mostatreg = 'R'		WHERE monumoper = @nNumoper
	IF @id_sistema = 'SWP' UPDATE VIEW_CONTRATO				SET Estado_oper_lineas = 'R'	WHERE numero_operacion  = @nNumoper
--	IF @id_sistema = 'SWP' UPDATE VIEW_FRA_CARTERA				SET Estado = 'R'		WHERE numero_operacion  = @nNumoper

END




GO
