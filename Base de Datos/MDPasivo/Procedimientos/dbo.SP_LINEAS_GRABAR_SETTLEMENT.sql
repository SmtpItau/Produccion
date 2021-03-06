USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABAR_SETTLEMENT]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_GRABAR_SETTLEMENT]
				(
   				@dFecPro 	DATETIME	,
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nRutcli	NUMERIC	(09,0)	,
				@nCodigo	NUMERIC	(09,0)	,
				@nNumoper	NUMERIC	(10,0)	,
				@nNumdocu	NUMERIC	(10,0)	,
				@nCorrela	NUMERIC	(10,0)	,
				@dFeciniop	DATETIME	,
				@nMonto		FLOAT		,
				@fTipcambio	FLOAT		,
				@dFecvctop	DATETIME	,
				@cUsuario	CHAR	(10)	,
				@cModPago	CHAR	(01)	,
				@cTipo_Riesgo	CHAR	(01)	,
		                @nMonedalin	NUMERIC	(05,0)	,
		                @nValmonlin	FLOAT		,
                                @Mto_Sobregiro  FLOAT		,
				@ccodigo_grupo	CHAR	(10)	,
				@nMoneda2	NUMERIC (05,0) = 0
				)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON


	DECLARE @nRutcasamatriz		NUMERIC	(09,0)
	DECLARE @nCodigocasamatriz	NUMERIC	(09,0)
	DECLARE @nMatrizriesgo		NUMERIC	(08,4)
	DECLARE @nPlazoDesde 		NUMERIC	(05,0)
	DECLARE @nPlazoHasta		NUMERIC	(05,0)
	DECLARE @cMensaje		VARCHAR	(255)
	DECLARE @cTipoMov  		VARCHAR	(01)
	DECLARE @cTipoLinea 		VARCHAR	(01)
	DECLARE @cTipoControl 		VARCHAR	(01)
	DECLARE @cError 		VARCHAR	(01)
	DECLARE @Cod_Error      	VARCHAR	(01)
	DECLARE @Exceso_General		VARCHAR	(01)
	DECLARE @cBloqueado		CHAR	(01)
	DECLARE @cNombre		CHAR	(60)
	DECLARE @cCtrlplazo		CHAR	(01)
	DECLARE @cCompartido		CHAR	(01)
	DECLARE @cNombreCMatriz		CHAR	(60)
	DECLARE @dFecvctolinea		DATETIME
	DECLARE @nCorrDet		INTEGER
	DECLARE	@iFound			INTEGER	
	DECLARE @nMontolin      	NUMERIC(19,4)
	DECLARE @nTotalasignado		FLOAT
	DECLARE @nTotalocupado		FLOAT
	DECLARE @nTotaldisponible	FLOAT
	DECLARE @nTotalexceso		FLOAT
	DECLARE @nTotaltraspaso		FLOAT
	DECLARE @nTotalrecibido		FLOAT
	DECLARE @nSinriesgoasignado	FLOAT
	DECLARE @nSinriesgoocupado	FLOAT
	DECLARE @nSinriesgodisponible	FLOAT
	DECLARE @nSinriesgoexceso	FLOAT
	DECLARE @nConriesgoasignado	FLOAT
	DECLARE @nConriesgoocupado	FLOAT
	DECLARE @nConriesgodisponible	FLOAT
	DECLARE @nConriesgoexceso	FLOAT
	DECLARE @nExceso 		FLOAT
	DECLARE @nDisponible		FLOAT
	DECLARE @nMontLimIni		FLOAT
	DECLARE @nMontLimVen		FLOAT
	DECLARE @Diferencia_Exceso	FLOAT
	DECLARE @Monto_Tot_Traspaso	FLOAT

	IF @nCodigo = 0 BEGIN
		SELECT 	@cNombre = clnombre,
			@nCodigo = clcodigo
		FROM 	CLIENTE
		WHERE	clrut	 = @nRutcli
	END ELSE BEGIN
		SELECT 	@cNombre = clnombre
		FROM 	CLIENTE
		WHERE	clrut	 = @nRutcli	AND
			clcodigo = @nCodigo
	END

	SELECT	@nCorrDet 	= 0 	,
		@cTipoMov  	= 'S'	,   -- S.suma R.resta
		@cTipoLinea 	= 'L'	,   -- L.linea
		@cTipoControl 	= 'C'	,   -- C.control
		@nMatrizriesgo	= 0	,
		@nMontolin	= ROUND(@nMonto/@nValmonlin,4)

	IF @cSistema  = 'BFW' BEGIN
		SELECT	@iFound		= 0

		SELECT	@iFound		= 1		,
			@nMatrizriesgo	= porcentaje
		FROM	MATRIZ_RIESGO
		WHERE	codigo_grupo	= @ccodigo_grupo	  AND
			DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_desde AND
			DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_hasta AND
                        codigo_moneda  = @nMonedalin		AND
                        codigo_moneda2 = @nMoneda2
                
		IF @iFound = 1 BEGIN
			SELECT @nMontolin = ROUND(@nMontolin / 100 * @nMatrizriesgo,4)
		END
	END

	SELECT	@iFound		= 0

	SELECT	@iFound			= 1			,
		@nRutcasamatriz		= GEN.rutcasamatriz	,
		@nCodigocasamatriz	= GEN.codigocasamatriz	,
		@nDisponible		= CASE WHEN SIS.compartido = 'S' THEN SUM(SIS.conriesgodisponible)
					       ELSE SUM(SIS.totaldisponible)
					  END			,
		@cBloqueado 		= GEN.bloqueado		,
		@dFecvctolinea 		= GEN.fechavencimiento
	FROM	LINEA_GENERAL AS GEN,
		LINEA_SISTEMA AS SIS
	WHERE	GEN.rut_cliente		= @nRutcli		AND
		GEN.codigo_cliente	= @nCodigo		AND
		GEN.rut_cliente         = SIS.rut_cliente	AND
		GEN.codigo_cliente      = SIS.codigo_cliente
	GROUP BY GEN.rutcasamatriz	,
		 GEN.codigocasamatriz	,
		 SIS.compartido		,
		 GEN.bloqueado		,
		 GEN.fechavencimiento

	IF @iFound = 1 BEGIN

		-- SP_HELP LINEA_TRANSACCION
		INSERT INTO LINEA_TRANSACCION
			(
			numerodocumento		,
			numerooperacion		,
			numerocorrelativo	,
			rut_cliente		,
			codigo_cliente		,
			id_sistema		,
			tipo_operacion		,
			tipo_riesgo		,
			fechainicio		,
			fechavencimiento	,
			montooriginal		,
			tipocambio		,
			matrizriesgo		,
			montotransaccion	,
			operador		,
			activo                  
			)
		SELECT
			@nNumdocu		,
			@nNumoper		,
			@nCorrela		,
			@nRutcli		,
			@nCodigo		,
			@cSistema		,
			' '			, --descripcion		,
			@cTipo_Riesgo		,
			@dFeciniop		,
			@dFecvctop		,
			@nMonto			,
			@fTipcambio		,
			@nMatrizriesgo		,
			@nMontolin		,
			@cUsuario		,
			'S'                     
		--FROM	PRODUCTO
		--WHERE	@cProducto=codigo_producto

		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/********** LINEA CASA MATRIZ *********************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		IF @nRutcasamatriz > 0	BEGIN

			SELECT 	@cNombreCMatriz	= clnombre
			FROM 	cliente
			WHERE	clrut	 = @nRutcasamatriz	AND
				clcodigo = @nCodigocasamatriz

			SELECT	@iFound			= 0
			SELECT	@iFound			= 1			,
				@nDisponible		= TotalDisponible	,
				@nSinriesgodisponible 	= Sinriesgodisponible	,
				@nConriesgodisponible 	= Conriesgodisponible
		       	FROM	LINEA_AFILIADO
			WHERE	rutcasamatriz 	 = @nRutcasamatriz	AND 
				codigocasamatriz = @nCodigocasamatriz


			/**************************************************************************/
			/******* LINEA TOTAL ******************************************************/
			/**************************************************************************/
			IF @nDisponible < 0 BEGIN
				SELECT @nExceso = ABS(@nMontolin)
			END ELSE BEGIN
				SELECT @nExceso = @nDisponible - @nMontolin
			END

			UPDATE	LINEA_AFILIADO
			SET	totalocupado	= totalocupado    + @nMontolin	,
				totaldisponible = totaldisponible - @nMontolin
			WHERE	rutcasamatriz 	= @nRutcasamatriz	AND
				codigocasamatriz= @nCodigocasamatriz


			SELECT  @cMensaje  = ' '	,
				@cError    = 'N',
				@nExceso   = 0  ,
				@Cod_Error = ' '
			SELECT	@nCorrDet = @nCorrDet + 1

			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	   ,
					Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error	   ,
					Codigo_Excepcion, Mensaje_Error)
			SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema	   ,
					@cProducto      , @cTipoLinea  	 , @cTipoMov        , 'MATRIZ'	    	 , @nMontolin      ,
					@nExceso   	, 0         	 , 0         	    , 'S' 		 , @cError	   ,
					@Cod_Error  	, @cMensaje

			/**************************************************************************/
			/****** SIN RIESGO ********************************************************/
			/**************************************************************************/
			IF @cTipo_Riesgo = 'S' BEGIN
				If @nSinriesgoDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN
					SELECT @nExceso = @nSinriesgoDisponible - @nMontolin
				END

				UPDATE	LINEA_AFILIADO
				SET	Sinriesgoocupado	= Sinriesgoocupado    + @nMontolin	,
				        Sinriesgodisponible	= Sinriesgodisponible - @nMontolin
				WHERE	rutcasamatriz 		= @nRutcasamatriz	AND
					codigocasamatriz	= @nCodigocasamatriz

				SELECT  @cMensaje  = ' '	,
					@cError    = 'N',
					@nExceso   = 0  ,
                                        @Cod_Error = ' '

				SELECT	@nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion	, NumeroDocumento    , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	,
						Codigo_Producto , Tipo_Detalle	     , Tipo_Movimiento	, Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	     , PlazoHasta	, Actualizo_Linea    , Error		,
						Codigo_Excepcion, Mensaje_Error
						)
				SELECT		@nNumoper	, @nNumdocu	     , @nCorrela        , @nCorrDet          , @cSistema	,
						@cProducto	, @cTipoLinea	     , @cTipoMov	, 'MAT_SR'	     , @nMontolin       ,
						@nExceso	, 0   		     , 0 		, 'S'		     , @cError		,
						@Cod_Error	, @cMensaje
   			END

			/**************************************************************************/
			/******* CON RIESGO *******************************************************/
			/**************************************************************************/
			IF @cTipo_Riesgo = 'C' BEGIN
				If @nConriesgoDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN 
					SELECT @nExceso = @nConriesgoDisponible - @nMontolin
				END

				UPDATE	LINEA_AFILIADO
				SET	Conriesgoocupado	= Conriesgoocupado    + @nMontolin	,
					Conriesgodisponible	= Conriesgodisponible - @nMontolin
				WHERE	rutcasamatriz 		= @nRutcasamatriz	AND
					codigocasamatriz	= @nCodigocasamatriz

				SELECT  @cMensaje  = ' '	 ,
					@cError    = 'N' ,
					@nExceso   = 0   ,
					@Cod_Error = ' '

				SELECT	@nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion	, NumeroDocumento   , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	,
						Codigo_Producto , Tipo_Detalle      , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	    , PlazoHasta       , Actualizo_Linea    , Error   		,
						Codigo_Excepcion, Mensaje_Error
						)
				SELECT		@nNumoper       , @nNumdocu         , @nCorrela        , @nCorrDet          , @cSistema 	,
						@cProducto      , @cTipoLinea       , @cTipoMov        , 'MAT_CR'	    , @nMontolin      	,
						@nExceso  	, 0 		    , 0		       , 'S'		    , @cError 		,
						@Cod_Error	, @cMensaje
			END
		END

		SELECT	@iFound			= 1			,
			@nRutcasamatriz		= GEN.rutcasamatriz	,
			@nCodigocasamatriz	= GEN.codigocasamatriz	,
			@nDisponible		= CASE WHEN SIS.compartido = 'S' THEN SUM(SIS.conriesgodisponible) ELSE SUM(SIS.totaldisponible) END,
			@cBloqueado 		= GEN.bloqueado		,
			@dFecvctolinea 		= GEN.fechavencimiento
	       	FROM	LINEA_GENERAL GEN,
			LINEA_SISTEMA SIS
		WHERE	GEN.rut_cliente		= @nRutcli		AND
			GEN.codigo_cliente	= @nCodigo		AND
			GEN.rut_cliente         = SIS.rut_cliente	AND
			GEN.codigo_cliente      = SIS.codigo_cliente
		GROUP BY GEN.rutcasamatriz
			,GEN.codigocasamatriz
			,SIS.compartido
			,GEN.bloqueado
			,GEN.fechavencimiento


		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/********** LINEA GENERAL *************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		IF @cBloqueado = 'S' BEGIN --** Linea General Bloqueada para operar **--
			SELECT  @cMensaje = 'Linea General Bloqueada Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = 0						,
				@nCorrDet = @nCorrDet + 1                               ,
                                @Cod_Error = 'L'

			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
			SELECT		@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema	,
					@cProducto	, @cTipoControl  , @cTipoMov	    , 'LINGEN'		 , @nMontolin   ,
					@nExceso	, 0	         , 0         	    , 'S'		 , @cError 	,
					@Cod_Error  	, @cMensaje
		END

	
		IF @dFecPro > @dFecvctolinea BEGIN
			SELECT  @cMensaje  = 'Linea General Vencida Para ' + @cNombre 	,
				@cError    = 'S'					,
				@nExceso   = 0						,
				@nCorrDet  = @nCorrDet + 1                              ,
                                @Cod_Error = 'L'

			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
			SELECT		@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
					@cProducto      , @cTipoControl  , @cTipoMov        , 'LINGEN'	         , @nMontolin      	,
					@nExceso   	, 0 	         , 0         	    , 'S'		 , @cError 		,
					@Cod_Error  	, @cMensaje
		END

		IF @nDisponible < 0 BEGIN
			SELECT @nExceso = @nMontolin * (-1)
		END ELSE BEGIN
			SELECT @nExceso = @nDisponible - @nMontolin
		END


--	        UPDATE	LINEA_GENERAL
--		SET	totalocupado	= totalocupado  + @nMontolin	,
--			totaldisponible = totaldisponible - @nMontolin
--		WHERE	rut_cliente	= @nRutcli 
--		AND	codigo_cliente	= @nCodigo


                IF @nExceso < 0 AND ( @nExceso  * -1 ) <= @Mto_Sobregiro   	SELECT  @Cod_Error = 'S'
                IF @nExceso < 0 AND ( @nExceso  * -1 ) >  @Mto_Sobregiro   	SELECT  @Cod_Error = 'E'


		IF @nExceso < 0
			SELECT  @cMensaje = 'Linea General Excedido Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = @nExceso * (-1)                             ,
                                @Exceso_General = 'S'
		ELSE
			SELECT  @cMensaje	= ' '	,
				@cError		= 'N'	,
				@nExceso	= 0	,
                                @Cod_Error	= ' '	,
                                @Exceso_General = ' '

		SELECT	@nCorrDet = @nCorrDet + 1

		INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion , NumeroDocumento , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto , Tipo_Detalle	  , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso     , PlazoDesde	  , PlazoHasta	     , Actualizo_Linea	  , Error  		,
					Codigo_Excepcion, Mensaje_Error
					)
		SELECT			@nNumoper       , @nNumdocu       , @nCorrela        , @nCorrDet          , @cSistema		,
					@cProducto      , @cTipoLinea     , @cTipoMov        , 'LINGEN'	          , @nMontolin      	,
					@nExceso   	, 0	          , 0      	     , 'S'  		  , @cError 		,
					@Cod_Error  	, @cMensaje

		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/******** LINEA SISTEMA ***************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		SELECT	@nDisponible 	= 0

		SELECT	@cCtrlplazo		= controlaplazo		,
                        @cCompartido    	= Compartido            ,
			@nDisponible		= totaldisponible	,
			@cBloqueado 		= bloqueado		,
			@dFecvctolinea 		= fechavencimiento	,
			@nSinriesgodisponible	= Sinriesgodisponible	,
			@nConriesgodisponible	= Conriesgodisponible
	       	FROM	LINEA_SISTEMA
		WHERE	rut_cliente	= @nRutcli		AND
			codigo_cliente	= @nCodigo		AND
			Codigo_grupo	= @cCodigo_grupo

		/**************************************************************************/
		/******* Linea Sistema Bloqueada para operar ******************************/
		/**************************************************************************/
		IF @cBloqueado ='S' BEGIN
			SELECT  @cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = 0						,
				@nCorrDet = @nCorrDet + 1                               ,
                                @Cod_Error = 'L'

			INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle   , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error   		,
						Codigo_Excepcion, Mensaje_Error
						)
			SELECT			@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
						@cProducto      , @cTipoControl  , @cTipoMov        , 'LINSIS'	         , @nMontolin      	,
						@nExceso   	, 0	         , 0         	    , 'S'		 , @cError 		,
						@Cod_Error  	, @cMensaje
		END

	
		IF @dFecPro>@dFecvctolinea BEGIN
			SELECT  @cMensaje  = 'Linea Sistema Vencida Para ' + @cNombre 	,
				@cError    = 'S'						,
				@nExceso   = 0						,
				@nCorrDet  = @nCorrDet + 1                               ,
                                @Cod_Error = 'L'

			INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error                ,
						Codigo_Excepcion, Mensaje_Error
						)
			SELECT			@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
						@cProducto      , @cTipoControl  , @cTipoMov        , 'LINSIS'	         , @nMontolin      	,
						@nExceso	, 0  		 , 0 		    , 'S' 		 , @cError 		,
						@Cod_Error  	, @cMensaje
		END


		IF @cCompartido <> 'N' BEGIN
			If @nDisponible < 0 BEGIN
				SELECT @nExceso = ABS(@nMontolin)
			END ELSE BEGIN
				SELECT @nExceso = @nDisponible - @nMontolin
			END

			SELECT  @Cod_Error = ' '

	                IF @nExceso < 0 BEGIN  /*AND @Exceso_General = ' '*/ 
				SELECT  @Cod_Error = 'T'
			END
/*
			   IF @Cod_Error = 'T' and 1 = 2
				EXECUTE SP_TRASPASO_AUTOMATICO	@nNumoper
							,	@nNumdocu
							,	@nCorrela
							,	@cSistema
							,	@nRutcli
							,	@nCodigo
							,	@cTipo_Riesgo
							,	@Diferencia_Exceso	OUTPUT
							,	@Monto_Tot_Traspaso	OUTPUT
                                                        ,       @Cod_Error              OUTPUT
                                                        ,       @Mto_Sobregiro

			--EXECUTE SP_LINEAS_ACTUALIZA @dFecPro.
*/

			IF @Cod_Error <> ' ' BEGIN
				SELECT  @cMensaje = 'Linea Sistema Excedido Para ' + @cNombre 	,
					@cError   = 'S'						,
					@nExceso  = CASE WHEN (@nMontolin + @Diferencia_Exceso) > 0 THEN (@nMontolin + @Diferencia_Exceso) ELSE @nExceso * (-1) END
			END ELSE BEGIN
				SELECT  @cMensaje = ' '	,
					@cError   = 'N'	,
					@nExceso  = 0   ,
                        	        @Cod_Error = ' '
			END
			

			UPDATE	LINEA_SISTEMA
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				ConRiesgoOcupado	= ConRiesgoOcupado	+ CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END,
				ConRiesgoDisponible	= ConRiesgoDisponible 	- CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo

			SELECT @nCorrDet = @nCorrDet + 1

			INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle   , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error		,
						Codigo_Excepcion, Mensaje_Error
						)
			SELECT			@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
						@cProducto      , @cTipoLinea    , @cTipoMov        , 'LINSIS'	         , @nMontolin      	,
						@nExceso   	, 0         	 , 0         	    , 'S' 		 , @cError 		,
						@Cod_Error  	, @cMensaje

		END ELSE BEGIN


			IF @cTipo_Riesgo = 'S'BEGIN

				SELECT @nDisponible = @nSinriesgodisponible

				If @nDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN
					SELECT @nExceso = @nDisponible - @nMontolin
				END


				SELECT  @Cod_Error = ' '

	        	        IF @nExceso < 0 /*AND @Exceso_General = ' '*/ SELECT  @Cod_Error = 'T'

/*			   IF @Cod_Error = 'T' and 1 = 2
				EXECUTE SP_TRASPASO_AUTOMATICO	@nNumoper
							,	@nNumdocu
							,	@nCorrela
							,	@cSistema
							,	@nRutcli
							,	@nCodigo
							,	@cTipo_Riesgo
							,	@Diferencia_Exceso	OUTPUT
							,	@Monto_Tot_Traspaso	OUTPUT
                                                        ,       @Cod_Error              OUTPUT
                                                        ,       @Mto_Sobregiro*/

				IF @Cod_Error <> ' ' BEGIN
					SELECT  @cMensaje = 'Linea Sistema Sin Riesgo Excedido Para ' + @cNombre 	,
						@cError   = 'S'						,
						@nExceso  = CASE WHEN (@nMontolin + @Diferencia_Exceso) > 0 THEN (@nMontolin + @Diferencia_Exceso) ELSE @nExceso * (-1) END
				END ELSE BEGIN
					SELECT  @cMensaje = ' '	,
						@cError   = 'N'	,
						@nExceso  = 0   ,
                        		        @Cod_Error = ' '
				END

      
				UPDATE	LINEA_SISTEMA
				SET	totalocupado		= totalocupado    	+ @nMontolin	,
					totaldisponible 	= totaldisponible 	- @nMontolin	,
					SinRiesgoOcupado	= SinRiesgoOcupado	+ CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END,
					SinRiesgoDisponible	= SinRiesgoDisponible 	- CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END
				WHERE	rut_cliente	= @nRutcli
				AND 	codigo_cliente	= @nCodigo
				AND 	codigo_grupo	= @ccodigo_grupo


				SELECT @nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle   , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
						Codigo_Excepcion, Mensaje_Error
						)
				SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
						@cProducto      , @cTipoLinea    , @cTipoMov        , 'LINSSR'	         , @nMontolin      	,
						@nExceso   	, 0         	 , 0 		    , 'S'		 , @cError 		,
						@Cod_Error  	, @cMensaje
			END ELSE BEGIN

				SELECT @nDisponible = @nConriesgodisponible

				IF @nDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN
					SELECT @nExceso = @nDisponible - @nMontolin
				END


				SELECT  @Cod_Error = ' '

		                IF @nExceso < 0 /*AND @Exceso_General = ' '*/ SELECT  @Cod_Error = 'T'


/*			   	IF @Cod_Error = 'T' and 1 = 2
					EXECUTE SP_TRASPASO_AUTOMATICO	@nNumoper
								,	@nNumdocu
								,	@nCorrela
								,	@cSistema
								,	@nRutcli
								,	@nCodigo
								,	@cTipo_Riesgo
								,	@Diferencia_Exceso	OUTPUT
								,	@Monto_Tot_Traspaso	OUTPUT
                                                                ,       @Cod_Error              OUTPUT
                                                                ,       @Mto_Sobregiro*/

				IF @Cod_Error <> ' '
					SELECT  @cMensaje = 'Linea Sistema Con Riesgo Excedido Para ' + @cNombre 	,
						@cError   = 'S'						,
						@nExceso  = CASE WHEN (@nMontolin + @Diferencia_Exceso) > 0 THEN (@nMontolin + @Diferencia_Exceso) ELSE @nExceso * (-1) END
				ELSE
					SELECT  @cMensaje = ' '	,
						@cError   = 'N'	,
						@nExceso  = 0   ,
                        		        @Cod_Error =  ' '


				UPDATE	LINEA_SISTEMA
				SET	totalocupado		= totalocupado    	+ @nMontolin	,
					totaldisponible 	= totaldisponible 	- @nMontolin	,
					ConRiesgoOcupado	= ConRiesgoOcupado	+ CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END,
					ConRiesgoDisponible	= ConRiesgoDisponible 	- CASE WHEN @Cod_Error IN ('T','E') AND @Diferencia_Exceso <> 0 THEN (@nMontolin - @Monto_Tot_Traspaso) ELSE @nMontolin END
				WHERE	rut_cliente	= @nRutcli		AND
				 	codigo_cliente	= @nCodigo		AND
					codigo_grupo	= @ccodigo_grupo

				SELECT @nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error  		,
						Codigo_Excepcion, Mensaje_Error
						)
				SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
						@cProducto      , @cTipoLinea    , @cTipoMov        , 'LINSCR'	         , @nMontolin      	,
						@nExceso   	, 0	         , 0 		    , 'S'         	 , @cError 		,
						@Cod_Error  	, @cMensaje
			END


		END



		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/***** LINEA POR PLAZO ****************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/

		IF @cCtrlplazo = 'S' BEGIN
			SELECT	@ndisponible	= 0

         		SELECT	@iFound		= 0
		        SELECT	@iFound		= 1,
                                @nPlazoDesde	= PlazoDesde,
				@nPlazoHasta	= PlazoHasta,
				@ndisponible	= Totaldisponible
		       	FROM	LINEA_POR_PLAZO
			WHERE	rut_cliente	=  @nRutcli			AND
				codigo_cliente	=  @nCodigo			AND
				codigo_grupo	=  @ccodigo_grupo		AND
				plazodesde 	<= DATEDIFF(day, @dFecPro, @dFecvctop)	AND
				plazohasta	>  DATEDIFF(day, @dFecPro, @dFecvctop)


                        IF @iFound = 1 BEGIN
   			      IF @nDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
			      END ELSE BEGIN
					SELECT @nExceso = @nDisponible - @nMontolin
			      END

			      UPDATE 	LINEA_POR_PLAZO
			      SET 	totalocupado	=  totalocupado    + @nMontolin	,      
					totaldisponible =  totaldisponible - @nMontolin
			      WHERE	rut_cliente	=  @nRutcli		AND
					codigo_cliente	=  @nCodigo		AND
					codigo_grupo 	=  @ccodigo_grupo	AND
					plazodesde	<= DATEDIFF(day, @dFecPro, @dFecvctop)

			      SELECT	@cMensaje  = ' '		,
					@cError    = 'N'	,
					@nExceso   = 0		,
                                        @Cod_Error = ' '		,
					@nCorrDet  = @nCorrDet + 1

			      INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	 , PlazoHasta  	    , Actualizo_Linea	 , Error 		,
						Codigo_Excepcion, Mensaje_Error
						)
			      SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
						@cProducto      , @cTipoLinea    , @cTipoMov        , 'LINPZO'	         , @nMontolin           ,
						@nExceso        , @nPlazoDesde	 , @nPlazoDesde	    , 'S'  		 , @cError		,
						@Cod_Error	, @cMensaje
                        END
                END

		EXECUTE SP_LINEAS_ACTUALIZA 


	END ELSE BEGIN
		SELECT	'NO','ERROR: No Existe Linea Definida ' + @cNombre
		RETURN
	END

	SET NOCOUNT OFF
END





GO
