USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_GrbOperacion]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_GrbOperacion]
		(	@cSistema	CHAR (03) 	,
			@cProducto	CHAR (05)	,
			@nNumPantalla	NUMERIC(10) 	,
			@nNumoper	NUMERIC(10) 	,
			@cTipoper	CHAR(01) 	,
			@cValidaCheque	CHAR(01) 	,
			@nMercadoLocal	CHAR(01)
		)
AS
BEGIN

	SET NOCOUNT ON
	SELECT 	@cProducto = LTRIM(RTRIM(@cProducto))
	DECLARE @cCheckEmi  	CHAR(1)		,
		@cCheckChq  	CHAR(1)		,
		@cCheckCli  	CHAR(1)		,
		@cCheckLimOPER  CHAR(1)		,
		@cCheckLimInst	CHAR(1)		,
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
		@nMonedaOp  	NUMERIC (05,00) ,
		@nInCodigo  	NUMERIC (05,0)	,
		@FormaPago	NUMERIC (03,0)	,
		@nFactor  	NUMERIC (19,8)	,
		@rut_banco	NUMERIC(09)     ,
                @cCtrlGrpEmisor CHAR(01)	,
		@nTasPact	FLOAT		,
		@nTir		FLOAT		,
		@cCheckTasa	CHAR(01)	,
		@cIntser	CHAR(12)	,
		@cSeriado	CHAR(01)

	SELECT	@rut_banco = rcrut
	FROM	view_entidad


	--************************************************
	--************************************************
	--**********                     *****************
	--**********    CHEQUEA LINEAS   *****************
	--**********                     *****************
	--************************************************
	--************************************************


	SELECT	@cCheckCli  = 'S',
		@cCheckEmi  = 'N',
		@cCheckChq  = 'N',
		@cCheckTasa = 'N'

	IF @cSistema = 'BTR' AND @cProducto = 'CP'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VP' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'

	IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'

	IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'

	IF @cSistema = 'BCC' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' OR @cProducto = 'ARBI' OR @cProducto = 'OVER' ) --AND @cTipoper = 'C'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' OR @cProducto = 'ARBI' OR @cProducto = 'OVER' )AND @cValidaCheque = 'S' --  AND @cTipoper = 'C' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'

	IF @cSistema = 'BFW' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR @cProducto = '7' ) --AND @nMercadoLocal = 'S'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'

	 IF @cSistema = 'PCS' 
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'

	 IF @cSistema = 'PCS' AND ( RTRIM(LTRIM(@cProducto)) = '1' OR RTRIM(LTRIM(@cProducto)) = '2'  OR RTRIM(LTRIM(@cProducto)) = '3'  ) --AND @nMercadoLocal = 'S'
		SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'


        SELECT @cCtrlGrpEmisor = 'N'
        IF @cSistema = 'BTR' AND (@cProducto = 'CP' OR @cProducto = 'VP')
                SELECT @cCtrlGrpEmisor = 'S'

	IF @cSistema = 'BTR' AND (@cProducto = 'CI' OR @cProducto = 'VI' OR @cProducto = 'ICOL' OR @cProducto = 'ICAP') BEGIN
		SELECT @cCheckCli = 'S' -- Esto es por el control de Tasas del pacto 
					-- pero no chequea las lineas del cliente
		iF @cProducto <> 'ICOL' AND @cProducto <> 'ICAP'
			SELECT @cCheckTasa = 'S'
	END

	IF @cSistema = 'BTR' AND (@cProducto = 'CP' OR @cProducto = 'VP')
		SELECT @cCheckTasa = 'S'


	IF @cSistema = 'BEX' AND @cProducto = 'CP'
		SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'

	IF @cSistema = 'BEX' AND @cProducto = 'VP'		
		SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N', @cCheckTasa = 'S'



	SELECT @cProducto =  ( CASE 	WHEN @cProducto = '1' AND @cSistema = 'PCS' THEN '1' --'ST'
					WHEN @cProducto = '2' AND @cSistema = 'PCS' THEN '2' --'SM'
					WHEN @cProducto = '3' AND @cSistema = 'PCS' THEN '3' --'FR'
					WHEN @cProducto = 'CP' AND @cSistema = 'BEX' THEN 'CPX'
					WHEN @cProducto = 'VP' AND @cSistema = 'BEX' THEN 'VPX'
					ELSE @cProducto
					END )


	 --************************************************
	 --************************************************
	 --**********                     *****************
	 --**********   ACTUALIZA LINEAS  *****************
	 --**********                     *****************
	 --************************************************
	 --************************************************
	 --********** GRABAR LINEA EMISOR *****************

	IF @cCheckEmi = 'S'
		BEGIN

			DECLARE Cursor_LINEAS_EMISOR SCROLL CURSOR FOR
			SELECT	FechaOperacion		,
				Rut_Emisor  		,
				NumeroDocumento  	,
				NumeroCorrelativo 	,
				SUM(MontoTransaccion) 	,
				TipoCambio  		,
				FechaVctoInst  		,
				Operador  		,
				Moneda_Emision		,
				Tipo_Riesgo		,
				InCodigo		,
				FormaPago		--,
--				Tir

			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema			AND
				Rut_Emisor  <> 97029000			AND
				Rut_Emisor <> @rut_banco
			GROUP BY
				FechaOperacion		,
				Rut_Emisor		,
				NumeroDocumento		,
				NumeroCorrelativo	,
				TipoCambio  		,
				FechaVctoInst  		,
				Operador  		,
				Moneda_Emision  	,
				Tipo_Riesgo		,
				InCodigo		,
				FormaPago		



			OPEN Cursor_LINEAS_EMISOR
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_EMISOR
					INTO 	@dFecPro  	,
						@nRutcli 	,
						@nNumdocu 	,
						@nCorrela 	,
						@nMonto  	,
						@fTipcambio 	,
						@dFecvctop 	,
						@cUsuario 	,
						@nMonedaOp	,
						@cTipo_Riesgo 	,
						@nInCodigo  	,
						@FormaPago	


					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					SELECT @nMonto

					IF @nInCodigo NOT in (9,11,13) -- DPF-DPR-DPX Se excluyen en el control del Emisor VGS

						EXECUTE Sp_Lineas_Grabar @dFecPro, @cSistema, @cProducto, @nRutcli, 1, @nNumoper, @nNumdocu, @nCorrela, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo, @nInCodigo, @FormaPago
					
				END
			CLOSE Cursor_LINEAS_EMISOR
			DEALLOCATE Cursor_LINEAS_EMISOR
		END


	--********** GRABAR LINEA CLIENTE *****************


	IF @cCheckCli = 'S'
		BEGIN


			DECLARE Cursor_LINEAS_CLIENTE SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				Rut_Cliente  		,
				Codigo_Cliente  	,
				SUM(MontoTransaccion) 	,
				TipoCambio  		,
				FechaVencimiento 	,
				Operador  		,
				MonedaOperacion  	,
				Tipo_Riesgo		,
				FormaPago		,
				MAX(TasaPacto)

			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema

			GROUP BY
				FechaOperacion  	,
				Rut_Cliente  		,
				Codigo_Cliente  	,
				TipoCambio  		,
				FechaVencimiento	,
				Operador  		,
				MonedaOperacion		,
				Tipo_Riesgo		,
				FormaPago



			OPEN Cursor_LINEAS_CLIENTE
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_CLIENTE
					INTO	@dFecPro  	,
						@nRutcli 	,
						@nCodigo 	,
						@nMonto  	,
						@fTipcambio 	,
						@dFecvctop 	,
						@cUsuario 	,
						@nMonedaOp	,
						@cTipo_Riesgo 	,
						@FormaPago	,
						@nTasPact

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END



					IF @cProducto <> 'VP' AND @cProducto <> 'ICAP' BEGIN

						IF @cProducto <> 'VI'

 						EXECUTE Sp_Lineas_Grabar @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @nNumoper, 0, 0, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo, 0, @FormaPago  


						IF @cProducto = 'ICOL' begin
							EXECUTE Sp_Chk_Tasas @dFecPro, @cSistema, 'CI', @FormaPago, @nMonedaOp, @nNumPantalla, @dFecvctop, @nTasPact,0,'P','','',@nNumoper
						end
						IF @cProducto = 'CI' OR @cProducto = 'VI' BEGIN
							EXECUTE Sp_Chk_Tasas @dFecPro, @cSistema, @cProducto, @FormaPago, @nMonedaOp, @nNumPantalla, @dFecvctop, @nTasPact,0,'P','','',@nNumoper
						END


					END ELSE BEGIN  -- Solo chequea CI - ICAP - VI - VP
						IF @cProducto = 'ICAP'
							EXECUTE Sp_Chk_Tasas @dFecPro, @cSistema, 'VI', @FormaPago, @nMonedaOp, @nNumPantalla, @dFecvctop, @nTasPact,0,'P','','',@nNumoper
						Else
							EXECUTE Sp_Chk_Tasas @dFecPro, @cSistema, @cProducto, @FormaPago, @nMonedaOp, @nNumPantalla, @dFecvctop, @nTasPact,0,'P','','',@nNumoper

					END
				END

			CLOSE Cursor_LINEAS_CLIENTE
			DEALLOCATE Cursor_LINEAS_CLIENTE

		END


	--********** GRABAR LINEA CHEQUE *****************
	IF @cCheckChq = 'S' AND @cProducto <> 'VP'
		BEGIN

			DECLARE Cursor_LINEAS_CHEQUE SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				Rut_Cheque  		,
				SUM(MontoTransaccion)	,
				TipoCambio  		,
				FechaVctoCheque		,
				Operador  		,
				MonedaOperacion		,
				Tipo_Riesgo
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema			AND
				Pago_Cheque  = @cCheckChq
			GROUP BY
				FechaOperacion  ,
				Rut_Cheque  	,
				TipoCambio  	,
				FechaVctoCheque	,
				Operador  	,
				MonedaOperacion	,
				Tipo_Riesgo




			OPEN Cursor_LINEAS_CHEQUE
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_CHEQUE
					INTO	@dFecPro 	,
						@nRutcli 	,
						@nMonto  	,
						@fTipcambio 	,
						@dFecvctop 	,
						@cUsuario 	,
						@nMonedaOp	,
						@cTipo_Riesgo

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

--					select '3'
--					select @dFecPro, @cSistema, @cProducto, @nRutcli, 0, @nNumoper, 0, 0, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo
					EXECUTE Sp_Lineas_Grabar @dFecPro, @cSistema, @cProducto, @nRutcli, 0, @nNumoper, 0, 0, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo


				END

			CLOSE Cursor_LINEAS_CHEQUE
			DEALLOCATE Cursor_LINEAS_CHEQUE

		END
	--********** REBAJA LINEA EN VENTA PROPIA *****************
	IF ( @cSistema = 'BTR' OR @cSistema = 'BEX' ) AND @cProducto = 'VP'
		BEGIN
			SELECT  @cCtrlGrpEmisor = 'N'

			DECLARE Cursor_LINEAS_REBAJA SCROLL CURSOR FOR
			SELECT	FechaOperacion  ,
				NumeroDocumento  ,
				NumeroCorrelativo ,
				FactorVenta   
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema

			OPEN Cursor_LINEAS_REBAJA
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_REBAJA
					INTO	@dFecPro  ,
						@nNumdocu ,
						@nCorrela ,
						@nFactor

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE Sp_Lineas_Rebaja @dFecPro, @cSistema, @nNumdocu, @nNumdocu, @nCorrela, @nFactor

				END

			CLOSE Cursor_LINEAS_REBAJA
			DEALLOCATE Cursor_LINEAS_REBAJA

		END

	--********** REBAJA LINEA EN ANTICIPOS *****************
	IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA'  )
		BEGIN
			DECLARE Cursor_LINEAS_REBAJA SCROLL CURSOR FOR
			SELECT 	FechaOperacion   
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema

			OPEN Cursor_LINEAS_REBAJA
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_REBAJA
					INTO @dFecPro  

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE Sp_Lineas_Rebaja @dFecPro, @cSistema, @nNumoper, 0, 0, 1

				END

			CLOSE Cursor_LINEAS_REBAJA
			DEALLOCATE Cursor_LINEAS_REBAJA

		END

	--************************************************
	--************************************************
	--**********                     *****************
	--********** LIMITES DE OPERADOR *****************
	--**********                     *****************
	--************************************************
	--************************************************
	SELECT 	@cCheckLimOPER = 'S',
		@cCheckLimInst = 'S'

	IF @cSistema = 'BTR' AND @cProducto = 'CP'
		SELECT @cCheckLimInst = 'S'

--SELECT @cCheckLimOPER
	--********** GRABAR LIMITE POR OPERACION *****************
	IF @cCheckLimOPER = 'S'
		BEGIN
			DECLARE Cursor_LIMITES_OPERACION SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				SUM(MontoTransaccion) 	,
				FechaVencimiento 	,
				Operador
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema
			GROUP BY
				FechaOperacion  	,
				FechaVencimiento	,
				Operador

			OPEN Cursor_LIMITES_OPERACION
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LIMITES_OPERACION
					INTO	@dFecPro	,
						@nMonto		,
						@dFecvctop	,
						@cUsuario

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE Sp_Limites_Grabar @dFecPro, @cSistema, @cProducto, 0, @nNumoper, @nMonto, @dFecvctop, @cUsuario, @cCheckLimOPER, 'N'

				END

			CLOSE Cursor_LIMITES_OPERACION
			DEALLOCATE Cursor_LIMITES_OPERACION
		END


	--********** GRABAR LIMITE POR OPERACION e INSTRUMENTO *****************
	IF @cCheckLimInst = 'S'
		BEGIN
			DECLARE Cursor_LIMITES_OPERACION_INSTRUMENTO SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				InCodigo  		,
				SUM(MontoTransaccion) 	,
				FechaVencimiento 	,
				Operador
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema
			GROUP BY
				FechaOperacion  	,
				InCodigo  		,
				FechaVencimiento 	,
				Operador

			OPEN Cursor_LIMITES_OPERACION_INSTRUMENTO
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LIMITES_OPERACION_INSTRUMENTO
					INTO 	@dFecPro	,
						@nInCodigo	,
						@nMonto		,
						@dFecvctop	,
						@cUsuario

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE Sp_Limites_Grabar @dFecPro, @cSistema, @cProducto, @nInCodigo, @nNumoper, @nMonto, @dFecvctop, @cUsuario, 'S', @cCheckLimInst

				END

			CLOSE Cursor_LIMITES_OPERACION_INSTRUMENTO
			DEALLOCATE Cursor_LIMITES_OPERACION_INSTRUMENTO

		END


  	IF @cCtrlGrpEmisor = 'S'
                BEGIN

			DECLARE Cursor_LIMITES_GRUPO_EMISOR SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
                                Rut_Emisor              ,
				SUM(MontoTransaccion)
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema
			GROUP BY
				FechaOperacion  	,
                                Rut_Emisor

			OPEN Cursor_LIMITES_GRUPO_EMISOR
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LIMITES_GRUPO_EMISOR
					INTO 	@dFecPro	,
						@nRutcli        ,
                                                @nMonto

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

                                        --EXECUTE bactradersuda..Sp_Lineas_Grabar_Grp_Emisor @dFecPro, @cSistema, '', @nRutcli, 0, @nNumPantalla, 0, 0, @dFecPro, @nMonto, 0, @dFecPro, '', 0, '', 0, 0,'O'

				END

			CLOSE Cursor_LIMITES_GRUPO_EMISOR
			DEALLOCATE Cursor_LIMITES_GRUPO_EMISOR


			--  Control para Letras Emision propia porcentaje Capital Basico 
			DECLARE Cursor_LIMITES_GRUPO_EMISOR SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
              			Rut_Emisor              ,
				SUM(MontoTransaccion)
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema			AND
				incodigo    = 20			AND
				Rut_Emisor = 97023000

			GROUP BY
				FechaOperacion  	,
                           Rut_Emisor

			OPEN Cursor_LIMITES_GRUPO_EMISOR
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LIMITES_GRUPO_EMISOR
					INTO 	@dFecPro	,
						@nRutcli        ,
                                                @nMonto

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

                                        --EXECUTE bactradersuda..Sp_Lineas_Grabar_Grp_Emisor @dFecPro, @cSistema, '', @nRutcli, 0, @nNumPantalla, 0, 0, @dFecPro, @nMonto, 0, @dFecPro, '', 0, '', 0, 0,'P'


				END

			CLOSE Cursor_LIMITES_GRUPO_EMISOR
			DEALLOCATE Cursor_LIMITES_GRUPO_EMISOR


                END




	IF @cCheckTasa = 'S'
		BEGIN
			DECLARE Cursor_LINEAS_TASA SCROLL CURSOR FOR
			SELECT 	FechaOperacion  	,
				Rut_Cliente  		,
				Codigo_Cliente  	,
				Codigo_Producto		,
				Tir	 		,
				FechaVctoInst 		,
				Moneda_Emision  	,
				Incodigo		,
				FormaPago		,
				Instser			,
				Seriado
			FROM 	LINEA_CHEQUEAR
			WHERE 	NumeroOperacion  = @nNumPantalla	AND
				Id_Sistema  = @cSistema

			OPEN Cursor_LINEAS_TASA
			WHILE (1=1)
				BEGIN
					FETCH NEXT FROM Cursor_LINEAS_TASA
					INTO	@dFecPro  	,
						@nRutcli 	,
						@nCodigo 	,
						@cProducto	,
						@nTir  		,
						@dFecvctop 	,
						@nMonedaOp	,
						@nInCodigo	,
						@FormaPago	,
						@cIntser	,
						@cSeriado

					IF (@@fetch_status <> 0)
						BEGIN
							BREAK
						END

					EXECUTE Sp_Chk_Tasas @dFecPro, @cSistema, @cProducto, @FormaPago, @nMonedaOp, @nNumPantalla, @dFecvctop, @nTir,@nInCodigo,'I',@cIntser,@cSeriado,@nNumoper


				END


			CLOSE Cursor_LINEAS_TASA
			DEALLOCATE Cursor_LINEAS_TASA

		END




	--********** GRABAR LIMITE DE OPERADOR *****************
	EXECUTE Sp_Limites_Chequear @cSistema, @nNumoper



	DELETE	LINEA_CHEQUEAR
	WHERE 	NumeroOperacion = @nNumPantalla	AND
		Id_Sistema 	= @cSistema	AND
		Codigo_Producto = @cProducto

	SET NOCOUNT OFF

END

/*
SELECT *
FROM 	LINEA_CHEQUEAR
WHERE 	Id_Sistema  = 'BEX'			AND
	Rut_Emisor  <> 97029000			AND
	Rut_Emisor <> @rut_banco
*/
GO
