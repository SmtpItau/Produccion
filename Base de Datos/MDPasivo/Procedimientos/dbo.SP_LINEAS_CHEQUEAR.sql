USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEAR]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEAR]
			(
			@cSistema		CHAR	(03)	,
			@cProducto		CHAR	(05)	,
			@cCodigo_grupo		CHAR	(10)	,
			@nNumoper		NUMERIC	(10,00)	,
			@cTipoper		CHAR	(01)	,
			@cValidaCheque		CHAR	(01)	,
			@nMercadoLocal		CHAR	(01)	,
			@nMontoconriesgo	FLOAT		,
			@nMontosinriesgo	FLOAT		,
			@Patrimonio_Efectivo	FLOAT		
			)
AS BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT DMY
	
   SET @cProducto = LTRIM(RTRIM(@cProducto))

   -- Agregar Formas de PAGO para Cambios
   -- Incorporarar @nMercadoLocal
      
   DECLARE @dFecPro		DATETIME
      ,    @dFeciniop		DATETIME
      ,    @dFecvctop		DATETIME
      ,    @dFecvctop_AUX	DATETIME
      ,    @cCheckEmi		CHAR   (01)
      ,    @cCheckChq		CHAR   (01)
      ,    @cCheckCli		CHAR   (01)
      ,    @cCheckEmiAux	CHAR   (01)
      ,    @cCheckChqAux	CHAR   (01)
      ,    @cCheckCliAux	CHAR   (01)
      ,    @cCheckLimOPER	CHAR   (01)
      ,    @cCheckLimInst	CHAR   (01)
      ,    @cUsuario		CHAR   (15)
      ,    @cTipo_Riesgo	CHAR   (01)
      ,    @cModPago		CHAR   (01)
      ,    @nRutcli		NUMERIC(09,00)
      ,    @nCodigo		NUMERIC(09,00)
      ,    @nNumdocu		NUMERIC(10,00)
      ,    @nCorrela		NUMERIC(10,00)
      ,    @fTipcambio		NUMERIC(19,04)
      ,    @nMonto		NUMERIC(19,04)
      ,    @nInCodigo		NUMERIC(05,00)
      ,    @nFactor		NUMERIC(19,08)
      ,    @nForpag             INTEGER
      ,    @iFound		INTEGER
      ,    @iFound1		INTEGER
      ,    @iFound2		INTEGER
      ,    @nMatrizriesgo	FLOAT
      ,    @cMoneda             NUMERIC(5)
      ,    @cMoneda2            NUMERIC(3)
      ,    @cMoneda1            NUMERIC(5)
      ,    @cMarca              CHAR(1)
      ,	   @cCodigo_Grupo_EMI	CHAR(10)
      ,    @cSistema_AUX	CHAR(03)
      ,    @cProducto_AUX	CHAR(05)
      ,    @nInCodigo_AUX	NUMERIC(05,00)
      ,	   @cGlosaProducto	CHAR(50)
      ,    @cGlosaMoneda1	CHAR(5)
      ,    @cGlosaMoneda2	CHAR(5)
      ,    @cFamilia		CHAR(6)
      ,    @cplazos_matriz	CHAR(01)

	
	DECLARE @NumeroOperacion 	NUMERIC	(10,0) 	
	DECLARE @Numerodocumento 	NUMERIC	(10,0)	
	DECLARE @NumeroCorrelativo 	NUMERIC	(10,0)
	DECLARE @NumeroOperacion_paso 	NUMERIC	(10,0) 	
	DECLARE @Numerodocumento_paso 	NUMERIC	(10,0)	
	DECLARE @NumeroCorrelativo_paso NUMERIC	(10,0)
      	DECLARE @nMonto_total 		NUMERIC	(19,4)
	DECLARE @cAnticipo		CHAR(1)
	DECLARE @nCorrelativoFRP 	NUMERIC	(10,0)





   CREATE TABLE #TEMP1( mensaje VARCHAR(255) NULL DEFAULT '')

	IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WITH (NOLOCK) WHERE codigo_control	= 'ENBAN' AND
						       id_sistema       = @cSistema		AND
						       codigo_producto  = @cProducto		AND
						       estado		= 'S'	) BEGIN

		EXECUTE SP_LINEA_CHEQUEAR_ENDEUDAMIENTO_BANCO @cSistema,  @nNumoper, @cTipoper
	END


   /******************************************************************************************/
   /******************************************************************************************/
   /******* CHEQUEA LINEAS *******************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/
   /******************************************************************************************/


	SELECT	@cCheckCliAux = 'S',
		@cCheckEmiAux = 'N',
		@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND @cProducto = 'CP'
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'S',
			@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VIX' OR @cProducto = 'VP' )
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'S'

	IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
		SELECT 	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'

	IF @cSistema = 'INV' AND @cProducto = 'CPI'
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'S',
			@cCheckChqAux = 'N'

	IF @cSistema = 'INV' AND @cProducto = 'VPI'
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'S'



	IF @cSistema = 'BCC' 
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'


	IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' ) --AND @cTipoper = 'C'
		SELECT	@cCheckCliAux = 'S',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'


	IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cValidaCheque = 'S' --AND @cTipoper = 'C' 
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'S'


	IF @cSistema = 'BFW' 
		SELECT	@cCheckCliAux = 'N',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'


	IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3' OR @cProducto = '7' OR @cProducto = '8')
		SELECT	@cCheckCliAux = 'S',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'

	IF @cSistema = 'BFW' AND ( @cProducto = '7' ) AND @cTipoper = 'C'
		SELECT	@cCheckCliAux = 'S',
			@cCheckEmiAux = 'S',
			@cCheckChqAux = 'N'

	IF @cSistema = 'BFW' AND @cProducto = '5' AND @cTipoper = 'O' 
		SELECT	@cCheckCliAux = 'S',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'


	IF @cSistema = 'SWP'
		SELECT	@cCheckCliAux = 'S',
			@cCheckEmiAux = 'N',
			@cCheckChqAux = 'N'


	SET	@cCheckCli	= 'N'	
	SET	@cCheckEmi	= 'N'	
	SET	@cCheckChq	= 'N'


	SELECT	@cCheckCli	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK)
	WHERE	codigo_control  = 'LINEA'	 AND
		codigo_grupo	= @cCodigo_Grupo AND
		estado		= 'S'		 AND
		@cCheckCliAux	= 'S'


	SELECT	@cCheckEmi	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK)
	WHERE	codigo_control	= 'CTEMI'	 AND
		estado		= 'S'		 AND
		codigo_grupo	= @cCodigo_Grupo AND
		@cCheckEmiAux	= 'S'


	SELECT	@cCheckChq	= 'S'
	FROM	PRODUCTO_CONTROL WITH (NOLOCK)
	WHERE	codigo_control	= 'CTCHQ'	AND
		estado		= 'S'		AND
		@cCheckChqAux	= 'S'

/*
   	print @cCheckCli
	print @cCheckEmi	
	print @cCheckChq
	return 
*/	
	/**********************************************************************************/
	/****  CHEQUEA LINEA EMISOR  ******************************************************/
	/**********************************************************************************/
	IF @cCheckEmi = 'S' BEGIN



		SELECT	@cCodigo_Grupo_EMI = @cCodigo_Grupo,
			@cSistema_AUX = @cSistema,
			@cProducto_AUX = @cProducto,
			@nInCodigo_AUX = @nInCodigo


		IF @cSistema = 'BFW'
		BEGIN

			SELECT	@cCodigo_Grupo_EMI = A.codigo_grupo,
				@cSistema_AUX = A.id_sistema,
				@cProducto_AUX = A.codigo_producto
			FROM	GRUPO_PRODUCTO_DETALLE A WITH (NOLOCK), LINEA_CHEQUEAR B WITH (NOLOCK)
			WHERE	A.id_sistema		= 'BTR'
			AND	A.codigo_producto	= 'CP'
			AND	A.codigo_instrumento	= B.incodigo 
			AND	B.NumeroOperacion	= @nNumoper
			AND	B.Id_Sistema		= @cSistema
			AND	B.incodigo  < 2000

			SELECT	@cCodigo_Grupo_EMI = A.codigo_grupo,
				@cSistema_AUX = A.id_sistema,
				@cProducto_AUX = A.codigo_producto
			FROM	GRUPO_PRODUCTO_DETALLE A WITH (NOLOCK), LINEA_CHEQUEAR B WITH (NOLOCK)
			WHERE	A.id_sistema		= 'INV'
			AND	A.codigo_producto	= 'CPI'
			AND	B.NumeroOperacion	= @nNumoper
			AND	B.Id_Sistema		= @cSistema
			AND	B.incodigo  = 2000




		END

-- SELECT * FROM INSTRUMENTO WHERE INCONTAB='N'
		DECLARE CURSOR_LINEAS CURSOR 
			LOCAL
			FORWARD_ONLY STATIC
			FOR
			SELECT	FechaOperacion		,Rut_Emisor		,FechaVencimiento	,MontoTransaccion	,
				Tipo_Riesgo		,Compensacion           ,moneda_emision		,Moneda1		,
				Moneda2			,NumeroOperacion 	,Numerodocumento 	,NumeroCorrelativo	,
				nCorrelativoFRP		,InCodigo
			FROM	LINEA_CHEQUEAR	WITH (NOLOCK INDEX = IX_LINEA_CHEQUEAR),
				EMISOR 		WITH (NOLOCK)
			WHERE	NumeroOperacion	= @nNumoper		AND
				Id_Sistema	= @cSistema		AND
				(  ( @cSistema = 'BTR' AND EXISTS (SELECT 1 FROM INSTRUMENTO WITH (NOLOCK) WHERE incontab = 'S' AND LINEA_CHEQUEAR.incodigo = INSTRUMENTO.incodigo) )
				OR ( @cSistema = 'BFW' AND EXISTS (SELECT 1 FROM INSTRUMENTO WITH (NOLOCK) WHERE incontab = 'S' AND LINEA_CHEQUEAR.incodigo = INSTRUMENTO.incodigo) )
				OR ( @cSistema = 'BFW' AND LINEA_CHEQUEAR.incodigo = 2000 )
				OR   @cSistema = 'INV' )
			AND	emrut = Rut_Emisor
			AND	emglosa = 'S'



			OPEN CURSOR_LINEAS
			FETCH NEXT FROM CURSOR_LINEAS INTO	
				@dFecPro		,@nRutcli		,@dFecvctop		,@nMonto		,
				@cTipo_Riesgo		,@cModPago      	,@cMoneda 		,@cMoneda1		,
				@cMoneda2		,@NumeroOperacion	,@Numerodocumento	,@NumeroCorrelativo	,
				@nCorrelativoFRP	,@nInCodigo
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @NumeroOperacion_paso 	= @NumeroOperacion 
				SET @Numerodocumento_paso	= @Numerodocumento 
				SET @NumeroCorrelativo_paso	= @NumeroCorrelativo


				WHILE @@FETCH_STATUS = 0 AND @NumeroOperacion_paso = @NumeroOperacion AND @Numerodocumento_paso	= @Numerodocumento AND @NumeroCorrelativo_paso	= @NumeroCorrelativo
				BEGIN


					SELECT	@iFound	= 0
	                    		SELECT  @cMarca  =' '
					SELECT	@cFamilia = ''


					SELECT	@cGlosaMoneda1 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda1
					SELECT	@cGlosaMoneda2 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda2




					SELECT	@cGlosaProducto = Descripcion,
						@cplazos_matriz = plazos_matriz
					FROM	PRODUCTO WITH (NOLOCK) 
					WHERE	Id_Sistema = @cSistema_AUX
					AND	Codigo_Producto = @cProducto_AUX


					IF @nInCodigo = 2000
						SELECT @nInCodigo = 0

					SELECT	@cFamilia = inserie FROM INSTRUMENTO WITH (NOLOCK)  WHERE InCodigo = @nInCodigo


					SELECT	@iFound	= 0

		        		SELECT	@iFound	= 1
					FROM	MATRIZ_RIESGO WITH (NOLOCK)
					WHERE	id_sistema = @cSistema_AUX
					AND	codigo_producto = @cProducto_AUX
					AND	codigo_instrumento = @nInCodigo
					AND	codigo_moneda = @cMoneda1
					AND	codigo_moneda2 = @cMoneda2



					IF @iFound = 0 AND @ccodigo_grupo <> 'SETTLE'
						INSERT INTO #TEMP1
						SELECT	'No Existe Matriz de Riesgo Monedas: '
						+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
						+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
						+	LTRIM(RTRIM(@cSistema_AUX)) + "-"
						+	LTRIM(RTRIM(@cGlosaProducto)) + "-"
						+	LTRIM(RTRIM(@cFamilia))



					SELECT	@iFound1	= 0


					SELECT	@iFound1	= 1,
						@nMatrizriesgo	= porcentaje
					FROM	MATRIZ_RIESGO WITH (NOLOCK)
					WHERE	id_sistema = @cSistema_AUX
					AND	codigo_producto = @cProducto_AUX
					AND	codigo_instrumento = @nInCodigo
					AND	DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_grupo_desde
					AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_grupo_hasta
					AND	DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_desde
					AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_hasta
					AND	codigo_moneda = @cMoneda1
					AND	codigo_moneda2= @cMoneda2


				SELECT	@iFound1 = 1, @iFound =1 , @nMatrizriesgo = 100 WHERE @ccodigo_grupo = 'SETTLE'


					IF @iFound = 1 AND ( @iFound1 = 0 ) --OR @nMatrizriesgo = 0 )
						IF @cplazos_matriz = 'S'
							INSERT INTO #TEMP1
							SELECT	'No Existe Matriz de Riesgo para Combinacion de Plazos ('
							+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop)))) +	'-'
							+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
							+ 	') Monedas :'
							+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
							+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
							+	LTRIM(RTRIM(@cSistema_AUX)) + "-"
							+	LTRIM(RTRIM(@cGlosaProducto)) + "-"
							+	LTRIM(RTRIM(@cFamilia))
						ELSE
							INSERT INTO #TEMP1
							SELECT	'No Existe Matriz de Riesgo para Plazo ('
							+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
							+ 	') Monedas :'
							+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
							+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
							+	LTRIM(RTRIM(@cSistema_AUX)) + "-"
							+	LTRIM(RTRIM(@cGlosaProducto)) + "-"
							+	LTRIM(RTRIM(@cFamilia))



					SET @nMonto_total=@nMonto_total+@nMonto

	
					FETCH NEXT FROM CURSOR_LINEAS INTO	
					@dFecPro		,@nRutcli		,@dFecvctop		,@nMonto		,
					@cTipo_Riesgo		,@cModPago      	,@cMoneda 		,@cMoneda1		,
					@cMoneda2		,@NumeroOperacion	,@Numerodocumento	,@NumeroCorrelativo	,
					@nCorrelativoFRP	,@nInCodigo
				END 

			IF EXISTS(SELECT 1 FROM EMISOR WITH (NOLOCK) WHERE emrut = @nRutcli AND emglosa = 'S') BEGIN
				EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cCodigo_Grupo_EMI, @dFecPro, @nRutcli, 0, @dFecvctop, @nMonto_total, @cTipo_Riesgo, @nMontoconriesgo, @nMontosinriesgo
				EXECUTE SP_LINEAS_ENDEUDA_POR_TIPO_CLIENTE @cCodigo_Grupo_EMI, @nRutcli, 0, @nMonto_total, @cTipo_Riesgo, @Patrimonio_Efectivo
			END

		END

		CLOSE CURSOR_LINEAS
		DEALLOCATE CURSOR_LINEAS

	END




	/**********************************************************************************/
	/******** CHEQUEA LINEA CLIENTE ***************************************************/
	/**********************************************************************************/
	IF @cCheckCli = 'S' BEGIN

-- select * from LINEA_CHEQUEAR

		DECLARE CURSOR_LINEAS CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,Rut_Cliente		,Codigo_Cliente		,FechaVencimiento	,
			MontoTransaccion	,Tipo_Riesgo		,FormaPago		,Compensacion           ,
                        Moneda1			,Moneda2            	,NumeroOperacion 	,Numerodocumento 	,
			NumeroCorrelativo	,nCorrelativoFRP	,FechaVctoInst
		FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX = IX_LINEA_CHEQUEAR)
		WHERE	NumeroOperacion	= @nNumoper	AND
			Id_Sistema	= @cSistema	AND
			codigo_grupo	= @cCodigo_grupo

		OPEN CURSOR_LINEAS
		FETCH NEXT FROM CURSOR_LINEAS INTO	
			@dFecPro		,@nRutcli		,@nCodigo		,@dFecvctop	,
			@nMonto			,@cTipo_Riesgo		,@nForpag		,@cModPago	,
			@cMoneda1		,@cMoneda2		,@NumeroOperacion	,@Numerodocumento,
			@NumeroCorrelativo 	,@nCorrelativoFRP	,@dFecvctop_AUX

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NumeroOperacion_paso 	= @NumeroOperacion
			SET @Numerodocumento_paso	= @Numerodocumento
			SET @NumeroCorrelativo_paso	= @NumeroCorrelativo

			WHILE @@FETCH_STATUS = 0 AND @NumeroOperacion_paso = @NumeroOperacion AND @Numerodocumento_paso	= @Numerodocumento AND @NumeroCorrelativo_paso	= @NumeroCorrelativo
			BEGIN
	

				SET	@iFound		= 0
				SET	@nMatrizriesgo	= 0
	     		        SET 	@cMarca  =' '

				SELECT	@nInCodigo = 0
				SELECT	@cGlosaMoneda1 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda1
				SELECT	@cGlosaMoneda2 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda2


				SELECT	@cGlosaProducto = Descripcion,
					@cplazos_matriz = plazos_matriz
				FROM	PRODUCTO WITH (NOLOCK)
				WHERE	Id_Sistema = @cSistema
				AND	Codigo_Producto = @cProducto



				SELECT	@iFound	= 0

	        		SELECT	@iFound	= 1
				FROM	MATRIZ_RIESGO WITH (NOLOCK)
				WHERE	id_sistema = @cSistema
				AND	codigo_producto = @cProducto
				AND	codigo_instrumento = @nInCodigo
				AND	codigo_moneda = @cMoneda1
				AND	codigo_moneda2 = @cMoneda2


				IF @iFound = 0 AND @ccodigo_grupo <> 'SETTLE'
					INSERT INTO #TEMP1
					SELECT	'No Existe Matriz de Riesgo Monedas: '
					+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
					+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
					+	LTRIM(RTRIM(@cSistema)) + "-"
					+	LTRIM(RTRIM(@cGlosaProducto))


				SELECT	@iFound1	= 0

				SELECT	@iFound1	= 1,
					@nMatrizriesgo	= porcentaje
				FROM	MATRIZ_RIESGO WITH (NOLOCK)
				WHERE	id_sistema = @cSistema
				AND	codigo_producto = @cProducto
				AND	codigo_instrumento = @nInCodigo
				AND	DATEDIFF(day, @dFecPro, @dFecvctop_AUX)  > dias_grupo_desde
				AND	DATEDIFF(day, @dFecPro, @dFecvctop_AUX) <= dias_grupo_hasta
				AND	DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_desde
				AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_hasta
				AND	codigo_moneda  = @cMoneda1
				AND	codigo_moneda2 = @cMoneda2

	
				SELECT	@iFound1 = 1, @iFound =1 , @nMatrizriesgo = 100 WHERE @ccodigo_grupo = 'SETTLE'


				IF @iFound = 1 AND ( @iFound1 = 0 ) --OR @nMatrizriesgo = 0 )
					IF @cplazos_matriz = 'S'
						INSERT INTO #TEMP1
						SELECT	'No Existe Matriz de Riesgo para Combinacion de Plazos ('
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop_AUX)))) +	'-'
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
						+ 	') Monedas :'
						+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
						+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
						+	LTRIM(RTRIM(@cSistema)) + "-"
						+	LTRIM(RTRIM(@cGlosaProducto))
					ELSE
						INSERT INTO #TEMP1
						SELECT	'No Existe Matriz de Riesgo para Plazo ('
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
						+ 	') Monedas :'
						+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
						+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
						+	LTRIM(RTRIM(@cSistema)) + "-"
						+	LTRIM(RTRIM(@cGlosaProducto))
	
	
	
					
				IF @iFound = 1 	SELECT @nMonto = ROUND(@nMonto/100*@nMatrizriesgo,4)
				SET @nMonto_total=@nMonto_total+@nMonto

				FETCH NEXT FROM CURSOR_LINEAS INTO	
					@dFecPro		,@nRutcli		,@nCodigo		,@dFecvctop	,
					@nMonto			,@cTipo_Riesgo		,@nForpag		,@cModPago	,
					@cMoneda1		,@cMoneda2		,@NumeroOperacion	,@Numerodocumento,
					@NumeroCorrelativo 	,@nCorrelativoFRP	,@dFecvctop_AUX
			END

			IF EXISTS(SELECT 1 FROM CLIENTE WITH (NOLOCK) WHERE clrut=@nRutcli AND clcodigo=@nCodigo AND Clvalidalinea= 'S') 
			BEGIN
				IF EXISTS(SELECT 1 FROM FORMA_DE_PAGO WITH (NOLOCK) WHERE codigo = @nForpag	AND afectacorr	= 'S')  
				BEGIN
					EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cCodigo_Grupo, @dFecPro, @nRutcli, @nCodigo, @dFecvctop, @nMonto, @cTipo_Riesgo, @nMontoconriesgo, @nMontosinriesgo
					EXECUTE SP_LINEAS_ENDEUDA_POR_TIPO_CLIENTE @cCodigo_Grupo, @nRutcli, @nCodigo, @nMonto, @cTipo_Riesgo, @Patrimonio_Efectivo
				END
			END

		END
		CLOSE CURSOR_LINEAS
		DEALLOCATE CURSOR_LINEAS
	END


	/**********************************************************************************/
	/******** CHEQUEA LINEA CHEQUE ****************************************************/
	/**********************************************************************************/
	IF @cCheckChq = 'S' BEGIN


		DECLARE CURSOR_LINEAS CURSOR 
		LOCAL
		FORWARD_ONLY STATIC
		FOR
		SELECT	FechaOperacion		,
			Rut_Cheque		,
			FechaVctoCheque		,
			MontoTransaccion	,
			Tipo_Riesgo		,
			FormaPago		,
			Compensacion            ,
			moneda1			,
                        Moneda2			,
			NumeroOperacion 	,
			Numerodocumento 	,
			NumeroCorrelativo	,
			nCorrelativoFRP
		FROM   LINEA_CHEQUEAR WITH (NOLOCK INDEX = IX_LINEA_CHEQUEAR)
		WHERE  NumeroOperacion	= @nNumoper	AND
			Id_Sistema	= @cSistema	AND
			codigo_Grupo	= @cCodigo_Grupo AND
			Pago_Cheque     = 'S'


		OPEN CURSOR_LINEAS

		FETCH NEXT FROM CURSOR_LINEAS
			INTO	@dFecPro	,@nRutcli	,@dFecvctop	,@nMonto		,
				@cTipo_Riesgo	,@nForpag	,@cModPago      ,@cMoneda1		,
                                @cMoneda2	,@NumeroOperacion ,@Numerodocumento ,@NumeroCorrelativo	,
				@nCorrelativoFRP
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NumeroOperacion_paso 	= @NumeroOperacion 
			SET @Numerodocumento_paso	= @Numerodocumento 
			SET @NumeroCorrelativo_paso	= @NumeroCorrelativo

			WHILE @@FETCH_STATUS = 0 AND @NumeroOperacion_paso = @NumeroOperacion AND @Numerodocumento_paso	= @Numerodocumento AND @NumeroCorrelativo_paso	= @NumeroCorrelativo
			BEGIN
				SET	@iFound		= 0
                		SET 	@cMarca  =' '
				SELECT 	@nInCodigo = 0

				SELECT	@cGlosaMoneda1 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda1
				SELECT	@cGlosaMoneda2 = mnnemo  FROM MONEDA WITH (NOLOCK) WHERE mncodmon = @cMoneda2


				SELECT	@cGlosaProducto = Descripcion,
					@cplazos_matriz = plazos_matriz
				FROM	PRODUCTO WITH (NOLOCK) 
				WHERE	Id_Sistema = @cSistema
				AND	Codigo_Producto = @cProducto



				SELECT	@iFound	= 0

	        		SELECT	@iFound	= 1
				FROM	MATRIZ_RIESGO WITH (NOLOCK)
				WHERE	id_sistema = @cSistema
				AND	codigo_producto = @cProducto
				AND	codigo_instrumento = @nInCodigo
				AND	codigo_moneda = @cMoneda1
				AND	codigo_moneda2 = @cMoneda2


				IF @iFound = 0 AND @ccodigo_grupo <> 'SETTLE'
					INSERT INTO #TEMP1
					SELECT	'No Existe Matriz de Riesgo Monedas: '
					+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
					+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
					+	LTRIM(RTRIM(@cSistema)) + "-"
					+	LTRIM(RTRIM(@cGlosaProducto))


				SELECT	@iFound1	= 0

				SELECT	@iFound1	= 1,
					@nMatrizriesgo	= porcentaje
				FROM	MATRIZ_RIESGO WITH (NOLOCK)
				WHERE	id_sistema = @cSistema
				AND	codigo_producto = @cProducto
				AND	codigo_instrumento = @nInCodigo
				AND	DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_grupo_desde
				AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_grupo_hasta
				AND	DATEDIFF(day, @dFecPro, @dFecvctop)  > dias_desde
				AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= dias_hasta
				AND	codigo_moneda  = @cMoneda1
				AND	codigo_moneda2 = @cMoneda2

	
				SELECT	@iFound1 = 1, @iFound =1 , @nMatrizriesgo = 100 WHERE @ccodigo_grupo = 'SETTLE'


				IF @iFound = 1 AND ( @iFound1 = 0 ) --OR @nMatrizriesgo = 0 )
					IF @cplazos_matriz = 'S'
						INSERT INTO #TEMP1
						SELECT	'No Existe Matriz de Riesgo para Combinacion de Plazos ('
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop)))) +	'-'
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
						+ 	') Monedas :'
						+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
						+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
						+	LTRIM(RTRIM(@cSistema)) + "-"
						+	LTRIM(RTRIM(@cGlosaProducto))
					ELSE
						INSERT INTO #TEMP1
						SELECT	'No Existe Matriz de Riesgo para Plazo ('
						+ 	LTRIM(RTRIM(CONVERT(CHAR(5),DATEDIFF(day, @dFecPro, @dFecvctop))))
						+ 	') Monedas :'
						+	LTRIM(RTRIM(@cGlosaMoneda1)) + '-'
						+	LTRIM(RTRIM(@cGlosaMoneda2)) + '-'
						+	LTRIM(RTRIM(@cSistema)) + "-"
						+	LTRIM(RTRIM(@cGlosaProducto))

				SET @nMonto_total=@nMonto_total+@nMonto
				FETCH NEXT FROM CURSOR_LINEAS
				INTO	@dFecPro	,@nRutcli	,@dFecvctop	,@nMonto		,
					@cTipo_Riesgo	,@nForpag	,@cModPago      ,@cMoneda1		,
                        	        @cMoneda2	,@NumeroOperacion ,@Numerodocumento ,@NumeroCorrelativo	,
					@nCorrelativoFRP
			END

			IF EXISTS(SELECT 1 FROM CLIENTE WITH (NOLOCK) WHERE clrut = @nRutcli AND Clvalidalinea	= 'S') 
			BEGIN
				IF EXISTS(SELECT 1 FROM FORMA_DE_PAGO  WITH (NOLOCK) WHERE codigo = @nForpag AND afectacorr	= 'S') 
				BEGIN
					EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cCodigo_Grupo, @dFecPro, @nRutcli, 0, @dFecvctop, @nMonto, @cTipo_Riesgo, @nMontoconriesgo, @nMontosinriesgo
					EXECUTE SP_LINEAS_ENDEUDA_POR_TIPO_CLIENTE @cCodigo_Grupo, @nRutcli, 0, @nMonto, @cTipo_Riesgo, @Patrimonio_Efectivo
				END
			END
		END

		CLOSE CURSOR_LINEAS
		DEALLOCATE CURSOR_LINEAS

	END




	IF EXISTS(SELECT 1 FROM #Temp1)  BEGIN

		DELETE LINEA_CHEQUEAR WITH (ROWLOCK)
		WHERE	NumeroOperacion = @nNumoper		AND
			Id_Sistema	= @cSistema		AND
			Codigo_grupo	= @cCodigo_grupo 	AND
			Codigo_Producto = @cProducto 		AND
			nCorrelativoFRP = @nCorrelativoFRP
		-- AGREGADO GMG
		--and 	@nCorrelativoFRP	
		--AND	MontoTransaccion	= @nMonto

		SELECT mensaje FROM #TEMP1
		RETURN
	END


	SET	@cAnticipo = 'N'

	IF @cSistema='BTR' AND @cProducto IN('RCA','RVA') 
		SET	@cAnticipo = 'S'


	IF @cSistema='BFW' AND @cProducto IN('ANT') 
		SET	@cAnticipo = 'S'


	IF @cSistema='SWP' AND @cProducto IN('ANT') 
		SET	@cAnticipo = 'S'


	IF @cAnticipo = 'N'
	BEGIN

		-- esto para los sistemas que al modificar anulan la operacion y vuelven a tomar lineas,
		-- ya que la anulación no elimina estos registros y al existir se produce un problema con las llaves primarias
		-- mquilodran 9-7-2003

		EXECUTE Sp_Lineas_Anula @cSistema, @nNumoper

		DELETE LINEA_AUTORIZACION 		WITH (ROWLOCK) WHERE Codigo_Sistema = @cSistema	AND NumeroOperacion = @nNumoper
		DELETE LIMITE_TRANSACCION_ERROR		WITH (ROWLOCK) WHERE id_sistema = @cSistema		AND NumeroOperacion = @nNumoper
		DELETE LIMITE_TRANSACCION		WITH (ROWLOCK) WHERE id_sistema = @cSistema		AND NumeroOperacion = @nNumoper
		DELETE LINEA_TRANSACCION_DETALLE	WITH (ROWLOCK) WHERE id_sistema = @cSistema		AND NumeroOperacion = @nNumoper
		DELETE LINEA_TRANSACCION 		WITH (ROWLOCK) WHERE id_sistema = @cSistema		AND NumeroOperacion = @nNumoper
		DELETE LINEAS_OPERACION_FRP 		WITH (ROWLOCK) WHERE id_sistema = @cSistema		AND NumeroOperacion = @nNumoper

	END

		SELECT mensaje FROM #TEMP1

END

GO
