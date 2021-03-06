USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Autoriza]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Autoriza]
			(
			@dFecha		DATETIME	,
			@id_sistema	CHAR	(10)	,
			@nNumoper	NUMERIC	(10,0)	,
			@cOperador_Ap	CHAR	(15)	,
			@cOperador_Chq	CHAR	(15)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @Numero_Operacion	NUMERIC	(10)
	DECLARE @Numero_Documento	NUMERIC	(10)
	DECLARE @Numero_Correlativo	NUMERIC	(10)
	DECLARE @Rut_Cliente		NUMERIC	(09)
	DECLARE @Codigo_Cliente		NUMERIC	(09)
	DECLARE @Numero_Traspaso	NUMERIC	(10)
	DECLARE @Codigo_Instrumento	NUMERIC	(05)
	DECLARE @GlosaExcepcion		VARCHAR	(100)
	DECLARE @Codigo_Excepcion	CHAR	(02)
	DECLARE @Codigo_Producto	CHAR	(05)
	DECLARE @cCodigo_Grupo		CHAR	(10)
	DECLARE @Tipo_Operacion		CHAR	(05)
	DECLARE @Operador		CHAR	(15)
	DECLARE @Chequea_Instrumento	CHAR	(01)
	DECLARE @Chequea_Operacion	CHAR	(01)
	DECLARE @cTipInst		CHAR	(12)
	DECLARE @xCodigo_Grupo		CHAR	(10)
	DECLARE @FechaInicio		DATETIME
	DECLARE @FechaVencimiento	DATETIME
	DECLARE @Contador		INTEGER
	DECLARE @Total			INTEGER
	DECLARE @Monto_Autorizado	FLOAT
	DECLARE @nMontLimIni		FLOAT	
	DECLARE @nMontLimVen		FLOAT
	DECLARE @Valor_UF		FLOAT
	DECLARE @cMensAprob		VARCHAR(255)

	SELECT @Valor_UF = 1.0
	SELECT @Valor_UF = vmvalor FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA) where vmcodigo = 998 and vmfecha = @dFecha

	/*******************************************************************************************************/
	/************************** CONTROL DE LINEAS DE CLIENTES **********************************************/
	/*******************************************************************************************************/


--select @cOperador_Chq

	IF EXISTS(SELECT 1 FROM LINEA_TRANSACCION  WITH (NOLOCK) WHERE	NumeroOperacion = @nNumoper		AND
							id_sistema	= @id_sistema		AND
							Operador	= @cOperador_Chq)	--AND
							--FechaInicio	= @dFecha) 
							BEGIN

		SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No puede autorizar una operacion realizada por el mismo'
		RETURN
	END

	IF EXISTS(SELECT 1 FROM LIMITE_TRANSACCION  WITH (NOLOCK) WHERE NumeroOperacion	= @nNumoper	 AND
							 id_sistema		= @id_sistema     AND
							 Operador		= @cOperador_Chq ) --AND
							 --FechaOperacion		= @dFecha)
		BEGIN
		SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No puede autorizar una operacion realizada por el mismo'
		RETURN
	END

	SELECT @Contador = 1
	SELECT @Total	 = COUNT(1) FROM LINEA_TRANSACCION_DETALLE  WITH (NOLOCK) WHERE NumeroOperacion   = @nNumoper	    AND
									 id_sistema	   = @id_sistema    AND
									 codigo_excepcion <> ' '

	WHILE @Contador <= @Total BEGIN
		SET ROWCOUNT @Contador

		SELECT	@nNumoper	    = NumeroOperacion	,
			@Numero_Documento   = NumeroDocumento	,
			@Numero_Correlativo = NumeroCorrelativo	,
			@Numero_Traspaso    = 0			,
			@xCodigo_Grupo	    = Codigo_Grupo	,
			@Tipo_Operacion     = ' '		,
			@Operador           = ' '		,
			@Codigo_Producto    = Codigo_Producto 	,
			@Monto_Autorizado   = MontoTransaccion	,
			@Codigo_Excepcion   = Codigo_Excepcion	,
			@cCodigo_Grupo	    = Codigo_Grupo
		FROM	LINEA_TRANSACCION_DETALLE  WITH (NOLOCK)
		WHERE	NumeroOperacion = @nNumoper	 AND
			id_sistema	= @id_sistema    AND
			codigo_excepcion <> ' '
		SET ROWCOUNT 0


		SELECT	@Rut_Cliente	= Rut_Cliente	,
			@Codigo_Cliente = Codigo_Cliente,
			@Tipo_Operacion = ' '
		FROM	LINEA_TRANSACCION  WITH (NOLOCK)
		WHERE	NumeroOperacion  = @nNumoper 
		AND	id_sistema     = @id_sistema
		AND	NumeroDocumento	= @Numero_Documento
		AND	NumeroCorrelativo = @Numero_Correlativo



		SELECT	@Contador	= @Contador + 1,
			@Codigo_Cliente = ISNULL(@Codigo_Cliente, 1)


		SELECT	@Tipo_Operacion = Tipo_Operacion 	,
			@Operador       = Operador
		FROM	LINEA_TRANSACCION  WITH (NOLOCK)
		WHERE	NumeroOperacion	= @nNumoper
		AND	id_sistema      = @id_sistema
		AND	NumeroDocumento	= @Numero_Documento
		AND	NumeroCorrelativo = @Numero_Correlativo


		IF NOT EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	    = @cOperador_Chq	AND
								    Id_Sistema      = @id_sistema	AND
								    Codigo_Producto = @Codigo_Producto) OR

		       EXISTS(SELECT 1 FROM EXCEPCION_USUARIO  WITH (NOLOCK) WHERE usuario	    = @cOperador_Chq	AND
								    Id_Sistema      = @id_sistema	AND
								    Codigo_Producto = @Codigo_Producto  AND 
								    estado = 'N')	BEGIN

			SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No tiene atribuciones asignadas para autorizar esta operación.'
			RETURN

		END

		IF NOT EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE  WITH (NOLOCK) WHERE usuario		= @cOperador_Chq	AND
								    	    Id_Sistema          = @id_sistema	        AND
								            Codigo_Producto     = @Codigo_Producto)     OR

		       EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE  WITH (NOLOCK) WHERE usuario		= @cOperador_Chq	AND
								            Id_Sistema          = @id_sistema	        AND
								            Codigo_Producto     = @Codigo_Producto      AND
									    codigo_excepcion	= @Codigo_Excepcion	AND
									    estado		= 'N') BEGIN

			SELECT @GlosaExcepcion = mensaje FROM EXCEPCION  WITH (NOLOCK) WHERE codigo_excepcion = @Codigo_Excepcion
			SELECT @GlosaExcepcion = ISNULL(@GlosaExcepcion,' ')

			SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', ' + @GlosaExcepcion
			RETURN
		END

		IF EXISTS(SELECT 1 FROM LINEA_TRANSACCION_DETALLE  WITH (NOLOCK) WHERE codigo_excepcion = 'SC'		  AND
									NumeroOperacion  = @nNumoper	  AND
									id_sistema       = @id_sistema  ) BEGIN

			IF @Monto_Autorizado > (SELECT (monto_excepcion * @Valor_UF) FROM EXCEPCION_USUARIO_DETALLE  WITH (NOLOCK)
										     WHERE usuario	    = @cOperador_Chq    AND
								                           Id_Sistema       = @id_sistema      AND
 								                           Codigo_Producto  = @Codigo_Producto AND
											   codigo_excepcion = 'SC') BEGIN

				SELECT @GlosaExcepcion  = descripcion FROM EXCEPCION  WITH (NOLOCK)
				WHERE  codigo_excepcion = @Codigo_Excepcion

				SELECT @GlosaExcepcion = ISNULL(@GlosaExcepcion,' ')

				SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No tiene monto suficiente para aprobar esta operación (' + @GlosaExcepcion + ').'
				RETURN
			END
		END


		IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION  WITH (NOLOCK) WHERE numerooperacion  = @nNumoper	AND
								     codigo_sistema   = @id_sistema	AND
								     codigo_excepcion = @Codigo_Excepcion)
			INSERT INTO LINEA_AUTORIZACION
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
				@cCodigo_Grupo		,
				@Tipo_Operacion		,
				@Operador		,
				@Monto_Autorizado	,
				@cOperador_Ap		,
				'S'			,
				CONVERT(CHAR(08),GETDATE(),114),
			    	@id_sistema
				)


	END

	/*******************************************************************************************************/
	/************************ CONTROL DE LIMITES DE USUARIOS ***********************************************/
	/*******************************************************************************************************/

	SELECT @Contador = 1
   
	SELECT @Total = COUNT(1) FROM LIMITE_TRANSACCION_ERROR AS A  WITH (NOLOCK),
				      LIMITE_TRANSACCION       AS B  WITH (NOLOCK)
			WHERE	A.NumeroOperacion	= @nNumoper		AND
				A.id_sistema		= @id_sistema		AND
				A.numerooperacion	= B.numerooperacion	AND
				A.id_sistema		= B.id_sistema		AND
				A.tipo_control		= B.Tipo_Control


		WHILE @Contador <= @Total BEGIN

			SET ROWCOUNT @Contador

			SELECT	@Numero_Documento	= B.NumeroOperacion	,
				@Numero_Correlativo	= 0			,
				@Rut_Cliente		= 0			,
				@Codigo_Cliente		= 0			,
				@Numero_Traspaso	= 0			,
				@Codigo_Instrumento	= B.InCodigo		,
				@Tipo_Operacion		= ' '			,
				@Operador		= B.Operador		,
				@Monto_Autorizado	= B.MontoTransaccion	,
				@Codigo_Excepcion   	= Codigo_Excepcion	,
				@Chequea_Instrumento	= B.Check_Instrumento	,
				@Chequea_Operacion	= B.Check_Operacion	,
				@FechaInicio		= B.FechaOperacion	,
				@FechaVencimiento	= B.FechaVencimiento	,
				@xCodigo_Grupo	    	= B.Codigo_Grupo	,
				@cCodigo_Grupo	    	= B.Codigo_Grupo	,
				@Codigo_Producto    	= A.Codigo_Producto
			FROM	LIMITE_TRANSACCION_ERROR AS A  WITH (NOLOCK),
				LIMITE_TRANSACCION	 AS B  WITH (NOLOCK)
			WHERE	A.NumeroOperacion	= @nNumoper		AND
				A.id_sistema		= @id_sistema		AND
				A.numerooperacion	= B.numerooperacion	AND
				A.id_sistema		= B.id_sistema		AND
				A.tipo_control		= B.Tipo_Control

			SET ROWCOUNT 1


			IF @id_Sistema = 'BTR' BEGIN
				SELECT	@Rut_Cliente	= morutcli	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = ' '
				FROM	VIEW_MOVIMIENTO_TRADER
				WHERE	monumoper = @nNumoper
			END


			IF @id_Sistema = 'BCC' BEGIN
				SELECT	@Rut_Cliente	= morutcli	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = motipope
				FROM VIEW_MOVIMIENTO_CAMBIO
				WHERE monumope = @nNumoper
			END


			IF @id_Sistema = 'BFW' BEGIN
				SELECT	@Rut_Cliente	= mocodigo	,
					@Codigo_Cliente = mocodcli	,
					@Tipo_Operacion = motipoper
				FROM VIEW_MOVIMIENTO_FORWARD
				WHERE monumoper = @nNumoper

				SELECT	@Rut_Cliente	= rut_cliente,
					@Codigo_Cliente = codigo_cliente,
					@Tipo_Operacion = tipo_operacion
				FROM	VIEW_MOVIMIENTO_FORWARD_PAPEL
				WHERE	numero_operacion = @nNumoper
			END

			SET ROWCOUNT 0

			SELECT @Contador = @Contador + 1

			IF NOT	EXISTS(SELECT 1 FROM EXCEPCION_USUARIO WITH (NOLOCK) WHERE usuario	     = @cOperador_Chq	 AND
								             Id_Sistema      = @id_sistema	 AND
								             Codigo_Producto = @Codigo_Producto) OR
				EXISTS(SELECT 1 FROM EXCEPCION_USUARIO WITH (NOLOCK) WHERE usuario	     = @cOperador_Chq	 AND
 								             Id_Sistema      = @id_sistema	 AND
								             Codigo_Producto = @Codigo_Producto  AND 
									     estado	     = 'N') BEGIN


				SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', No tiene atribuciones asignadas para autorizar esta operación.'
				RETURN

			END


			IF NOT EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE WITH (NOLOCK) WHERE usuario	     = @cOperador_Chq	 AND
								                    Id_Sistema       = @id_sistema	 AND
								                    Codigo_Producto  = @Codigo_Producto  AND
										    codigo_excepcion = @Codigo_Excepcion)OR
			       EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE WITH (NOLOCK) WHERE usuario	     = @cOperador_Chq	 AND
								                    Id_Sistema       = @id_sistema	 AND
								                    Codigo_Producto  = @Codigo_Producto  AND
										    codigo_excepcion = @Codigo_Excepcion AND
										    estado	     = 'N') BEGIN

					SELECT @GlosaExcepcion = mensaje FROM EXCEPCION WITH (NOLOCK) WHERE codigo_excepcion = @Codigo_Excepcion
					SELECT @GlosaExcepcion = ISNULL(@GlosaExcepcion,' ')
	


					SELECT 'NO','Usuario : ' + LTRIM(RTRIM(@cOperador_Ap)) + ', ' + @GlosaExcepcion
					RETURN
			END


			BEGIN

			/***********************************************************************************/
			/***********************************************************************************/
			/***********************************************************************************/


			EXECUTE SP_LIMITES_CHEQUEAR @id_sistema, @nNumoper, 'N', @cOperador_Chq, @cMensAprob OUTPUT


			IF @cMensAprob <> ''
			BEGIN
				SELECT  'NO', RTRIM(LTRIM(@cOperador_Ap)) + @cMensAprob
				RETURN
			END


		/*************************************************************************/
		/********** FIN LIMITES OP.INST ******************************************/
		/*************************************************************************/
      END


	IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION WITH (NOLOCK) WHERE numerooperacion  = @nNumoper	AND
							     Codigo_sistema   = @id_sistema     AND
							     codigo_excepcion = @Codigo_Excepcion)

	      INSERT INTO LINEA_AUTORIZACION
        	    (   codigo_excepcion
	            ,   FechaAutorizo
	            ,   NumeroOperacion
	            ,   NumeroDocumento
	            ,   NumeroCorrelativo
	            ,   Rut_Cliente
	            ,   Codigo_Cliente
	       	    ,   NumeroTraspaso
	            ,   Codigo_Grupo
	            ,   TipoOperacion
	            ,   Operador
	   	    ,   MontoAutorizo
	            ,   UsuarioAutorizo
	            ,   Activo
	            ,   Hora_Autorizacion
		    ,	Codigo_Sistema
	            )
	      VALUES
	            (   @Codigo_Excepcion
	            ,   @dFecha
	            ,   @nNumoper
	            ,   @Numero_Documento
	            ,   @Numero_Correlativo
	            ,   @Rut_Cliente
	            ,   @Codigo_Cliente
	            ,   @Numero_Traspaso
	            ,   @cCodigo_Grupo
	            ,   @Tipo_Operacion
	            ,   @Operador
	            ,   @Monto_Autorizado
	            ,   @cOperador_Ap
	            ,   'S'
	            ,   CONVERT(CHAR(08),GETDATE(),114)
		    ,   @id_sistema
	            )



   END
	/*******************************************************************************************************************************************
	*******************************************************************************************************************************************/
	IF @id_sistema = 'BTR'	UPDATE VIEW_MOVIMIENTO_TRADER  			SET mostatreg = ' ' 		WHERE monumoper = @nNumoper
	IF @id_sistema = 'BFW'	UPDATE view_MOVIMIENTO_FORWARD 			SET moestado  = ' ' 		WHERE monumoper = @nNumoper
	IF @id_sistema = 'BFW'	UPDATE VIEW_CARTERA_FORWARD    			SET caestado  = ' ' 		WHERE canumoper = @nNumoper
	IF @id_sistema = 'BFW'	UPDATE view_MOVIMIENTO_FORWARD_PAPEL 		SET estado  = ' ' 		WHERE numero_operacion = @nNumoper
	IF @id_sistema = 'BFW'	UPDATE VIEW_CARTERA_FORWARD_PAPEL		SET estado  = ' ' 		WHERE numero_operacion = @nNumoper
	IF @id_sistema = 'BCC'	UPDATE VIEW_MOVIMIENTO_CAMBIO  			SET moestatus = ' ' 		WHERE monumope  = @nNumoper
	IF @id_sistema = 'INV'	UPDATE VIEW_MOVIMIENTO_INVERSION_EXTERIOR	SET mostatreg = ' '		WHERE monumoper = @nNumoper
	IF @id_sistema = 'SWP'	UPDATE VIEW_CONTRATO				SET Estado_oper_lineas = ' '	WHERE numero_operacion  = @nNumoper
--	IF @id_sistema = 'SWP' 	UPDATE VIEW_FRA_CARTERA				SET Estado = ''			WHERE numero_operacion  = @nNumoper

END

GO
