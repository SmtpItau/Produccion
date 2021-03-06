USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABAR]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRABAR]
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
				@cUsuario	CHAR	(15)	,
				@cModPago	CHAR	(01)	,
				@cTipo_Riesgo	CHAR	(01)	,
		                @nMonedalin	NUMERIC	(05,0)	,
		                @nValmonlin	FLOAT		,
                                @Mto_Sobregiro  FLOAT		,
				@ccodigo_grupo	CHAR	(10)	,
				@nMonedaMat1	NUMERIC (05,0) = 0,
				@nMonedaMat2	NUMERIC (05,0) = 0,
				@nMatrizriesgo	FLOAT		,
				@nMonto_Orig	FLOAT = 0
				)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	SET NOCOUNT ON
	SET DATEFORMAT DMY

	DECLARE @nRutcasamatriz		NUMERIC	(09,0)
	DECLARE @nCodigocasamatriz	NUMERIC	(09,0)
	--DECLARE @nMatrizriesgo		NUMERIC	(08,4)
	DECLARE @nPlazoDesde 		NUMERIC	(05,0)
	DECLARE @nPlazoHasta		NUMERIC	(05,0)
	DECLARE @nContPlazosTotales	NUMERIC	(05,0)
	DECLARE @nContPlazosLeidos	NUMERIC	(05,0)
	DECLARE @cMensaje		VARCHAR	(255)
	DECLARE @cMensaje_Compartido	VARCHAR	(255)
	DECLARE @cTipoMov  		VARCHAR	(01)
	DECLARE @cTipoLinea 		VARCHAR	(01)
	DECLARE @cTipoControl 		VARCHAR	(01)
	DECLARE @cTipoOperacion		VARCHAR	(10)
	DECLARE @cError 		VARCHAR	(01)
	DECLARE @Cod_Error      	VARCHAR	(02)
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
	DECLARE @nMontolinPlazo      	NUMERIC(19,4)
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
	DECLARE @cExceso_General	CHAR(1)
	DECLARE @cExceso_Sistema	CHAR(1)
	DECLARE @nDisponible		FLOAT
	DECLARE @nMontLimIni		FLOAT
	DECLARE @nMontLimVen		FLOAT
	DECLARE @Diferencia_Exceso	FLOAT
	DECLARE @Monto_Tot_Traspaso	FLOAT

    --Variables de Calculo de Interpolacion Lineas
	DECLARE	@Dias			INTEGER
	DECLARE	@Dias_Inicio            INTEGER
	DECLARE	@Dias_Fin               INTEGER
	DECLARE	@Flujo_Inicio        	FLOAT
	DECLARE	@Flujo_Fin	        FLOAT
        DECLARE	@Pendiente	        FLOAT
        DECLARE	@Factor_Riesgo	        FLOAT

	IF @nCodigo = 0 BEGIN
		SELECT 	@cNombre = clnombre,
			@nCodigo = clcodigo
		FROM 	CLIENTE WITH(NOLOCK INDEX=PK_CLIENTE)
		WHERE	clrut	 = @nRutcli
	END ELSE BEGIN
		SELECT 	@cNombre = clnombre
		FROM 	CLIENTE WITH(NOLOCK INDEX=PK_CLIENTE)
		WHERE	clrut	 = @nRutcli	AND
			clcodigo = @nCodigo
	END

	SET	@nCorrDet 	= 0 	
	SET	@cTipoMov  	= 'S'	   -- S.suma R.resta
	SET	@cTipoLinea 	= 'L'	   -- L.linea
	SET	@cTipoControl 	= 'C'	   -- C.control
	SET	@nMatrizriesgo	= 0	
--	SET	@nMontolin	= ROUND(@nMonto/@nValmonlin,4)

	SELECT	@nMontolin	= @nMonto
	SELECT	@nMonto		= @nMonto_Orig


/*
		SET	@iFound		= 0
                --INTERPOLACION DEL FACTOR DE RIESGO Renato Quintana 20 de Noviembre de 2003
                --*************************************************************
                --Dias del Flujo
                SET  @Dias = DATEDIFF(day, @dFecPro, @dFecvctop)

                --Obtiener Flujo Inicial **************************************
                SET	@Flujo_Inicio	= 0  --Inicializa el Flujo de Inicio


                IF EXISTS(    SELECT	1
            		      FROM	MATRIZ_RIESGO WITH(NOLOCK)
    		    WHERE	codigo_grupo	= @ccodigo_grupo AND
			                dias_hasta     <= @Dias          AND
                  			codigo_moneda 	= @nMonedaMat1	 AND
                        		codigo_moneda2	= @nMonedaMat2    )
                BEGIN


			SELECT	@Dias_Inicio	= ISNULL(max(dias_desde),0) -- Obtiene la Fecha para buscar el Flujo de Inicio
			FROM	MATRIZ_RIESGO WITH(NOLOCK)
			WHERE	codigo_grupo	= @ccodigo_grupo AND
				dias_hasta     <= @Dias          AND
	                        codigo_moneda 	= @nMonedaMat1	 AND
				codigo_moneda2	= @nMonedaMat2

                
			SELECT	@Flujo_Inicio	= isnull(porcentaje,0)      -- Obtiene el Flujo de Inicio
			FROM	MATRIZ_RIESGO WITH(NOLOCK)
			WHERE	codigo_grupo	= @ccodigo_grupo AND
				dias_desde      = @Dias_Inicio   AND
                	        codigo_moneda 	= @nMonedaMat1	 AND
				codigo_moneda2	= @nMonedaMat2
                END
		ELSE
		BEGIN
			-- Si no Existe Flujo Anterior ( POR OBASAURE 09-03-2004 )
			-- Se asume como inicial el mismo porcentaje del primer flujo
			SELECT	@Flujo_Inicio	= isnull(porcentaje,0)
			FROM	MATRIZ_RIESGO WITH(NOLOCK)
			WHERE	codigo_grupo	= @ccodigo_grupo AND
				dias_desde     <= @Dias          AND
				dias_hasta     >= @Dias          AND
                        	codigo_moneda 	= @nMonedaMat1	 AND
				codigo_moneda2	= @nMonedaMat2

		
                END
                -- Fin Flujo Inicial **************************************


                --Obtiene Dias Inicial - Dias Final - Flujo Final
                SET	@Dias_Inicio	= 0
                SET     @Dias_Fin	= 0
                SET     @Flujo_fin      = 0
		SET     @iFound	        = 0

		SELECT	@Dias_Inicio	= dias_desde	,
                        @Dias_Fin	= dias_Hasta	,
			@Flujo_fin	= isnull(porcentaje,0),
			@iFound	        = 1
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	codigo_grupo	= @ccodigo_grupo AND
			dias_desde     <= @Dias          AND
			dias_hasta     >= @Dias          AND
                        codigo_moneda 	= @nMonedaMat1	 AND
			codigo_moneda2	= @nMonedaMat2
               

		SELECT	@iFound		= 1		,
			@nMatrizriesgo	= 100
		WHERE	@ccodigo_grupo	= 'SETTLE'



		IF @iFound = 1 BEGIN

			IF @Flujo_Fin <> @Flujo_Inicio
			BEGIN

	                        SET @Pendiente     = (@Dias_Fin - @Dias_Inicio)/(@Flujo_Fin - @Flujo_Inicio)
        	                SET @nMatrizriesgo = @Flujo_Inicio + (@Dias - @Dias_Inicio) / @Pendiente
			END
			ELSE
        		        SET @nMatrizriesgo = @Flujo_Inicio


			IF @nMatrizriesgo > 0
				SET @nMontolin = ROUND(@nMontolin / 100 * @nMatrizriesgo,4)

		END


*/
	SELECT	@iFound		= 0

	SELECT	@iFound			= 1			,
		@nRutcasamatriz		= GEN.rutcasamatriz	,
		@nCodigocasamatriz	= GEN.codigocasamatriz	,
		@nDisponible		= CASE WHEN SIS.compartido = 'S' THEN SUM(SIS.conriesgodisponible)
					       ELSE SUM(SIS.totaldisponible)
					  END			,
		@cBloqueado 		= GEN.bloqueado		,
		@dFecvctolinea 		= GEN.fechavencimiento
	FROM	LINEA_GENERAL AS GEN WITH(NOLOCK),
		LINEA_SISTEMA AS SIS WITH(NOLOCK)
	WHERE	GEN.rut_cliente		= @nRutcli		AND
		GEN.codigo_cliente	= @nCodigo		AND
		GEN.rut_cliente         = SIS.rut_cliente	AND
		GEN.codigo_cliente      = SIS.codigo_cliente    AND
                SIS.codigo_grupo      <> 'SETTLE'
	GROUP BY GEN.rutcasamatriz	,
		 GEN.codigocasamatriz	,
		 SIS.compartido		,
		 GEN.bloqueado		,
		 GEN.fechavencimiento

	IF @iFound = 1 BEGIN

		-- SP_HELP LINEA_TRANSACCION
		
		INSERT INTO LINEA_TRANSACCION WITH (ROWLOCK)
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
			activo                  ,
                        codigo_grupo            ,
       			codigo_moneda
			)
		VALUES(
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
			'S'                     ,
                        @ccodigo_grupo          ,
                        @nMonedalin  )
		--FROM	PRODUCTO
		--WHERE	@cProducto=codigo_producto

		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/********** LINEA CASA MATRIZ *********************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
/*		IF @nRutcasamatriz > 0	BEGIN


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

			UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
			SET	totalocupado	= totalocupado    + @nMontolin	,
				totaldisponible = totaldisponible - @nMontolin
			WHERE	rutcasamatriz 	= @nRutcasamatriz	AND
				codigocasamatriz= @nCodigocasamatriz


			SELECT  @cMensaje  = ' '	,
				@cError    = 'N',
				@nExceso   = 0  ,
				@Cod_Error = ' '
			SELECT	@nCorrDet = @nCorrDet + 1

			INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
					(
					NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	   ,
					Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error	   ,
					Codigo_Excepcion, Mensaje_Error  , codigo_grupo     , codigo_moneda      )
			SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema	   ,
					@cProducto      , @cTipoLinea  	 , @cTipoMov        , 'MATRIZ'	    	 , @nMontolin      ,
					@nExceso   	, 0         	 , 0         	    , 'S' 		 , @cError	   ,
					@Cod_Error  	, @cMensaje      , @ccodigo_grupo   , @nMonedalin	

			/**************************************************************************/
			/****** SIN RIESGO ********************************************************/
			/**************************************************************************/
			IF @cTipo_Riesgo = 'S' BEGIN
				If @nSinriesgoDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN
					SELECT @nExceso = @nSinriesgoDisponible - @nMontolin
				END

				UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
				SET	Sinriesgoocupado	= Sinriesgoocupado    + @nMontolin ,
				        Sinriesgodisponible	= Sinriesgodisponible - @nMontolin
				WHERE	rutcasamatriz 		= @nRutcasamatriz	AND
					codigocasamatriz	= @nCodigocasamatriz

				SELECT  @cMensaje  = ' ' ,
					@cError    = 'N' ,
					@nExceso   = 0   ,
					@Cod_Error = ' '

				SELECT	@nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
						(
						NumeroOperacion	, NumeroDocumento    , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	,
						Codigo_Producto , Tipo_Detalle	    , Tipo_Movimiento	, Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	     , PlazoHasta	, Actualizo_Linea    , Error		,
						Codigo_Excepcion, Mensaje_Error      , codigo_grupo     , codigo_moneda      )
				SELECT		@nNumoper	, @nNumdocu	     , @nCorrela        , @nCorrDet          , @cSistema	,
						@cProducto	, @cTipoLinea	     , @cTipoMov	, 'MAT_SR'	     , @nMontolin       ,
						@nExceso	, 0   		     , 0 		, 'S'		     , @cError		,
						@Cod_Error	, @cMensaje          , @ccodigo_grupo   , @nMonedalin	
   			END

			/**************************************************************************/
			/******* CON RIESGO *******************************************************/
			/**************************************************************************/
			IF @cTipo_Riesgo = 'C'BEGIN
				If @nConriesgoDisponible < 0 BEGIN
					SELECT @nExceso = ABS(@nMontolin)
				END ELSE BEGIN 
					SELECT @nExceso = @nConriesgoDisponible - @nMontolin
				END

				UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
				SET	Conriesgoocupado	= Conriesgoocupado    + @nMontolin	,
					Conriesgodisponible	= Conriesgodisponible - @nMontolin
				WHERE	rutcasamatriz 		= @nRutcasamatriz	AND
					codigocasamatriz	= @nCodigocasamatriz

				SELECT  @cMensaje  = ' '	 ,
					@cError    = 'N' ,
					@nExceso   = 0   ,
					@Cod_Error = ' '

				SELECT	@nCorrDet = @nCorrDet + 1

				INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
						(
						NumeroOperacion	, NumeroDocumento   , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema	,
						Codigo_Producto , Tipo_Detalle      , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso	, PlazoDesde	    , PlazoHasta       , Actualizo_Linea    , Error   		,
						Codigo_Excepcion, Mensaje_Error     , codigo_grupo     , codigo_moneda      )
				SELECT		@nNumoper       , @nNumdocu         , @nCorrela        , @nCorrDet          , @cSistema 	,
						@cProducto      , @cTipoLinea       , @cTipoMov        , 'MAT_CR'	    , @nMontolin      	,
						@nExceso  	, 0 		    , 0		       , 'S'		    , @cError 		,
						@Cod_Error	, @cMensaje         , @ccodigo_grupo   , @nMonedalin	
			END
		END*/

		SELECT	@iFound			= 1			,
			@nRutcasamatriz		= GEN.rutcasamatriz	,
			@nCodigocasamatriz	= GEN.codigocasamatriz	,
			@nDisponible		= CASE WHEN SIS.compartido = 'S' THEN SUM(SIS.conriesgodisponible) ELSE SUM(SIS.totaldisponible) END,
			@cBloqueado 		= GEN.bloqueado		,
			@dFecvctolinea 		= GEN.fechavencimiento
	       	FROM	LINEA_GENERAL GEN  WITH (NOLOCK),
			LINEA_SISTEMA SIS  WITH (NOLOCK)
		WHERE	GEN.rut_cliente		= @nRutcli		AND
			GEN.codigo_cliente	= @nCodigo		AND
			GEN.rut_cliente         = SIS.rut_cliente	AND
			GEN.codigo_cliente      = SIS.codigo_cliente    AND
                        SIS.codigo_grupo        <> 'SETTLE'
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
				@cError = 'S'						,
				@nExceso  = 0						,
				@nCorrDet = @nCorrDet + 1                               ,
                                @Cod_Error = 'LB'

			INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
					(
					NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error,codigo_grupo,codigo_moneda
					)
			SELECT		@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema	,
					@cProducto	, @cTipoControl  , @cTipoMov	    , 'LINGEN'		 , @nMontolin   ,
					@nExceso	, 0	         , 0         	    , 'S'		 , @cError 	,
					@Cod_Error  	, @cMensaje ,@ccodigo_grupo,@nMonedalin	
		END

	
		IF @dFecPro > @dFecvctolinea BEGIN
			SELECT  @cMensaje  = 'Linea General Vencida Para ' + @cNombre 	,
				@cError    = 'S'					,
				@nExceso   = 0						,
				@nCorrDet  = @nCorrDet + 1                              ,
                                @Cod_Error = 'LV'

			INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
					(
					NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error ,codigo_grupo
					)
			SELECT		@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
					@cProducto      , @cTipoControl  , @cTipoMov        , 'LINGEN'	         , @nMontolin      	,
					@nExceso   	, 0 	         , 0         	    , 'S'		 , @cError 		,
					@Cod_Error  	, @cMensaje ,@ccodigo_grupo	
		END

		IF @nDisponible < 0 BEGIN
			SELECT @nExceso = @nMontolin * (-1)
		END ELSE BEGIN
			SELECT @nExceso = @nDisponible - @nMontolin
		END

	        UPDATE	LINEA_GENERAL WITH (ROWLOCK)
		SET	totalocupado	= totalocupado  + @nMontolin	,
			totaldisponible = totaldisponible - @nMontolin
		WHERE	rut_cliente	= @nRutcli 
		AND	codigo_cliente	= @nCodigo

		SELECT  @Cod_Error = '',
			@cExceso_General = 'N'


                IF @nExceso < 0
			SELECT  @Cod_Error = 'SC',
				@cExceso_General = 'S'



		IF @nExceso < 0
			SELECT  @cMensaje = 'Linea General Excedido Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = ABS(@nExceso),
                		@Exceso_General = 'S'
		ELSE
			SELECT  @cMensaje	= ' '	,
				@cError		= 'N'	,
				@nExceso	= 0	,
                                @Cod_Error	= ' '	,
                                @Exceso_General = ' '

		SELECT	@nCorrDet = @nCorrDet + 1

		INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
					(
					NumeroOperacion , NumeroDocumento , NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto , Tipo_Detalle	  , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso     , PlazoDesde	  , PlazoHasta	     , Actualizo_Linea	  , Error  		,
					Codigo_Excepcion, Mensaje_Error   , codigo_grupo     , codigo_moneda      )
		SELECT			@nNumoper       , @nNumdocu       , @nCorrela        , @nCorrDet          , @cSistema		,
					@cProducto      , @cTipoLinea     , @cTipoMov        , 'LINGEN'	          , @nMontolin      	,
					@nExceso   	, 0	          , 0      	     , 'S'  		  , @cError 		,
					@Cod_Error  	, @cMensaje       , @ccodigo_grupo   , @nMonedalin	

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
		FROM	LINEA_SISTEMA  WITH (NOLOCK)
		WHERE	rut_cliente	= @nRutcli		AND
			codigo_cliente	= @nCodigo		AND
			Codigo_grupo	= @cCodigo_grupo

		/**************************************************************************/
		/******* Linea Sistema Bloqueada para operar ******************************/
		/**************************************************************************/
/*
		IF @cBloqueado ='S' BEGIN

			SELECT  @cMensaje = 'Linea Grupo ' + ltrim(rtrim(@cCodigo_grupo)) + ' Bloqueada Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = 0						,
				@nCorrDet = @nCorrDet + 1                               ,
                                @Cod_Error = 'LB'

			INSERT INTO LINEA_TRANSACCION_DETALLE
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle   , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error   		,
						Codigo_Excepcion, Mensaje_Error,codigo_grupo,codigo_moneda
						)
			SELECT			@nNumoper	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
						@cProducto      , @cTipoControl  , @cTipoMov        , 'LINSIS'	         , @nMontolin      	,
						@nExceso   	, 0	         , 0         	    , 'S'		 , @cError 		,
						@Cod_Error  	, @cMensaje ,@ccodigo_grupo,@nMonedalin	
		END
*/

	
		IF @dFecPro>@dFecvctolinea BEGIN
			SELECT  @cMensaje  = 'Linea Grupo ' + ltrim(rtrim(@cCodigo_grupo)) + ' Vencida Para ' + @cNombre 	,
				@cError    = 'S'						,
				@nExceso   = 0						,
				@nCorrDet  = @nCorrDet + 1                               ,
                                @Cod_Error = 'LV'

			INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
						(
						NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
						Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
						MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error                ,
						Codigo_Excepcion, Mensaje_Error,codigo_grupo,codigo_moneda
						)
			SELECT			@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema		,
						@cProducto      , @cTipoControl  , @cTipoMov        , 'LINSIS'	         , @nMontolin      	,
						@nExceso	, 0  		 , 0 		    , 'S' 		 , @cError 		,
						@Cod_Error  	, @cMensaje ,@ccodigo_grupo,@nMonedalin	
		END




		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S' SELECT @ndisponible = @nSinriesgodisponible
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C' SELECT @ndisponible = @nConriesgodisponible

		If @nDisponible < 0 BEGIN
			SELECT @nExceso = ABS(@nMontolin)
		END ELSE BEGIN
			SELECT @nExceso = @nDisponible - @nMontolin
		END

		SELECT  @Cod_Error = ' ',
			@cExceso_Sistema = 'N'


                IF @nExceso < 0
			SELECT  @Cod_Error = 'SG',
				@cExceso_Sistema = 'S'

		IF @cCompartido = 'N' 				SELECT @cTipoOperacion = 'LINSIS'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cTipoOperacion = 'LINSSR'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cTipoOperacion = 'LINSCR'


		IF @cCompartido = 'N' 				SELECT @cMensaje_Compartido = ''
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cMensaje_Compartido = 'Sin Riesgo'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cMensaje_Compartido = 'Con Riesgo'


		IF @Cod_Error <> ' ' BEGIN

			IF @cExceso_General = 'N'
				SELECT  @cMensaje = 'Linea Grupo ' + ltrim(rtrim(@cCodigo_grupo)) + ' ' + @cMensaje_Compartido + ' Excedido Para ' + @cNombre 	,
					@cError   = 'S'						,
					@nExceso  = ABS(@nExceso)
			Else
				SELECT  @cMensaje = '',
					@cError   = 'N',
					@nExceso  = ABS(@nExceso),
					@Cod_Error=' '

		END ELSE BEGIN
			SELECT  @cMensaje = ' '	,
				@cError   = 'N'	,
				@nExceso  = 0   ,
                       	        @Cod_Error = ' '
		END
			

		IF @cCompartido = 'N'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				ConRiesgoOcupado	= ConRiesgoOcupado	+ @nMontolin	,
				ConRiesgoDisponible	= ConRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo

		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				SinRiesgoOcupado	= SinRiesgoOcupado	+ @nMontolin	,
				SinRiesgoDisponible	= SinRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo

		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				ConRiesgoOcupado	= ConRiesgoOcupado	+ @nMontolin	,
				ConRiesgoDisponible	= ConRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo


		SELECT @nCorrDet = @nCorrDet + 1

		INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
					(
					NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto , Tipo_Detalle   , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso     , PlazoDesde     , PlazoHasta       , Actualizo_Linea    , Error		,
					Codigo_Excepcion, Mensaje_Error ,codigo_grupo,codigo_moneda
					)
		SELECT			@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
					@cProducto      , @cTipoLinea    , @cTipoMov        , @cTipoOperacion    , @nMontolin      	,
					@nExceso   	, 0         	 , 0         	    , 'S' 		 , @cError 		,
					@Cod_Error  	, @cMensaje ,@ccodigo_grupo,@nMonedalin	



		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/***** LINEA POR PLAZO ****************************************************/
		/**************************************************************************/
		/**************************************************************************/
		/**************************************************************************/

		IF @cCtrlplazo = 'S' BEGIN


			SELECT	@nContPlazosTotales = COUNT(*)
		       	FROM	LINEA_POR_PLAZO WITH (NOLOCK)
			WHERE	rut_cliente	=  @nRutcli				AND
				codigo_cliente	=  @nCodigo				AND
				codigo_grupo	=  @ccodigo_grupo			AND
				DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta


			SELECT	@nContPlazosLeidos = 0


			DECLARE cursor_plazos SCROLL CURSOR FOR
         		SELECT	PlazoDesde,
				PlazoHasta,
				Totaldisponible,
				Sinriesgodisponible,
				Conriesgodisponible
		       	FROM	LINEA_POR_PLAZO WITH (NOLOCK)
			WHERE	rut_cliente	=  @nRutcli			AND
				codigo_cliente	=  @nCodigo			AND
				codigo_grupo	=  @ccodigo_grupo		AND
--				DATEDIFF(day, @dFecPro, @dFecvctop) >= plazodesde	AND
				DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta
			ORDER BY plazohasta


--select * from LINEA_TRANSACCION

			SELECT @nMontolinPlazo = @nMontolin

			OPEN cursor_plazos

			WHILE (1=1)
			BEGIN


				FETCH NEXT FROM cursor_plazos
				INTO	@nPlazoDesde,
					@nPlazoHasta,
					@ndisponible,
					@nSinriesgodisponible,
					@nConriesgodisponible



				IF (@@fetch_status <> 0) BEGIN
					BREAK
				END



				SELECT @nContPlazosLeidos = @nContPlazosLeidos + 1



				IF @nMontolinPlazo > 0
				BEGIN


					SELECT	@nMontolin = @nMontolinPlazo


					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S' SELECT @ndisponible = @nSinriesgodisponible
					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C' SELECT @ndisponible = @nConriesgodisponible



					IF @nDisponible < 0 BEGIN
						SELECT @nExceso = ABS(@nMontolin)
					END ELSE BEGIN
						SELECT @nExceso = @nDisponible - @nMontolin
					END


					IF @nExceso < 0 AND @nContPlazosLeidos < @nContPlazosTotales
					BEGIN

						SELECT	@nMontolinPlazo = ABS(@nExceso)
						SELECT	@nExceso = 0

						SELECT  @nMontolin = @nDisponible

					END
					ELSE BEGIN
						SELECT	@nMontolinPlazo = 0
					END




					IF @cCompartido = 'N' 
						UPDATE 	LINEA_POR_PLAZO	WITH (ROWLOCK)
						SET 	totalocupado		=  totalocupado    	+ @nMontolin	,
							totaldisponible 	=  totaldisponible 	- @nMontolin	,
							ConRiesgoocupado	=  ConRiesgoocupado	+ @nMontolin	,
							ConRiesgodisponible	=  ConRiesgodisponible	- @nMontolin
						WHERE	rut_cliente	=  @nRutcli		AND
							codigo_cliente	=  @nCodigo		AND
							codigo_grupo 	=  @ccodigo_grupo	AND
							plazodesde	=  @nPlazoDesde		AND
							plazohasta	=  @nPlazoHasta

--							DATEDIFF(day, @dFecPro, @dFecvctop) >= plazodesde	AND
--							DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta



					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'
						UPDATE 	LINEA_POR_PLAZO	WITH (ROWLOCK)
						SET 	totalocupado		=  totalocupado		+ @nMontolin	,
							totaldisponible		=  totaldisponible	- @nMontolin	,
							SinRiesgoocupado	=  SinRiesgoocupado	+ @nMontolin	,
							SinRiesgodisponible	=  SinRiesgodisponible	- @nMontolin
						WHERE	rut_cliente	=  @nRutcli		AND
							codigo_cliente	=  @nCodigo		AND
							codigo_grupo 	=  @ccodigo_grupo	AND
							plazodesde	=  @nPlazoDesde		AND
							plazohasta	=  @nPlazoHasta


					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'
						UPDATE 	LINEA_POR_PLAZO	WITH (ROWLOCK)
						SET 	totalocupado		=  totalocupado		+ @nMontolin	,
							totaldisponible		=  totaldisponible	- @nMontolin	,
							ConRiesgoocupado	=  ConRiesgoocupado	+ @nMontolin	,
							ConRiesgodisponible	=  ConRiesgodisponible	- @nMontolin
						WHERE	rut_cliente	=  @nRutcli		AND
							codigo_cliente	=  @nCodigo		AND
							codigo_grupo 	=  @ccodigo_grupo	AND
							plazodesde	=  @nPlazoDesde		AND
							plazohasta	=  @nPlazoHasta



					SELECT @cTipoOperacion = ''

					IF @cCompartido = 'N' 				SELECT @cTipoOperacion = 'LINPZO'
					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cTipoOperacion = 'LINPSR'
					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cTipoOperacion = 'LINPCR'


	
					IF @cCompartido = 'N' 				SELECT @cMensaje_Compartido = ''
					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cMensaje_Compartido = 'Sin Riesgo'
					IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cMensaje_Compartido = 'Con Riesgo'




					SELECT  @Cod_Error = ' '

		        	        IF @nExceso < 0 SELECT  @Cod_Error = 'SP'



					IF @Cod_Error <> ' ' BEGIN
						IF @cExceso_Sistema = 'N' AND @cExceso_general = 'N'
							SELECT  @cMensaje = 'Linea Por Plazo ' + ltrim(rtrim(@cCodigo_grupo)) + ' ' + @cMensaje_Compartido + ' Excedido Para ' + @cNombre 	,
								@cError   = 'S',
								@nExceso  = ABS(@nExceso)
						ELSE
							SELECT  @cMensaje = '',
								@cError   = 'N',
								@nExceso  = ABS(@nExceso),
								@Cod_Error=' '

					END ELSE BEGIN
						SELECT  @cMensaje = ' '	,
							@cError   = 'N'	,
							@nExceso  = 0   ,
	                        		        @Cod_Error = ' '
					END


					SELECT	@nCorrDet  = @nCorrDet + 1


					INSERT INTO LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
							(
							NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
							Codigo_Producto , Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
							MontoExceso	, PlazoDesde	 , PlazoHasta  	    , Actualizo_Linea	 , Error 		,
							Codigo_Excepcion, Mensaje_Error ,codigo_grupo,codigo_moneda
							)
					SELECT		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
							@cProducto      , @cTipoLinea    , @cTipoMov        , @cTipoOperacion    , @nMontolin           ,
							@nExceso        , @nPlazoDesde	 , @nPlazoHasta	    , 'S'  		 , @cError		,
							@Cod_Error	, @cMensaje ,@ccodigo_grupo,@nMonedalin	
        	                END
			END
	


			CLOSE cursor_plazos
			DEALLOCATE cursor_plazos

                END

		EXECUTE SP_LINEAS_ACTUALIZA @nRutcli


	END ELSE BEGIN
		SELECT	'NO','ERROR: No Existe Linea Definida ' + @cNombre
		RETURN
	END

END
GO
