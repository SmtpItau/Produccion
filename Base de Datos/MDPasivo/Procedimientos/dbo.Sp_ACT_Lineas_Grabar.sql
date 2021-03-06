USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ACT_Lineas_Grabar]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ACT_Lineas_Grabar]
			(
			@dFecPro 	DATETIME	,
			@cSistema	CHAR	(03)	,
			@cProducto	CHAR	(05)	,
			@nRutcli	NUMERIC	(10,0)	,
			@nCodigo	NUMERIC	(10,0)	,
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
			@cCodigo_Grupo	CHAR	(10)    ,
			@nMoneda1	NUMERIC	(03)	,
			@nMoneda2	NUMERIC	(03)	,
			@nMatrizriesgo	NUMERIC	(08,4)	,
			@nMonto_ORIG	FLOAT	= 0

			)
AS BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy
	DECLARE @nRutcasamatriz		NUMERIC	(09,0)
	DECLARE @nCodigocasamatriz	NUMERIC	(09,0)
--	DECLARE @nMatrizriesgo		NUMERIC	(08,4)
	DECLARE @Mto_Sobregiro 		FLOAT	--NUMERIC	(19,4)
	DECLARE @nSinriesgodisponible	FLOAT	--NUMERIC	(19,4)
	DECLARE @nConriesgodisponible	FLOAT	--NUMERIC	(19,4)
	DECLARE @nContPlazosTotales	NUMERIC	(05,0)
	DECLARE @nContPlazosLeidos	NUMERIC	(05,0)
	DECLARE @nMontolinPlazo      	NUMERIC(19,4)
	DECLARE @nMonedalin		NUMERIC	(05,0)
	DECLARE @nValmonlin		NUMERIC	(10,4)
	DECLARE @nMontolin		FLOAT	--NUMERIC	(19,4)
	DECLARE @nPlazoDesde 		NUMERIC	(05,0)
	DECLARE @nPlazoHasta		NUMERIC	(05,0)
	DECLARE @nExceso 		FLOAT	--NUMERIC	(19,4)
	DECLARE @nDisponible		FLOAT	--NUMERIC	(19,4)
	DECLARE @cMensaje		VARCHAR	(255)
	DECLARE @cMensaje_Compartido	VARCHAR	(255)
	DECLARE @cTipoMov 		VARCHAR	(01)
	DECLARE @cTipoLinea 		VARCHAR	(01)
	DECLARE @cTipoControl 		VARCHAR	(01)
	DECLARE @cTipoOperacion		VARCHAR	(10)
	DECLARE @cError 		VARCHAR	(01)
	DECLARE @Cod_Error 		VARCHAR	(02)
	DECLARE @Exceso_General 	VARCHAR	(01)
	DECLARE @cExceso_General	CHAR(1)
	DECLARE @cExceso_Sistema	CHAR(1)
	DECLARE @cCtrlplazo		CHAR	(01)
	DECLARE @cCompartido		CHAR	(01)
	DECLARE @cBloqueado		CHAR	(01)
	DECLARE @cNombre		CHAR	(60)
	DECLARE @cNombreCMatriz		CHAR	(60)
	DECLARE @dFecvctolinea		DATETIME
	DECLARE @nCorrDet		NUMERIC (05)
	DECLARE	@IFound			INTEGER	
	DECLARE @valor_moneda 		FLOAT
	DECLARE @Diferencia_Exceso	FLOAT
	DECLARE	@contador		NUMERIC(10)
	DECLARE	@sw			CHAR(1)

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
		FROM 	cliente
		WHERE	clrut	 = @nRutcli
	END ELSE BEGIN
		SELECT 	@cNombre = clnombre
		FROM 	cliente
		WHERE	clrut	 = @nRutcli	AND
			clcodigo = @nCodigo
	END

	SELECT  @nCorrDet 	= 0  ,
		@cTipoMov  	= 'S',   -- S.suma R.resta
		@cTipoLinea 	= 'L',   -- L.linea
		@cTipoControl 	= 'C',   -- C.control
		@valor_moneda 	= 1

	SELECT @valor_moneda = ISNULL(vmvalor, 1)
        FROM VALOR_MONEDA
	INNER JOIN DATOS_GENERALES ON
		vmcodigo = moneda_control	AND
		vmfecha  = @dFecPro		AND
		moneda_control <> 999


	SELECT	@nMonedalin	= moneda_control			,
		@nValmonlin	= @valor_moneda			        ,
		@nMontolin	= ROUND(@nMonto / @valor_moneda, 4)	,
		--@nMatrizriesgo	= 0                                     ,
                @Mto_Sobregiro  = primer_tramo * vmvalor
	FROM	DATOS_GENERALES
	INNER JOIN valor_moneda ON 
		vmcodigo = 998	AND
		vmfecha  = @dFecPro

--select @nMontolin, @nMonto , @valor_moneda, @nMonto_ORIG, @dFecPro

	SELECT	@nMonto = @nMonto_ORIG

--select @nMontolin, @nMonto , @valor_moneda, @nMonto_ORIG





/*	

	SELECT	@IFound		= 0,
		@nMatrizriesgo	= 0

	SELECT	@IFound		= 1		,
		@nMatrizriesgo	= matrizriesgo
	FROM	#MATRIZ_ANTERIOR
	WHERE	Id_Sistema		= @cSistema	AND	NumeroOperacion		= @nNumoper
	AND	NumeroDocumento		= @nNumdocu	AND	NumeroCorrelativo	= @nCorrela
	AND	matrizriesgo		<> 0
*/
	/*
	IF @IFound = 1 
	BEGIN
		SELECT @nMontolin = ROUND(@nMontolin/100*@nMatrizriesgo,4)
	END
	ELSE	
	BEGIN
	*/
	                -- INTERPOLACION DEL FACTOR DE RIESGO Renato Quintana 20 de Noviembre de 2003
	                -- *************************************************************
	             -- Dias del Flujo
	                -- SELECT  @Dias = DATEDIFF(day, @dFecPro, @dFecvctop)
		                --Obtiener Flujo Inicial **************************************
	                --SELECT	@Flujo_Inicio	= 0  --Inicializa el Flujo de Inicio
			
--	                IF exists(SELECT * FROM	MATRIZ_RIESGO WHERE	codigo_grupo	= @ccodigo_grupo AND dias_hasta<= @Dias AND codigo_moneda = @nMoneda1	 AND codigo_moneda2= @nMoneda2 )
--	                BEGIN
				/*
						SELECT	@Dias_Inicio	= ISNULL(max(dias_desde),0) -- Obtiene la Fecha para buscar el Flujo de Inicio
						FROM	MATRIZ_RIESGO
						WHERE	codigo_grupo	= @ccodigo_grupo AND
							dias_hasta     <= @Dias          AND
				                        codigo_moneda 	= @nMoneda1	 AND
							codigo_moneda2	= @nMoneda2
			                
						SELECT	@Flujo_Inicio	= isnull(porcentaje,0)      -- Obtiene el Flujo de Inicio
						FROM	MATRIZ_RIESGO
						WHERE	codigo_grupo	= @ccodigo_grupo AND
							dias_desde      = @Dias_Inicio   AND
				                        codigo_moneda 	= @nMoneda1	 AND
							codigo_moneda2	= @nMoneda2
					END
					ELSE
					BEGIN
						-- Si no Existe Flujo Anterior ( POR OBASAURE 09-03-2004 )
						-- Se asume como inicial el mismo porcentaje del primer flujo
						SELECT	@Flujo_Inicio	= isnull(porcentaje,0)
						FROM	MATRIZ_RIESGO
						WHERE	codigo_grupo	= @ccodigo_grupo AND
							dias_desde     <= @Dias          AND
							dias_hasta     >= @Dias          AND
				                        codigo_moneda 	= @nMoneda1	 AND
							codigo_moneda2	= @nMoneda2
			                END
			                -- Fin Flujo Inicial **************************************
			
			
			                --Obtiene Dias Inicial - Dias Final - Flujo Final
			                SELECT	@Dias_Inicio	= 0,
			                        @Dias_Fin	= 0,
			                        @Flujo_fin      = 0,
						@iFound	        = 0
			
					SELECT	@Dias_Inicio	= dias_desde	,
			                        @Dias_Fin	= dias_Hasta	,
						@Flujo_fin	= isnull(porcentaje,0),
						@iFound	      = 1
					FROM	MATRIZ_RIESGO
					WHERE	codigo_grupo	= @ccodigo_grupo AND
						dias_desde     <= @Dias          AND
						dias_hasta     >= @Dias          AND
			                        codigo_moneda 	= @nMoneda1	 AND
						codigo_moneda2	= @nMoneda2
			
			
			--SELECT	@Dias_Inicio, @Dias_Fin, @Flujo_Inicio, @Flujo_fin
			               
			
					IF @iFound = 1 BEGIN
			
						IF @Flujo_Fin <> @Flujo_Inicio
						BEGIN
					                SELECT @Pendiente     = (@Dias_Fin - @Dias_Inicio)/(@Flujo_Fin - @Flujo_Inicio)
			        		        SELECT @nMatrizriesgo = @Flujo_Inicio + (@Dias - @Dias_Inicio) / @Pendiente
						END
						ELSE
						SET	@nMatrizriesgo = @Flujo_Inicio
					*/
/*				EXECUTE SP_BUSCA_INTERPOLACION_FACTOR_RIESGO @cCodigo_Grupo , @nMoneda1 , @nMoneda2 ,@dFecPro, @dFecvctop ,@nMontolin , @nMatrizriesgo OUTPUT
			IF @nMatrizriesgo > 0 
				SELECT @nMontolin = ROUND(@nMontolin / 100 * @nMatrizriesgo,4)
			ELSE
				INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': Matriz de Riesgo en 0 Para ' + CONVERT(CHAR(03),@nMoneda1) + '-' +CONVERT(CHAR(03),@nMoneda2) + '-' + @ccodigo_grupo
		END
		ELSE 
		BEGIN
			INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': No Existe Matriz de Riesgo Para ' + CONVERT(CHAR(03),@nMoneda1) + '-' +CONVERT(CHAR(03),@nMoneda2) + '-' + @ccodigo_grupo
		END
	END

	IF @nMatrizriesgo > 0 
		SELECT @nMontolin = ROUND(@nMontolin / 100 * @nMatrizriesgo,4)
	ELSE
		INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': Matriz de Riesgo en 0 Para ' + CONVERT(CHAR(03),@nMoneda1) + '-' +CONVERT(CHAR(03),@nMoneda2) + '-' + @ccodigo_grupo
*/


	SELECT	@nMatrizriesgo = 0


	SELECT	@IFound			= 0
	SELECT	@IFound			= 1			,
		@nRutcasamatriz		= GEN.rutcasamatriz	,
		@nCodigocasamatriz	= GEN.codigocasamatriz	,
		@nDisponible		= CASE WHEN SIS.compartido = 'N' THEN SUM(SIS.conriesgodisponible) ELSE SUM(SIS.totaldisponible) END,
		@cBloqueado 		= GEN.bloqueado		,
		@dFecvctolinea 		= GEN.fechavencimiento
       	FROM	LINEA_GENERAL AS GEN , --WITH (NOLOCK INDEX=id_linea_general),
		LINEA_SISTEMA AS SIS   --WITH (NOLOCK INDEX=id_LINEA_SISTEMA) 
	WHERE	GEN.rut_cliente		= @nRutcli		AND
		GEN.codigo_cliente	= @nCodigo		AND
		GEN.rut_cliente         = SIS.rut_cliente	AND
		GEN.codigo_cliente      = SIS.codigo_cliente
	GROUP BY GEN.rutcasamatriz	,
		 GEN.codigocasamatriz	,
		 SIS.compartido		,
		 GEN.bloqueado		,
		 GEN.fechavencimiento


	IF @IFound = 1 BEGIN


		INSERT INTO LINEA_TRANSACCION
			(
			NumeroOperacion    ,
			NumeroDocumento    ,
			NumeroCorrelativo  ,
			Rut_Cliente        ,
			Codigo_Cliente     ,
			Id_Sistema         ,
			Codigo_Grupo       ,
			Tipo_Operacion     ,
			Tipo_Riesgo        ,
			FechaInicio     ,
			FechaVencimiento   ,
			MontoOriginal      ,
			TipoCambio     ,
			MatrizRiesgo       ,
			MontoTransaccion   ,
			Operador           ,
			Activo
			)
		SELECT
			@nNumoper		,
			@nNumdocu		,
			@nCorrela		,
			@nRutcli		,
			@nCodigo		,
			@cSistema		,
			@cCodigo_grupo		,
			' '			,
			@cTipo_Riesgo		,
			@dFeciniop		,
			@dFecvctop		,
			@nMonto			,
			@fTipcambio		,
			@nMatrizriesgo		,
			@nMontolin		,
			@cUsuario		,
			'S'


		SELECT @Diferencia_Exceso=0

		/************************************************************7************************/
		/************************************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		/*** LINEA GENERAL ******************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		IF @cBloqueado = 'S' BEGIN  --** Linea General Bloqueada para operar **--
			SELECT  @cMensaje  = 'Linea General Bloqueada Para ' + @cNombre 	,
				@cError    = 'S'						,
				@nExceso   = 0						,
				@nCorrDet  = @nCorrDet + 1 ,
                                @Cod_Error = 'LB'

			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto , Codigo_Grupo	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
			SELECT 		@nNumoper       , @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
					@cProducto      , @CCodigo_Grupo , @cTipoControl  , @cTipoMov        , 'LINGEN'	     	 , @nMontolin           ,
					@nExceso   	, 0         	 , 0         	    , 'S'            	 , @cError 		,
					@Cod_Error  	, @cMensaje
		END

	
		IF @dFecPro > @dFecvctolinea BEGIN
			SELECT	@cMensaje	= 'Linea General Vencida Para ' + @cNombre 	,
				@cError		= 'S'						,
				@nExceso	= 0						,
				@nCorrDet	= @nCorrDet + 1                               ,
				@Cod_Error	= 'LV'
			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Codigo_Grupo, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
			SELECT 		@nNumoper      	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
					@cProducto      , @cCodigo_Grupo , @cTipoControl  , @cTipoMov        , 'LINGEN'	     	 , @nMontolin      	,
					@nExceso   	, 0	         , 0         	    , 'S'            	 , @cError 		,
					@Cod_Error  	, @cMensaje
		END

		IF @nDisponible < 0 BEGIN
			SELECT @nExceso = @nMontolin * (-1)
		END ELSE BEGIN
			SELECT @nExceso = @nDisponible - @nMontolin
		END

		UPDATE	LINEA_GENERAL
		SET	totalocupado	= totalocupado  + @nMontolin	,
			totaldisponible = totaldisponible - @nMontolin
		WHERE	rut_cliente	= @nRutcli 	AND
			codigo_cliente	= @nCodigo


--		EXECUTE sp_lineas_actualiza @nRutcli


		SELECT  @Cod_Error = '',
			@cExceso_General='N'



       IF @nExceso < 0
			SELECT  @Cod_Error = 'SC',
				@cExceso_General='S'


		IF @nExceso < 0 BEGIN
			SELECT  @cMensaje 	= 'Limite General Excedido Para ' + @cNombre 	,
				@cError   	= 'S'						,
				@nExceso  	= @nExceso * (-1)				,
                                @Exceso_General = 'S'
		END ELSE BEGIN
			SELECT  @cMensaje	= ' '	,
				@cError		= 'N'	,
				@nExceso	= 0	,
                                @Cod_Error	= ' '	,
                                @Exceso_General = ' '
		END

		SELECT	@nCorrDet = @nCorrDet + 1
		INSERT INTO LINEA_TRANSACCION_DETALLE
					(
					NumeroOperacion , NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto , Codigo_Grupo	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
		SELECT 			@nNumoper      	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,
					@cProducto     	, @cCodigo_Grupo, @cTipoLinea  	 , @cTipoMov        , 'LINGEN'	     	 , @nMontolin      	,
					@nExceso   	, 0         	 , 0         	    , 'S'            	 , @cError 		,
					@Cod_Error  	, @cMensaje

		/************************************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		/***** LINEA SISTEMA ****************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		/************************************************************************************/


		SELECT	@IFound			= 0

		SELECT	@IFound			= 1,
			@cCtrlplazo		= controlaplazo		,
                        @cCompartido    	= Compartido            ,
			@nDisponible		= CASE WHEN Compartido = 'N' THEN Conriesgodisponible ELSE @nDisponible END,
			@cBloqueado 		= bloqueado		,
			@dFecvctolinea 		= fechavencimiento	,
			@nSinriesgodisponible	= Sinriesgodisponible	,
			@nConriesgodisponible	= Conriesgodisponible
	       	FROM	LINEA_SISTEMA --WITH (NOLOCK INDEX=id_LINEA_SISTEMA) 
		WHERE	rut_cliente	= @nRutcli	AND
			codigo_cliente	= @nCodigo	AND
			codigo_grupo 	= @ccodigo_grupo 


		IF @IFound = 0
		BEGIN
			INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': No Existe Linea por Grupo ' + ISNULL(LTRIM(RTRIM(@cNombre)),'') + ' - ' + @ccodigo_grupo
			RETURN
		END



		/****************************************************************************/
		/******** Linea Sistema Bloqueada para operar *******************************/
		/****************************************************************************/
	
		IF @dFecPro > @dFecvctolinea BEGIN
			SELECT  @cMensaje = 'Linea Grupo Vencida Para ' + @cNombre 	,
				@cError   = 'S'						,
				@nExceso  = 0						,
				@nCorrDet = @nCorrDet + 1                               ,
                                @Cod_Error = 'LV'

			INSERT INTO LINEA_TRANSACCION_DETALLE
					(
				 	NumeroOperacion	, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Id_Sistema		,
					Codigo_Producto	, Codigo_Grupo	, Tipo_Detalle	 , Tipo_Movimiento  , Linea_Transsaccion , MontoTransaccion	,
					MontoExceso	, PlazoDesde	 , PlazoHasta	    , Actualizo_Linea	 , Error   		,
					Codigo_Excepcion, Mensaje_Error
					)
			SELECT 		@nNumoper      	, @nNumdocu      , @nCorrela        , @nCorrDet          , @cSistema 		,	
					@cProducto      , @cCodigo_Grupo , @cTipoControl  , @cTipoMov        , 'LINSIS'	     	 , @nMontolin      	,
					@nExceso   	, 0         	 , 0         	    , 'S'            	 , @cError 		,
					@Cod_Error  	, @cMensaje
		END








		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S' SELECT @ndisponible = @nSinriesgodisponible
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C' SELECT @ndisponible = @nConriesgodisponible



		If @nDisponible < 0 BEGIN
			SELECT @nExceso = ABS(@nMontolin)
		END ELSE BEGIN
			SELECT @nExceso = @nDisponible - @nMontolin
		END

		SELECT  @Cod_Error = ' ',
			@cExceso_Sistema='N'


                IF @nExceso < 0
			SELECT  @Cod_Error = 'SG',
				@cExceso_Sistema='S'


		IF @cCompartido = 'N' 				SELECT @cTipoOperacion = 'LINSIS'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cTipoOperacion = 'LINSSR'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cTipoOperacion = 'LINSCR'



		IF @cCompartido = 'N' 				SELECT @cMensaje_Compartido = ''
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'	SELECT @cMensaje_Compartido = 'Sin Riesgo'
		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'	SELECT @cMensaje_Compartido = 'Con Riesgo'



		IF @Cod_Error <> ' ' BEGIN
			IF @cExceso_General='N'
				SELECT  @cMensaje = 'Linea Grupo ' + ltrim(rtrim(@cCodigo_grupo)) + ' ' + @cMensaje_Compartido + ' Excedido Para ' + @cNombre 	,
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
			

		IF @cCompartido = 'N'
			UPDATE	LINEA_SISTEMA
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				ConRiesgoOcupado	= ConRiesgoOcupado	+ @nMontolin	,
				ConRiesgoDisponible	= ConRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo


		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'S'
			UPDATE	LINEA_SISTEMA
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				SinRiesgoOcupado	= SinRiesgoOcupado	+ @nMontolin	,
				SinRiesgoDisponible	= SinRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo


		IF @cCompartido = 'S' AND @cTipo_Riesgo  = 'C'
			UPDATE	LINEA_SISTEMA
			SET	totalocupado		= totalocupado    	+ @nMontolin	,
				totaldisponible 	= totaldisponible 	- @nMontolin	,
				ConRiesgoOcupado	= ConRiesgoOcupado	+ @nMontolin	,
				ConRiesgoDisponible	= ConRiesgoDisponible 	- @nMontolin
			WHERE	rut_cliente	= @nRutcli		AND
			 	codigo_cliente	= @nCodigo		AND
				codigo_grupo	= @ccodigo_grupo



		SELECT @nCorrDet = @nCorrDet + 1

		INSERT INTO LINEA_TRANSACCION_DETALLE
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
		       	FROM	LINEA_POR_PLAZO --WITH (NOLOCK INDEX=id_LINEA_POR_PLAZO)
			WHERE	rut_cliente	=  @nRutcli				AND
				codigo_cliente	=  @nCodigo				AND
				codigo_grupo	=  @ccodigo_grupo			AND
				DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta

			IF  @nContPlazosTotales = 0 BEGIN

				INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': No Existe Linea Por Plazo: ' + RTRIM(CONVERT(CHAR(10),DATEDIFF(day, @dFecPro, @dFecvctop))) +' Operacion N°: ' + RTRIM(CONVERT(CHAR(10),@nNumoper)) + '  ' + ISNULL(@cNombre,'')
				RETURN

			END

			SELECT	@nContPlazosLeidos = 0


			DECLARE cursor_plazos SCROLL CURSOR FOR
         		SELECT	PlazoDesde,
				PlazoHasta,
				Totaldisponible,
				Sinriesgodisponible,
				Conriesgodisponible
		       	FROM	LINEA_POR_PLAZO --WITH (NOLOCK INDEX=id_LINEA_POR_PLAZO)
			WHERE	rut_cliente	=  @nRutcli			AND
				codigo_cliente	=  @nCodigo			AND
				codigo_grupo	=  @ccodigo_grupo		AND
				DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta
			ORDER BY plazohasta

/*

         		SELECT	PlazoDesde,
				PlazoHasta,
				Totaldisponible,
				Sinriesgodisponible,
				Conriesgodisponible,
				SW='N',
				contador = IDENTITY(NUMERIC(10),1,1)
			INTO	#tmp_plazos
		       	FROM	LINEA_POR_PLAZO --WITH (NOLOCK INDEX=id_LINEA_POR_PLAZO)
			WHERE	rut_cliente	=  @nRutcli			AND
				codigo_cliente	=  @nCodigo			AND
				codigo_grupo	=  @ccodigo_grupo		AND
				DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta
*/

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

/*
				SELECT @sw = '*'


				SET ROWCOUNT 1

	         		SELECT	@nPlazoDesde = PlazoDesde,
					@nPlazoHasta = PlazoHasta,
					@ndisponible = Totaldisponible,
					@nSinriesgodisponible = Sinriesgodisponible,
					@nConriesgodisponible = Conriesgodisponible,
					@contador = contador,
					@sw = SW
				FROM 	#tmp_plazos
				WHERE	sw='N'
				ORDER BY plazohasta

				SET ROWCOUNT 0

				
				IF @sw = '*' 	BREAK
*/


--SELECT	@nPlazoDesde,	@nPlazoHasta,	@ndisponible,		@nSinriesgodisponible,					@nConriesgodisponible,					@contador




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
						UPDATE 	LINEA_POR_PLAZO	
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
						UPDATE 	LINEA_POR_PLAZO	
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
						UPDATE 	LINEA_POR_PLAZO	
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
						IF @cExceso_Sistema='N' AND @cExceso_General='S'
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


					INSERT INTO LINEA_TRANSACCION_DETALLE
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

--				UPDATE	#tmp_plazos
--				SET	sw='S'
--				WHERE	contador = @contador


			END
	



			CLOSE cursor_plazos
			DEALLOCATE cursor_plazos



                END

--		EXECUTE Sp_Lineas_Actualiza @nRutcli

	END ELSE BEGIN

		INSERT INTO #Errores SELECT LTRIM(RTRIM(@cSistema)) + ': No Existe Linea Definida ' + ISNULL(@cNombre,'')
		RETURN

	END


SET NOCOUNT ON


END







-- select * from linea_sistema
--sp_helptext sp_lineas_actualiza











GO
