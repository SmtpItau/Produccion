USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRBOPERACION]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRBOPERACION]
			(
			@cCodigo_Grupo	CHAR	(10)	,
			@cSistema	CHAR	(03)	,
			@cProducto	CHAR	(05)	,
			@nNumPantalla	NUMERIC(10)	,
			@nNumoper	NUMERIC(10)	,
			@cTipoper 	CHAR(01)	,
			@cValidaCheque	CHAR(01)	,
			@nMercadoLocal	CHAR(01)        ,
			@nMonedalin	NUMERIC	(05,0)	,
		        @nValmonlin	NUMERIC	(10,4)	,
                        @Mto_Sobregiro  NUMERIC(19,4)	
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	SET NOCOUNT ON
	SET DATEFORMAT dmy
	
	SET @cProducto = LTRIM(RTRIM(@cProducto))

	DECLARE @cCheckEmi	CHAR	(01)
	DECLARE @cCheckChq	CHAR	(01)
	DECLARE @cCheckCli	CHAR	(01)
	DECLARE @cCheckEmiAux	CHAR	(01)
	DECLARE @cCheckChqAux	CHAR	(01)
	DECLARE @cCheckCliAux	CHAR	(01)
	DECLARE @cCheckLimOPER	CHAR	(01)
	DECLARE @cCheckLimInst	CHAR	(01)
	DECLARE @cCheckRebajaVP	CHAR	(01)
	DECLARE @cCheckRebajaAT	CHAR	(01)
	DECLARE	@dFecPro	DATETIME
	DECLARE @nRutcli	NUMERIC	(09,0)
	DECLARE @nCodigo	NUMERIC	(09,0)
	DECLARE @dFecvctop	DATETIME
	DECLARE @dFecvctop_INS	DATETIME
	DECLARE @dFecvctop_AUX	DATETIME
	DECLARE @cUsuario	CHAR	(15)
	DECLARE @nMonto		NUMERIC	(19,4)
	DECLARE @nMontoOri	NUMERIC	(19,4)
	DECLARE @cTipo_Riesgo	CHAR	(01)
	DECLARE @nNumdocu	NUMERIC	(10,0)
	DECLARE @nCorrela	NUMERIC	(10,0)
	DECLARE @dFeciniop	DATETIME
	DECLARE @fTipcambio	NUMERIC	(19,4)
	DECLARE @cModPago	CHAR	(01)
	DECLARE @nInCodigo	NUMERIC	(05,0)
	DECLARE @nFactor	NUMERIC	(19,8)
	DECLARE @nForpag	INTEGER
	DECLARE @rut_cheque	NUMERIC	(10)
	DECLARE @pago_cheque	CHAR	(01)
	DECLARE @nMoneda1	NUMERIC	(05,0)
	DECLARE @nMoneda2	NUMERIC	(05,0)
	DECLARE @nMoneda_Emi	NUMERIC	(05,0)
	DECLARE @nMonedaMat1	NUMERIC	(05,0)
	DECLARE @nMonedaMat2	NUMERIC	(05,0)
	DECLARE @cMensAprob	VARCHAR (255)
	DECLARE @montoOriginal	NUMERIC	(19,4)
	DECLARE @montoMX2	NUMERIC	(19,4)
	DECLARE @nRutBCCH	NUMERIC	(09,0)
	DECLARE @nRutBanco	NUMERIC	(09,0)
	DECLARE	@cSistema_aux	CHAR	(03)
	DECLARE	@cProducto_aux	CHAR	(05)
	DECLARE @nInCodigo_aux	NUMERIC	(05,0)

	
	DECLARE @cTipo_Moneda   	CHAR(1)
        DECLARE @cTipo_Moneda_Pac  	CHAR(1)
        DECLARE @cFuerte        	CHAR(1)
        DECLARE @nParidad       	FLOAT
        DECLARE @cNemo          	CHAR(8)

	DECLARE @nMonedaProcesar	NUMERIC	(05,0)

	DECLARE @NumeroOperacion 	NUMERIC	(10,0) 	
	DECLARE @Numerodocumento 	NUMERIC	(10,0)	
	DECLARE @NumeroCorrelativo 	NUMERIC	(10,0)
	DECLARE @NumeroOperacion_paso 	NUMERIC	(10,0) 	
	DECLARE @Numerodocumento_paso 	NUMERIC	(10,0)	
	DECLARE @NumeroCorrelativo_paso NUMERIC	(10,0)
      	DECLARE @nMonto_total 		FLOAT
      	DECLARE @nMonto_Original	FLOAT
	DECLARE @cAnticipo		CHAR(1)

	DECLARE @iFound			INTEGER
	DECLARE @nMatrizriesgo		FLOAT
	DECLARE @cMoneda             	NUMERIC(5)
	DECLARE @cMoneda2            	NUMERIC(3)
	DECLARE @cMoneda1            	NUMERIC(5)
	DECLARE @cMarca              	CHAR(1)
	DECLARE @nCorrelativoFrp	INT 
	DECLARE	@cCodigo_Grupo_EMI	CHAR(10)

	CREATE TABLE #temp1( mensaje CHAR(255) )


	SELECT	@nRutBCCH = 97029000
	SELECT 	@nRutBanco = rut_entidad from DATOS_GENERALES WITH (NOLOCK)
	

   /******************************************************************************************/
   /******************************************************************************************/
   /****** ACTUALIZA OTRAS LINEAS ************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/

	SELECT	@cProducto = LTRIM(RTRIM(codigo_producto))
	FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
	WHERE	NumeroOperacion = @nNumPantalla		AND
		Id_Sistema	= @cSistema

	/**********************************************************************************/
	/*************** INVERSION TOTAL POR INSTRUMENTO **********************************/
	/**********************************************************************************/
--	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WHERE	codigo_control	= 'MAINV'	AND
--							estado		= 'S'		AND
--						       id_sistema       = @cSistema	AND
--						       codigo_producto  = @cProducto	) BEGIN
--
--		EXECUTE SP_LINEA_GRABAR_INVERSION_INSTRUMENTO @cSistema, @cProducto, @nNumoper
--	END


	/**********************************************************************************/
	/*************** INVERSION TOTAL POR CARTERA PERMANETE ****************************/
	/**********************************************************************************/
	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
			WHERE	codigo_control	= 'LINVP'	AND
				estado		= 'S'		AND
			        id_sistema       = @cSistema	AND
			        codigo_producto  = @cProducto	) BEGIN
			        
		IF @cProducto IN ('CP','VP') BEGIN
			EXECUTE SP_LINEA_GRABAR_INVERSION_CARTERA_PERMANENTE @cSistema, @cProducto, @nNumoper
		END
	END

	/**********************************************************************************/
	/*************** INVERSION TOTAL POR LCHR PROIAS **********************************/
	/**********************************************************************************/
	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
			WHERE	codigo_control	= 'CLCHR'	AND
				estado		= 'S'		AND
			        id_sistema       = @cSistema	AND
			        codigo_producto  = @cProducto	) BEGIN

		IF @cProducto IN ('CP','VP') BEGIN
			EXECUTE SP_LINEA_GRABAR_INVERSION_LCHR_PROPIA @cSistema, @cProducto, @nNumoper
		END
	END

 
      
	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)  
				  WHERE	codigo_control	= 'ENBAN'	AND
					estado		= 'S'		AND
				        id_sistema       = @cSistema	AND
				        codigo_producto  = @cProducto	) BEGIN

		EXECUTE SP_LINEA_GRABAR_ENDEUDAMIENTO_BANCO @cSistema, @nNumoper, @cTipoper


	END


	SELECT	@cCheckCliAux = 'S',
		@cCheckEmiAux = 'N',
		@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND @cProducto IN('CP','CFM')
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'S',@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VIX' OR @cProducto = 'VP' )
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'S'

	IF @cSistema = 'BTR' AND @cProducto = 'RFM'
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N', @cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N', @cCheckChqAux = 'N'

	IF @cSistema = 'INV' AND @cProducto = 'CPI'
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'S',@cCheckChqAux = 'N'

	IF @cSistema = 'INV' AND @cProducto = 'VPI'
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'S'


	IF @cSistema = 'BCC' 
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'N'


	IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' ) --AND @cTipoper = "C"
		SELECT	@cCheckCliAux = 'S', @cCheckEmiAux = 'N',@cCheckChqAux = 'N'


	IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cValidaCheque = 'S' --AND @cTipoper = "C" 
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'S'


	IF @cSistema = 'BFW' 
		SELECT	@cCheckCliAux = 'N', @cCheckEmiAux = 'N',@cCheckChqAux = 'N'


	IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR ( @cProducto = '7') OR @cProducto = '8') --AND @nMercadoLocal = "S"
		SELECT	@cCheckCliAux = 'S', @cCheckEmiAux = 'N', @cCheckChqAux = 'N'

	IF @cSistema = 'BFW' AND ( @cProducto = '7') AND @cTipoper = 'C'
		SELECT	@cCheckCliAux = 'S', @cCheckEmiAux = 'S', @cCheckChqAux = 'N'

	IF @cSistema = 'BFW' AND @cProducto = '5' AND  @cTipoper = 'O' 
		SELECT	@cCheckCliAux = 'S', @cCheckEmiAux = 'N', @cCheckChqAux = 'N'


	IF @cSistema = 'SWP'
		SELECT	@cCheckCliAux = 'S', @cCheckEmiAux = 'N',@cCheckChqAux = 'N'


	SELECT	@cCheckCli = 'N',
		@cCheckEmi = 'N',
		@cCheckChq = 'N',
		@cCheckLimOPER = 'N',
		@cCheckLimInst = 'N'

-- select * from PRODUCTO_CONTROL	
	SELECT	@cCheckCli = 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
        WHERE	codigo_control	= 'LINEA'	 AND
		estado		= 'S'		 AND
		Codigo_Grupo	= @cCodigo_Grupo AND
		@cCheckCliAux 	= 'S'



	SELECT	@cCheckEmi	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
        WHERE	codigo_control	= 'CTEMI'	 AND
		estado		= 'S'		 AND
		Codigo_Grupo	= @cCodigo_Grupo AND
		@cCheckEmiAux	= 'S'


	SELECT	@cCheckChq	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
	WHERE	codigo_control	= 'CTCHQ'	 AND
		estado		= 'S'		 AND
		Codigo_Grupo	= @cCodigo_Grupo AND
		@cCheckChqAux	= 'S'




	SELECT	@cCheckLimOPER	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL)
	WHERE	codigo_control	= 'MATRI'	AND
		estado		= 'S'		AND
		id_sistema       = @cSistema	AND
		codigo_producto  = @cProducto



--	IF @cSistema = 'BCC' AND @cTipoper = 'V'  BEGIN
--		SELECT	@cCheckCli = 'N'	,
--			@cCheckEmi = 'N'
--      END


   /******************************************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/
   /**** ACTUALIZA LINEAS ********************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/




-- SELECT * FROM INSTRUMENTO
	/**********************************************************************************/
	/******** GRABAR LINEA EMISOR *****************************************************/
	/**********************************************************************************/

	IF @cCheckEmi = 'S' BEGIN

		SELECT	@cCodigo_Grupo_EMI = @cCodigo_Grupo

		IF @cSistema = 'BFW'
		BEGIN

			SELECT	@cCodigo_Grupo_EMI 	= A.codigo_grupo,
				@cSistema_aux		= A.id_sistema,
				@cProducto_aux		= A.codigo_producto
			FROM	GRUPO_PRODUCTO_DETALLE A WITH (NOLOCK), LINEA_CHEQUEAR B WITH (NOLOCK)
			WHERE	A.id_sistema		= 'BTR'
			AND	A.codigo_producto	= 'CP'
			AND	A.codigo_instrumento	= B.incodigo 
			AND	B.NumeroOperacion	= @nNumoper
			AND	B.Id_Sistema		= @cSistema
			AND	B.incodigo  < 2000

			SELECT	@cCodigo_Grupo_EMI 	= A.codigo_grupo,
				@cSistema_aux		= A.id_sistema,
				@cProducto_aux		= A.codigo_producto
			FROM	GRUPO_PRODUCTO_DETALLE A WITH (NOLOCK), LINEA_CHEQUEAR B WITH (NOLOCK)
			WHERE	A.id_sistema		= 'INV'
			AND	A.codigo_producto	= 'CPI'
			AND	B.NumeroOperacion	= @nNumoper
			AND	B.Id_Sistema		= @cSistema
			AND	B.incodigo  = 2000



		END



		SET @nMonto_total=0
		SET @nMonto_Original=0

		DECLARE Cursor_LINEAS_EMISOR CURSOR
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT		FechaOperacion		,
				CASE WHEN @cProducto = 'CFM' THEN Rut_Cliente ELSE Rut_Emisor END,
				CASE WHEN @cProducto = 'CFM' THEN Codigo_Cliente ELSE 0 END,
				NumeroDocumento		,
				NumeroCorrelativo	,
				MontoTransaccion	,
				TipoCambio		,
				FechaVctoInst		,
				Operador		,
				Compensacion		,
				Tipo_Riesgo             ,
				rut_cheque              ,
				pago_cheque		,
				moneda1			,
				moneda2			,
				NumeroOperacion 	,
				Numerodocumento 	,	
				NumeroCorrelativo	,
				nCorrelativoFRP		,
				InCodigo

			FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
			WHERE	NumeroOperacion		= @nNumPantalla		AND
				Id_Sistema		= @cSistema		AND
				Codigo_Grupo		= @cCodigo_Grupo	AND
				Rut_Emisor		<> @nRutBCCH		AND
				Rut_Emisor		<> @nRutBanco		AND
				((@cSistema = 'BTR' AND EXISTS (SELECT 1 FROM INSTRUMENTO WITH (NOLOCK) WHERE incontab = 'S' AND LINEA_CHEQUEAR.incodigo = INSTRUMENTO.incodigo) )
				 OR @cSistema = 'INV' 
				 OR @cSistema = 'BFW' )

			OPEN Cursor_LINEAS_EMISOR

			FETCH NEXT FROM Cursor_LINEAS_EMISOR
				INTO	@dFecPro 	,	@nRutcli	,	@nCodigo	,
					@nNumdocu	,	@nCorrela	,       @nMonto		,
					@fTipcambio	,	@dFecvctop	,	@cUsuario	,
					@cModPago	,	@cTipo_Riesgo	,	@rut_cheque     ,
					@pago_cheque	,	@nMoneda1	,	@nMoneda2	,
					@NumeroOperacion,	@Numerodocumento,	@NumeroCorrelativo	,
					@nCorrelativoFRP,	@nInCodigo


			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @NumeroOperacion_paso 	= @NumeroOperacion 
				SET @Numerodocumento_paso	= @Numerodocumento 
				SET @NumeroCorrelativo_paso	= @NumeroCorrelativo


--select @NumeroOperacion , @Numerodocumento , @NumeroCorrelativo


				WHILE @@FETCH_STATUS = 0 AND @NumeroOperacion_paso = @NumeroOperacion AND @Numerodocumento_paso	= @Numerodocumento AND @NumeroCorrelativo_paso	= @NumeroCorrelativo
				BEGIN


					if @cSistema_AUX = 'BTR'
						SELECT @nInCodigo_aux = @nInCodigo
					ELSE
						SELECT @nInCodigo_aux = 0



--SELECT @cSistema_AUX, @cProducto_AUX, @nInCodigo_aux, @nMoneda1, @nMoneda2 ,@dFecPro, @dFecvctop, @dFecvctop, @nMonto, @nMatrizriesgo 

					EXECUTE SP_BUSCA_INTERPOLACION_FACTOR_RIESGO @cSistema_AUX, @cProducto_AUX, @nInCodigo_aux, @nMoneda1, @nMoneda2 ,@dFecPro, @dFecvctop, @dFecvctop, @nMonto, @nMatrizriesgo OUTPUT


					SELECT	@nMonto_Original = @nMonto_Original + @nMonto

--					IF @nMatrizriesgo > 0 
						SET @nMonto_total = @nMonto_total+ ROUND(@nMonto / 100 * @nMatrizriesgo,4)

					--SELECT @nCorrelativoFRP=ISNULL(MAX(correlativoFrp),0)+1 FROM  lineas_operacion_frp
					INSERT INTO lineas_operacion_frp WITH (ROWLOCK) VALUES(
								@nNumoper	,     @Numerodocumento  , @NumeroCorrelativo	,
								@cSistema	,     @cCodigo_Grupo_EMI	, @dFecvctop,     
								@nMatrizriesgo	,     @nCorrelativoFRP
					)
			
				FETCH NEXT FROM Cursor_LINEAS_EMISOR
					INTO	@dFecPro 	,	@nRutcli	,	@nCodigo	,
						@nNumdocu	,	@nCorrela	,       @nMonto		,
						@fTipcambio	,	@dFecvctop	,	@cUsuario	,
						@cModPago	,	@cTipo_Riesgo	,	@rut_cheque     ,
						@pago_cheque	,	@nMoneda1	,	@nMoneda2	,
						@NumeroOperacion,	@Numerodocumento,	@NumeroCorrelativo	,
						@nCorrelativoFRP,	@nInCodigo
				END 

			IF EXISTS(SELECT 1 FROM EMISOR WITH (NOLOCK) WHERE emrut = @nRutcli AND emglosa = 'S') BEGIN
				--SELECT @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @NumeroOperacion, @Numerodocumento, @NumeroCorrelativo, @dFecPro, @nMonto_total, @fTipcambio, @dFecvctop, @cUsuario, @cModPago, @cTipo_Riesgo, @nMonedalin, @nValmonlin, @Mto_Sobregiro, @cCodigo_Grupo, @nMoneda1, @nMoneda2,@nMatrizriesgo
				EXECUTE SP_LINEAS_GRABAR @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @NumeroOperacion, @Numerodocumento, @NumeroCorrelativo, @dFecPro, @nMonto_total, @fTipcambio, @dFecvctop, @cUsuario, @cModPago, @cTipo_Riesgo, @nMonedalin, @nValmonlin, @Mto_Sobregiro, @cCodigo_Grupo_EMI, @nMoneda1, @nMoneda2, @nMatrizriesgo, @nMonto_Original
                        END
		END
		CLOSE Cursor_LINEAS_EMISOR
		DEALLOCATE Cursor_LINEAS_EMISOR

	END


	/**********************************************************************************/
	/****** GRABAR LINEA CLIENTE ******************************************************/
	/**********************************************************************************/

	IF @cCheckCli = 'S' BEGIN

		SET @nMonto_total=0
		SET @nMonto_Original=0

		DECLARE Cursor_LINEAS_CLIENTE CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT		FechaOperacion		,	Rut_Cliente		,	Codigo_Cliente		,
				SUM(MontoTransaccion)	,	TipoCambio		,	FechaVencimiento	,
				Operador		,	Compensacion		,	Tipo_Riesgo             ,
                        	FormaPago               ,	rut_cheque              ,	pago_cheque		,
				moneda1			,	moneda2			,	sum(montoOriginal)	,
				sum(montoMX2)		,	NumeroOperacion 	,      	0			, --Numerodocumento , NumeroCorrelativo
				0			,	nCorrelativoFRP		,	FechaVctoInst

		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion		= @nNumPantalla	AND
			Id_Sistema		= @cSistema	AND
			Codigo_Grupo		= @cCodigo_Grupo
		GROUP BY	FechaOperacion		,	Rut_Cliente		,	Codigo_Cliente		,
				TipoCambio		,	FechaVencimiento	,	Operador		,
				Compensacion		,	Tipo_Riesgo             ,	FormaPago               ,
				rut_cheque              ,	pago_cheque		,	moneda1			,
				moneda2			,	NumeroOperacion 	,      	nCorrelativoFRP		,
				FechaVctoInst

		OPEN Cursor_LINEAS_CLIENTE

			FETCH NEXT FROM Cursor_LINEAS_CLIENTE INTO	
				@dFecPro 	,	@nRutcli	,	@nCodigo	,
				@nMonto		,	@fTipcambio	,	@dFecvctop	,
				@cUsuario	,	@cModPago	,	@cTipo_Riesgo	,
                                @nForpag        ,	@rut_cheque     ,	@pago_cheque	,
				@nMoneda1	,	@nMoneda2	,	@montoOriginal	,
				@montoMX2	, 	@NumeroOperacion,	@Numerodocumento,
				@NumeroCorrelativo,	@nCorrelativoFRP,	@dFecvctop_INS


			WHILE @@FETCH_STATUS = 0
			BEGIN

				SET @NumeroOperacion_paso 	= @NumeroOperacion 
				SET @Numerodocumento_paso	= @Numerodocumento 
				SET @NumeroCorrelativo_paso	= @NumeroCorrelativo

				
				WHILE @@FETCH_STATUS = 0 AND @NumeroOperacion_paso = @NumeroOperacion AND @Numerodocumento_paso	= @Numerodocumento AND @NumeroCorrelativo_paso	= @NumeroCorrelativo
				BEGIN

					SELECT @dFecvctop_AUX = @dFecvctop

					if @cSistema = 'BFW' AND @cProducto = '7'
					BEGIN
						SELECT @dFecvctop_AUX = @dFecvctop_INS
					END

					EXECUTE SP_BUSCA_INTERPOLACION_FACTOR_RIESGO @cSistema, @cProducto, 0, @nMoneda1, @nMoneda2 ,@dFecPro, @dFecvctop_AUX, @dFecvctop, @nMonto, @nMatrizriesgo OUTPUT

					SELECT @nParidad = 1


					IF @cSistema = 'BFW' AND (@cProducto in (1,2,8))
					BEGIN
						SET @nMonedaProcesar=0

						IF(@cTipoper='C')  --COMPRA
							SET @nMonedaProcesar = @nMoneda1
						ELSE
							SET @nMonedaProcesar = @nMoneda2

--select @nMonedaProcesar
						SELECT @cTipo_Moneda= mnextranj, @cFuerte= mnrrda, @cNemo=mnnemo
						FROM MONEDA  WITH (NOLOCK) WHERE mncodmon=@nMonedaProcesar

						IF @cTipo_Moneda=0 AND @nMonedaProcesar=13
						BEGIN
							SET @nMonto = @montoOriginal --MONTO_USD
						END ELSE BEGIN 
							IF @cTipo_Moneda = 0 AND @nMonedaProcesar <> 13 BEGIN
								SET @nMonto = @montoMX2	
							END
						END

--SELECT @nMonto
						IF @cTipo_Moneda =0
						BEGIN 
							SELECT @nParidad = CASE WHEN Vmparidad  = 0 THEN 1 ELSE Vmparidad  END 	FROM VIEW_POSICION
							WHERE		codigo_area = 'PTAS'
								AND	vmcodigo    = @cNemo  
								AND	Vmfecha     = @dFecPro
--select Vmparidad,* from VIEW_POSICION where vmfecha ='20041230'
--select * from MONEDA where MNCODMON=142
							IF @cFuerte = 'D' BEGIN
								SELECT  @nMonto = @nMonto / @nParidad
							END ELSE BEGIN
					       			SELECT  @nMonto = @nMonto * @nParidad
							END

					                SELECT @nMonto = ROUND(@nMonto * (CASE WHEN vmvalor = 0 THEN 1 ELSE ISNULL(vmvalor, 1)END ),0)
					                FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA) WHERE vmcodigo = 994 AND vmfecha  = @dFecPro 
						END
					END


					IF @cSistema = 'SWP'
					BEGIN

						SET @nMonedaProcesar = @nMoneda1
						SET @nMonto = @montoOriginal

						SELECT @cTipo_Moneda= mnextranj, @cFuerte= mnrrda, @cNemo=mnnemo
						FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA) WHERE mncodmon=@nMonedaProcesar

						IF @cTipo_Moneda =0
						BEGIN
							SELECT @nParidad = CASE WHEN Vmparidad  = 0 THEN 1 ELSE Vmparidad  END 	FROM VIEW_POSICION
							WHERE		codigo_area = 'PTAS'
								AND	vmcodigo    = @cNemo  
								AND	Vmfecha     = @dFecPro
							IF @cFuerte = 'D' BEGIN
								SELECT  @nMonto = @nMonto / @nParidad
							END ELSE BEGIN
					       			SELECT  @nMonto = @nMonto * @nParidad
							END 
					                SELECT @nMonto = ROUND(@nMonto * (CASE WHEN vmvalor = 0 THEN 1 ELSE ISNULL(vmvalor, 1)END ),0)
					                FROM VALOR_MONEDA WITH (NOLOCK INDEX=PK_VALOR_MONEDA) WHERE vmcodigo = 994 AND vmfecha  = @dFecPro 
						END
						ELSE
							IF @nMonedaProcesar IN(998,997)
						                SELECT	@nMonto = ROUND(@nMonto * vmvalor, 0 )
						                FROM	VALOR_MONEDA WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
								WHERE	vmcodigo = @nMonedaProcesar
								AND	vmfecha  = @dFecPro 

					END



					SELECT	@nMonto_Original = @nMonto_Original + @nMonto

--					IF @nMatrizriesgo > 0 
						SET @nMonto_total = @nMonto_total + ROUND(@nMonto / 100 * @nMatrizriesgo,4)

					INSERT INTO lineas_operacion_frp WITH (ROWLOCK) VALUES(
								@nNumoper	,     @Numerodocumento  , @NumeroCorrelativo	,
								@cSistema	,     @cCodigo_Grupo	, @dFecvctop,     
								@nMatrizriesgo	,     @nCorrelativoFRP
					)
					
					FETCH NEXT FROM Cursor_LINEAS_CLIENTE INTO	
						@dFecPro 	,	@nRutcli	,	@nCodigo	,
						@nMonto		,	@fTipcambio	,	@dFecvctop	,
						@cUsuario	,	@cModPago	,	@cTipo_Riesgo	,
		                                @nForpag        ,	@rut_cheque     ,	@pago_cheque	,
						@nMoneda1	,	@nMoneda2	,	@montoOriginal	,
						@montoMX2	, 	@NumeroOperacion,	@Numerodocumento,
						@NumeroCorrelativo,	@nCorrelativoFRP,	@dFecvctop_INS
				END 



				set @nMonto = @nMonto_total
				


			IF EXISTS(SELECT 1 FROM CLIENTE WITH (NOLOCK) WHERE clrut = @nRutcli AND clcodigo = @nCodigo AND Clvalidalinea = 'S') BEGIN
				
				--	SELECT @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @NumeroOperacion, @Numerodocumento, @NumeroCorrelativo, @dFecPro, @nMonto	, @fTipcambio, @dFecvctop, @cUsuario, @cModPago, @cTipo_Riesgo, @nMonedalin, @nValmonlin, @Mto_Sobregiro, @cCodigo_Grupo, @nMoneda1, @nMoneda2,@nMatrizriesgo
				EXECUTE SP_LINEAS_GRABAR @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @NumeroOperacion, @Numerodocumento, @NumeroCorrelativo, @dFecPro, @nMonto	, @fTipcambio, @dFecvctop, @cUsuario, @cModPago, @cTipo_Riesgo, @nMonedalin, @nValmonlin, @Mto_Sobregiro, @cCodigo_Grupo, @nMoneda1, @nMoneda2,@nMatrizriesgo, @nMonto_Original


                        END
		END
		CLOSE Cursor_LINEAS_CLIENTE
		DEALLOCATE Cursor_LINEAS_CLIENTE

	END


	/**********************************************************************************/
	/********** GRABAR LINEA CHEQUE ***************************************************/
	/**********************************************************************************/
	IF @cCheckChq = 'S' BEGIN

		SET @nMonto_Original=0
		SELECT @nMatrizriesgo = 100

		DECLARE Cursor_LINEAS_CHEQUE CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,
			Rut_Cheque		,
			SUM(MontoTransaccion)	,
			TipoCambio		,
			FechaVctoCheque		,
			Operador		,
			Compensacion		,
			Tipo_Riesgo             ,
   			FormaPago               ,
                        rut_cheque              ,
                        pago_cheque		,
			moneda1			,
			moneda2
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR )
		WHERE	NumeroOperacion		= @nNumPantalla	 AND
			Id_Sistema		= @cSistema	 AND
			Codigo_Grupo		= @cCodigo_Grupo AND
			Pago_Cheque		= @cCheckChq
		GROUP BY	FechaOperacion		,
				Rut_Cheque		,
				TipoCambio		,
				FechaVctoCheque		,
				Operador		,
				Compensacion		,
				Tipo_Riesgo             ,
				FormaPago               ,
				rut_cheque              ,
				pago_cheque		,
				moneda1			,
				moneda2
		OPEN Cursor_LINEAS_CHEQUE

		WHILE (1=1) BEGIN

			FETCH NEXT FROM Cursor_LINEAS_CHEQUE
			INTO	@dFecPro	,
				@nRutcli	,
				@nMonto		,
				@fTipcambio	,
				@dFecvctop	,
				@cUsuario	,
				@cModPago	,
				@cTipo_Riesgo   ,
                                @nForpag        ,
                                @rut_cheque     ,
                                @pago_cheque	,
				@nMoneda1	,
				@nMoneda2

				IF (@@fetch_status <> 0) BEGIN
					BREAK
				END


				IF EXISTS(SELECT 1 FROM CLIENTE WITH (NOLOCK) WHERE clrut = @nRutcli AND Clvalidalinea = 'S') BEGIN
--					IF EXISTS(SELECT 1 FROM FORMA_DE_PAGO WHERE codigo = @nForpag  AND afectacorr = 'S') BEGIN
						EXECUTE SP_LINEAS_GRABAR @dFecPro, @cSistema, @cProducto, @nRutcli, 0, @nNumoper, 0, 0, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @cModPago, @cTipo_Riesgo, @nMonedalin, @nValmonlin, @Mto_Sobregiro, @cCodigo_Grupo, @nMoneda1, @nMoneda2, @nMatrizriesgo, @nMonto_Original
--					END
 				END
		END

		CLOSE Cursor_LINEAS_CHEQUE
		DEALLOCATE Cursor_LINEAS_CHEQUE
	END


	/**********************************************************************************/
	/********* REBAJA LINEA EN VENTA PROPIA *******************************************/
	/**********************************************************************************/

	SELECT	@cCheckRebajaVP = 'N'

	IF @cSistema = 'BTR' AND @cProducto IN ('VP','SLH','RFM') 
		SELECT	@cCheckRebajaVP = 'S'

	IF @cSistema = 'INV' AND @cProducto = 'VPI' 
		SELECT	@cCheckRebajaVP = 'S'


	IF @cCheckRebajaVP = 'S' BEGIN

		DECLARE Cursor_LINEAS_REBAJA CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,
			NumeroDocumento		,
			NumeroCorrelativo	,
			FactorVenta			
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion		= @nNumPantalla	AND
			Id_Sistema		= @cSistema

		OPEN Cursor_LINEAS_REBAJA

		WHILE (1=1)BEGIN

			FETCH NEXT FROM Cursor_LINEAS_REBAJA
			INTO	@dFecPro 	,
				@nNumdocu	,
				@nCorrela	,
				@nFactor

				IF (@@fetch_status <> 0) BEGIN
					BREAK
				END
				EXECUTE SP_LINEAS_REBAJA @dFecPro, @cSistema, @nNumdocu, @nNumdocu, @nCorrela, @nFactor, @cCodigo_Grupo, @nNumoper, @cProducto
		END
		CLOSE Cursor_LINEAS_REBAJA
		DEALLOCATE Cursor_LINEAS_REBAJA
	END




	/**********************************************************************************/
	/********* REBAJA LINEA ANTICIPOS DE OPERACIONES **********************************/
	/**********************************************************************************/

	SELECT	@cCheckRebajaAT = 'N'

	IF @cSistema = 'BTR' AND @cProducto = 'RVA'
		SELECT	@cCheckRebajaAT = 'S'

	IF @cSistema = 'BFW' AND @cProducto = 'ANT'
		SELECT	@cCheckRebajaAT = 'S'

	IF @cSistema = 'SWP' AND @cProducto = 'ANT'
		SELECT	@cCheckRebajaAT = 'S'



	IF @cCheckRebajaAT = 'S' BEGIN

		DECLARE Cursor_LINEAS_REBAJA CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion,
			NumeroDocumento		,
			NumeroCorrelativo	,
			FactorVenta
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion	= @nNumPantalla	AND
			Id_Sistema	= @cSistema


		OPEN Cursor_LINEAS_REBAJA


		WHILE (1=1) BEGIN

			FETCH NEXT FROM Cursor_LINEAS_REBAJA
			INTO	@dFecPro,
				@nNumdocu	,
				@nCorrela	,
				@nFactor

			IF (@@fetch_status <> 0) BEGIN
				BREAK
			END

			IF @nFactor = 0
				SELECT @nFactor = 1


--select @dFecPro, @cSistema, @nNumoper, @nNumdocu, @nCorrela, @nFactor, @cCodigo_Grupo, 0, @cProducto

			EXECUTE SP_LINEAS_REBAJA @dFecPro, @cSistema, @nNumoper, @nNumdocu, @nCorrela, @nFactor, @cCodigo_Grupo, 0, @cProducto
		END

		CLOSE Cursor_LINEAS_REBAJA
		DEALLOCATE Cursor_LINEAS_REBAJA

	END

	/******************************************************************************************/
	/******************************************************************************************/
	/********* LIMITES DE OPERADOR ************************************************************/
	/******************************************************************************************/
	/******************************************************************************************/

--	SELECT	@cCheckLimOPER = 'S',
--		@cCheckLimInst = 'N'

	IF @cSistema = 'BTR' AND @cProducto in('RCA','RVA')
		SELECT	@cCheckLimOPER = 'N',	@cCheckLimInst = 'N'

	IF @cSistema = 'BFW' AND @cProducto ='ANT'
		SELECT	@cCheckLimOPER = 'N',	@cCheckLimInst = 'N'

	IF @cProducto IN ('CP','VP','SLH') AND @cCheckLimOPER = 'S'
		SELECT	@cCheckLimOPER = 'N',	@cCheckLimInst = 'S'

	IF @cProducto IN ('CPI','VPI') AND @cCheckLimOPER = 'S'
		SELECT	@cCheckLimOPER = 'N',	@cCheckLimInst = 'S'

	/**********************************************************************************/
	/******* GRABAR LIMITE POR OPERACION **********************************************/
	/**********************************************************************************/

	IF @cCheckLimOPER = 'S' AND @cProducto NOT IN ('CP','VP','SLH')  BEGIN

		DECLARE Cursor_LIMITES_OPERACION CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,	SUM(MontoTransaccion)	,	SUM(MontoOriginal)	,
			MAX(FechaVencimiento)	,	Operador                ,	Moneda1			,
			Moneda2			,	SUM(MontoMX2)		
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion	= @nNumPantalla	AND
			Id_Sistema	= @cSistema
		GROUP	BY
			FechaOperacion		,	/*FechaVencimiento	,*/	Operador		,
			Moneda1			,	Moneda2

		OPEN Cursor_LIMITES_OPERACION
		WHILE (1=1)BEGIN
			FETCH NEXT FROM Cursor_LIMITES_OPERACION
			INTO	@dFecPro	,		@nMonto		,	@nMontoOri		,
				@dFecvctop	,		@cUsuario	,	@nMoneda1		,
				@nMoneda2	,		@montoMX2

			IF (@@fetch_status <> 0) BEGIN
				BREAK
			END
 			--SELECT 'SP_LIMITES_GRABAR',@dFecPro, @nNumoper, @cSistema, @cProducto, @cCodigo_Grupo, 0, @nMonto, @nMontoOri, @dFecvctop, @cUsuario, @cCheckLimOPER, 'N','',  @nMoneda1, @nMoneda2,@montoMX2,@cTipoper
			EXECUTE   SP_LIMITES_GRABAR  @dFecPro, @nNumoper, @cSistema, @cProducto, @cCodigo_Grupo, 0, @nMonto, @nMontoOri, @dFecvctop, @cUsuario, @cCheckLimOPER, 'N','',  @nMoneda1, @nMoneda2 , @montoMX2 , @cTipoper
		END
		CLOSE Cursor_LIMITES_OPERACION
		DEALLOCATE Cursor_LIMITES_OPERACION
	END


	/**********************************************************************************/
	/******** GRABAR LIMITE POR OPERACION E INSTRUMENTO *******************************/
	/**********************************************************************************/

	IF @cCheckLimInst = 'S' BEGIN

		DECLARE Cursor_LIMITES_OPERACION_INSTRUMENTO CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,	InCodigo		,	SUM(MontoTransaccion)	,
			SUM(MontoOriginal)	,	MAX(FechaVencimiento)	,	Operador		,
			MAX(Moneda1)		,	MAX(Moneda2)		,	SUM(MontoMX2)		
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion	= @nNumPantalla	AND
			Id_Sistema	= @cSistema	
		GROUP	BY
			FechaOperacion		,	InCodigo		,	--FechaVencimiento	,
			Operador		--,	Moneda1			, 	Moneda2			

		OPEN Cursor_LIMITES_OPERACION_INSTRUMENTO
		WHILE (1=1) BEGIN
			FETCH NEXT FROM Cursor_LIMITES_OPERACION_INSTRUMENTO
			INTO	@dFecPro	,		@nInCodigo	,	@nMonto			,
				@nMontoOri	,		@dFecvctop	,	@cUsuario		,
				@nMoneda1	,		@nMoneda2	,	@MontoMX2

			IF (@@fetch_status <> 0) BEGIN
				BREAK
			END
			--SELECT @dFecPro, @nNumoper, @cSistema, @cProducto, @cCodigo_Grupo, @nInCodigo,  @nMonto, @nMontoOri, @dFecvctop, @cUsuario, 'N', @cCheckLimInst,'', @nMoneda1, @nMoneda2, @MontoMX2 , @cTipoper
			EXECUTE SP_LIMITES_GRABAR @dFecPro, @nNumoper, @cSistema, @cProducto, @cCodigo_Grupo, @nInCodigo,  @nMonto, @nMontoOri, @dFecvctop, @cUsuario, 'N', @cCheckLimInst,'', @nMoneda1, @nMoneda2, @MontoMX2 , @cTipoper
		END
		CLOSE Cursor_LIMITES_OPERACION_INSTRUMENTO
		DEALLOCATE Cursor_LIMITES_OPERACION_INSTRUMENTO
	END


	SELECT @cMensAprob=''

	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WITH (NOLOCK INDEX=PK_PRODUCTO_CONTROL) 
				 WHERE  codigo_control  = 'MATRI'	AND
					estado		= 'S'		AND
				        id_sistema       = @cSistema	AND
				        codigo_producto  = @cProducto	) BEGIN

	    	--********** GRABAR LIMITE DE OPERADOR *****************
	         EXECUTE SP_LIMITES_CHEQUEAR @cSistema, @nNumoper, 'S', '', @cMensAprob OUTPUT
	END

	DELETE 	LINEA_CHEQUEAR WITH (ROWLOCK)
	WHERE		NumeroOperacion	= @nNumPantalla	
		AND	Id_Sistema	= @cSistema	
		AND	Codigo_Producto = @cProducto	
		AND	Codigo_Grupo	= @cCodigo_Grupo 

END

GO
