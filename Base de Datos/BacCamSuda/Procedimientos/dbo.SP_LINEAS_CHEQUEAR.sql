USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEAR]
	(	@cSistema 	CHAR(03) 	,
		@cProducto 	CHAR(05) 	,
		@nNumoper 	NUMERIC(10) 	,
		@cTipoper  	Char(01) 	,
		@cValidaCheque 	Char(01) 	,
		@nMercadoLocal	Char(01)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT 	@cProducto = LTRIM(RTRIM(@cProducto))
	DECLARE @cCheckEmi  	CHAR(1)		,
		@cCheckChq  	CHAR(1)		,
		@cCheckCli  	CHAR(1)		,
		@cCheckLimOPER  CHAR(1)		,
		@cCheckLimInst  CHAR(1)		,
		@dFecPro  	DATETIME 	,
		@nRutcli  	NUMERIC (09,0) 	,
		@nCodigo  	NUMERIC (09,0) 	,
		@dFecvctop  	DATETIME 	,
		@cUsuario  	CHAR (15) 	,
		@nMonto   	NUMERIC (19,4) 	,
		@cTipo_Riesgo  	CHAR (1) 	,
		@nNumdocu  	NUMERIC (10,0) 	,
		@nCorrela  	NUMERIC (10,0) 	,
		@dFeciniop  	DATETIME 	,
		@fTipcambio  	NUMERIC (19,4) 	,
		@nMonedaOp  	NUMERIC (05,0) 	,
		@nInCodigo  	NUMERIC (05) 	,
		@FormaPago	NUMERIC (03,0)	,
		@nFactor	NUMERIC (19,8)	,
		@nTasPact	FLOAT		,
		@nTir		FLOAT		,
		@nMonemi	NUMERIC(05,0)	,
		@dFecVenc	DATETIME


		


	CREATE TABLE #temp1( mensaje CHAR(255) )
	--************************************************
	--************************************************
	--**********                     *****************
	--**********    CHEQUEA LINEAS   *****************
	--**********                     *****************
	--************************************************
	--************************************************
	SELECT 	@cCheckCli = 'S',
		@cCheckEmi = 'N',
		@cCheckChq = 'N'

	IF 	@cSistema = 'BTR' AND @cProducto = 'CP'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'

	IF 	@cSistema = 'BTR' AND @cProducto = 'FLI'  
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'

	IF 	@cSistema = 'BEX' AND @cProducto = 'CP'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'

	IF 	@cSistema = 'BEX' AND @cProducto = 'VP'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VP' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'

	IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'

	IF @cSistema = 'BCC' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' OR @cProducto = 'ARBI' OR @cProducto = 'OVER' OR @cProducto = 'WEEK') AND @cTipoper = 'C'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cTipoper = 'C' AND @cValidaCheque = 'S'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'

	IF @cSistema = 'BFW' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR @cProducto = '7' ) -- VGS 12/2004 AND @nMercadoLocal = 'S'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'PCS' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'PCS' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3' ) -- VGS 12/2004 AND @nMercadoLocal = 'S'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'PCS' AND ( @cProducto = '4' ) -- VGS 12/2004 AND @nMercadoLocal = 'S'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	--********** CHEQUEA LINEA EMISOR *****************


	IF @cCheckEmi = 'S'
		BEGIN
			DECLARE Cursor_LINEAS SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				Rut_Emisor  		,
				FechaVctoInst 		,
				SUM(MontoTransaccion)	,
				Tipo_Riesgo		,
				InCodigo		,
				MonedaOperacion		,
				FormaPago
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion = @nNumoper	AND
				Id_Sistema = @cSistema		AND
				Rut_Emisor     <> 97029000	AND
				Rut_Emisor  <> 97023000
			GROUP BY
				FechaOperacion  	,
				Rut_Emisor  		,
				FechaVctoInst	,
				Tipo_Riesgo		,
				InCodigo		,
				MonedaOperacion		,
				FormaPago



			OPEN Cursor_LINEAS
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS
					INTO	@dFecPro 	,
						@nRutcli 	,
						@dFecvctop 	,
						@nMonto  	,
						@cTipo_Riesgo	,
						@nInCodigo  	,
						@nMonedaOp  	,
						@FormaPago

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema, @dFecPro, @nRutcli, 1, @dFecvctop, @nMonto, @cTipo_Riesgo, @cProducto, @nInCodigo, @nMonedaOp, @FormaPago

				END

			CLOSE Cursor_LINEAS
			DEALLOCATE Cursor_LINEAS

		END


	--********** CHEQUEA LINEA CLIENTE *****************
	IF @cCheckCli = 'S'
		BEGIN
			DECLARE Cursor_LINEAS SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				Rut_Cliente  		,
				Codigo_Cliente  	,
				FechaVencimiento 	,
				SUM(MontoTransaccion) 	,
				Tipo_Riesgo		,
				InCodigo		,
				MonedaOperacion		,
				FormaPago
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion = @nNumoper	AND
				Id_Sistema = @cSistema
			GROUP BY
				FechaOperacion  	,
				Rut_Cliente  		,
				Codigo_Cliente  	,
				FechaVencimiento 	,
				Tipo_Riesgo		,
				InCodigo		,
				MonedaOperacion		,
				FormaPago

			

			OPEN Cursor_LINEAS
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS
					INTO	@dFecPro 	,
						@nRutcli 	,
						@nCodigo 	,
						@dFecvctop 	,
						@nMonto  	,
						@cTipo_Riesgo	,
						@nInCodigo  	,
						@nMonedaOp  	,
						@FormaPago

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END
					--cambio 01/06/04
					SELECT @nMonedaOp = 0
					SELECT @FormaPago = 0					

					IF @cSistema = 'BTR' and @cProducto='ICOL'
						EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema, @dFecPro, @nRutcli, @nCodigo, @dFecvctop, @nMonto, @cTipo_Riesgo, @cProducto, @nInCodigo, @nMonedaOp, @FormaPago 
					ELSE
						EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema, @dFecPro, @nRutcli, @nCodigo, @dFecvctop, @nMonto, @cTipo_Riesgo, @cProducto, 0, @nMonedaOp, @FormaPago --@nInCodigo


				END

			CLOSE Cursor_LINEAS
			DEALLOCATE Cursor_LINEAS

		END


	IF (SELECT COUNT(*) FROM #Temp1) > 0 
		BEGIN
			DELETE  LINEA_CHEQUEAR
			WHERE 	NumeroOperacion = @nNumoper	AND
				Id_Sistema 	= @cSistema	AND
				Codigo_Producto = @cProducto  
			SELECT * FROM #Temp1
			RETURN 
		END

	SET NOCOUNT OFF

END



GO
